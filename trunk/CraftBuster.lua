CraftBusterOptions = {};
CraftBusterPlayer = nil;
CraftBusterPlayerLevel = nil;
CraftBusterServer = nil;
CraftBusterEntry = nil;

local _;
local CraftBusterInit = nil;
local CraftBuster_LeaveCombatCommands = {};

--==SLASH COMMANDS==--
SLASH_CBUSTER1 = "/craftbuster";
SLASH_CBUSTER2 = "/cbuster";
SLASH_CBUSTER3 = "/cb";

CraftBuster_Modules = {};

function CraftBuster_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("PLAYER_LEVEL_UP");
	self:RegisterEvent("CHAT_MSG_SKILL");
	self:RegisterEvent("SKILL_LINES_CHANGED");
	self:RegisterEvent("PLAYER_REGEN_ENABLED");

	SlashCmdList["CBUSTER"] = function(msg)
		CraftBuster_Command(msg);
	end
end

function CraftBuster_OnEvent(self, event, ...)
	--echo("Here: " .. event);
	if (event == "ADDON_LOADED") then
		if (CraftBuster_InitPlayer()) then
			CraftBuster_InitSettings();
			CraftBuster_MiniMap_Init();
			CraftBuster_UpdateSkills();
			self:UnregisterEvent(event);
			CraftBusterInit = true;
		end
	elseif (CraftBusterInit and (event == "PLAYER_LEVEL_UP")) then
		CraftBuster_UpdatePlayerLevel(arg1);
	--elseif (CraftBusterInit and (event == "CHAT_MSG_SKILL" or event == "SKILL_LINES_CHANGED")) then
	elseif (CraftBusterInit and event == "SKILL_LINES_CHANGED") then
		--if (not InCombatLockdown()) then
			CraftBuster_UpdateSkills();
		--end
	elseif (CraftBusterInit and event == "PLAYER_REGEN_ENABLED") then
		CraftBuster_ProcessLeaveCombatCommands();
	end
end

function CraftBuster_Command(cmd)
	cmd = string.lower(cmd);

	--[[for index, data in ipairs(CBG_SLASH_CMDS) do
		if (string.match(cmd, data[1])) then
			matches = string.match(cmd, data[1]);
			data[2](matches);
		end
	end]]--
	if (cmd == "help") then
		for i = 1, CBL["HELP_LINES"] do
			DEFAULT_CHAT_FRAME:AddMessage(CBL["HELP" .. i]);
		end
	elseif (cmd == "config") then
		CraftBuster_Config_Show();
	elseif (cmd == "reset") then
		CraftBuster_InitSettings("character");
		CraftBuster_UpdateSkills();
	elseif (cmd == "fullreset") then
		CraftBuster_InitSettings(true);
		CraftBuster_UpdateSkills();
	elseif (cmd == "clearignore") then
		CraftBuster_BusterFrame_ClearIgnore();
	elseif (cmd == "update") then
		CraftBuster_UpdateSkills();
	end
end

function CraftBuster_InitPlayer()
	CraftBusterPlayer = UnitName("player");
	CraftBusterPlayerLevel = UnitLevel("player");
	CraftBusterServer = GetRealmName();
	CraftBusterEntry = CraftBusterPlayer .. "@" .. CraftBusterServer;

	if (CraftBusterPlayer == nil or CraftBusterPlayer == UNKNOWNOBJECT or CraftBusterPlayer == UKNOWNBEING) then
		return false;
	end

	return true;
end

