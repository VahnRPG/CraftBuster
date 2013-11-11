local config_frame_name = "CraftBuster_ConfigFrame";

local config_frame = CreateFrame("Frame", config_frame_name, InterfaceOptionsFramePanelContainer);
config_frame.name = CBG_MOD_NAME;
config_frame:SetScript("OnShow", function(config_frame)
	local count = 0;

	local title = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:SetPoint("TOPLEFT", 16, -16);
	title:SetText(CBG_MOD_NAME .. " v" .. CBG_VERSION);

	local minimap = CreateFrame("CheckButton", config_frame_name .. "Minimap", config_frame, "InterfaceOptionsCheckButtonTemplate");
	minimap:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20);
	_G[minimap:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_MINIMAP"]);
	minimap:SetChecked(CraftBusterOptions[CraftBusterEntry].minimap.show);
	minimap:SetScript("OnClick", function(self, button)
		CraftBusterOptions[CraftBusterEntry].minimap.show = self:GetChecked();
		CraftBuster_MiniMap_Init();
	end);

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		local tooltips = config_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		tooltips:SetPoint("TOPLEFT", minimap, "BOTTOMLEFT", 0, -24);
		tooltips:SetText(CBL["CONFIG_TITLE_TOOLTIP_INFO"]);

		count = 0;
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.tooltip_info) then
				local tooltip = CreateFrame("CheckButton", config_frame_name .. "Tooltips" .. module_id, config_frame, "InterfaceOptionsCheckButtonTemplate");
				tooltip:SetPoint("TOPLEFT", tooltips, "BOTTOMLEFT", 0, -20 * count);
				_G[tooltip:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				--echo("Here1: " .. module_id .. ", " .. (tooltip:GetChecked() and "checked" or "unchecked"));
				tooltip:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips);
				--echo("Here2: " .. module_id .. ", " .. (tooltip:GetChecked() and "checked" or "unchecked"));
				tooltip:SetScript("OnClick", function(self, button)
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

	local title = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	title:SetPoint("TOPLEFT", 16, -16);
	title:SetText(CBG_MOD_NAME .. " - Tracker");

	local tracker = CreateFrame("CheckButton", config_frame_name .. "Tracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	tracker:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -20);
	_G[tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_SHOW_TRACKER"]);
	tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.show);
	tracker:SetScript("OnClick", function(self, button)
		CraftBuster_MiniMap_SetShowTracking(self, _, _, self:GetChecked());
	end);

	local expand_tracker = CreateFrame("CheckButton", config_frame_name .. "ExpandTracker", child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
	expand_tracker:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -40);
	_G[expand_tracker:GetName() .. "Text"]:SetText(CBL["CONFIG_EXPAND_TRACKER"]);
	expand_tracker:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded");
	expand_tracker:SetScript("OnClick", function(self, button)
		CraftBuster_SkillFrame_Collapse_OnClick();
	end);

	local track_professions = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	track_professions:SetPoint("TOPLEFT", expand_tracker, "BOTTOMLEFT", 0, -24);
	track_professions:SetText(CBL["CONFIG_TITLE_TRACK_PROFESSION"]);

	local skills = {
		["skill_1"] = nil,
		["skill_2"] = nil,
		["cooking"] = nil,
		["first_aid"] = nil,
		["fishing"] = nil,
		["archaeology"] = nil,
		["lockpicking"] = nil,
	};
	skills.skill_1, skills.skill_2, skills.archaeology, skills.fishing, skills.cooking, skills.first_aid = GetProfessions();
	local _, player_class = UnitClass("player");
	if (player_class == "ROGUE" and UnitLevel("player") >= 20) then
		skills.lockpicking = CBT_SKILL_PICK;
	end

	count = 0;
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
	end
	for rank,skill in sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			local skill_name, skill_texture = GetProfessionInfo(index);
			if (player_class == "ROGUE" and skill == "lockpicking" and UnitLevel("player") >= 20) then
				skill_name, _, skill_texture = GetSpellInfo(index);
			end

			local profession = CreateFrame("CheckButton", config_frame_name .. "TrackProfessions" .. skill, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
			profession:SetPoint("TOPLEFT", track_professions, "BOTTOMLEFT", 0, -20 * count);
			_G[profession:GetName() .. "Text"]:SetText(skill_name);
			profession:SetChecked(CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]);
			profession:SetScript("OnClick", function(self, button)
				CraftBuster_MiniMap_SetTracking(self, skill, _, self:GetChecked());
			end);

			count = count + 1;
		end
	end
	
	local bustables = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	bustables:SetPoint("TOPLEFT", track_professions, "BOTTOMLEFT", 0, -(24 + 20 * count));

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		bustables:SetText(CBL["CONFIG_TITLE_BUSTER_ICON"]);

		count = 0;
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.bustable_spell) then
				local bustable = CreateFrame("CheckButton", config_frame_name .. "Bustables" .. module_id, child_tracker_frame, "InterfaceOptionsCheckButtonTemplate");
				bustable:SetPoint("TOPLEFT", bustables, "BOTTOMLEFT", 0, -20 * count);
				_G[bustable:GetName() .. "Text"]:SetText(CraftBuster_Modules[module_id].name);
				bustable:SetChecked(CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster);
				bustable:SetScript("OnClick", function(self, button)
					CraftBuster_MiniMap_SetBuster(self, module_id, _, self:GetChecked());
				end);

				count = count + 1;
			end
		end
	end
	
	local position = child_tracker_frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
	position:SetPoint("TOPLEFT", bustables, "BOTTOMLEFT", 0, -(24 + 20 * count));
	position:SetText(CBL["CONFIG_POSITION_TRACKER"]);
	
	local position_x = CreateFrame("EditBox", "PositionX", child_tracker_frame, "InputBoxTemplate");
	position_x:SetPoint("TOPLEFT", position, "BOTTOMLEFT", 0, -20);
	position_x:SetSize(64, 16);
	position_x:SetText(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x);
	--_G[position_x:GetName() .. "Text"]:SetText(CraftBusterOptions[CraftBusterEntry].skills_frame.position.x);

	child_tracker_frame:SetScript("OnShow", nil);
end);
InterfaceOptions_AddCategory(child_tracker_frame);

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

function CraftBuster_Config_RegisterModule(module_id, module_name, module_options)
	local module_config_frame = module_options.config.frame;
	--module_config_frame.name = module_options.config.name;
	module_config_frame.parent = config_frame.name;
	InterfaceOptions_AddCategory(module_config_frame);
end

function CraftBuster_Config_Show()
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);
	InterfaceOptionsFrame_OpenToCategory(config_frame.name);		--hack for patch 5.3
end