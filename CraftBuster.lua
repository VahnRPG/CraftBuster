local _, cb = ...;
cb.player_skills = {};

--==BINDING==--
BINDING_HEADER_CRAFTBUSTER = CBG_MOD_NAME;
BINDING_NAME_CB_TOGGLE_SKILL_FRAME = CBL["BINDING_TOGGLE_SKILL_FRAME"];
BINDING_NAME_CB_OPEN_SKILL_1 = CBL["BINDING_OPEN_SKILL_1"];
BINDING_NAME_CB_OPEN_SKILL_1_BUSTER = CBL["BINDING_OPEN_SKILL_1_BUSTER"];
BINDING_NAME_CB_OPEN_SKILL_2 = CBL["BINDING_OPEN_SKILL_2"];
BINDING_NAME_CB_OPEN_SKILL_2_BUSTER = CBL["BINDING_OPEN_SKILL_2_BUSTER"];
BINDING_NAME_CB_OPEN_COOKING = CBL["BINDING_OPEN_COOKING"];
BINDING_NAME_CB_OPEN_ARCHAEOLOGY = CBL["BINDING_OPEN_ARCHAEOLOGY"];
BINDING_NAME_CB_OPEN_LOCKPICKING_BUSTER = CBL["BINDING_OPEN_LOCKPICKING_BUSTER"];

--==SLASH COMMANDS==--
SLASH_CBUSTER1 = "/craftbuster";
SLASH_CBUSTER2 = "/cbuster";
SLASH_CBUSTER3 = "/cb";

SlashCmdList["CBUSTER"] = function(cmd)
	cmd = string.lower(cmd);

	if (cmd == "help") then
		for i = 1, CBL["HELP_LINES"] do
			cb.omg:echo(CBL["HELP" .. i]);
		end
	elseif (cmd == "config") then
		CraftBuster_Config_Show();
	elseif (cmd == "reset") then
		cb.settings:initSettings("character");
		cb:updateSkills(true);
	elseif (cmd == "fullreset") then
		cb.settings:initSettings(true);
		cb:updateSkills(true);
	elseif (cmd == "clearignore") then
		cb.modules.buster_frame:clearIgnore();
	elseif (cmd == "update") then
		cb:updateSkills(true);
	elseif (cmd == "dump") then
		cb:dumpProfession();
	elseif (cmd == "where") then
		cb.modules.map_icons:displayPosition();
	end
end

cb.frame = CreateFrame("Frame", "CraftBusterFrame", UIParent);
cb.frame:RegisterEvent("ADDON_LOADED");
cb.frame:RegisterEvent("CHAT_MSG_SKILL");
cb.frame:RegisterEvent("SKILL_LINES_CHANGED");
cb.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
cb.frame:RegisterEvent("PLAYER_REGEN_ENABLED");
cb.frame:SetScript("OnEvent", function(self, event, ...)
	if (cb.settings.init) then
		return cb[event] and cb[event](cb, ...);
	end
end);

cb.leave_combat_commands = {};

function cb:ADDON_LOADED(self, ...)
	cb.omg:create_timer(2, function()
		cb:updateSkills(true);
	end);
	cb:ZONE_CHANGED_NEW_AREA();

	cb.omg:echo(CBG_MOD_COLOR .. CBG_MOD_NAME .. " (v" .. CBG_VERSION .. " - Last Updated: " .. CBG_LAST_UPDATED .. ")");
	
	cb.frame:UnregisterEvent("ADDON_LOADED");
end

function cb:SKILL_LINES_CHANGED(self, ...)
	cb:updateSkills(true);
end

function cb:ZONE_CHANGED_NEW_AREA()
	cb.modules.map_icons:update();
end

function cb:PLAYER_REGEN_ENABLED()
	if (cb.leave_combat_commands and next(cb.leave_combat_commands)) then
		for i, command in pairs(cb.leave_combat_commands) do
			command();
			table.remove(cb.leave_combat_commands, i);
		end
	end
end

function cb:updateSkills(reload)
	local settings = cb.settings:get();
	local skills = cb:getProfessions(reload);
	for skill, index in pairs(skills) do
		if (index and skill ~= "lockpicking") then
			local skill_name, skill_texture, skill_level, skill_max_level, skill_num_spells, skill_offset, skill_id, skill_bonus = GetProfessionInfo(index);
			if (not settings.skills[skill] or (settings.skills[skill].id ~= skill_id)) then
				settings.skills[skill] = {};
				settings.skills[skill].index = index;
				settings.skills[skill].id = skill_id;
				settings.skills[skill].name = skill_name;
				settings.skills[skill].texture = skill_texture;
			end
			settings.skills[skill].profession_level = cb:getProfessionLevel(skill_max_level);
			settings.skills[skill].level = skill_level;
			settings.skills[skill].bonus = skill_bonus;
			settings.skills[skill].max_level = skill_max_level;
			settings.skills[skill].num_spells = skill_num_spells;
			settings.skills[skill].offset = skill_offset;
			--cb.omg:echo("Profession: " .. skill_name .. " - " .. skill_offset .. " - " .. skill_id);
			cb.professions:handleSkill(skill);
		end
	end

	local _, player_class = UnitClass("player");
	if (player_class == "ROGUE") then
		local index = CBT_SKILL_PICK;
		local skill_id = CBT_SKILL_PICK;
		local skill = "lockpicking";
		skills.lockpicking = skill_id;

		local skill_name, _, skill_texture = GetSpellInfo(index);
		if (not settings.skills[skill] or (settings.skills[skill].id ~= skill_id)) then
			settings.skills[skill] = {};
			settings.skills[skill].index = index;
			settings.skills[skill].id = skill_id;
			settings.skills[skill].name = skill_name;
			settings.skills[skill].texture = skill_texture;
		end
		local skill_level = (UnitLevel("player") * 5);
		local skill_max_level = 425;
		settings.skills[skill].profession_level = cb:getProfessionLevel(skill_max_level);
		settings.skills[skill].level = (UnitLevel("player") * 5);
		settings.skills[skill].max_level = skill_max_level;
		settings.skills[skill].num_spells = 1;
		cb.professions:handleSkill(skill);
	end

	cb.modules.skill_frame:update();
	cb.modules.skill_frame:updatePosition();
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb:handleNode(line_one, line_two, line_three)
	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.node_function ~= nil and cb.settings:get().modules[module_id].show_tooltips) then
				if (module_data.node_function(line_one, line_two, line_three)) then
					return;
				end
			end
		end
	end
