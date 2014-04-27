function CraftBuster_SkillFrame_Update()
	local skills = CraftBuster_GetProfessions(false);
	local _, player_class = UnitClass("player");
	local player_level = UnitLevel("player");
	if (CraftBusterOptions[CraftBusterEntry].skills_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded") then
			local count = -1;
			local rank_skills = {
				[0] = "skill_1",
				[1] = "skill_2",
				[2] = "cooking",
				[3] = "first_aid",
				[4] = "fishing",
				[5] = "archaeology",
			};
			if (player_class == "ROGUE" and player_level >= CBG_LOCKPICKING_LEVEL) then
				rank_skills[6] = "lockpicking";
			end
			for rank,skill in sortedpairs(rank_skills) do
				local index = skills[skill];
				if (index) then
					local bar_frame = _G["CraftBuster_SkillFrame_" .. skill];
					if (bar_frame) then
						if (CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]) then
							count = count + 1;

							local skill_name, skill_texture, skill_level, skill_max_level, skill_num_spells, _, skill_id, skill_bonus = GetProfessionInfo(index);
							if (player_class == "ROGUE" and skill == "lockpicking" and player_level >= CBG_LOCKPICKING_LEVEL) then
								skill_name, _, skill_texture = GetSpellInfo(index);
								skill_level = (player_level * 5);
								skill_max_level = 425 + 100;
								skill_num_spells = 1;
								skill_id = index;
							end

							local skill_bonus_text = "";
							if (skill_bonus ~= nil and skill_bonus > 0) then
								skill_bonus_text = CBG_CLR_OFFBLUE .. " + " .. skill_bonus .. CBG_CLR_WHITE;
							end

							local module_data = CraftBuster_Modules[skill_id];
							bar_frame:SetPoint("TOPLEFT", "CraftBuster_SkillFrame", "TOPLEFT", 5, -(count * 18) - 5);
							bar_frame:SetValue(skill_level / skill_max_level);
							if ((skill_level >= (skill_max_level - 25)) and (skill_max_level < CBG_PROFESSION_RANKS[CBG_MAX_PROFESSIONS][2])) then
								local profession_level = CraftBuster_GetProfessionLevel(skill_max_level) + 1;
								local profession_ply_lvl;
								if (module_data.skill_type == CBG_SKILL_NORMAL) then
									profession_ply_lvl = CBG_SKILL_PLY_LEVELS[profession_level][1];
								else
									profession_ply_lvl = CBG_SKILL_PLY_LEVELS[profession_level][2];
								end
								local title = CBG_PROFESSION_RANKS[profession_level][3];

								if (profession_ply_lvl <= CraftBusterPlayerLevel) then
									bar_frame:SetStatusBarColor(0.7, 0.0, 0.0, 1.0);
									bar_frame:SetBackdropColor(0.7, 0.0, 0.0, 0.5);
									_G[bar_frame:GetName() .. "Text"]:SetText(CBG_CLR_RED .. skill_name .. ": " .. CBG_CLR_WHITE .. skill_level .. skill_bonus_text .. "/" .. skill_max_level);
									bar_frame:SetScript("OnEnter", function(self)
										GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
										GameTooltip:SetText(string.format(CBL["SKILL_FRAME_VISIT_TRAINER"], skill_name, title));
										GameTooltip:Show();
									end);
									bar_frame:SetScript("OnLeave", function(self)
										GameTooltip:Hide();
									end);
								else
									bar_frame:SetStatusBarColor(0.0, 0.0, 0.7, 1.0);
									bar_frame:SetBackdropColor(0.0, 0.0, 0.7, 0.5);
									_G[bar_frame:GetName() .. "Text"]:SetText(CBG_CLR_BLUE .. skill_name .. ": " .. CBG_CLR_WHITE .. skill_level .. skill_bonus_text .. "/" .. skill_max_level);
									bar_frame:SetScript("OnEnter", function(self)
										GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
										GameTooltip:SetText(string.format(CBL["SKILL_FRAME_LEVEL_UP"], profession_ply_lvl, skill_name, title));
										GameTooltip:Show();
									end);
									bar_frame:SetScript("OnLeave", function(self)
										GameTooltip:Hide();
									end);
								end
							else
								bar_frame:SetStatusBarColor(0.0, 0.7, 0.0, 1.0);
								bar_frame:SetBackdropColor(0.0, 0.7, 0.0, 0.5);
								_G[bar_frame:GetName() .. "Text"]:SetText(CBG_CLR_DEFAULT .. skill_name .. ": " .. CBG_CLR_WHITE .. skill_level .. skill_bonus_text .. "/" .. skill_max_level);
								bar_frame:SetScript("OnEnter", nil);
								bar_frame:SetScript("OnLeave", nil);
							end

							if (not InCombatLockdown()) then
								local spell_buster_frame = _G[bar_frame:GetName() .. "_buster"];
								spell_buster_frame:Hide();
								if (module_data.spell_buster ~= nil and spell_buster_frame and CraftBusterOptions[CraftBusterEntry].modules[skill_id].show_buster) then
									local spell_name, _, button_texture = GetSpellInfo(module_data.spell_buster);
									_G[spell_buster_frame:GetName() .. "Icon"]:SetTexture(button_texture);
									spell_buster_frame.spell_id = module_data.spell_buster_id;
									spell_buster_frame:SetScript("OnClick", function(self)
										CraftBusterOptions[CraftBusterEntry].buster_frame.show = not CraftBuster_Buster_MoverFrame:IsVisible();
										CraftBuster_BusterFrame_Update(skill, skill_id, self.spell_id);
									end);
									spell_buster_frame:SetScript("OnEnter", function(self)
										GameTooltip_SetDefaultAnchor(GameTooltip, self);
										GameTooltip:SetSpellByID(self.spell_id);
										GameTooltip:AppendText(CBL["BUSTER_SPELL_TOOLTIP_APPEND"]);
										GameTooltip:AddLine(CBL["BUSTER_SPELL_TOOLTIP_LINE1"]);
										GameTooltip:Show();
									end);
									spell_buster_frame:Show();
								end

								local spell_1_frame = _G[bar_frame:GetName() .. "_spell_1"];
								spell_1_frame:Hide();
								if (module_data.spell_1 ~= nil and spell_1_frame) then
									spell_1_frame:SetAttribute("type", "spell");
									spell_1_frame:SetAttribute("spell", module_data.spell_1);
									local _, _, button_texture = GetSpellInfo(module_data.spell_1);
									_G[spell_1_frame:GetName() .. "Icon"]:SetTexture(button_texture);
									spell_1_frame.spell_id = module_data.spell_1_id;
									spell_1_frame:Show();
								end

								local spell_2_frame = _G[bar_frame:GetName() .. "_spell_2"];
								spell_2_frame:Hide();
								if (module_data.spell_2 ~= nil and spell_2_frame) then
									spell_2_frame:SetAttribute("type", "spell");
									spell_2_frame:SetAttribute("spell", module_data.spell_2);
									local _, _, button_texture = GetSpellInfo(module_data.spell_2);
									_G[spell_2_frame:GetName() .. "Icon"]:SetTexture(button_texture);
									spell_2_frame.spell_id = module_data.spell_2_id;
									spell_2_frame:Show();
								end
							end
							bar_frame:Show();
						else
							bar_frame:Hide();
						end
					end
				end
			end
			if (count > -1) then
				CraftBuster_Skill_MoverFrame:Show();
				CraftBuster_Skill_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				CraftBuster_SkillFrame:SetHeight(28 + (count * 18));
				CraftBuster_SkillFrame:Show();
			else
				CraftBuster_Skill_MoverFrame:Hide();
				CraftBuster_SkillFrame:Hide();
			end
		else
			CraftBuster_Skill_MoverFrame:Show();
			CraftBuster_Skill_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			CraftBuster_SkillFrame:Hide();
		end
	else
		CraftBuster_Skill_MoverFrame:Hide();
		CraftBuster_SkillFrame:Hide();
	end
