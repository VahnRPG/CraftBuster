local _, cb = ...;

cb.config = {};

local config_frame_name = "CraftBuster_ConfigFrame";

local tooltips = {};
local map_icons = {};
local professions = {};
local bustables = {};
local show_minimap_button, show_world_map_icons, show_minimap_map_icons, show_skills_only_map_icons, trainer_map_icons_label, station_map_icons_label;
local show_tracker, expand_tracker;
local position_x, position_y, position_point, position_relative_point, position_locked;
local buster_position_x, buster_position_y, buster_position_point, buster_position_relative_point;

local backdrop = {
	bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 3, right = 3, top = 5, bottom = 3 }
};

local skills = {
	["skill_1"] = nil,
	["skill_2"] = nil,
	["cooking"] = nil,
	["fishing"] = nil,
	["archaeology"] = nil,
	["lockpicking"] = nil,
};
local rank_skills = {
	[1] = "skill_1",
	[2] = "skill_2",
	[3] = "cooking",
	[4] = "fishing",
	[5] = "archaeology",
};
local _, player_class = UnitClass("player");
if (player_class == "ROGUE") then
	rank_skills[7] = "lockpicking";
	if (UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
		skills.lockpicking = CBT_SKILL_PICK;
	end
end

--There's probably a better way to do this but I'm not in the mood to figure it out right now...
function cb.config:updateFields()
	skills = cb:getProfessions();

	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.show_tooltips) then
				tooltips[module_id]:SetChecked(
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips
				);
			end

			if (module_data.trainer_map_icons) then
				map_icons[module_id .. "trainer"].frame:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons);
			end
			if (module_data.station_map_icons) then
				map_icons[module_id .. "station"]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons);
			end
		end
	end

	show_world_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map);
	show_minimap_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map);
	show_skills_only_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_skills_only);
	if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global") then
		show_skills_only_map_icons:Show();
	else
		show_skills_only_map_icons:Hide();
	end

	show_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	for rank, skill in cb.omg:sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			local skill_name, skill_texture = GetProfessionInfo(index);
			if (player_class == "ROGUE" and skill == "lockpicking" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
				skill_name, _, skill_texture = GetSpellInfo(index);
			end

			if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global") then
				if (skill == "skill_1") then
					skill_name = format(CBL["CONFIG_TITLE_TRACK_SKILL_1"], skill_name);
				elseif (skill == "skill_2") then
					skill_name = format(CBL["CONFIG_TITLE_TRACK_SKILL_2"], skill_name);
				end
			end
			_G[professions[skill]:GetName() .. "Text"]:SetText(skill_name);
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
		end
	end

	local skill_ids = {};
	for skill, skill_data in cb.omg:sortedpairs(CraftBusterOptions[CraftBusterEntry].skills) do
		skill_ids[skill] = skill_data.id;
	end

	local i = 0;
	for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
		if (map_icons[module_id .. "trainer"] ~= nil) then
			if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global" and CraftBusterOptions[CraftBusterEntry].map_icons.show_skills_only) then
				if (cb.omg:in_array(module_id, skill_ids)) then
					map_icons[module_id .. "trainer"]:SetPoint("TOPLEFT", trainer_map_icons_label, "BOTTOMLEFT", 0, -20 * i);
					map_icons[module_id .. "trainer"]:Show();
					i = i + 1;
				else
					map_icons[module_id .. "trainer"]:Hide();
				end
			else
				map_icons[module_id .. "trainer"]:SetPoint("TOPLEFT", trainer_map_icons_label, "BOTTOMLEFT", 0, -20 * i);
				map_icons[module_id .. "trainer"]:Show();
				i = i + 1;
			end
		end
	end

	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.bustable_spell) then
				bustables[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
			end
		end
	end

	position_x:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
	position_y:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));
	position_locked:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.locked);

	buster_position_x:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
	buster_position_y:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
end

