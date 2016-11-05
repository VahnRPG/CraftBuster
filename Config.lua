local _, cb = ...;

cb.config = {};

function cb.config:setShowWorldMapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setShowMinimapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setShowTracking(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].skills_frame.show = checked;
	cb.skill_frame:update();
end

function cb.config:setShowWorldMap(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.show = checked;
	cb.worldmap_frame:update();
end

function cb.config:setShowGatherer(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.show = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setAutoHideGatherer(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setShowZoneNodes(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setSkillUpNodes(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setTracking(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].skills_frame.bars[id] = checked;
	cb.skill_frame:update();
end

function cb.config:setTooltip(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_tooltips = checked;
end

function cb.config:setTrainerMapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_trainer_map_icons = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setStationMapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_station_map_icons = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb.config:setBuster(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_buster = checked;
	cb.skill_frame:update();
end

function cb.config:setProfessionWorldMap(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_worldmap_icons = checked;
	cb.worldmap_frame:update();
end

function cb.config:setProfessionGather(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_gather = checked;
	cb:ZONE_CHANGED_NEW_AREA();
end

local skills = {
	["skill_1"] = nil,
	["skill_2"] = nil,
	["cooking"] = nil,
	["first_aid"] = nil,
	["fishing"] = nil,
	["archaeology"] = nil,
	["lockpicking"] = nil,
};
local rank_skills = {
	[1] = "skill_1",
	[2] = "skill_2",
	[3] = "cooking",
	[4] = "first_aid",
	[5] = "fishing",
	[6] = "archaeology",
};
local _, player_class = UnitClass("player");
if (player_class == "ROGUE") then
	rank_skills[7] = "lockpicking";
	if (UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
		skills.lockpicking = CBT_SKILL_PICK;
	end
end
local tooltips = {};
local map_icons = {};
local professions = {};
local bustables = {};
local profession_worldmap = {};
local profession_gathers = {};
local show_minimap_button, show_world_map_icons, show_minimap_map_icons, show_tracker, expand_tracker;
local show_worldmap, expand_worldmap;
local show_gatherer, expand_gatherer, auto_hide_gatherer, show_zone_nodes, show_skillup_nodes;
local position_x, position_y, position_point, position_relative_point, position_locked;
local worldmap_position_x, worldmap_position_y, worldmap_position_point, worldmap_position_relative_point;
local gatherer_position_x, gatherer_position_y, gatherer_position_point, gatherer_position_relative_point;
local buster_position_x, buster_position_y, buster_position_point, buster_position_relative_point;

local backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
};

--There's probably a better way to do this but I'm not in the mood to figure it out right now...
function cb.config:updateFields()
	if (player_class == "ROGUE" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
		skills.lockpicking = CBT_SKILL_PICK;
	end

	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.show_tooltips) then
				tooltips[module_id]:SetChecked(
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips
				);
			end

			if (module_data.trainer_map_icons) then
				map_icons[module_id .. "trainer"]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons);
			end
			if (module_data.station_map_icons) then
				map_icons[module_id .. "station"]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons);
			end
		end
	end

	show_world_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map);
	show_minimap_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map);

	show_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	for rank,skill in cb.omg:sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
		end
	end

	show_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.show);
	expand_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.state == "expanded");

	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.bustable_spell) then
				bustables[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
			end
			if (module_data.nodes ~= nil) then
				profession_worldmap[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_worldmap_icons);
				profession_gathers[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_gather);
			end
		end
	end

	show_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show);
	expand_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded");
	auto_hide_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide);
	show_zone_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes);
	show_skillup_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes);

	position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
	position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));

	worldmap_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.x, 2));
	worldmap_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.y, 2));

	gatherer_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.x, 2));
	gatherer_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.y, 2));

	buster_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
	buster_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
end