end

function CraftBuster_SkillFrame_Collapse_OnClick()
	if (CraftBuster_SkillFrame:IsShown()) then
		CraftBuster_SkillFrame:Hide();
		CraftBusterOptions[CraftBusterEntry].skills_frame.state = "collapsed";
	else
		CraftBuster_SkillFrame:Show();
		CraftBusterOptions[CraftBusterEntry].skills_frame.state = "expanded";
	end

	CraftBuster_SkillFrame_Update();
end

function CraftBuster_SkillFrame_Close_OnClick()
	CraftBuster_Skill_MoverFrame:Hide();
	CraftBuster_SkillFrame:Hide();
	if (not CraftBuster_Skill_MoverFrame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].skills_frame.show = false;
	end
end

function CraftBuster_SkillFrame_OnDrag()
	local point, _, relative_point, x, y = CraftBuster_Skill_MoverFrame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.y = y;
	CraftBuster_SkillFrame_UpdatePosition();
end

function CraftBuster_SkillFrame_UpdatePosition()
	local position = CraftBusterOptions[CraftBusterEntry].skills_frame.position;
	CraftBuster_Skill_MoverFrame:ClearAllPoints();
	CraftBuster_Skill_MoverFrame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function CraftBuster_SkillFrame_ResetPosition()
	CraftBusterOptions[CraftBusterEntry].skills_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	CraftBuster_SkillFrame_UpdatePosition();
end