local _, cb = ...;

cb.skill_frame = {};
cb.skill_frame.mover_frame = CreateFrame("Frame", "CraftBuster_SkillFrame_MoverFrame", UIParent, "CraftBuster_MoverBar_Template");
cb.skill_frame.mover_frame:SetSize(234, 10);
cb.skill_frame.mover_frame:RegisterForDrag("LeftButton");
cb.skill_frame.mover_frame:SetScript("OnDragStart", function(self)
	if (not CraftBusterOptions[CraftBusterEntry].skills_frame.locked) then
		self.dragging = true;
		self:StartMoving();
	end
end);
cb.skill_frame.mover_frame:SetScript("OnDragStop", function(self)
	if (not CraftBusterOptions[CraftBusterEntry].skills_frame.locked) then
		self.dragging = false;
		self:StopMovingOrSizing();
	end
end);
cb.skill_frame.mover_frame:SetScript("OnUpdate", function(self)
	if (self.dragging) then
		cb.skill_frame:dragFrame();
	end
end);
CraftBuster_SkillFrame_MoverFrameLabel:SetText("Professions");
CraftBuster_SkillFrame_MoverFrame_LockFrame:SetScript("OnClick", function(self)
	cb.skill_frame:lockFrame();
end);
CraftBuster_SkillFrame_MoverFrame_CollapseFrame:SetScript("OnClick", function(self)
	cb.skill_frame:collapseFrame();
end);
CraftBuster_SkillFrame_MoverFrame_CloseFrame:SetScript("OnClick", function(self)
	cb.skill_frame:closeFrame();
end);

cb.skill_frame.frame = CreateFrame("Frame", "CraftBuster_SkillFrame_Frame", UIParent, "CraftBuster_ContainerFrame_Template");
cb.skill_frame.frame:SetSize(234, 10);
cb.skill_frame.frame:SetPoint("TOPLEFT", cb.skill_frame.mover_frame, "BOTTOMLEFT", 0, 2);
cb.skill_frame.frame:RegisterEvent("ADDON_LOADED");
cb.skill_frame.frame:SetScript("OnEvent", function(self, event, ...)
	if (CraftBusterInit) then
		return cb.skill_frame[event] and cb.skill_frame[event](qb, ...)
	end
end);
cb.skill_frame.skill_frames = {};

function cb.skill_frame:ADDON_LOADED()
	cb.skill_frame.skill_frames = {};
	for rank, skill in cb.omg:sortedpairs(CBG_SKILL_FRAMES) do
		local frame = CreateFrame("StatusBar", "CraftBuster_SkillFrame_" .. skill .. "Frame", cb.skill_frame.frame, "CraftBuster_SkillBar_Template");
		frame:SetPoint("TOPLEFT", cb.skill_frame.frame, "TOPLEFT", 5, -5);
		frame:SetMinMaxValues(0, 1);
		frame:SetValue(0);
		frame:Hide();
		
		cb.skill_frame.skill_frames[rank] = frame;
	end
	
	cb.skill_frame.frame:UnregisterEvent("ADDON_LOADED");
end