function CraftBuster_InitSettings(reset)
	if (CraftBusterInit and not reset) then
		return;
	end

	if (not CraftBusterOptions or reset == true) then
		CraftBusterOptions = {};
	end
	if (not CraftBusterOptions[CraftBusterEntry] or reset == "character") then
		CraftBusterOptions[CraftBusterEntry] = {};
	end
	if (not CraftBusterOptions[CraftBusterEntry].skills) then
		CraftBusterOptions[CraftBusterEntry].skills = {
			["skill_1"] = nil,
			["skill_2"] = nil,
			["cooking"] = nil,
			["first_aid"] = nil,
			["fishing"] = nil,
			["archaeology"] = nil,
			["lockpicking"] = nil,
		};
	end
	if (not CraftBusterOptions[CraftBusterEntry].skills_frame) then
		CraftBusterOptions[CraftBusterEntry].skills_frame = {};
		CraftBusterOptions[CraftBusterEntry].skills_frame.show = true;
		CraftBusterOptions[CraftBusterEntry].skills_frame.position = {
			point = "TOPLEFT",
			relative_point = "TOPLEFT",
			x = 490,
			y = -330,
		};
		CraftBusterOptions[CraftBusterEntry].skills_frame.state = "expanded";
		CraftBusterOptions[CraftBusterEntry].skills_frame.bars = {
			["skill_1"] = true,
			["skill_2"] = true,
			["cooking"] = true,
			["first_aid"] = true,
			["fishing"] = true,
			["archaeology"] = true,
			["lockpicking"] = false,
		};
		local _, player_class = UnitClass("player");
		if (player_class == "ROGUE") then
			CraftBusterOptions[CraftBusterEntry].skills_frame.bars.lockpicking = true;
		end
	end
	if (not CraftBusterOptions[CraftBusterEntry].buster_frame) then
		CraftBusterOptions[CraftBusterEntry].buster_frame = {};
		CraftBusterOptions[CraftBusterEntry].buster_frame.show = true;
		CraftBusterOptions[CraftBusterEntry].buster_frame.position = {
			point = "TOPLEFT",
			relative_point = "TOPLEFT",
			x = 490,
			y = -330,
		};
		CraftBusterOptions[CraftBusterEntry].buster_frame.state = "expanded";
		CraftBusterOptions[CraftBusterEntry].buster_frame.ignored_items = {};
	end
	if (not CraftBusterOptions[CraftBusterEntry].minimap) then
		CraftBusterOptions[CraftBusterEntry].minimap = {};
		CraftBusterOptions[CraftBusterEntry].minimap.show = true;
		CraftBusterOptions[CraftBusterEntry].minimap.position = 310;
		CraftBuster_MiniMap_Init();
	end
	if (not CraftBusterOptions[CraftBusterEntry].modules) then
		CraftBusterOptions[CraftBusterEntry].modules = {};
	end
	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (not CraftBusterOptions[CraftBusterEntry].modules[module_id]) then
				CraftBusterOptions[CraftBusterEntry].modules[module_id] = {};
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster = true;
			end
		end
	end
	if (not CraftBusterOptions[CraftBusterEntry].alerts) then
		CraftBusterOptions[CraftBusterEntry].alerts = {};
	end
	if (not CraftBusterOptions[CraftBusterEntry].bustables) then
		CraftBusterOptions[CraftBusterEntry].bustables = {};
	end
	if (not CraftBusterOptions[CraftBusterEntry].misc_options) then
		CraftBusterOptions[CraftBusterEntry].misc_options = {};
	end

	DEFAULT_CHAT_FRAME:AddMessage(CBG_CLR_MOD_COLOR .. CBG_MOD_NAME .. " (v" .. CBG_VERSION .. " - Last Updated: " .. CBG_LAST_UPDATED .. ")");
end

function CraftBuster_RegisterModule(module_id, module_name, module_options)
	--echo("Here: " .. module_id .. ", " .. module_name);
	if (not CraftBuster_Modules[module_id]) then
		CraftBuster_Modules[module_id] = {};
		CraftBuster_Modules[module_id].id = module_id;
		CraftBuster_Modules[module_id].name = module_name;
		CraftBuster_Modules[module_id].skill_type = CBG_SKILL_NORMAL;
		CraftBuster_Modules[module_id].spell_1 = nil;
		CraftBuster_Modules[module_id].spell_1_id = nil;
		CraftBuster_Modules[module_id].spell_2 = nil;
		CraftBuster_Modules[module_id].spell_2_id = nil;
		CraftBuster_Modules[module_id].spell_buster = nil;
		CraftBuster_Modules[module_id].spell_buster_id = nil;
		CraftBuster_Modules[module_id].tooltip_info = nil;
		CraftBuster_Modules[module_id].bustable_spell = nil;
		CraftBuster_Modules[module_id].bustable_type = nil;
		CraftBuster_Modules[module_id].bustable_function = nil;
		CraftBuster_Modules[module_id].sort_function = nil;
		CraftBuster_Modules[module_id].node_function = nil;
		CraftBuster_Modules[module_id].action_function = nil;
		CraftBuster_Modules[module_id].tradeskill_function = nil;
	end

	if (module_options.skill_type) then
		CraftBuster_Modules[module_id].skill_type = module_options.skill_type;
	end
	if (module_options.spell_1) then
		CraftBuster_Modules[module_id].spell_1 = GetSpellInfo(module_options.spell_1);
		CraftBuster_Modules[module_id].spell_1_id = module_options.spell_1;
	end
	if (module_options.spell_2) then
		CraftBuster_Modules[module_id].spell_2 = GetSpellInfo(module_options.spell_2);
		CraftBuster_Modules[module_id].spell_2_id = module_options.spell_2;
	end
	if (module_options.spell_buster) then
		CraftBuster_Modules[module_id].spell_buster = GetSpellInfo(module_options.spell_buster);
		CraftBuster_Modules[module_id].spell_buster_id = module_options.spell_buster;
	end
	if (module_options.tooltip_info) then
		CraftBuster_Modules[module_id].tooltip_info = module_options.tooltip_info;
	end
	if (module_options.bustable_spell) then
		CraftBuster_Modules[module_id].bustable_spell = GetSpellInfo(module_options.bustable_spell);
		if (module_options.bustable_function) then
			CraftBuster_Modules[module_id].bustable_function = module_options.bustable_function;
		else
			CraftBuster_Modules[module_id].bustable_type = module_options.bustable_type;
		end
	end
	if (module_options.sort_function) then
		CraftBuster_Modules[module_id].sort_function = module_options.sort_function;
	end
	if (module_options.node_function) then
		CraftBuster_Modules[module_id].node_function = module_options.node_function;
	end
	if (module_options.action_function) then
		CraftBuster_Modules[module_id].action_function = module_options.action_function;
	end
	if (module_options.tradeskill_function) then
		CraftBuster_Modules[module_id].tradeskill_function = module_options.tradeskill_function;
	end
	if (module_options.config) then
		CraftBuster_Config_RegisterModule(module_id, module_name, module_options);
	end
