local config_frame_name = "CraftBuster_ConfigFrame";
local _, player_class = UnitClass("player");

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
	[0] = "skill_1",
	[1] = "skill_2",
	[2] = "cooking",
	[3] = "first_aid",
	[4] = "fishing",
	[5] = "archaeology",
};
if (player_class == "ROGUE") then
	rank_skills[6] = "lockpicking";
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

local config_frame = CreateFrame("Frame", config_frame_name, InterfaceOptionsFramePanelContainer);
config_frame.name = CBG_MOD_NAME;
config_frame:SetScript("OnShow", function(config_frame)
	local count = 0;

	local title_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " v" .. CBG_VERSION);

	show_minimap_button = CreateFrame("CheckButton", config_frame_name .. "Minimap", config_frame, "InterfaceOptionsCheckButtonTemplate");
	show_minimap_button:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_minimap_button:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP"]);
	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	show_minimap_button:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].minimap.show = self:GetChecked();
		CraftBuster_Minimap_Init();
	end);

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		local tooltips_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		tooltips_label:SetPoint("TOPLEFT", show_minimap_button, "BOTTOMLEFT", 0, -24);
		tooltips_label:SetText(CBL["CONFIG_TITLE_TOOLTIP_INFO"]);

		count = 0;
		for _, module_id in sortedpairs(CBG_SORTED_SKILLS) do
			local module_data = CraftBuster_Modules[module_id];
			if (module_data.tooltip_info) then
				tooltips[module_id] = CreateFrame("CheckButton", config_frame_name .. "Tooltips" .. module_id, config_frame, "InterfaceOptionsCheckButtonTemplate");
				tooltips[module_id]:SetPoint("TOPLEFT", tooltips_label, "BOTTOMLEFT", 0, -20 * count);
				_G[tooltips[module_id]:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				tooltips[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips);
				tooltips[module_id]:SetScript("OnClick", function(self, button)
					CraftBuster_Minimap_SetTooltip(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end

	config_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(config_frame);

--[[
local child_alerts_frame = CreateFrame("Frame", config_frame_name .. "Alerts", config_frame);
child_alerts_frame.name = "Alerts";
child_alerts_frame.parent = config_frame.name;
child_alerts_frame:SetScript("OnShow", function(child_alerts_frame)
	local title_label = child_alerts_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_alerts_frame.name);

	local alert_frame = CreateFrame("Frame", config_frame_name .. "AlertFrame", child_alerts_frame);
	alert_frame:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	alert_frame:SetSize(155, 500);
	alert_frame:SetBackdrop(backdrop);
	alert_frame:SetBackdropColor(0.1, 0.1, 0.1, 0.5);
	alert_frame:SetBackdropBorderColor(0.4, 0.4, 0.4);

	local alert_data_frame = CreateFrame("Frame", config_frame_name .. "AlertFrame", child_alerts_frame);
	alert_data_frame:SetPoint("TOPLEFT", alert_frame, "TOPRIGHT", 5, 0);
	alert_data_frame:SetSize(430, 500);
	alert_data_frame:SetBackdrop(backdrop);
	alert_data_frame:SetBackdropColor(0.1, 0.1, 0.1, 0.5);
	alert_data_frame:SetBackdropBorderColor(0.4, 0.4, 0.4);

	local alert_trainer_tab_frame = CreateFrame("Button", config_frame_name .. "AlertTrainerTab", child_alerts_frame, "TabButtonTemplate");
	alert_trainer_tab_frame:SetPoint("TOPLEFT", alert_data_frame, "TOPLEFT", 10, 0);
	alert_trainer_tab_frame:SetText(CBL["CONFIG_ALERTS_TAB_TRAINER"]);
	PanelTemplates_TabResize(alert_trainer_tab_frame, 0);

	local alert_nodes_tab_frame = CreateFrame("Button", config_frame_name .. "AlertNodesTab", child_alerts_frame, "TabButtonTemplate");
	alert_nodes_tab_frame:SetPoint("TOPLEFT", alert_trainer_tab_frame, "TOPRIGHT", 5, 0);
	alert_nodes_tab_frame:SetText(CBL["CONFIG_ALERTS_TAB_NODES"]);
	PanelTemplates_TabResize(alert_nodes_tab_frame, 0);

	--local alert_trainer_frame = CreateFrame("Frame", );
	
	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		local count = 1;
		local max_count = CBG_SKILL_COUNT - 1;
		for _, module_id in sortedpairs(CBG_SORTED_SKILLS) do
			local module_data = CraftBuster_Modules[module_id];
			if (module_data.display_action_function) then
				local alert_tab = CreateFrame("Button", config_frame_name .. "AlertTab" .. count, alert_frame, "OptionsListButtonTemplate");
				alert_tab:SetPoint("TOPLEFT", alert_frame, "TOPLEFT", 0, -20 * count + 10);
				alert_tab:SetSize(150, 20);
				alert_tab:SetNormalFontObject(GameFontNormal);
				alert_tab:SetHighlightFontObject(GameFontHighlight);
				alert_tab:SetText(module_data.name);
				alert_tab.text:SetPoint("LEFT", 10, 2);
				alert_tab:SetScript("OnClick", function(self, button)
					for i=1,max_count do
						local button = _G[config_frame_name .. "AlertTab" .. i];
						button.highlight:SetVertexColor(.196, .388, .8);
						button:UnlockHighlight();
					end
					
					self.highlight:SetVertexColor(1, 1, 0);
					self:LockHighlight();
					module_data.display_action_function(alert_data_frame);
				end);

				count = count + 1;
			end
		end
	end

	child_alerts_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_alerts_frame);
]]--

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
		CraftBuster_Minimap_SetShowWorldMapIcons(self, _, _, self:GetChecked());
	end);

	show_minimap_map_icons = CreateFrame("CheckButton", config_frame_name .. "ShowMinimapMapIcons", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
	show_minimap_map_icons:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[show_minimap_map_icons:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP_ICONS"]);
	show_minimap_map_icons:SetChecked(CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map);
	show_minimap_map_icons:SetScript("OnClick", function(self, button)
		CraftBuster_Minimap_SetShowMinimapIcons(self, _, _, self:GetChecked());
	end);

	local trainer_map_icons_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	trainer_map_icons_label:SetPoint("TOPLEFT", show_minimap_map_icons, "BOTTOMLEFT", 0, -20);
	trainer_map_icons_label:SetText(CBL["CONFIG_TITLE_TRAINER_MAP_ICONS"]);

	local station_map_icons_label = child_map_icons_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	station_map_icons_label:SetPoint("TOPLEFT", show_minimap_map_icons, "BOTTOMLEFT", 220, -20);
	station_map_icons_label:SetText(CBL["CONFIG_TITLE_STATION_MAP_ICONS"]);

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		trainer_count = 0;
		station_count = 0;
		for _, module_id in sortedpairs(CBG_SORTED_SKILLS) do
			local module_data = CraftBuster_Modules[module_id];
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
					CraftBuster_Minimap_SetTrainerMapIcons(self, module_id, _, self:GetChecked());
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
				_G[map_icons[module_id .. "station"]:GetName() .. "Text"]:SetText(CBL["CONFIG_MAP_ICON_" .. CraftBuster_Modules[module_id].name]);
				map_icons[module_id .. "station"]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons);
				map_icons[module_id .. "station"]:SetScript("OnClick", function(self, button)
					CraftBuster_Minimap_SetStationMapIcons(self, module_id, _, self:GetChecked());
				end);
				
				station_count = station_count + 1;
			end
		end

		local map_icons_check_all = CreateFrame("CheckButton", config_frame_name .. "MapIconsCheckAll", child_map_icons_frame, "InterfaceOptionsCheckButtonTemplate");
		map_icons_check_all:SetPoint("TOPLEFT", station_map_icons_label, "TOPRIGHT", 50, 0);
		_G[map_icons_check_all:GetName() .. "Text"]:SetText(CBL["CONFIG_MAP_ICON_CHECK_ALL"]);
		map_icons_check_all:SetChecked(true);
		map_icons_check_all:SetScript("OnClick", function(self, button)
			local checked = self:GetChecked();
			for _, module_id in sortedpairs(CBG_SORTED_SKILLS) do
				local module_data = CraftBuster_Modules[module_id];
				if (module_data.trainer_map_icons) then
					map_icons[module_id .. "trainer"]:SetChecked(checked);
					CraftBuster_Minimap_SetTrainerMapIcons(self, module_id, _, checked);
				end

				if (module_data.station_map_icons) then
					map_icons[module_id .. "station"]:SetChecked(checked);
					CraftBuster_Minimap_SetStationMapIcons(self, module_id, _, checked);
				end
			end
		end);

		local map_icons_select_mine = CreateFrame("Button", config_frame_name .. "MapIconsSelectMine", child_map_icons_frame, "UIPanelButtonTemplate");
		map_icons_select_mine:SetPoint("TOPLEFT", map_icons_check_all, "TOPLEFT", 0, -40);
		map_icons_select_mine:SetText(CBL["CONFIG_MAP_ICON_SELECT_MINE"]);
		map_icons_select_mine:SetSize(120, 20);
		map_icons_select_mine:SetScript("OnClick", function()
			local skills = {};
			for skill, skill_data in sortedpairs(CraftBusterOptions[CraftBusterEntry].skills) do
				skills[skill] = skill_data.id;
			end
			for _, module_id in sortedpairs(CBG_SORTED_SKILLS) do
				local checked = in_array(module_id, skills);
				local module_data = CraftBuster_Modules[module_id];
				
				if (module_data.trainer_map_icons) then
					map_icons[module_id .. "trainer"]:SetChecked(checked);
					CraftBuster_Minimap_SetTrainerMapIcons(self, module_id, _, checked);
				end
				
				if (module_data.station_map_icons) then
					map_icons[module_id .. "station"]:SetChecked(checked);
					CraftBuster_Minimap_SetStationMapIcons(self, module_id, _, checked);
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
		CraftBuster_Minimap_SetShowTracking(self, _, _, self:GetChecked());
	end);

	expand_tracker = CreateFrame("CheckButton", config_frame_name .. "ExpandTracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_tracker:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[expand_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_TRACKER"]);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	expand_tracker:SetScript("OnClick", function(self, button)
		CraftBuster_SkillFrame_Collapse_OnClick();
	end);

	--Track Professions
	local track_professions_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	track_professions_label:SetPoint("TOPLEFT", expand_tracker, "BOTTOMLEFT", 0, -24);
	track_professions_label:SetText(CBL["CONFIG_TITLE_TRACK_PROFESSION"]);

	skills.skill_1, skills.skill_2, skills.archaeology, skills.fishing, skills.cooking, skills.first_aid = GetProfessions();

	count = 0;
	for rank,skill in sortedpairs(rank_skills) do
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
				CraftBuster_Minimap_SetTracking(self, skill, _, self:GetChecked());
			end);

			count = count + 1;
		end
	end
	
	--Show Buster Icon
	local bustables_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	bustables_label:SetPoint("TOPLEFT", track_professions_label, "BOTTOMLEFT", 0, -(24 + 20 * count));

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		bustables_label:SetText(CBL["CONFIG_TITLE_BUSTER_ICON"]);

		count = 0;
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.bustable_spell) then
				bustables[module_id] = CreateFrame("CheckButton", config_frame_name .. "Bustables" .. module_id, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
				bustables[module_id]:SetPoint("TOPLEFT", bustables_label, "BOTTOMLEFT", 0, -20 * count);
				_G[bustables[module_id]:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				bustables[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
				bustables[module_id]:SetScript("OnClick", function(self, button)
					CraftBuster_Minimap_SetBuster(self, module_id, _, self:GetChecked());
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
		CraftBuster_Minimap_SetShowWorldMap(self, _, _, self:GetChecked());
	end);

	expand_worldmap = CreateFrame("CheckButton", config_frame_name .. "ExpandWorldMap", child_worldmap_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_worldmap:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -40);
	_G[expand_worldmap:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_WORLDMAP"]);
	expand_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.state == "expanded");
	expand_worldmap:SetScript("OnClick", function(self, button)
		CraftBuster_WorldMap_Collapse_OnClick();
	end);
	
	--Show Professions World Map
	local professions_label = child_worldmap_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	professions_label:SetPoint("TOPLEFT", expand_worldmap, "BOTTOMLEFT", 0, -24);

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		professions_label:SetText(CBL["CONFIG_TITLE_SHOW_WORLDMAP_PROFESSIONS"]);
		
		count = 0;
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.has_worldmap) then
				profession_worldmap[module_id] = CreateFrame("CheckButton", config_frame_name .. "ProfessionWorldMap" .. module_id, child_worldmap_frame, "InterfaceOptionsCheckButtonTemplate");
				profession_worldmap[module_id]:SetPoint("TOPLEFT", professions_label, "BOTTOMLEFT", 0, -20 * count);
				_G[profession_worldmap[module_id]:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				profession_worldmap[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_worldmap_icons);
				profession_worldmap[module_id]:SetScript("OnClick", function(self, button)
					CraftBuster_Minimap_SetProfessionWorldMap(self, module_id, _, self:GetChecked());
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
		CraftBuster_Minimap_SetShowGatherer(self, _, _, self:GetChecked());
	end);

	expand_gatherer = CreateFrame("CheckButton", config_frame_name .. "ExpandGatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_gatherer:SetPoint("TOPLEFT", show_gatherer, "BOTTOMLEFT", 0, 0);
	_G[expand_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_GATHERER"]);
	expand_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded");
	expand_gatherer:SetScript("OnClick", function(self, button)
		CraftBuster_GatherFrame_Collapse_OnClick();
	end);

	auto_hide_gatherer = CreateFrame("CheckButton", config_frame_name .. "AutoHideGatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	auto_hide_gatherer:SetPoint("TOPLEFT", expand_gatherer, "BOTTOMLEFT", 0, 0);
	_G[auto_hide_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_AUTOHIDE_GATHERER"]);
	auto_hide_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide);
	auto_hide_gatherer:SetScript("OnClick", function(self, button)
		CraftBuster_Minimap_SetAutoHideGatherer(self, _, _, self:GetChecked());
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
		CraftBuster_Minimap_SetShowZoneNodes(self, _, _, self:GetChecked());
	end);

	show_skillup_nodes = CreateFrame("CheckButton", config_frame_name .. "ShowSkillUpZones", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_skillup_nodes:SetPoint("TOPLEFT", show_zone_nodes, "BOTTOMLEFT", 0, 0);
	_G[show_skillup_nodes:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_SKILLUP_NODES"]);
	show_skillup_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes);
	show_skillup_nodes:SetScript("OnClick", function(self, button)
		CraftBuster_Minimap_SetSkillUpNodes(self, _, _, self:GetChecked());
	end);
	
	--Show Professions Gather
	local professions_label = child_gatherer_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	professions_label:SetPoint("TOPLEFT", show_skillup_nodes, "BOTTOMLEFT", 0, -24);

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		professions_label:SetText(CBL["CONFIG_TITLE_SHOW_PROFESSION_GATHERS"]);
		
		count = 0;
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.gather_function) then
				profession_gathers[module_id] = CreateFrame("CheckButton", config_frame_name .. "ProfessionGathers" .. module_id, child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
				profession_gathers[module_id]:SetPoint("TOPLEFT", professions_label, "BOTTOMLEFT", 0, -20 * count);
				_G[profession_gathers[module_id]:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				profession_gathers[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_gather);
				profession_gathers[module_id]:SetScript("OnClick", function(self, button)
					CraftBuster_Minimap_SetProfessionGather(self, module_id, _, self:GetChecked());
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
		CraftBuster_SkillFrame_Lock_OnClick();
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
		CraftBuster_SkillFrame_UpdatePosition();
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
		CraftBuster_SkillFrame_UpdatePosition();
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
				CraftBuster_SkillFrame_UpdatePosition();
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
				CraftBuster_SkillFrame_UpdatePosition();
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
		CraftBuster_WorldMap_UpdatePosition();
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
		CraftBuster_WorldMap_UpdatePosition();
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
				CraftBuster_WorldMap_UpdatePosition();
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
				CraftBuster_WorldMap_UpdatePosition();
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
		CraftBuster_GatherFrame_UpdatePosition();
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
		CraftBuster_GatherFrame_UpdatePosition();
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
				CraftBuster_GatherFrame_UpdatePosition();
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
				CraftBuster_GatherFrame_UpdatePosition();
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
		CraftBuster_BusterFrame_UpdatePosition();
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
		CraftBuster_BusterFrame_UpdatePosition();
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
				CraftBuster_BusterFrame_UpdatePosition();
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
				CraftBuster_BusterFrame_UpdatePosition();
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
		CraftBuster_SkillFrame_ResetPosition();
		CraftBuster_WorldMap_ResetPosition();
		CraftBuster_GatherFrame_ResetPosition();
		CraftBuster_BusterFrame_ResetPosition();

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

--[[
local child_modules_frame = CreateFrame("Frame", config_frame_name .. "Modules", config_frame);
child_modules_frame.name = "Modules";
child_modules_frame.parent = config_frame.name;
child_modules_frame:SetScript("OnShow", function(child_modules_frame)
	local title = child_modules_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:SetPoint("TOPLEFT", 16, -16);
	title:SetText(CBG_MOD_NAME .. " - Modules");

	child_modules_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_modules_frame);
]]--

--There's probably a better way to do this but I'm not in the mood to figure it out right now...
local function updateFields()
	if (player_class == "ROGUE" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
		skills.lockpicking = CBT_SKILL_PICK;
	end

	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.tooltip_info) then
				tooltips[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips);
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
	for rank,skill in sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
		end
	end

	show_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.show);
	expand_worldmap:SetChecked(CraftBusterOptions[CraftBusterEntry].worldmap_frame.state == "expanded");

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.bustable_spell) then
				bustables[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
			end
			if (module_data.show_worldmap_icons) then
				profession_worldmap[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_worldmap_icons);
			end
			if (module_data.gather_function) then
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

function CraftBuster_Config_RegisterModule(module_id, module_name, module_options)
	local module_config_frame = module_options.config.frame;
	--module_config_frame.name = module_options.config.name;
	module_config_frame.parent = config_frame.name;
	InterfaceOptions_AddCategory(module_config_frame);
end

function CraftBuster_Config_Show()
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);		--hack for patch 5.3

	updateFields();
end