function cb.skill_frame:update()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand("CraftBuster_SkillFrame_Update");
		return;
	end

	local skills = cb:getProfessions(false);
	local _, player_class = UnitClass("player");
	local player_level = UnitLevel("player");
	if (CraftBusterOptions[CraftBusterEntry].skills_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].skills_frame.state == "expanded") then
			local count = -1;
			local rank_skills = {
				[1] = "skill_1",
				[2] = "skill_2",
				[3] = "cooking",
				[4] = "first_aid",
				[5] = "fishing",
				[6] = "archaeology",
			};
			if (player_class == "ROGUE" and player_level >= CBG_LOCKPICKING_LEVEL) then
				rank_skills[7] = "lockpicking";
			end
			for rank, skill in cb.omg:sortedpairs(rank_skills) do
				local index = skills[skill];
				if (index) then
					local bar_frame = cb.skill_frame.skill_frames[rank];
					if (bar_frame) then
						bar_frame:Hide();
						if (CraftBusterOptions[CraftBusterEntry].skills_frame.bars[skill]) then
							count = count + 1;

							local skill_name, skill_texture, skill_level, skill_max_level, skill_num_spells, _, skill_id, skill_bonus = GetProfessionInfo(index);
							if (player_class == "ROGUE" and skill == "lockpicking" and player_level >= CBG_LOCKPICKING_LEVEL) then
								skill_name, _, skill_texture = GetSpellInfo(index);
								skill_level = (player_level * 5);
								skill_max_level = CBG_LOCKPICKING_MAX_SKILL_LEVEL;
								skill_num_spells = 1;
								skill_id = index;
							end

							local skill_bonus_text = "";
							if (skill_bonus ~= nil and skill_bonus > 0) then
								skill_bonus_text = CBG_CLR_OFFBLUE .. " + " .. skill_bonus .. CBG_CLR_WHITE;
							end

							bar_frame:SetPoint("TOPLEFT", cb.skill_frame.frame, "TOPLEFT", 5, -(count * 18) - 5);
							bar_frame:SetValue(skill_level / skill_max_level);
							local module_data = cb.professions.modules[skill_id];
							if ((skill_level >= (skill_max_level - 25)) and (skill_max_level < CBG_PROFESSION_RANKS[CBG_MAX_PROFESSIONS][2])) then
								local profession_level = cb:getProfessionLevel(skill_max_level) + 1;
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
						end
					end
				end
			end
			if (count > -1) then
				cb.skill_frame.mover_frame:Show();
				_G[cb.skill_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				cb.skill_frame.frame:SetHeight(28 + (count * 18));
				cb.skill_frame.frame:Show();
			else
				cb.skill_frame.mover_frame:Hide();
				cb.skill_frame.frame:Hide();
			end
		else
			cb.skill_frame.mover_frame:Show();
			_G[cb.skill_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			cb.skill_frame.frame:Hide();
		end

		if (not CraftBusterOptions[CraftBusterEntry].skills_frame.locked) then
			_G[cb.skill_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Unlocked");
		else
			_G[cb.skill_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Locked");
		end
	else
		cb.skill_frame.mover_frame:Hide();
		cb.skill_frame.frame:Hide();
	end
end

function cb.skill_frame:lockFrame()
	if (not CraftBusterOptions[CraftBusterEntry].skills_frame.locked) then
		CraftBusterOptions[CraftBusterEntry].skills_frame.locked = true;
	else
		CraftBusterOptions[CraftBusterEntry].skills_frame.locked = false;
	end
	cb.skill_frame:update();
end

function cb.skill_frame:collapseFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand("CraftBuster_SkillFrame_Collapse_OnClick");
		return;
	end
	
	if (cb.skill_frame.frame:IsShown()) then
		cb.skill_frame.frame:Hide();
		CraftBusterOptions[CraftBusterEntry].skills_frame.state = "collapsed";
	else
		cb.skill_frame.frame:Show();
		CraftBusterOptions[CraftBusterEntry].skills_frame.state = "expanded";
	end
	cb.skill_frame:update();
end

function CraftBuster_SkillFrame_Collapse_OnClick()
	cb.skill_frame:collapseFrame();
end

function cb.skill_frame:closeFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand("CraftBuster_SkillFrame_Close_OnClick");
		return;
	end
	
	cb.skill_frame.mover_frame:Hide();
	cb.skill_frame.frame:Hide();
	if (not cb.skill_frame.mover_frame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].skills_frame.show = false;
	end
end

function cb.skill_frame:dragFrame()
	local point, _, relative_point, x, y = cb.skill_frame.mover_frame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].skills_frame.position.y = y;
	cb.skill_frame:updatePosition();
end

function cb.skill_frame:updatePosition()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand("CraftBuster_SkillFrame_UpdatePosition");
		return;
	end
	local position = CraftBusterOptions[CraftBusterEntry].skills_frame.position;
	cb.skill_frame.mover_frame:ClearAllPoints();
	cb.skill_frame.mover_frame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function cb.skill_frame:resetPosition()
	CraftBusterOptions[CraftBusterEntry].skills_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	cb.skill_frame:updatePosition();
end