end

function CraftBuster_UpdatePlayerLevel(player_level)
	if (not player_level) then
		CraftBusterPlayerLevel = UnitLevel("player");
	else
		CraftBusterPlayerLevel = player_level;
	end
	CraftBuster_UpdateSkills();
end

function CraftBuster_UpdateSkills()
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

	for skill, index in pairs(skills) do
		if (index) then
			local skill_name, skill_texture, skill_level, skill_max_level, skill_num_spells, _, skill_id, skill_bonus = GetProfessionInfo(index);
			--echo("Here " .. skill .. ", " .. index .. ": " .. skill_name .. ", " .. skill_level);
			if (not CraftBusterOptions[CraftBusterEntry].skills[skill] or (CraftBusterOptions[CraftBusterEntry].skills[skill].id ~= skill_id)) then
				CraftBusterOptions[CraftBusterEntry].skills[skill] = {};
				CraftBusterOptions[CraftBusterEntry].skills[skill].index = index;
				CraftBusterOptions[CraftBusterEntry].skills[skill].id = skill_id;
				CraftBusterOptions[CraftBusterEntry].skills[skill].name = skill_name;
				CraftBusterOptions[CraftBusterEntry].skills[skill].texture = skill_texture;
			end
			--echo("Here: " .. skill_name .. " -> " .. skill_level);
			CraftBusterOptions[CraftBusterEntry].skills[skill].profession_level = CraftBuster_GetProfessionLevel(skill_max_level);
			CraftBusterOptions[CraftBusterEntry].skills[skill].level = skill_level;
			CraftBusterOptions[CraftBusterEntry].skills[skill].bonus = skill_bonus;
			CraftBusterOptions[CraftBusterEntry].skills[skill].max_level = skill_max_level;
			CraftBusterOptions[CraftBusterEntry].skills[skill].num_spells = skill_num_spells;
			CraftBuster_HandleSkill(skill);
		end
	end
	local _, player_class = UnitClass("player");
	if (player_class == "ROGUE") then
		local index = CBT_SKILL_PICK;
		local skill_id = CBT_SKILL_PICK;
		local skill = "lockpicking";
		skills.lockpicking = skill_id;

		local skill_name, _, skill_texture = GetSpellInfo(index);
		--echo("Here " .. skill .. ", " .. index .. ": " .. skill_name);
		if (not CraftBusterOptions[CraftBusterEntry].skills[skill] or (CraftBusterOptions[CraftBusterEntry].skills[skill].id ~= skill_id)) then
			CraftBusterOptions[CraftBusterEntry].skills[skill] = {};
			CraftBusterOptions[CraftBusterEntry].skills[skill].index = index;
			CraftBusterOptions[CraftBusterEntry].skills[skill].id = skill_id;
			CraftBusterOptions[CraftBusterEntry].skills[skill].name = skill_name;
			CraftBusterOptions[CraftBusterEntry].skills[skill].texture = skill_texture;
		end
		--echo("Here: " .. skill_name .. " -> " .. skill_level);
		local skill_level = (UnitLevel("player") * 5);
		local skill_max_level = 425;
		CraftBusterOptions[CraftBusterEntry].skills[skill].profession_level = CraftBuster_GetProfessionLevel(skill_max_level);
		CraftBusterOptions[CraftBusterEntry].skills[skill].level = (UnitLevel("player") * 5);
		CraftBusterOptions[CraftBusterEntry].skills[skill].max_level = skill_max_level;
		CraftBusterOptions[CraftBusterEntry].skills[skill].num_spells = 1;
		CraftBuster_HandleSkill(skill);
	end
	CraftBuster_SkillFrame_Update(skills);
	CraftBuster_SkillFrame_UpdatePosition();