end

function cb:addLeaveCombatCommand(callback)
	table.insert(cb.leave_combat_commands, callback);
end

function cb:getProfessions(reload)
	if (cb.player_skills and next(cb.player_skills) and not reload) then
		return cb.player_skills;
	end

	local skills = {
		["skill_1"] = nil,
		["skill_2"] = nil,
		["cooking"] = nil,
		["fishing"] = nil,
		["archaeology"] = nil,
		["lockpicking"] = nil,
	};
	skills.skill_1, skills.skill_2, skills.archaeology, skills.fishing, skills.cooking = GetProfessions();
	local _, player_class = UnitClass("player");
	if (player_class == "ROGUE" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
		skills.lockpicking = CBT_SKILL_PICK;
	end
	cb.player_skills = skills;
	
	return skills;
end

function cb:getSkillLevel(skill_id)
	local skills = {
		[1] = "skill_1",
		[2] = "skill_2",
		[3] = "cooking",
		[4] = "fishing",
		[5] = "archaeology",
		[6] = "lockpicking",
	};

	for i, skill in pairs(skills) do
		local skill_data = cb.settings:get().skills[skill];
		if (skill_data ~= nil and skill_data.id == skill_id) then
			return (skill_data.level + skill_data.bonus);
		end
	end

	return nil;
end

function cb:getProfessionLevel(max_level)
	local profession_level;
	for i=1,#CBG_PROFESSION_RANKS do
		local max_skill_level = CBG_PROFESSION_RANKS[i][2];
		if (max_level < max_skill_level) then
			break;
		end
		profession_level = i;
	end

	return profession_level;
end

function cb:dumpProfession()
	TradeSkillFrame_LoadUI();
	if (C_TradeSkillUI.OpenTradeSkill(182)) then
		local categories = { C_TradeSkillUI.GetCategoryInfo(1044) };
		cb.omg:print_r(categories);
	end
	--CraftBusterOptions["dump_skills"] = nil;
	--[[
	if (not CraftBusterOptions["dump_skills"]) then
		CraftBusterOptions["dump_skills"] = {};
	end

	local skill_id = C_TradeSkillUI.GetTradeSkillLine();
	CraftBusterOptions["dump_skills"][skill_id] = {};

	local categories = { C_TradeSkillUI.GetCategories() };
	for _, category_id in ipairs(categories) do
		CraftBusterOptions["dump_skills"][skill_id][category_id] = C_TradeSkillUI.GetCategoryInfo(category_id);
	end
	]]--
end

-------------------------------------------------------------------------------
-- Hooks in Warcraft code
-------------------------------------------------------------------------------

local hook_frame = CreateFrame("Frame");
hook_frame:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_TradeSkillUI") then
		hooksecurefunc(TradeSkillFrame.DetailsFrame, "SetSelectedRecipeID", function(self)
			local recipe_id = self.selectedRecipeID;
			local tradeskill_id = C_TradeSkillUI.GetTradeSkillLine();
			if (not tradeskill_id) then
				return;
			end
			
			for skill, skill_data in cb.omg:sortedpairs(cb.settings:get().skills) do
				local skill_id = skill_data.id;
				if (skill_id == tradeskill_id) then
					if (cb.professions.modules[skill_id] and next(cb.professions.modules[skill_id])) then
						local module_data = cb.professions.modules[skill_id];
						if (module_data.tradeskill_function ~= nil) then
							module_data.tradeskill_function(tradeskill_id, recipe_id);
							return;
						end
					end
				end
			end
		end);
		self:UnregisterEvent("ADDON_LOADED");
	end
end);
hook_frame:RegisterEvent("ADDON_LOADED");

local function HookFrame(frame)
	frame:HookScript("OnShow", function(self, ...)
		if (not self.show_frame or self.show_frame ~= true) then		--something weird happening to cause this to duplicate itself
			cb:handleNode(GameTooltipTextLeft1:GetText(), GameTooltipTextLeft2:GetText(), "");
			self.show_frame = true;
		end
	end);
	frame:HookScript("OnHide", function(self, ...)
		self.show_frame = false;
	end);
end

HookFrame(GameTooltip);