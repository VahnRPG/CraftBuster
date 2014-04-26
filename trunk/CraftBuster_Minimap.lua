function CraftBuster_Minimap_Update()
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_OnClick(self, button, down)
	if (button == "LeftButton") then
		--ToggleDropDownMenu(1, nil, CraftBuster_MinimapButtonDropDown, "CraftBuster_MinimapButton", 0, -5);
		--PlaySound("igMainMenuOptionCheckBoxOn");
	elseif (button == "RightButton") then
		CraftBuster_Config_Show();
	end
end

function CraftBuster_MinimapDropDown_OnLoad(self)
	UIDropDownMenu_Initialize(self, CraftBuster_MinimapDropDown_Initialize, "MENU");
	self.noResize = true;
end

function CraftBuster_MinimapDropDownButton_ShowTracking()
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].skills_frame.show) then
		return true;
	end
	return false;
end

function CraftBuster_MinimapDropDownButton_ShowGatherer()
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].gather_frame.show) then
		return true;
	end
	return false;
end

function CraftBuster_MinimapDropDownButton_ShowZoneNodes()
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes) then
		return true;
	end
	return false;
end

function CraftBuster_MinimapDropDownButton_ShowSkillUpNodes()
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes) then
		return true;
	end
	return false;
end

function CraftBuster_MinimapDropDownButton_TrackingIsActive(button)
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].skills_frame.bars[button.arg1]) then
		return true;
	end
	return false;
end

function CraftBuster_MinimapDropDownButton_TooltipIsActive(button)
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].modules[button.arg1].show_tooltips) then
		return true;
	end
	return false;
end

function CraftBuster_MinimapDropDownButton_BusterIsActive(button)
	if (CraftBusterEntry ~= nil and CraftBusterOptions[CraftBusterEntry].modules[button.arg1].show_buster) then
		return true;
	end
	return false;
end