end

function CraftBuster_AddLeaveCombatCommand(function_name, ...)
	local arg = {...};
	local params = {};
	--echo("Added: " .. function_name);
	params.function_name = function_name;
	params.args = {};
	if (arg ~= nil) then
		for _,value in pairs(arg) do
			table.insert(params.args, value);
		end
	end
	table.insert(CraftBuster_LeaveCombatCommands, params);
end

function CraftBuster_ProcessLeaveCombatCommands()
	if (CraftBuster_LeaveCombatCommands and next(CraftBuster_LeaveCombatCommands)) then
		local i, command_data;
		for i, command_data in pairs(CraftBuster_LeaveCombatCommands) do
			--echo("Here: " .. command_data.function_name);
			_G[command_data.function_name](unpack(command_data.args));
			table.remove(CraftBuster_LeaveCombatCommands, i);
		end
	end
	if (CraftBuster_LeaveCombatCommands and next(CraftBuster_LeaveCombatCommands)) then
		CraftBuster_ProcessLeaveCombatCommands();
	end
end

local function CraftBuster_TradeSkillFrame_SetSelection(tradeskill_id)
	if (CURRENT_TRADESKILL == "") then
		return;
	end

	for skill, skill_data in sortedpairs(CraftBusterOptions[CraftBusterEntry].skills) do
		if (skill_data.name == CURRENT_TRADESKILL) then
			local skill_id = skill_data.id;
			if (CraftBuster_Modules[skill_id] and next(CraftBuster_Modules[skill_id])) then
				local module_data = CraftBuster_Modules[skill_id];
				if (module_data.tradeskill_function ~= nil) then
					module_data.tradeskill_function(tradeskill_id);
					return;
				end
			end
		end
	end
end

function CraftBuster_HandleNode(line_one, line_two, line_three)
	--echo("Here: " .. line_one .. ", " .. line_two);
	if (CraftBuster_Modules and next(CraftBuster_Modules)) then
		for module_id, module_data in sortedpairs(CraftBuster_Modules) do
			if (module_data.node_function ~= nil and CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips) then
				if (module_data.node_function(line_one, line_two, line_three)) then
					return;
				end
			end
		end
	end
end

function CraftBuster_HandleSkill(skill)
	local skill_data = CraftBusterOptions[CraftBusterEntry].skills[skill];
	if (skill_data ~= nil) then
		if (CraftBuster_Modules[skill_data.id] and CraftBuster_Modules[skill_data.id].action_function ~= nil) then
			CraftBuster_Modules[skill_data.id].action_function(skill_data);
		end
	end
end

function CraftBuster_GetProfessionLevel(max_level)
	local profession_level;
	for i=1,#CBG_PROFESSION_RANKS do
		local min_skill_level, max_skill_level, title = CBG_PROFESSION_RANKS[i][1], CBG_PROFESSION_RANKS[i][2], CBG_PROFESSION_RANKS[i][3];
		if (max_level < max_skill_level) then
			break;
		end
		profession_level = i;
	end

	return profession_level;
end

-------------------------------------------------------------------------------
-- Hooks in Warcraft code
-------------------------------------------------------------------------------

local hook_frame = CreateFrame("Frame");
hook_frame:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Blizzard_TradeSkillUI") then
		hooksecurefunc("TradeSkillFrame_SetSelection", CraftBuster_TradeSkillFrame_SetSelection);
	end
end);
hook_frame:RegisterEvent("ADDON_LOADED");

local function HookFrame(frame)
	frame:HookScript("OnShow",
		function(self, ...)
			if (self.show_frame ~= nil and self.show_frame ~= true) then		--something weird happening to cause this to duplicate itself
				CraftBuster_HandleNode(GameTooltipTextLeft1:GetText(), GameTooltipTextLeft2:GetText(), GameTooltipTextLeft3:GetText());
				self.show_frame = true;
			end
		end
	);
	frame:HookScript("OnHide",
		function(self, ...)
			self.show_frame = false;
		end
	);
end

HookFrame(GameTooltip);