local config_frame_name = "CraftBuster_ConfigFrame";
local config_frame = CreateFrame("Frame", config_frame_name, InterfaceOptionsFramePanelContainer);
config_frame.name = CBG_MOD_NAME;
config_frame:SetScript("OnShow", function(config_frame)
	local count = 0;

	local title_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " v" .. CBG_VERSION);

	--[[
	local settings_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	settings_label:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	settings_label:SetText(CBL["CONFIG_SETTINGS_TYPE"]);

	settings_menu = CreateFrame("Frame", config_frame_name .. "SetSettings", config_frame, "UIDropDownMenuTemplate");
	settings_menu:SetPoint("TOPLEFT", settings_label, "TOPRIGHT", 0, 4);
	UIDropDownMenu_Initialize(settings_menu, function()
		local values = { "Global", "Personal" };
		for i, value in pairs(values) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = value;
			info.value = value;
			info.func = function(self)
				UIDropDownMenu_SetSelectedValue(settings_menu, self.value);
				if (self.value == "Personal") then
					CraftBusterOptions.globals[CraftBusterEntry_Personal] = CraftBusterEntry_Personal;
				else
					CraftBusterOptions.globals[CraftBusterEntry_Personal] = CBG_GLOBAL_PROFILE;
				end
				CraftBusterEntry = CraftBusterOptions.globals[CraftBusterEntry_Personal];
				if (not CraftBusterOptions[CraftBusterEntry]) then
					cb:initSettings("character");
				end
				CraftBuster();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(settings_menu, "LEFT");
	UIDropDownMenu_SetSelectedValue(settings_menu, ((CraftBusterEntry_Personal == CraftBusterEntry) and "Personal" or "Global"));
	]]--

	show_minimap_button = CreateFrame("CheckButton", config_frame_name .. "Minimap", config_frame, "InterfaceOptionsCheckButtonTemplate");
	--show_minimap_button:SetPoint("TOPLEFT", settings_label, "BOTTOMLEFT", 0, -24);
	show_minimap_button:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -24);
	_G[show_minimap_button:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP"]);
	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	show_minimap_button:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].minimap.show = self:GetChecked();
		cb.minimap:init();
	end);

	if (cb.professions.modules and next(cb.professions.modules)) then
		local tooltips_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		tooltips_label:SetPoint("TOPLEFT", show_minimap_button, "BOTTOMLEFT", 0, -24);
		tooltips_label:SetText(CBL["CONFIG_TITLE_TOOLTIP_INFO"]);

		count = 0;
		for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
			local module_data = cb.professions.modules[module_id];
			if (module_data.show_tooltips) then
				tooltips[module_id] = CreateFrame("CheckButton", config_frame_name .. "Tooltips" .. module_id, config_frame, "InterfaceOptionsCheckButtonTemplate");
				tooltips[module_id]:SetPoint("TOPLEFT", tooltips_label, "BOTTOMLEFT", 0, -20 * count);
				_G[tooltips[module_id]:GetName() .. "Text"]:SetText(cb.professions.modules[module_id].name);
				tooltips[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips);
				tooltips[module_id]:SetScript("OnClick", function(self, button)
					cb.config:setTooltip(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end

	config_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(config_frame);

local child_map_icons_frame = CreateFrame("Frame", config_frame_name .. "MapIcons", config_frame);
child_map_icons_frame.name = "Map Icons";
child_map_icons_frame.parent = config_frame.name;
child_map_icons_frame:SetScript("OnShow", function(child_map_icons_frame)
	local trainer_count = 0;
	local station_count = 0;

	local title_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_map_icons_frame.name);

	show_world_map_icons = CreateFrame("CheckButton", config_frame_name .. "ShowWorldMapMapIcons", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
	show_world_map_icons:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_world_map_icons:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_WORLD_MAP_ICONS"]);
	show_world_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map);
	show_world_map_icons:SetScript("OnClick", function(self, button)
		cb.config:setShowWorldMapIcons(self, _, _, self:GetChecked());
	end);

	show_minimap_map_icons = CreateFrame("CheckButton", config_frame_name .. "ShowMinimapMapIcons", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
	show_minimap_map_icons:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[show_minimap_map_icons:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP_ICONS"]);
	show_minimap_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map);
	show_minimap_map_icons:SetScript("OnClick", function(self, button)
		cb.config:setShowMinimapIcons(self, _, _, self:GetChecked());
	end);

	local trainer_map_icons_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	trainer_map_icons_label:SetPoint("TOPLEFT", show_minimap_map_icons, "BOTTOMLEFT", 0, -24);
	trainer_map_icons_label:SetText(CBL["CONFIG_TITLE_TRAINER_MAP_ICONS"]);

	local station_map_icons_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	station_map_icons_label:SetPoint("TOPLEFT", show_minimap_map_icons, "BOTTOMLEFT", 220, -24);
	station_map_icons_label:SetText(CBL["CONFIG_TITLE_STATION_MAP_ICONS"]);

	if (cb.professions.modules and next(cb.professions.modules)) then
		local skills = {};
		for skill, skill_data in cb.omg:sortedpairs(CraftBusterOptions[CraftBusterEntry].skills) do
			skills[skill] = skill_data.id;
		end

		trainer_count = 0;
		station_count = 0;
		for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
			if (CraftBusterEntry ~= CBG_GLOBAL_PROFILE or cb.omg:in_array(module_id, skills)) then
				local module_data = cb.professions.modules[module_id];
				if (module_data.trainer_map_icons) then
					local label = config_frame_name .. "TrainerMapIcons_" .. module_id;
					local x1, x2, y1, y2 = unpack(CBG_MAP_ICON_TEXTURES[CBT_MAP_ICON_TRAINER][module_id]);
					local icon_frame = CreateFrame("Button", label .. "Icon", child_map_icons_frame);
					icon_frame:SetPoint("TOPLEFT", trainer_map_icons_label, "BOTTOMLEFT", 0, -20 * trainer_count);
					icon_frame:SetHeight(20);
					icon_frame:SetWidth(20);
					icon_frame:Show();
					icon_frame.icon = icon_frame:CreateTexture("BACKGROUND");
					icon_frame.icon:SetPoint("CENTER", 0, 0);
					icon_frame.icon:SetTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_MapIcons");
					icon_frame.icon:SetTexCoord(x1, x2, y1, y2);
					icon_frame.icon:SetHeight(16);
					icon_frame.icon:SetWidth(16);
					icon_frame.icon:Show();

					map_icons[module_id .. "trainer"] = CreateFrame("CheckButton", label, child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
					map_icons[module_id .. "trainer"]:SetPoint("TOPLEFT", label .. "Icon", "TOPRIGHT", 0, 3);
					_G[map_icons[module_id .. "trainer"]:GetName() .. "Text"]:SetText(module_data.name);
					map_icons[module_id .. "trainer"]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons);
					map_icons[module_id .. "trainer"]:SetScript("OnClick", function(self, button)
						cb.config:setTrainerMapIcons(self, module_id, _, self:GetChecked());
					end);
					
					trainer_count = trainer_count + 1;
				end
				
				if (module_data.station_map_icons) then
					local label = config_frame_name .. "StationMapIcons_" .. module_id;
					local x1, x2, y1, y2 = unpack(CBG_MAP_ICON_TEXTURES[CBT_MAP_ICON_STATION][module_id]);
					local icon_frame = CreateFrame("Button", label .. "Icon", child_map_icons_frame);
					icon_frame:SetPoint("TOPLEFT", station_map_icons_label, "BOTTOMLEFT", 0, -20 * station_count);
					icon_frame:SetHeight(20);
					icon_frame:SetWidth(20);
					icon_frame:Show();
					icon_frame.icon = icon_frame:CreateTexture("BACKGROUND");
					icon_frame.icon:SetPoint("CENTER", 0, 0);
					icon_frame.icon:SetTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_MapIcons");
					icon_frame.icon:SetTexCoord(x1, x2, y1, y2);
					icon_frame.icon:SetHeight(16);
					icon_frame.icon:SetWidth(16);
					icon_frame.icon:Show();

					map_icons[module_id .. "station"] = CreateFrame("CheckButton", label, child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
					map_icons[module_id .. "station"]:SetPoint("TOPLEFT", label .. "Icon", "TOPRIGHT", 0, 3);
					_G[map_icons[module_id .. "station"]:GetName() .. "Text"]:SetText(CBL["CONFIG_MAP_ICON_" .. cb.professions.modules[module_id].name]);
					map_icons[module_id .. "station"]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons);
					map_icons[module_id .. "station"]:SetScript("OnClick", function(self, button)
						cb.config:setStationMapIcons(self, module_id, _, self:GetChecked());
					end);
					
					station_count = station_count + 1;
				end
			end
		end

		local map_icons_check_all = CreateFrame("CheckButton", config_frame_name .. "MapIconsCheckAll", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
		map_icons_check_all:SetPoint("TOPLEFT", station_map_icons_label, "TOPRIGHT", 50, 0);
		_G[map_icons_check_all:GetName() .. "Text"]:SetText(CBL["CONFIG_MAP_ICON_CHECK_ALL"]);
		map_icons_check_all:SetChecked(true);
		map_icons_check_all:SetScript("OnClick", function(self, button)
			local checked = self:GetChecked();
			for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
				if (CraftBusterEntry ~= CBG_GLOBAL_PROFILE or cb.omg:in_array(module_id, skills)) then
					local module_data = cb.professions.modules[module_id];
					if (module_data.trainer_map_icons) then
						map_icons[module_id .. "trainer"]:SetChecked(checked);
						cb.config:setTrainerMapIcons(self, module_id, _, checked);
					end

					if (module_data.station_map_icons) then
						map_icons[module_id .. "station"]:SetChecked(checked);
						cb.config:setStationMapIcons(self, module_id, _, checked);
					end
				end
			end
		end);

		local map_icons_select_mine = CreateFrame("Button", config_frame_name .. "MapIconsSelectMine", child_map_icons_frame, "UIPanelButtonTemplate");
		map_icons_select_mine:SetPoint("TOPLEFT", map_icons_check_all, "TOPLEFT", 0, -40);
		map_icons_select_mine:SetText(CBL["CONFIG_MAP_ICON_SELECT_MINE"]);
		map_icons_select_mine:SetSize(120, 20);
		map_icons_select_mine:SetScript("OnClick", function()
			for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
				local checked = cb.omg:in_array(module_id, skills);
				local module_data = cb.professions.modules[module_id];
				
				if (module_data.trainer_map_icons) then
					map_icons[module_id .. "trainer"]:SetChecked(checked);
					cb.config:setTrainerMapIcons(self, module_id, _, checked);
				end
				
				if (module_data.station_map_icons) then
					map_icons[module_id .. "station"]:SetChecked(checked);
					cb.config:setStationMapIcons(self, module_id, _, checked);
				end
			end
		end);
	end

	child_map_icons_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_map_icons_frame);

local child_tracker_frame = CreateFrame("Frame", config_frame_name .. "Tracker", config_frame);
child_tracker_frame.name = "Tracker";
child_tracker_frame.parent = config_frame.name;
child_tracker_frame:SetScript("OnShow", function(child_tracker_frame)
	local count = 0;

	local title_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_tracker_frame.name);

	show_tracker = CreateFrame("CheckButton", config_frame_name .. "ShowTracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	show_tracker:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_TRACKER"]);
	show_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	show_tracker:SetScript("OnClick", function(self, button)
		cb.config:setShowTracking(self, _, _, self:GetChecked());
	end);

	expand_tracker = CreateFrame("CheckButton", config_frame_name .. "ExpandTracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_tracker:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[expand_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_TRACKER"]);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	expand_tracker:SetScript("OnClick", function(self, button)
		cb.skill_frame:collapseFrame();
	end);

	--Track Professions
	local track_professions_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	track_professions_label:SetPoint("TOPLEFT", expand_tracker, "BOTTOMLEFT", 0, -24);
	track_professions_label:SetText(CBL["CONFIG_TITLE_TRACK_PROFESSION"]);

	skills.skill_1, skills.skill_2, skills.archaeology, skills.fishing, skills.cooking, skills.first_aid = GetProfessions();

	count = 0;
	for rank,skill in cb.omg:sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			local skill_name, skill_texture = GetProfessionInfo(index);
			if (player_class == "ROGUE" and skill == "lockpicking" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
				skill_name, _, skill_texture = GetSpellInfo(index);
			end

			professions[skill] = CreateFrame("CheckButton", config_frame_name .. "TrackProfessions" .. skill, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
			professions[skill]:SetPoint("TOPLEFT", track_professions_label, "BOTTOMLEFT", 0, -20 * count);
			_G[professions[skill]:GetName() .. "Text"]:SetText(skill_name);
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
			professions[skill]:SetScript("OnClick", function(self, button)
				cb.config:setTracking(self, skill, _, self:GetChecked());
			end);

			count = count + 1;
		end
	end
	
	--Show Buster Icon
	local bustables_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	bustables_label:SetPoint("TOPLEFT", track_professions_label, "BOTTOMLEFT", 0, -(24 + 20 * count));

	if (cb.professions.modules and next(cb.professions.modules)) then
		bustables_label:SetText(CBL["CONFIG_TITLE_BUSTER_ICON"]);

		count = 0;
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.bustable_function) then
				bustables[module_id] = CreateFrame("CheckButton", config_frame_name .. "Bustables" .. module_id, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
				bustables[module_id]:SetPoint("TOPLEFT", bustables_label, "BOTTOMLEFT", 0, -20 * count);
				_G[bustables[module_id]:GetName() .. "Text"]:SetText(cb.professions.modules[module_id].name);
				bustables[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
				bustables[module_id]:SetScript("OnClick", function(self, button)
					cb.config:setBuster(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end

	child_tracker_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_tracker_frame);

local child_worldmap_frame = CreateFrame("Frame", config_frame_name .. "WorldMap", config_frame);
child_worldmap_frame.name = "World Map";
child_worldmap_frame.parent = config_frame.name;
child_worldmap_frame:SetScript("OnShow", function(child_worldmap_frame)
	local count = 0;

	local title_label = child_worldmap_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_worldmap_frame.name);

	show_worldmap = CreateFrame("CheckButton", config_frame_name .. "ShowWorldMap", child_worldmap_frame, "InterfaceOptionsCheckButtonTemplate");
	show_worldmap:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_worldmap:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_WORLDMAP"]);
	show_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.show);
	show_worldmap:SetScript("OnClick", function(self, button)
		cb.config:setShowWorldMap(self, _, _, self:GetChecked());
	end);

	expand_worldmap = CreateFrame("CheckButton", config_frame_name .. "ExpandWorldMap", child_worldmap_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_worldmap:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[expand_worldmap:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_WORLDMAP"]);
	expand_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.state == "expanded");
	expand_worldmap:SetScript("OnClick", function(self, button)
		cb.worldmap_frame:collapseFrame();
	end);
	
	--Show Professions World Map
	local professions_label = child_worldmap_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	professions_label:SetPoint("TOPLEFT", expand_worldmap, "BOTTOMLEFT", 0, -24);

	if (cb.professions.modules and next(cb.professions.modules)) then
		professions_label:SetText(CBL["CONFIG_TITLE_SHOW_WORLDMAP_PROFESSIONS"]);
		
		count = 0;
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.nodes ~= nil) then
				profession_worldmap[module_id] = CreateFrame("CheckButton", config_frame_name .. "ProfessionWorldMap" .. module_id, child_worldmap_frame, "InterfaceOptionsCheckButtonTemplate");
				profession_worldmap[module_id]:SetPoint("TOPLEFT", professions_label, "BOTTOMLEFT", 0, -20 * count);
				_G[profession_worldmap[module_id]:GetName() .. "Text"]:SetText(cb.professions.modules[module_id].name);
				profession_worldmap[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_worldmap_icons);
				profession_worldmap[module_id]:SetScript("OnClick", function(self, button)
					cb.config:setProfessionWorldMap(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end

	child_worldmap_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_worldmap_frame);

local child_gatherer_frame = CreateFrame("Frame", config_frame_name .. "Gatherer", config_frame);
child_gatherer_frame.name = "Gatherer";
child_gatherer_frame.parent = config_frame.name;
child_gatherer_frame:SetScript("OnShow", function(child_gatherer_frame)
	local count = 0;

	local title_label = child_gatherer_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_gatherer_frame.name);

	show_gatherer = CreateFrame("CheckButton", config_frame_name .. "ShowGatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_gatherer:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_GATHERER"]);
	show_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show);
	show_gatherer:SetScript("OnClick", function(self, button)
		cb.config:setShowGatherer(self, _, _, self:GetChecked());
	end);

	expand_gatherer = CreateFrame("CheckButton", config_frame_name .. "ExpandGatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_gatherer:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[expand_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_GATHERER"]);
	expand_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded");
	expand_gatherer:SetScript("OnClick", function(self, button)
		cb.gather_frame:collapseFrame();
	end);

	auto_hide_gatherer = CreateFrame("CheckButton", config_frame_name .. "AutoHideGatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	auto_hide_gatherer:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -60);
	_G[auto_hide_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_AUTOHIDE_GATHERER"]);
	auto_hide_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide);
	auto_hide_gatherer:SetScript("OnClick", function(self, button)
		cb.config:setAutoHideGatherer(self, _, _, self:GetChecked());
	end);

	--Show Nodes
	local show_nodes_label = child_gatherer_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	show_nodes_label:SetPoint("TOPLEFT", auto_hide_gatherer, "BOTTOMLEFT", 0, -24);
	show_nodes_label:SetText(CBL["CONFIG_TITLE_SHOW_NODES"]);

	show_zone_nodes = CreateFrame("CheckButton", config_frame_name .. "ShowZoneNodes", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_zone_nodes:SetPoint("TOPLEFT", show_nodes_label, "BOTTOMLEFT", 0, 0);
	_G[show_zone_nodes:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_ZONE_NODES"]);
	show_zone_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes);
	show_zone_nodes:SetScript("OnClick", function(self, button)
		cb.config:setShowZoneNodes(self, _, _, self:GetChecked());
	end);

	show_skillup_nodes = CreateFrame("CheckButton", config_frame_name .. "ShowSkillUpZones", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_skillup_nodes:SetPoint("TOPLEFT", show_nodes_label, "BOTTOMLEFT", 0, -20);
	_G[show_skillup_nodes:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_SKILLUP_NODES"]);
	show_skillup_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes);
	show_skillup_nodes:SetScript("OnClick", function(self, button)
		cb.config:setSkillUpNodes(self, _, _, self:GetChecked());
	end);
	
	--Show Professions Gather
	local professions_label = child_gatherer_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	professions_label:SetPoint("TOPLEFT", show_skillup_nodes, "BOTTOMLEFT", 0, -24);

	if (cb.professions.modules and next(cb.professions.modules)) then
		professions_label:SetText(CBL["CONFIG_TITLE_SHOW_PROFESSION_GATHERS"]);
		
		count = 0;
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.nodes ~= nil) then
				profession_gathers[module_id] = CreateFrame("CheckButton", config_frame_name .. "ProfessionGathers" .. module_id, child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
				profession_gathers[module_id]:SetPoint("TOPLEFT", professions_label, "BOTTOMLEFT", 0, -20 * count);
				_G[profession_gathers[module_id]:GetName() .. "Text"]:SetText(cb.professions.modules[module_id].name);
				profession_gathers[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_gather);
				profession_gathers[module_id]:SetScript("OnClick", function(self, button)
					cb.config:setProfessionGather(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end

	child_gatherer_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_gatherer_frame);

local child_positioning_frame = CreateFrame("Frame", config_frame_name .. "Positions", config_frame);
child_positioning_frame.name = "Positioning";
child_positioning_frame.parent = config_frame.name;
child_positioning_frame:SetScript("OnShow", function(child_positioning_frame)
	local title_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_positioning_frame.name);

	--Tracker Position
	local position_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_label:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	position_label:SetText(CBL["CONFIG_TRACKER_POSITION"]);

	position_locked = CreateFrame("CheckButton", config_frame_name .. "PositionLocked", child_positioning_frame, "InterfaceOptionsCheckButtonTemplate");
	position_locked:SetPoint("TOPLEFT", position_label, "TOPRIGHT", 20, 5);
	_G[position_locked:GetName() .. "Text"]:SetText(CBL["CONFIG_POSITION_LOCKED"]);
	position_locked:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.locked);
	position_locked:SetScript("OnClick", function(self, button)
		cb.skill_frame:lockFrame();
	end);

	local position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_x_label:SetPoint("TOPLEFT", position_label, "BOTTOMLEFT", 10, -10);
	position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	position_x = CreateFrame("EditBox", config_frame_name .. "PositionX", child_positioning_frame, "InputBoxTemplate");
	position_x:SetPoint("TOPLEFT", position_x_label, "TOPRIGHT", 10, 0);
	position_x:SetSize(64, 16);
	position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
	position_x:SetAutoFocus(false);
	position_x:SetFontObject(ChatFontNormal);
	position_x:SetCursorPosition(0);

	local set_position_x = CreateFrame("Button", config_frame_name .. "SetPositionX", child_positioning_frame, "UIPanelButtonTemplate");
	set_position_x:SetPoint("TOPLEFT", position_x, "TOPRIGHT", 10, 2);
	set_position_x:SetText(CBL["CONFIG_POSITION_SET"]);
	set_position_x:SetSize(48, 20);
	set_position_x:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].skills_frame.position.x = round(position_x:GetText(), 2);
		cb.skill_frame:updatePosition();
	end);
	
	local position_y_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_y_label:SetPoint("TOPLEFT", position_x, "TOPRIGHT", 120, 0);
	position_y_label:SetText(CBL["CONFIG_POSITION_Y"]);
	
	position_y = CreateFrame("EditBox", config_frame_name .. "PositionY", child_positioning_frame, "InputBoxTemplate");
	position_y:SetPoint("TOPLEFT", position_y_label, "TOPRIGHT", 10, 0);
	position_y:SetSize(64, 16);
	position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));
	position_y:SetAutoFocus(false);
	position_y:SetFontObject(ChatFontNormal);
	position_y:SetCursorPosition(0);

	local set_position_y = CreateFrame("Button", config_frame_name .. "etPositionY", child_positioning_frame, "UIPanelButtonTemplate");
	set_position_y:SetPoint("TOPLEFT", position_y, "TOPRIGHT", 10, 2);
	set_position_y:SetText(CBL["CONFIG_POSITION_SET"]);
	set_position_y:SetSize(48, 20);
	set_position_y:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].skills_frame.position.y = round(position_y:GetText(), 2);
		cb.skill_frame:updatePosition();
	end);
	
	local position_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_point_label:SetPoint("TOPLEFT", position_x_label, "BOTTOMLEFT", 0, -20);
	position_point_label:SetText(CBL["CONFIG_POSITION_POINT"]);

	position_point = CreateFrame("Frame", config_frame_name .. "SetPoint", child_positioning_frame, "UIDropDownMenuTemplate");
	position_point:SetPoint("TOPLEFT", position_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(position_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].skills_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(position_point, self.value);
				cb.skill_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(position_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(position_point, CraftBusterOptions[CraftBusterEntry].skills_frame.position.point);
	
	local position_relative_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_relative_point_label:SetPoint("TOPLEFT", position_y_label, "BOTTOMLEFT", 0, -20);
	position_relative_point_label:SetText(CBL["CONFIG_POSITION_RELATIVE_POINT"]);

	position_relative_point = CreateFrame("Frame", config_frame_name .. "SetRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
	position_relative_point:SetPoint("TOPLEFT", position_relative_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(position_relative_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].skills_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(position_relative_point, self.value);
				cb.skill_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(position_relative_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(position_relative_point, CraftBusterOptions[CraftBusterEntry].skills_frame.position.relative_point);
	
	--World Map Position
	local worldmap_position_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	worldmap_position_label:SetPoint("TOPLEFT", position_label, "BOTTOMLEFT", 0, -100);
	worldmap_position_label:SetText(CBL["CONFIG_WORLDMAP_POSITION"]);
	
	local worldmap_position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	worldmap_position_x_label:SetPoint("TOPLEFT", worldmap_position_label, "BOTTOMLEFT", 10, -10);
	worldmap_position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	worldmap_position_x = CreateFrame("EditBox", config_frame_name .. "WorldMapPositionX", child_positioning_frame, "InputBoxTemplate");
	worldmap_position_x:SetPoint("TOPLEFT", worldmap_position_x_label, "TOPRIGHT", 10, 0);
	worldmap_position_x:SetSize(64, 16);
	worldmap_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.x, 2));
	worldmap_position_x:SetAutoFocus(false);
	worldmap_position_x:SetFontObject(ChatFontNormal);
	worldmap_position_x:SetCursorPosition(0);

	local set_worldmap_position_x = CreateFrame("Button", config_frame_name .. "SetWorldMapPositionX", child_positioning_frame, "UIPanelButtonTemplate");
	set_worldmap_position_x:SetPoint("TOPLEFT", worldmap_position_x, "TOPRIGHT", 10, 2);
	set_worldmap_position_x:SetText(CBL["CONFIG_POSITION_SET"]);
	set_worldmap_position_x:SetSize(48, 20);
	set_worldmap_position_x:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.x = round(worldmap_position_x:GetText(), 2);
		cb.worldmap_frame:updatePosition();
	end);
	
	local worldmap_position_y_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	worldmap_position_y_label:SetPoint("TOPLEFT", worldmap_position_x, "TOPRIGHT", 120, 0);
	worldmap_position_y_label:SetText(CBL["CONFIG_POSITION_Y"]);
	
	worldmap_position_y = CreateFrame("EditBox", config_frame_name .. "WorldMapPositionY", child_positioning_frame, "InputBoxTemplate");
	worldmap_position_y:SetPoint("TOPLEFT", worldmap_position_y_label, "TOPRIGHT", 10, 0);
	worldmap_position_y:SetSize(64, 16);
	worldmap_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.y, 2));
	worldmap_position_y:SetAutoFocus(false);
	worldmap_position_y:SetFontObject(ChatFontNormal);
	worldmap_position_y:SetCursorPosition(0);

	local set_worldmap_position_y = CreateFrame("Button", config_frame_name .. "SetWorldMapPositionY", child_positioning_frame, "UIPanelButtonTemplate");
	set_worldmap_position_y:SetPoint("TOPLEFT", worldmap_position_y, "TOPRIGHT", 10, 2);
	set_worldmap_position_y:SetText(CBL["CONFIG_POSITION_SET"]);
	set_worldmap_position_y:SetSize(48, 20);
	set_worldmap_position_y:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.y = round(worldmap_position_y:GetText(), 2);
		cb.worldmap_frame:updatePosition();
	end);
	
	local worldmap_position_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	worldmap_position_point_label:SetPoint("TOPLEFT", worldmap_position_x_label, "BOTTOMLEFT", 0, -20);
	worldmap_position_point_label:SetText(CBL["CONFIG_POSITION_POINT"]);

	worldmap_position_point = CreateFrame("Frame", config_frame_name .. "SetWorldMapPoint", child_positioning_frame, "UIDropDownMenuTemplate");
	worldmap_position_point:SetPoint("TOPLEFT", worldmap_position_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(worldmap_position_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(worldmap_position_point, self.value);
				cb.worldmap_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(worldmap_position_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(worldmap_position_point, CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.point);
	
	local worldmap_position_relative_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	worldmap_position_relative_point_label:SetPoint("TOPLEFT", worldmap_position_y_label, "BOTTOMLEFT", 0, -20);
	worldmap_position_relative_point_label:SetText(CBL["CONFIG_POSITION_RELATIVE_POINT"]);

	worldmap_position_relative_point = CreateFrame("Frame", config_frame_name .. "SetWorldMapRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
	worldmap_position_relative_point:SetPoint("TOPLEFT", worldmap_position_relative_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(worldmap_position_relative_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(worldmap_position_relative_point, self.value);
				cb.worldmap_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(worldmap_position_relative_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(worldmap_position_relative_point, CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.relative_point);
	
	--Gatherer Position
	local gatherer_position_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_label:SetPoint("TOPLEFT", worldmap_position_label, "BOTTOMLEFT", 0, -100);
	gatherer_position_label:SetText(CBL["CONFIG_GATHERER_POSITION"]);
	
	local gatherer_position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_x_label:SetPoint("TOPLEFT", gatherer_position_label, "BOTTOMLEFT", 10, -10);
	gatherer_position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	gatherer_position_x = CreateFrame("EditBox", config_frame_name .. "GathererPositionX", child_positioning_frame, "InputBoxTemplate");
	gatherer_position_x:SetPoint("TOPLEFT", gatherer_position_x_label, "TOPRIGHT", 10, 0);
	gatherer_position_x:SetSize(64, 16);
	gatherer_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.x, 2));
	gatherer_position_x:SetAutoFocus(false);
	gatherer_position_x:SetFontObject(ChatFontNormal);
	gatherer_position_x:SetCursorPosition(0);

	local set_gatherer_position_x = CreateFrame("Button", config_frame_name .. "SetGathererPositionX", child_positioning_frame, "UIPanelButtonTemplate");
	set_gatherer_position_x:SetPoint("TOPLEFT", gatherer_position_x, "TOPRIGHT", 10, 2);
	set_gatherer_position_x:SetText(CBL["CONFIG_POSITION_SET"]);
	set_gatherer_position_x:SetSize(48, 20);
	set_gatherer_position_x:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].gather_frame.position.x = round(gatherer_position_x:GetText(), 2);
		cb.gather_frame:updatePosition();
	end);
	
	local gatherer_position_y_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_y_label:SetPoint("TOPLEFT", gatherer_position_x, "TOPRIGHT", 120, 0);
	gatherer_position_y_label:SetText(CBL["CONFIG_POSITION_Y"]);
	
	gatherer_position_y = CreateFrame("EditBox", config_frame_name .. "GathererPositionY", child_positioning_frame, "InputBoxTemplate");
	gatherer_position_y:SetPoint("TOPLEFT", gatherer_position_y_label, "TOPRIGHT", 10, 0);
	gatherer_position_y:SetSize(64, 16);
	gatherer_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.y, 2));
	gatherer_position_y:SetAutoFocus(false);
	gatherer_position_y:SetFontObject(ChatFontNormal);
	gatherer_position_y:SetCursorPosition(0);

	local set_gatherer_position_y = CreateFrame("Button", config_frame_name .. "SetGathererPositionY", child_positioning_frame, "UIPanelButtonTemplate");
	set_gatherer_position_y:SetPoint("TOPLEFT", gatherer_position_y, "TOPRIGHT", 10, 2);
	set_gatherer_position_y:SetText(CBL["CONFIG_POSITION_SET"]);
	set_gatherer_position_y:SetSize(48, 20);
	set_gatherer_position_y:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].gather_frame.position.y = round(gatherer_position_y:GetText(), 2);
		cb.gather_frame:updatePosition();
	end);
	
	local gatherer_position_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_point_label:SetPoint("TOPLEFT", gatherer_position_x_label, "BOTTOMLEFT", 0, -20);
	gatherer_position_point_label:SetText(CBL["CONFIG_POSITION_POINT"]);

	gatherer_position_point = CreateFrame("Frame", config_frame_name .. "SetGathererPoint", child_positioning_frame, "UIDropDownMenuTemplate");
	gatherer_position_point:SetPoint("TOPLEFT", gatherer_position_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(gatherer_position_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].gather_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(gatherer_position_point, self.value);
				cb.gather_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(gatherer_position_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(gatherer_position_point, CraftBusterOptions[CraftBusterEntry].gather_frame.position.point);
	
	local gatherer_position_relative_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_relative_point_label:SetPoint("TOPLEFT", gatherer_position_y_label, "BOTTOMLEFT", 0, -20);
	gatherer_position_relative_point_label:SetText(CBL["CONFIG_POSITION_RELATIVE_POINT"]);

	gatherer_position_relative_point = CreateFrame("Frame", config_frame_name .. "SetGathererRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
	gatherer_position_relative_point:SetPoint("TOPLEFT", gatherer_position_relative_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(gatherer_position_relative_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].gather_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(gatherer_position_relative_point, self.value);
				cb.gather_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(gatherer_position_relative_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(gatherer_position_relative_point, CraftBusterOptions[CraftBusterEntry].gather_frame.position.relative_point);
	
	--Buster Tracker Position
	local buster_position_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_label:SetPoint("TOPLEFT", gatherer_position_label, "BOTTOMLEFT", 0, -100);
	buster_position_label:SetText(CBL["CONFIG_BUSTER_POSITION"]);
	
	local buster_position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_x_label:SetPoint("TOPLEFT", buster_position_label, "BOTTOMLEFT", 10, -10);
	buster_position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	buster_position_x = CreateFrame("EditBox", config_frame_name .. "BusterPositionX", child_positioning_frame, "InputBoxTemplate");
	buster_position_x:SetPoint("TOPLEFT", buster_position_x_label, "TOPRIGHT", 10, 0);
	buster_position_x:SetSize(64, 16);
	buster_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
	buster_position_x:SetAutoFocus(false);
	buster_position_x:SetFontObject(ChatFontNormal);
	buster_position_x:SetCursorPosition(0);

	local set_buster_position_x = CreateFrame("Button", config_frame_name .. "SetBusterPositionX", child_positioning_frame, "UIPanelButtonTemplate");
	set_buster_position_x:SetPoint("TOPLEFT", buster_position_x, "TOPRIGHT", 10, 2);
	set_buster_position_x:SetText(CBL["CONFIG_POSITION_SET"]);
	set_buster_position_x:SetSize(48, 20);
	set_buster_position_x:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].buster_frame.position.x = round(buster_position_x:GetText(), 2);
		cb.buster_frame:updatePosition();
	end);
	
	local buster_position_y_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_y_label:SetPoint("TOPLEFT", buster_position_x, "TOPRIGHT", 120, 0);
	buster_position_y_label:SetText(CBL["CONFIG_POSITION_Y"]);
	
	buster_position_y = CreateFrame("EditBox", config_frame_name .. "BusterPositionY", child_positioning_frame, "InputBoxTemplate");
	buster_position_y:SetPoint("TOPLEFT", buster_position_y_label, "TOPRIGHT", 10, 0);
	buster_position_y:SetSize(64, 16);
	buster_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
	buster_position_y:SetAutoFocus(false);
	buster_position_y:SetFontObject(ChatFontNormal);
	buster_position_y:SetCursorPosition(0);

	local set_buster_position_y = CreateFrame("Button", config_frame_name .. "SetBusterPositionY", child_positioning_frame, "UIPanelButtonTemplate");
	set_buster_position_y:SetPoint("TOPLEFT", buster_position_y, "TOPRIGHT", 10, 2);
	set_buster_position_y:SetText(CBL["CONFIG_POSITION_SET"]);
	set_buster_position_y:SetSize(48, 20);
	set_buster_position_y:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].buster_frame.position.y = round(buster_position_y:GetText(), 2);
		cb.buster_frame:updatePosition();
	end);
	
	local buster_position_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_point_label:SetPoint("TOPLEFT", buster_position_x_label, "BOTTOMLEFT", 0, -20);
	buster_position_point_label:SetText(CBL["CONFIG_POSITION_POINT"]);

	buster_position_point = CreateFrame("Frame", config_frame_name .. "SetBusterPoint", child_positioning_frame, "UIDropDownMenuTemplate");
	buster_position_point:SetPoint("TOPLEFT", buster_position_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(buster_position_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].buster_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(buster_position_point, self.value);
				cb.buster_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(buster_position_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(buster_position_point, CraftBusterOptions[CraftBusterEntry].buster_frame.position.point);
	
	local buster_position_relative_point_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_relative_point_label:SetPoint("TOPLEFT", buster_position_y_label, "BOTTOMLEFT", 0, -20);
	buster_position_relative_point_label:SetText(CBL["CONFIG_POSITION_RELATIVE_POINT"]);

	buster_position_relative_point = CreateFrame("Frame", config_frame_name .. "SetBusterRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
	buster_position_relative_point:SetPoint("TOPLEFT", buster_position_relative_point_label, "TOPRIGHT", 0, 2);
	UIDropDownMenu_Initialize(buster_position_relative_point, function()
		local points = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "CENTER" };
		for i, point in pairs(points) do
			local info = UIDropDownMenu_CreateInfo();
			info.text = point;
			info.value = point;
			info.func = function(self)
				CraftBusterOptions[CraftBusterEntry].buster_frame.position.point = self.value;
				UIDropDownMenu_SetSelectedValue(buster_position_relative_point, self.value);
				cb.buster_frame:updatePosition();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(buster_position_relative_point, "LEFT");
	UIDropDownMenu_SetSelectedValue(buster_position_relative_point, CraftBusterOptions[CraftBusterEntry].buster_frame.position.relative_point);

	--Reset Positions
	local reset_position = CreateFrame("Button", config_frame_name .. "ResetPositions", child_positioning_frame, "UIPanelButtonTemplate");
	reset_position:SetPoint("TOPLEFT", buster_position_label, "BOTTOMLEFT", 0, -100);
	reset_position:SetText(CBL["CONFIG_POSITIONS_RESET"]);
	reset_position:SetSize(160, 24);
	reset_position:SetScript("OnClick", function() 
		cb.skill_frame:resetPosition();
		cb.buster_frame:resetPosition();
		cb.gather_frame:resetPosition();
		cb.worldmap_frame:resetPosition();

		position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
		position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));
		UIDropDownMenu_SetSelectedValue(position_point, CraftBusterOptions[CraftBusterEntry].skills_frame.position.point);
		UIDropDownMenu_SetSelectedValue(position_relative_point, CraftBusterOptions[CraftBusterEntry].skills_frame.position.relative_point);

		worldmap_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.x, 2));
		worldmap_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.y, 2));
		UIDropDownMenu_SetSelectedValue(worldmap_position_point, CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.point);
		UIDropDownMenu_SetSelectedValue(worldmap_position_relative_point, CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.relative_point);

		gatherer_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.x, 2));
		gatherer_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.y, 2));
		UIDropDownMenu_SetSelectedValue(gatherer_position_point, CraftBusterOptions[CraftBusterEntry].gather_frame.position.point);
		UIDropDownMenu_SetSelectedValue(gatherer_position_relative_point, CraftBusterOptions[CraftBusterEntry].gather_frame.position.relative_point);

		buster_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
		buster_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
		UIDropDownMenu_SetSelectedValue(buster_position_point, CraftBusterOptions[CraftBusterEntry].buster_frame.position.point);
		UIDropDownMenu_SetSelectedValue(buster_position_relative_point, CraftBusterOptions[CraftBusterEntry].buster_frame.position.relative_point);
	end);

	child_positioning_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_positioning_frame);

function CraftBuster_Config_Show()
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);		--hack for patch 5.3

	cb.config:updateFields();
end