local config_frame = CreateFrame("Frame", config_frame_name, InterfaceOptionsFramePanelContainer);
config_frame.name = CBG_MOD_NAME;
config_frame:SetScript("OnShow", function(config_frame)
	local count = 0;

	local title_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " v" .. CBG_VERSION);
	
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
					CraftBusterOptions.globals[CraftBusterEntry_Personal] = "global";
				end
				CraftBusterEntry = CraftBusterOptions.globals[CraftBusterEntry_Personal];
				if (not CraftBusterOptions[CraftBusterEntry]) then
					cb:InitSettings("character");
				end
				--cb.brokers:update();
				cb:updateSkills(true);

				cb.config:updateFields();
			end
			UIDropDownMenu_AddButton(info);
		end
	end);
	UIDropDownMenu_JustifyText(settings_menu, "LEFT");
	UIDropDownMenu_SetSelectedValue(settings_menu, ((CraftBusterEntry_Personal == CraftBusterEntry) and "Personal" or "Global"));

	show_minimap_button = CreateFrame("CheckButton", config_frame_name .. "Minimap", config_frame, "InterfaceOptionsCheckButtonTemplate");
	show_minimap_button:SetPoint("TOPLEFT", settings_label, "BOTTOMLEFT", 0, -24);
	_G[show_minimap_button:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP"]);
	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	show_minimap_button:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].minimap.show = self:GetChecked();
		cb.minimap:update();
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
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips = self:GetChecked();
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
	local title_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_map_icons_frame.name);

	show_world_map_icons = CreateFrame("CheckButton", config_frame_name .. "ShowWorldMapMapIcons", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
	show_world_map_icons:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_world_map_icons:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_WORLD_MAP_ICONS"]);
	show_world_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map);
	show_world_map_icons:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map = self:GetChecked();
		cb:ZONE_CHANGED_NEW_AREA();
	end);

	show_minimap_map_icons = CreateFrame("CheckButton", config_frame_name .. "ShowMinimapMapIcons", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
	show_minimap_map_icons:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[show_minimap_map_icons:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP_ICONS"]);
	show_minimap_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map);
	show_minimap_map_icons:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map = self:GetChecked();
		cb:ZONE_CHANGED_NEW_AREA();
	end);

	show_skills_only_map_icons = CreateFrame("CheckButton", config_frame_name .. "ShowSkillsOnlyMapIcons", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
	show_skills_only_map_icons:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -60);
	_G[show_skills_only_map_icons:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_SKILLS_ONLY_MAP_ICONS"]);
	show_skills_only_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_skills_only);
	show_skills_only_map_icons:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].map_icons.show_skills_only = self:GetChecked();
		cb:ZONE_CHANGED_NEW_AREA();
		cb.config:updateFields();
	end);
	if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global") then
		show_skills_only_map_icons:Show();
	else
		show_skills_only_map_icons:Hide();
	end

	trainer_map_icons_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	trainer_map_icons_label:SetPoint("TOPLEFT", show_skills_only_map_icons, "BOTTOMLEFT", 0, -24);
	trainer_map_icons_label:SetText(CBL["CONFIG_TITLE_TRAINER_MAP_ICONS"]);

	station_map_icons_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	station_map_icons_label:SetPoint("TOPLEFT", show_skills_only_map_icons, "BOTTOMLEFT", 220, -24);
	station_map_icons_label:SetText(CBL["CONFIG_TITLE_STATION_MAP_ICONS"]);

	if (cb.professions.modules and next(cb.professions.modules)) then
		local trainer_count = 0;
		local station_count = 0;
		for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
			local module_data = cb.professions.modules[module_id];
			if (module_data.trainer_map_icons) then
				local label = config_frame_name .. "TrainerMapIcons_" .. module_id .. "Frame";

				map_icons[module_id .. "trainer"] = CreateFrame("Frame", label, child_map_icons_frame);
				map_icons[module_id .. "trainer"]:SetPoint("TOPLEFT", trainer_map_icons_label, "BOTTOMLEFT", 0, -20 * trainer_count);
				map_icons[module_id .. "trainer"]:SetHeight(20);
				map_icons[module_id .. "trainer"]:SetWidth(200);
				map_icons[module_id .. "trainer"]:Show();

				local x1, x2, y1, y2 = unpack(CBG_MAP_ICON_TEXTURES[CBT_MAP_ICON_TRAINER][module_id]);
				map_icons[module_id .. "trainer"].icon_frame = CreateFrame("Button", label .. "_Icon", map_icons[module_id .. "trainer"]);
				map_icons[module_id .. "trainer"].icon_frame:SetPoint("TOPLEFT", label, "TOPLEFT", 0, 0);
				map_icons[module_id .. "trainer"].icon_frame:SetHeight(20);
				map_icons[module_id .. "trainer"].icon_frame:SetWidth(20);
				map_icons[module_id .. "trainer"].icon_frame:Show();
				map_icons[module_id .. "trainer"].icon_frame.icon = map_icons[module_id .. "trainer"].icon_frame:CreateTexture("BACKGROUND");
				map_icons[module_id .. "trainer"].icon_frame.icon:SetPoint("CENTER", 0, 0);
				map_icons[module_id .. "trainer"].icon_frame.icon:SetTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_MapIcons");
				map_icons[module_id .. "trainer"].icon_frame.icon:SetTexCoord(x1, x2, y1, y2);
				map_icons[module_id .. "trainer"].icon_frame.icon:SetHeight(16);
				map_icons[module_id .. "trainer"].icon_frame.icon:SetWidth(16);
				map_icons[module_id .. "trainer"].icon_frame.icon:Show();

				map_icons[module_id .. "trainer"].frame = CreateFrame("CheckButton", label .. "_Label", map_icons[module_id .. "trainer"], "InterfaceOptionsCheckButtonTemplate");
				map_icons[module_id .. "trainer"].frame:SetPoint("TOPLEFT", label .. "_Icon", "TOPRIGHT", 0, 3);
				_G[map_icons[module_id .. "trainer"].frame:GetName() .. "Text"]:SetText(module_data.name);
				map_icons[module_id .. "trainer"].frame:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons);
				map_icons[module_id .. "trainer"].frame:SetScript("OnClick", function(self, button)
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons = self:GetChecked();
					cb:ZONE_CHANGED_NEW_AREA();
				end);
				map_icons[module_id .. "trainer"].frame:Show();
				
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
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons = self:GetChecked();
					cb:ZONE_CHANGED_NEW_AREA();
				end);
				
				station_count = station_count + 1;
			end
		end

		local skill_ids = {};
		for skill, skill_data in cb.omg:sortedpairs(CraftBusterOptions[CraftBusterEntry].skills) do
			skill_ids[skill] = skill_data.id;
		end

		local i = 0;
		for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
			if (map_icons[module_id .. "trainer"] ~= nil) then
				if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global" and CraftBusterOptions[CraftBusterEntry].map_icons.show_skills_only) then
					if (cb.omg:in_array(module_id, skill_ids)) then
						map_icons[module_id .. "trainer"]:SetPoint("TOPLEFT", trainer_map_icons_label, "BOTTOMLEFT", 0, -20 * i);
						map_icons[module_id .. "trainer"]:Show();
						i = i + 1;
					else
						map_icons[module_id .. "trainer"]:Hide();
					end
				else
					map_icons[module_id .. "trainer"]:SetPoint("TOPLEFT", trainer_map_icons_label, "BOTTOMLEFT", 0, -20 * i);
					map_icons[module_id .. "trainer"]:Show();
					i = i + 1;
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
				local module_data = cb.professions.modules[module_id];
				if (module_data.trainer_map_icons) then
					map_icons[module_id .. "trainer"]:SetChecked(checked);
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons = checked;
					cb:ZONE_CHANGED_NEW_AREA();
				end

				if (module_data.station_map_icons) then
					map_icons[module_id .. "station"]:SetChecked(checked);
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons = checked;
					cb:ZONE_CHANGED_NEW_AREA();
				end
			end
		end);

		local map_icons_select_mine = CreateFrame("Button", config_frame_name .. "MapIconsSelectMine", child_map_icons_frame, "UIPanelButtonTemplate");
		map_icons_select_mine:SetPoint("TOPLEFT", map_icons_check_all, "TOPLEFT", 0, -40);
		map_icons_select_mine:SetText(CBL["CONFIG_MAP_ICON_SELECT_MINE"]);
		map_icons_select_mine:SetSize(120, 20);
		map_icons_select_mine:SetScript("OnClick", function()
			for _, module_id in cb.omg:sortedpairs(CBG_SORTED_SKILLS) do
				local checked = cb.omg:in_array(module_id, skill_ids);
				local module_data = cb.professions.modules[module_id];
				
				if (module_data.trainer_map_icons) then
					map_icons[module_id .. "trainer"]:SetChecked(checked);
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons = checked;
					cb:ZONE_CHANGED_NEW_AREA();
				end
				
				if (module_data.station_map_icons) then
					map_icons[module_id .. "station"]:SetChecked(checked);
					CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons = checked;
					cb:ZONE_CHANGED_NEW_AREA();
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
	skills = cb:getProfessions();

	local title_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_tracker_frame.name);

	show_tracker = CreateFrame("CheckButton", config_frame_name .. "ShowTracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	show_tracker:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_TRACKER"]);
	show_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	show_tracker:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].skills_frame.show = self:GetChecked();
		cb.modules.skill_frame:update();
	end);

	expand_tracker = CreateFrame("CheckButton", config_frame_name .. "ExpandTracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_tracker:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[expand_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_TRACKER"]);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	expand_tracker:SetScript("OnClick", function(self, button)
		cb.modules.skill_frame:collapseFrame();
	end);

	--Track Professions
	local track_professions_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	track_professions_label:SetPoint("TOPLEFT", expand_tracker, "BOTTOMLEFT", 0, -24);
	track_professions_label:SetText(CBL["CONFIG_TITLE_TRACK_PROFESSION"]);

	local count = 0;
	for rank, skill in cb.omg:sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			local skill_name, skill_texture = GetProfessionInfo(index);
			if (player_class == "ROGUE" and skill == "lockpicking" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
				skill_name, _, skill_texture = GetSpellInfo(index);
			end

			if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global") then
				if (skill == "skill_1") then
					skill_name = format(CBL["CONFIG_TITLE_TRACK_SKILL_1"], skill_name);
				elseif (skill == "skill_2") then
					skill_name = format(CBL["CONFIG_TITLE_TRACK_SKILL_2"], skill_name);
				end
			end

			professions[skill] = CreateFrame("CheckButton", config_frame_name .. "TrackProfessions" .. skill, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
			professions[skill]:SetPoint("TOPLEFT", track_professions_label, "BOTTOMLEFT", 0, -20 * count);
			_G[professions[skill]:GetName() .. "Text"]:SetText(skill_name);
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
			professions[skill]:SetScript("OnClick", function(self, button)
				CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill] = self:GetChecked();
				cb.modules.skill_frame:update();
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
					CraftBusterOptions[CraftBusterEntry].modules[id].show_buster = self:GetChecked();
					cb.modules.skill_frame:update();
				end);

				count = count + 1;
			end
		end
	end

	child_tracker_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_tracker_frame);

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
		cb.modules.skill_frame:lockFrame();
	end);

	local position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_x_label:SetPoint("TOPLEFT", position_label, "BOTTOMLEFT", 10, -10);
	position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	position_x = CreateFrame("EditBox", config_frame_name .. "PositionX", child_positioning_frame, "InputBoxTemplate");
	position_x:SetPoint("TOPLEFT", position_x_label, "TOPRIGHT", 10, 0);
	position_x:SetSize(64, 16);
	position_x:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
	position_x:SetAutoFocus(false);
	position_x:SetFontObject(ChatFontNormal);
	position_x:SetCursorPosition(0);

	local set_position_x = CreateFrame("Button", config_frame_name .. "SetPositionX", child_positioning_frame, "UIPanelButtonTemplate");
	set_position_x:SetPoint("TOPLEFT", position_x, "TOPRIGHT", 10, 2);
	set_position_x:SetText(CBL["CONFIG_POSITION_SET"]);
	set_position_x:SetSize(48, 20);
	set_position_x:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].skills_frame.position.x = cb.omg:round(position_x:GetText(), 2);
		cb.modules.skill_frame:updatePosition();
	end);
	
	local position_y_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_y_label:SetPoint("TOPLEFT", position_x, "TOPRIGHT", 120, 0);
	position_y_label:SetText(CBL["CONFIG_POSITION_Y"]);
	
	position_y = CreateFrame("EditBox", config_frame_name .. "PositionY", child_positioning_frame, "InputBoxTemplate");
	position_y:SetPoint("TOPLEFT", position_y_label, "TOPRIGHT", 10, 0);
	position_y:SetSize(64, 16);
	position_y:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));
	position_y:SetAutoFocus(false);
	position_y:SetFontObject(ChatFontNormal);
	position_y:SetCursorPosition(0);

	local set_position_y = CreateFrame("Button", config_frame_name .. "etPositionY", child_positioning_frame, "UIPanelButtonTemplate");
	set_position_y:SetPoint("TOPLEFT", position_y, "TOPRIGHT", 10, 2);
	set_position_y:SetText(CBL["CONFIG_POSITION_SET"]);
	set_position_y:SetSize(48, 20);
	set_position_y:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].skills_frame.position.y = cb.omg:round(position_y:GetText(), 2);
		cb.modules.skill_frame:updatePosition();
	end);
	
	--Buster Tracker Position
	local buster_position_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_label:SetPoint("TOPLEFT", position_label, "BOTTOMLEFT", 0, -40);
	buster_position_label:SetText(CBL["CONFIG_BUSTER_POSITION"]);
	
	local buster_position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_x_label:SetPoint("TOPLEFT", buster_position_label, "BOTTOMLEFT", 10, -10);
	buster_position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	buster_position_x = CreateFrame("EditBox", config_frame_name .. "BusterPositionX", child_positioning_frame, "InputBoxTemplate");
	buster_position_x:SetPoint("TOPLEFT", buster_position_x_label, "TOPRIGHT", 10, 0);
	buster_position_x:SetSize(64, 16);
	buster_position_x:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
	buster_position_x:SetAutoFocus(false);
	buster_position_x:SetFontObject(ChatFontNormal);
	buster_position_x:SetCursorPosition(0);

	local set_buster_position_x = CreateFrame("Button", config_frame_name .. "SetBusterPositionX", child_positioning_frame, "UIPanelButtonTemplate");
	set_buster_position_x:SetPoint("TOPLEFT", buster_position_x, "TOPRIGHT", 10, 2);
	set_buster_position_x:SetText(CBL["CONFIG_POSITION_SET"]);
	set_buster_position_x:SetSize(48, 20);
	set_buster_position_x:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].buster_frame.position.x = cb.omg:round(buster_position_x:GetText(), 2);
		cb.modules.buster_frame:updatePosition();
	end);
	
	local buster_position_y_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	buster_position_y_label:SetPoint("TOPLEFT", buster_position_x, "TOPRIGHT", 120, 0);
	buster_position_y_label:SetText(CBL["CONFIG_POSITION_Y"]);
	
	buster_position_y = CreateFrame("EditBox", config_frame_name .. "BusterPositionY", child_positioning_frame, "InputBoxTemplate");
	buster_position_y:SetPoint("TOPLEFT", buster_position_y_label, "TOPRIGHT", 10, 0);
	buster_position_y:SetSize(64, 16);
	buster_position_y:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
	buster_position_y:SetAutoFocus(false);
	buster_position_y:SetFontObject(ChatFontNormal);
	buster_position_y:SetCursorPosition(0);

	local set_buster_position_y = CreateFrame("Button", config_frame_name .. "SetBusterPositionY", child_positioning_frame, "UIPanelButtonTemplate");
	set_buster_position_y:SetPoint("TOPLEFT", buster_position_y, "TOPRIGHT", 10, 2);
	set_buster_position_y:SetText(CBL["CONFIG_POSITION_SET"]);
	set_buster_position_y:SetSize(48, 20);
	set_buster_position_y:SetScript("OnClick", function()
		CraftBusterOptions[CraftBusterEntry].buster_frame.position.y = cb.omg:round(buster_position_y:GetText(), 2);
		cb.modules.buster_frame:updatePosition();
	end);

	--Reset Positions
	local reset_position = CreateFrame("Button", config_frame_name .. "ResetPositions", child_positioning_frame, "UIPanelButtonTemplate");
	reset_position:SetPoint("TOPLEFT", buster_position_label, "BOTTOMLEFT", 0, -40);
	reset_position:SetText(CBL["CONFIG_POSITIONS_RESET"]);
	reset_position:SetSize(160, 24);
	reset_position:SetScript("OnClick", function() 
		cb.modules.skill_frame:resetPosition();
		cb.modules.buster_frame:resetPosition();

		position_x:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
		position_y:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));

		buster_position_x:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
		buster_position_y:SetText(cb.omg:round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
	end);

	child_positioning_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_positioning_frame);

function CraftBuster_Config_Show()
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);		--hack for patch 5.3

	cb.config:updateFields();
end