function CraftBuster_Minimap_SetShowWorldMapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetShowMinimapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetShowTracking(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].skills_frame.show = checked;
	CraftBuster_SkillFrame_Update();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetShowGatherer(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.show = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetAutoHideGatherer(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetShowZoneNodes(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetSkillUpNodes(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetTracking(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].skills_frame.bars[id] = checked;
	CraftBuster_SkillFrame_Update();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetTooltip(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_tooltips = checked;
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetTrainerMapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_trainer_map_icons = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetStationMapIcons(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_station_map_icons = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetBuster(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_buster = checked;
	CraftBuster_SkillFrame_Update();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_Minimap_SetProfessionGather(self, id, unused, checked)
	CraftBusterOptions[CraftBusterEntry].modules[id].show_gather = checked;
	CraftBuster_UpdateZone();
	UIDropDownMenu_Refresh(CraftBuster_MinimapButtonDropDown);
end

function CraftBuster_MinimapDropDown_Initialize()
	local info = UIDropDownMenu_CreateInfo();
	info.text = CBL["CONFIG_TITLE_TRACK_PROFESSION"];
	info.isTitle = true;
	info.notCheckable = true;
	info.keepShownOnClick = true;
	UIDropDownMenu_AddButton(info);

	info = UIDropDownMenu_CreateInfo();
	info.text = CBL["CONFIG_SHOW_TRACKER"];
	info.checked = CraftBuster_MinimapDropDownButton_ShowTracking;
	info.func = CraftBuster_Minimap_SetShowTracking;
	info.isNotRadio = true;
	info.keepShownOnClick = true;
	UIDropDownMenu_AddButton(info);

	local skills = CraftBuster_GetProfessions();
	local rank_skills = {
		[1] = "skill_1",
		[2] = "skill_2",
		[3] = "cooking",
		[4] = "first_aid",
		[5] = "fishing",
		[7] = "archaeology",
	};
	if (player_class == "ROGUE") then
		rank_skills[8] = "lockpicking";
	end
	for rank,skill in sortedpairs(rank_skills) do
		local index = skills[skill];
		if (index) then
			local skill_name, skill_texture, skill_level, skill_max_level, skill_num_spells, _, skill_id = GetProfessionInfo(index);
			if (player_class == "ROGUE" and skill == "lockpicking" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
				skill_name, _, skill_texture = GetSpellInfo(index);
				skill_level = (UnitLevel("player") * 5);
				skill_max_level = 425;
				skill_num_spells = 1;
				skill_id = index;
			end

			info = UIDropDownMenu_CreateInfo();
			info.text = skill_name;
			info.checked = CraftBuster_MinimapDropDownButton_TrackingIsActive;
			info.func = CraftBuster_Minimap_SetTracking;
			info.icon = skill_texture;
			info.arg1 = skill;
			info.isNotRadio = true;
			info.keepShownOnClick = true;
			UIDropDownMenu_AddButton(info);
		end
	end

	info = UIDropDownMenu_CreateInfo();
	info.text = CBL["CONFIG_TITLE_TRACK_GATHERING"];
	info.isTitle = true;
	info.notCheckable = true;
	info.keepShownOnClick = true;
	UIDropDownMenu_AddButton(info);

	info = UIDropDownMenu_CreateInfo();
	info.text = CBL["CONFIG_SHOW_GATHERER"];
	info.checked = CraftBuster_MinimapDropDownButton_ShowGatherer;
	info.func = CraftBuster_Minimap_SetShowGatherer;
	info.isNotRadio = true;
	info.keepShownOnClick = true;
	UIDropDownMenu_AddButton(info);

	info = UIDropDownMenu_CreateInfo();
	info.text = CBL["CONFIG_SHOW_ZONE_NODES"];
	info.checked = CraftBuster_MinimapDropDownButton_ShowZoneNodes;
	info.func = CraftBuster_Minimap_SetShowZoneNodes;
	info.isNotRadio = true;
	info.keepShownOnClick = true;
	UIDropDownMenu_AddButton(info);

	info = UIDropDownMenu_CreateInfo();
	info.text = CBL["CONFIG_SHOW_SKILLUP_NODES"];
	info.checked = CraftBuster_MinimapDropDownButton_ShowSkillUpNodes;
	info.func = CraftBuster_Minimap_SetSkillUpNodes;
	info.isNotRadio = true;
	info.keepShownOnClick = true;
	UIDropDownMenu_AddButton(info);

	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		local info = UIDropDownMenu_CreateInfo();
		info.text = CBL["CONFIG_TITLE_TOOLTIP_INFO"];
		info.isTitle = true;
		info.notCheckable = true;
		info.keepShownOnClick = true;
		UIDropDownMenu_AddButton(info);

		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.tooltip_info) then
				info = UIDropDownMenu_CreateInfo();
				info.text = CraftBuster_Modules[module_id].name;
				info.checked = CraftBuster_MinimapDropDownButton_TooltipIsActive;
				info.func = CraftBuster_Minimap_SetTooltip;
				--info.icon = skill_texture;
				info.arg1 = module_id;
				info.isNotRadio = true;
				info.keepShownOnClick = true;
				UIDropDownMenu_AddButton(info);
			end
		end

		local info = UIDropDownMenu_CreateInfo();
		info.text = CBL["CONFIG_TITLE_BUSTER_ICON"];
		info.isTitle = true;
		info.notCheckable = true;
		info.keepShownOnClick = true;
		UIDropDownMenu_AddButton(info);

		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.bustable_spell) then
				info = UIDropDownMenu_CreateInfo();
				info.text = CraftBuster_Modules[module_id].name;
				info.checked = CraftBuster_MinimapDropDownButton_BusterIsActive;
				info.func = CraftBuster_Minimap_SetBuster;
				--info.icon = skill_texture;
				info.arg1 = module_id;
				info.isNotRadio = true;
				info.keepShownOnClick = true;
				UIDropDownMenu_AddButton(info);
			end
		end
	end
end

function CraftBuster_Minimap_Init()
	if (CraftBusterOptions[CraftBusterEntry].minimap.show) then
		CraftBuster_MinimapFrame:Show();
	else
		CraftBuster_MinimapFrame:Hide();
	end
	CraftBuster_Minimap_UpdatePosition();
end

function CraftBuster_Minimap_OnEnter()
	GameTooltip:SetOwner(CraftBuster_MinimapFrame, "ANCHOR_LEFT");
	GameTooltip:AddLine(CBG_MOD_COLOR .. CBG_MOD_NAME);
	GameTooltip:AddLine(CBL["MINIMAP_HOVER_LINE1"]);
	--GameTooltip:AddLine(CBL["MINIMAP_HOVER_LINE2"]);
	GameTooltip:AddLine(CBL["MINIMAP_HOVER_LINE3"]);
	GameTooltip:Show();
end

function CraftBuster_Minimap_OnDrag()
	local xpos, ypos = GetCursorPosition();
	local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = (xmin - xpos) / UIParent:GetScale() + 80;
	ypos = (ypos / UIParent:GetScale()) - ymin - 80;

	local angle = math.deg(math.atan2(ypos, xpos));
	if (angle < 0) then
		angle = angle + 360;
	end;

	CraftBusterOptions[CraftBusterEntry].minimap.position = angle;
	CraftBuster_Minimap_UpdatePosition();
end

function CraftBuster_Minimap_UpdatePosition()
	local radius = 80;
	local angle = CraftBusterOptions[CraftBusterEntry].minimap.position;

	CraftBuster_MinimapFrame:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", (52 - (radius * cos(angle))), ((radius * sin(angle)) - 52));
end

function CraftBuster_Minimap_Toggle()
	if (CraftBuster_MinimapFrame:IsVisible()) then
		CraftBuster_MinimapFrame:Hide();
		CraftBusterOptions[CraftBusterEntry].minimap.show = false;
	else
		CraftBuster_MinimapFrame:Show()
		CraftBusterOptions[CraftBusterEntry].minimap.show = true;
	end
end