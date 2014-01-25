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
if (player_class == "ROGUE" and UnitLevel("player") >= 20) then
	skills.lockpicking = CBT_SKILL_PICK;
end
if (player_class == "ROGUE") then
	rank_skills[6] = "lockpicking";
end
local tooltips = {};
local professions = {};
local bustables = {};
local show_minimap_button, show_tracker, expand_tracker;
local show_gatherer, expand_gatherer, show_zone_nodes, show_skillup_nodes;
local position_x, position_y, position_point, position_relative_point;
local gatherer_position_x, gatherer_position_y, gatherer_position_point, gatherer_position_relative_point;
local buster_position_x, buster_position_y, buster_position_point, buster_position_relative_point;

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
		CraftBuster_MiniMap_Init();
	end);

	--Show Tooltip Info
	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		local tooltips_label = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		tooltips_label:SetPoint("TOPLEFT", show_minimap_button, "BOTTOMLEFT", 0, -24);
		tooltips_label:SetText(CBL["CONFIG_TITLE_TOOLTIP_INFO"]);

		count = 0;
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.tooltip_info) then
				tooltips[module_id] = CreateFrame("CheckButton", config_frame_name .. "Tooltips" .. module_id, config_frame, "InterfaceOptionsCheckButtonTemplate");
				tooltips[module_id]:SetPoint("TOPLEFT", tooltips_label, "BOTTOMLEFT", 0, -20 * count);
				_G[tooltips[module_id]:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				--echo("Here1: " .. module_id .. ", " .. (tooltip:GetChecked() and "checked" or "unchecked"));
				tooltips[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips);
				--echo("Here2: " .. module_id .. ", " .. (tooltip:GetChecked() and "checked" or "unchecked"));
				tooltips[module_id]:SetScript("OnClick", function(self, button)
					--echo("Here3: " .. module_id .. ", " .. (self:GetChecked() and "checked" or "unchecked"));
					CraftBuster_MiniMap_SetTooltip(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end

	config_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(config_frame);

local child_tracker_frame = CreateFrame("Frame", config_frame_name .. "Tracker", config_frame);
child_tracker_frame.name = "Tracker";
child_tracker_frame.parent = config_frame.name;
child_tracker_frame:SetScript("OnShow", function(child_tracker_frame)
	local count = 0;

	local title_label = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_tracker_frame.name);

	show_tracker = CreateFrame("CheckButton", config_frame_name .. "Tracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	show_tracker:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_TRACKER"]);
	show_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	show_tracker:SetScript("OnClick", function(self, button)
		CraftBuster_MiniMap_SetShowTracking(self, _, _, self:GetChecked());
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
			if (player_class == "ROGUE" and skill == "lockpicking" and UnitLevel("player") >= 20) then
				skill_name, _, skill_texture = GetSpellInfo(index);
			end

			professions[skill] = CreateFrame("CheckButton", config_frame_name .. "TrackProfessions" .. skill, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
			professions[skill]:SetPoint("TOPLEFT", track_professions_label, "BOTTOMLEFT", 0, -20 * count);
			_G[professions[skill]:GetName() .. "Text"]:SetText(skill_name);
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
			professions[skill]:SetScript("OnClick", function(self, button)
				CraftBuster_MiniMap_SetTracking(self, skill, _, self:GetChecked());
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
					CraftBuster_MiniMap_SetBuster(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end
end);
InterfaceOptions_AddCategory(child_tracker_frame);

local child_gatherer_frame = CreateFrame("Frame", config_frame_name .. "Gatherer", config_frame);
child_gatherer_frame.name = "Gatherer";
child_gatherer_frame.parent = config_frame.name;
child_gatherer_frame:SetScript("OnShow", function(child_gatherer_frame)
	local count = 0;

	local title_label = child_gatherer_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title_label:SetPoint("TOPLEFT", 16, -16);
	title_label:SetText(CBG_MOD_NAME .. " - " .. child_gatherer_frame.name);

	show_gatherer = CreateFrame("CheckButton", config_frame_name .. "Gatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_gatherer:SetPoint("TOPLEFT", title_label, "BOTTOMLEFT", 0, -20);
	_G[show_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_GATHERER"]);
	show_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show);
	show_gatherer:SetScript("OnClick", function(self, button)
		CraftBuster_MiniMap_SetShowGatherer(self, _, _, self:GetChecked());
	end);

	expand_gatherer = CreateFrame("CheckButton", config_frame_name .. "ExpandGatherer", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_gatherer:SetPoint("TOPLEFT", show_gatherer, "BOTTOMLEFT", 0, 0);
	_G[expand_gatherer:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_GATHERER"]);
	expand_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded");
	expand_gatherer:SetScript("OnClick", function(self, button)
		CraftBuster_GatherFrame_Collapse_OnClick();
	end);

	--Track Professions
	local show_nodes_label = child_gatherer_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	show_nodes_label:SetPoint("TOPLEFT", expand_gatherer, "BOTTOMLEFT", 0, -24);
	show_nodes_label:SetText(CBL["CONFIG_TITLE_SHOW_NODES"]);

	show_zone_nodes = CreateFrame("CheckButton", config_frame_name .. "ShowZoneNodes", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_zone_nodes:SetPoint("TOPLEFT", show_nodes_label, "BOTTOMLEFT", 0, 0);
	_G[show_zone_nodes:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_ZONE_NODES"]);
	show_zone_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes);
	show_zone_nodes:SetScript("OnClick", function(self, button)
		CraftBuster_MiniMap_SetShowZoneNodes(self, _, _, self:GetChecked());
	end);

	show_skillup_nodes = CreateFrame("CheckButton", config_frame_name .. "ShowSkillUpZones", child_gatherer_frame, "InterfaceOptionsCheckButtonTemplate");
	show_skillup_nodes:SetPoint("TOPLEFT", show_zone_nodes, "BOTTOMLEFT", 0, 0);
	_G[show_skillup_nodes:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_SKILLUP_NODES"]);
	show_skillup_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes);
	show_skillup_nodes:SetScript("OnClick", function(self, button)
		CraftBuster_MiniMap_SetSkillUpNodes(self, _, _, self:GetChecked());
	end);
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
	
	local position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position_x_label:SetPoint("TOPLEFT", position_label, "BOTTOMLEFT", 10, -10);
	position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	position_x = CreateFrame("EditBox", "PositionX", child_positioning_frame, "InputBoxTemplate");
	position_x:SetPoint("TOPLEFT", position_x_label, "TOPRIGHT", 10, 0);
	position_x:SetSize(64, 16);
	position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
	position_x:SetAutoFocus(false);
	position_x:SetFontObject(ChatFontNormal);
	position_x:SetCursorPosition(0);

	local set_position_x = CreateFrame("Button", "SetPositionX", child_positioning_frame, "UIPanelButtonTemplate");
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
	
	position_y = CreateFrame("EditBox", "PositionY", child_positioning_frame, "InputBoxTemplate");
	position_y:SetPoint("TOPLEFT", position_y_label, "TOPRIGHT", 10, 0);
	position_y:SetSize(64, 16);
	position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));
	position_y:SetAutoFocus(false);
	position_y:SetFontObject(ChatFontNormal);
	position_y:SetCursorPosition(0);

	local set_position_y = CreateFrame("Button", "SetPositionY", child_positioning_frame, "UIPanelButtonTemplate");
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

	position_point = CreateFrame("Frame", "SetPoint", child_positioning_frame, "UIDropDownMenuTemplate");
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

	position_relative_point = CreateFrame("Frame", "SetRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
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
	
	--Gatherer Position
	local gatherer_position_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_label:SetPoint("TOPLEFT", position_label, "BOTTOMLEFT", 0, -100);
	gatherer_position_label:SetText(CBL["CONFIG_GATHERER_POSITION"]);
	
	local gatherer_position_x_label = child_positioning_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	gatherer_position_x_label:SetPoint("TOPLEFT", gatherer_position_label, "BOTTOMLEFT", 10, -10);
	gatherer_position_x_label:SetText(CBL["CONFIG_POSITION_X"]);
	
	gatherer_position_x = CreateFrame("EditBox", "GathererPositionX", child_positioning_frame, "InputBoxTemplate");
	gatherer_position_x:SetPoint("TOPLEFT", gatherer_position_x_label, "TOPRIGHT", 10, 0);
	gatherer_position_x:SetSize(64, 16);
	gatherer_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.x, 2));
	gatherer_position_x:SetAutoFocus(false);
	gatherer_position_x:SetFontObject(ChatFontNormal);
	gatherer_position_x:SetCursorPosition(0);

	local set_gatherer_position_x = CreateFrame("Button", "SetGathererPositionX", child_positioning_frame, "UIPanelButtonTemplate");
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
	
	gatherer_position_y = CreateFrame("EditBox", "GathererPositionY", child_positioning_frame, "InputBoxTemplate");
	gatherer_position_y:SetPoint("TOPLEFT", gatherer_position_y_label, "TOPRIGHT", 10, 0);
	gatherer_position_y:SetSize(64, 16);
	gatherer_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].gather_frame.position.y, 2));
	gatherer_position_y:SetAutoFocus(false);
	gatherer_position_y:SetFontObject(ChatFontNormal);
	gatherer_position_y:SetCursorPosition(0);

	local set_gatherer_position_y = CreateFrame("Button", "SetGathererPositionY", child_positioning_frame, "UIPanelButtonTemplate");
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

	gatherer_position_point = CreateFrame("Frame", "SetGathererPoint", child_positioning_frame, "UIDropDownMenuTemplate");
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

	gatherer_position_relative_point = CreateFrame("Frame", "SetGathererRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
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
	
	buster_position_x = CreateFrame("EditBox", "BusterPositionX", child_positioning_frame, "InputBoxTemplate");
	buster_position_x:SetPoint("TOPLEFT", buster_position_x_label, "TOPRIGHT", 10, 0);
	buster_position_x:SetSize(64, 16);
	buster_position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.x, 2));
	buster_position_x:SetAutoFocus(false);
	buster_position_x:SetFontObject(ChatFontNormal);
	buster_position_x:SetCursorPosition(0);

	local set_buster_position_x = CreateFrame("Button", "SetBusterPositionX", child_positioning_frame, "UIPanelButtonTemplate");
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
	
	buster_position_y = CreateFrame("EditBox", "BusterPositionY", child_positioning_frame, "InputBoxTemplate");
	buster_position_y:SetPoint("TOPLEFT", buster_position_y_label, "TOPRIGHT", 10, 0);
	buster_position_y:SetSize(64, 16);
	buster_position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].buster_frame.position.y, 2));
	buster_position_y:SetAutoFocus(false);
	buster_position_y:SetFontObject(ChatFontNormal);
	buster_position_y:SetCursorPosition(0);

	local set_buster_position_y = CreateFrame("Button", "SetBusterPositionY", child_positioning_frame, "UIPanelButtonTemplate");
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

	buster_position_point = CreateFrame("Frame", "SetBusterPoint", child_positioning_frame, "UIDropDownMenuTemplate");
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

	buster_position_relative_point = CreateFrame("Frame", "SetBusterRelativePoint", child_positioning_frame, "UIDropDownMenuTemplate");
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
	local reset_position = CreateFrame("Button", "ResetPositions", child_positioning_frame, "UIPanelButtonTemplate");
	reset_position:SetPoint("TOPLEFT", buster_position_label, "BOTTOMLEFT", 0, -100);
	reset_position:SetText(CBL["CONFIG_POSITIONS_RESET"]);
	reset_position:SetSize(160, 24);
	reset_position:SetScript("OnClick", function() 
		CraftBuster_SkillFrame_ResetPosition();
		CraftBuster_GatherFrame_ResetPosition();
		CraftBuster_BusterFrame_ResetPosition();

		position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
		position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));
		UIDropDownMenu_SetSelectedValue(position_point, CraftBusterOptions[CraftBusterEntry].skills_frame.position.point);
		UIDropDownMenu_SetSelectedValue(position_relative_point, CraftBusterOptions[CraftBusterEntry].skills_frame.position.relative_point);

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
local child_actions_frame = CreateFrame("Frame", config_frame_name .. "Actions", config_frame);
child_actions_frame.name = "Actions";
child_actions_frame.parent = config_frame.name;
child_actions_frame:SetScript("OnShow", function(child_actions_frame)
	local title = child_actions_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:SetPoint("TOPLEFT", 16, -16);
	title:SetText(CBG_MOD_NAME .. " - Actions");

	child_actions_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_actions_frame);

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

--There's probably a bettr way to do this but I'm not in the mood to figure it out right now...
local function updateFields()
	if (player_class == "ROGUE" and UnitLevel("player") >= 20) then
		skills.lockpicking = CBT_SKILL_PICK;
	end

	show_minimap_button:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.tooltip_info) then
				tooltips[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips);
			end
		end
	end

	show_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	for rank,skill in sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			professions[skill]:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
		end
	end

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.bustable_spell) then
				bustables[module_id]:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
			end
		end
	end

	show_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show);
	expand_gatherer:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded");
	show_zone_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes);
	show_skillup_nodes:SetChecked(CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes);

	position_x:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x, 2));
	position_y:SetText(round(CraftBusterOptions[CraftBusterEntry].skills_frame.position.y, 2));

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