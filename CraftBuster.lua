local DB_VERSION = 0.05;

CraftBusterInit = nil;
CraftBusterOptions = {};
CraftBusterPlayer = nil;
CraftBusterServer = nil;
CraftBusterEntry_Personal = nil;
CraftBusterEntry = nil;
CraftBusterPlayerLevel = nil;
CraftBusterPlayerSkills = {};

local _, cb = ...;

cb.frame = CreateFrame("Frame", "CraftBusterFrame", UIParent);

--==BINDING==--
BINDING_HEADER_CRAFTBUSTER = CBG_MOD_NAME;
BINDING_NAME_CB_TOGGLE_SKILL_FRAME = CBL["BINDING_TOGGLE_SKILL_FRAME"];
BINDING_NAME_CB_OPEN_SKILL_1 = CBL["BINDING_OPEN_SKILL_1"];
BINDING_NAME_CB_OPEN_SKILL_1_BUSTER = CBL["BINDING_OPEN_SKILL_1_BUSTER"];
BINDING_NAME_CB_OPEN_SKILL_2 = CBL["BINDING_OPEN_SKILL_2"];
BINDING_NAME_CB_OPEN_SKILL_2_BUSTER = CBL["BINDING_OPEN_SKILL_2_BUSTER"];
BINDING_NAME_CB_OPEN_COOKING = CBL["BINDING_OPEN_COOKING"];
BINDING_NAME_CB_OPEN_FIRST_AID = CBL["BINDING_OPEN_FIRST_AID"];
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
			DEFAULT_CHAT_FRAME:AddMessage(CBL["HELP" .. i]);
		end
	elseif (cmd == "config") then
		CraftBuster_Config_Show();
	elseif (cmd == "reset") then
		cb:initSettings("character");
		cb:SKILL_LINES_CHANGED(true);
	elseif (cmd == "fullreset") then
		cb:initSettings(true);
		cb:SKILL_LINES_CHANGED(true);
	elseif (cmd == "clearignore") then
		cb.buster_frame:clearIgnore();
	elseif (cmd == "update") then
		cb:SKILL_LINES_CHANGED(true);
	elseif (cmd == "where") then
		cb.map_icons:displayPosition();
	end
end

cb.modules = {};
cb.leave_combat_commands = {};

cb.frame:RegisterEvent("ADDON_LOADED");
cb.frame:RegisterEvent("PLAYER_LEVEL_UP");
cb.frame:RegisterEvent("CHAT_MSG_SKILL");
cb.frame:RegisterEvent("SKILL_LINES_CHANGED");
cb.frame:RegisterEvent("ZONE_CHANGED_NEW_AREA");
cb.frame:RegisterEvent("PLAYER_REGEN_ENABLED");
cb.frame:RegisterEvent("GET_ITEM_INFO_RECEIVED");
cb.frame:SetScript("OnEvent", function(self, event, ...)
	if (event == "ADDON_LOADED" or CraftBusterInit) then
		return cb[event] and cb[event](cb, ...);
	end
end);

function cb:ADDON_LOADED(self, ...)
	if (cb:initPlayer()) then
		cb:initSettings();
		cb.minimap:init();
		cb.map_icons:registerInit();
		cb:SKILL_LINES_CHANGED(true);
		cb:ZONE_CHANGED_NEW_AREA();

		cb.frame:UnregisterEvent("ADDON_LOADED");
		CraftBusterInit = true;
	end
end

function cb:PLAYER_LEVEL_UP(player_level)
	if (not player_level) then
		CraftBusterPlayerLevel = UnitLevel("player");
	else
		CraftBusterPlayerLevel = player_level;
	end
	cb:SKILL_LINES_CHANGED(false);
end

function cb:SKILL_LINES_CHANGED(reload)
	local skills = cb:getProfessions(reload);
	for skill, index in pairs(skills) do
		if (index and skill ~= "lockpicking") then
			local skill_name, skill_texture, skill_level, skill_max_level, skill_num_spells, _, skill_id, skill_bonus = GetProfessionInfo(index);
			if (not CraftBusterOptions[CraftBusterEntry].skills[skill] or (CraftBusterOptions[CraftBusterEntry].skills[skill].id ~= skill_id)) then
				CraftBusterOptions[CraftBusterEntry].skills[skill] = {};
				CraftBusterOptions[CraftBusterEntry].skills[skill].index = index;
				CraftBusterOptions[CraftBusterEntry].skills[skill].id = skill_id;
				CraftBusterOptions[CraftBusterEntry].skills[skill].name = skill_name;
				CraftBusterOptions[CraftBusterEntry].skills[skill].texture = skill_texture;
			end
			CraftBusterOptions[CraftBusterEntry].skills[skill].profession_level = cb:getProfessionLevel(skill_max_level);
			CraftBusterOptions[CraftBusterEntry].skills[skill].level = skill_level;
			CraftBusterOptions[CraftBusterEntry].skills[skill].bonus = skill_bonus;
			CraftBusterOptions[CraftBusterEntry].skills[skill].max_level = skill_max_level;
			CraftBusterOptions[CraftBusterEntry].skills[skill].num_spells = skill_num_spells;
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
		if (not CraftBusterOptions[CraftBusterEntry].skills[skill] or (CraftBusterOptions[CraftBusterEntry].skills[skill].id ~= skill_id)) then
			CraftBusterOptions[CraftBusterEntry].skills[skill] = {};
			CraftBusterOptions[CraftBusterEntry].skills[skill].index = index;
			CraftBusterOptions[CraftBusterEntry].skills[skill].id = skill_id;
			CraftBusterOptions[CraftBusterEntry].skills[skill].name = skill_name;
			CraftBusterOptions[CraftBusterEntry].skills[skill].texture = skill_texture;
		end
		local skill_level = (UnitLevel("player") * 5);
		local skill_max_level = 425;
		CraftBusterOptions[CraftBusterEntry].skills[skill].profession_level = cb:getProfessionLevel(skill_max_level);
		CraftBusterOptions[CraftBusterEntry].skills[skill].level = (UnitLevel("player") * 5);
		CraftBusterOptions[CraftBusterEntry].skills[skill].max_level = skill_max_level;
		CraftBusterOptions[CraftBusterEntry].skills[skill].num_spells = 1;
		cb.professions:handleSkill(skill);
	end

	cb.skill_frame:update();
	cb.skill_frame:updatePosition();
	cb:ZONE_CHANGED_NEW_AREA();
end

function cb:ZONE_CHANGED_NEW_AREA()
	cb.gather_frame:reset();
	local map_id = GetCurrentMapAreaID();
	if (map_id ~= nil) then
		if (cb.professions.modules and next(cb.professions.modules)) then
			for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
				if (cb.professions.modules[module_id].nodes ~= nil) then
					cb.professions:handleGather(module_id, map_id);
				end
			end
		end
	end
	cb.gather_frame:update();
	cb.gather_frame:updatePosition();

	cb.map_icons:update();
end

function cb:PLAYER_REGEN_ENABLED()
	if (cb.leave_combat_commands and next(cb.leave_combat_commands)) then
		local i, command_data;
		for i, command_data in pairs(cb.leave_combat_commands) do
			_G[command_data.function_name](unpack(command_data.args));
			table.remove(cb.leave_combat_commands, i);
		end
	end
	if (cb.leave_combat_commands and next(cb.leave_combat_commands)) then
		cb:PLAYER_REGEN_ENABLED();
	end
end

function cb:GET_ITEM_INFO_RECEIVED()
	cb.gather_frame:update();
end

function cb:initPlayer()
	CraftBusterPlayerSkills = {};
	CraftBusterPlayer = UnitName("player");
	CraftBusterPlayerLevel = UnitLevel("player");
	CraftBusterServer = GetRealmName();
	CraftBusterEntry_Personal = CraftBusterPlayer .. "@" .. CraftBusterServer;
	CraftBusterEntry = CraftBusterEntry_Personal;
	if (not CraftBusterOptions) then
		CraftBusterOptions = {};
	end
	if (not CraftBusterOptions.globals) then
		CraftBusterOptions.globals = {};
	end
	if (not CraftBusterOptions.globals[CraftBusterEntry_Personal]) then
		--CraftBusterOptions.globals[CraftBusterEntry_Personal] = CBG_GLOBAL_PROFILE;
		CraftBusterOptions.globals[CraftBusterEntry_Personal] = CraftBusterEntry_Personal;
	end
	CraftBusterEntry = CraftBusterOptions.globals[CraftBusterEntry_Personal];

	if (CraftBusterPlayer == nil or CraftBusterPlayer == UNKNOWNOBJECT or CraftBusterPlayer == UKNOWNBEING) then
		return false;
	end

	return true;
end

function cb:initSettings(reset)
	if (CraftBusterInit and not reset) then
		return;
	end

	if (not CraftBusterOptions or reset == true) then
		CraftBusterOptions = {};
	end
	if (not CraftBusterOptions[CraftBusterEntry] or reset == "character") then
		CraftBusterOptions[CraftBusterEntry] = {};
	end

	if (not CraftBusterOptions[CraftBusterEntry].minimap) then
		CraftBusterOptions[CraftBusterEntry].minimap = {};
		CraftBusterOptions[CraftBusterEntry].minimap.show = true;
		CraftBusterOptions[CraftBusterEntry].minimap.position = 310;
		cb.minimap:init();
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
		CraftBusterOptions[CraftBusterEntry].skills_frame.locked = false;
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
		CraftBusterOptions[CraftBusterEntry].buster_frame.locked = false;
		CraftBusterOptions[CraftBusterEntry].buster_frame.state = "expanded";
		CraftBusterOptions[CraftBusterEntry].buster_frame.ignored_items = {};
	end

	if (not CraftBusterOptions[CraftBusterEntry].gather_frame) then
		CraftBusterOptions[CraftBusterEntry].gather_frame = {};
		CraftBusterOptions[CraftBusterEntry].gather_frame.show = true;
		CraftBusterOptions[CraftBusterEntry].gather_frame.position = {
			point = "TOPLEFT",
			relative_point = "TOPLEFT",
			x = 490,
			y = -330,
		};
		CraftBusterOptions[CraftBusterEntry].gather_frame.locked = false;
		CraftBusterOptions[CraftBusterEntry].gather_frame.state = "expanded";
		CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes = true;
		CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes = true;
		CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide = true;
	end
	if (not CraftBusterOptions[CraftBusterEntry].zone_limit) then
		CraftBusterOptions[CraftBusterEntry].zone_limit = 10;
	end

	if (not CraftBusterOptions[CraftBusterEntry].worldmap_frame) then
		CraftBusterOptions[CraftBusterEntry].worldmap_frame = {};
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.show = true;
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.position = {
			point = "TOPLEFT",
			relative_point = "TOPLEFT",
			x = 20,
			y = 20,
		};
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked = false;
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.state = "expanded";
	end

	if (not CraftBusterOptions[CraftBusterEntry].map_icons) then
		CraftBusterOptions[CraftBusterEntry].map_icons = {};
		CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map = true;
		CraftBusterOptions[CraftBusterEntry].map_icons.show_mini_map = true;
	end

	if (not CraftBusterOptions[CraftBusterEntry].modules) then
		CraftBusterOptions[CraftBusterEntry].modules = {};
	end
	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (not CraftBusterOptions[CraftBusterEntry].modules[module_id]) then
				CraftBusterOptions[CraftBusterEntry].modules[module_id] = {};
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_gather = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_buster = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_worldmap_icons = true;
			end
		end
	end

	if (not CraftBusterOptions[CraftBusterEntry].alerts) then
		CraftBusterOptions[CraftBusterEntry].alerts = {};
	end

	if (not CraftBusterOptions[CraftBusterEntry].bustables) then
		CraftBusterOptions[CraftBusterEntry].bustables = {};
	end

	cb:initVersionSettings();

	DEFAULT_CHAT_FRAME:AddMessage(CBG_MOD_COLOR .. CBG_MOD_NAME .. " (v" .. CBG_VERSION .. " - Last Updated: " .. CBG_LAST_UPDATED .. ")");
end

function cb:initVersionSettings()
	if (not CraftBusterOptions[CraftBusterEntry].db_version or CraftBusterOptions[CraftBusterEntry].db_version < 0.01) then
		CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide = true;

		if (cb.professions.modules and next(cb.professions.modules)) then
			for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_gather = true;
			end
		end
	end

	if (not CraftBusterOptions[CraftBusterEntry].db_version or CraftBusterOptions[CraftBusterEntry].db_version < 0.02) then
		CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide = true;

		if (cb.professions.modules and next(cb.professions.modules)) then
			for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_trainer_map_icons = true;
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_station_map_icons = true;
			end
		end
	end

	if (not CraftBusterOptions[CraftBusterEntry].db_version or CraftBusterOptions[CraftBusterEntry].db_version < 0.03) then
		if (cb.professions.modules and next(cb.professions.modules)) then
			for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
				CraftBusterOptions[CraftBusterEntry].modules[module_id].show_worldmap_icons = true;
			end
		end
	end

	if (not CraftBusterOptions[CraftBusterEntry].db_version or CraftBusterOptions[CraftBusterEntry].db_version < 0.04) then
		CraftBusterOptions[CraftBusterEntry].skills_frame.locked = false;
	end

	if (not CraftBusterOptions[CraftBusterEntry].db_version or CraftBusterOptions[CraftBusterEntry].db_version < 0.05) then
		CraftBusterOptions[CraftBusterEntry].buster_frame.locked = false;
		CraftBusterOptions[CraftBusterEntry].gather_frame.locked = false;
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked = false;
	end

	CraftBusterOptions[CraftBusterEntry].db_version = DB_VERSION;
end

function cb:getProfessions(reload)
	if (CraftBusterPlayerSkills and next(CraftBusterPlayerSkills) and not reload) then
		return CraftBusterPlayerSkills;
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
	skills.skill_1, skills.skill_2, skills.archaeology, skills.fishing, skills.cooking, skills.first_aid = GetProfessions();
	local _, player_class = UnitClass("player");
	if (player_class == "ROGUE" and UnitLevel("player") >= CBG_LOCKPICKING_LEVEL) then
		skills.lockpicking = CBT_SKILL_PICK;
	end
	CraftBusterPlayerSkills = skills;
	
	return skills;
end

function cb:addLeaveCombatCommand(function_name, ...)
	local arg = {...};
	local params = {};
	params.function_name = function_name;
	params.args = {};
	if (arg ~= nil) then
		for _,value in pairs(arg) do
			table.insert(params.args, value);
		end
	end
	table.insert(cb.leave_combat_commands, params);
end

function cb:handleNode(line_one, line_two, line_three)
	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			if (module_data.node_function ~= nil and CraftBusterOptions[CraftBusterEntry].modules[module_id].show_tooltips) then
				if (module_data.node_function(line_one, line_two, line_three)) then
					return;
				end
			end
		end
	end
end

function cb:getSkillLevel(skill_id)
	local skills = {
		[1] = "skill_1",
		[2] = "skill_2",
		[3] = "cooking",
		[4] = "first_aid",
		[5] = "fishing",
		[6] = "archaeology",
		[7] = "lockpicking",
	};

	for i, skill in pairs(skills) do
		local skill_data = CraftBusterOptions[CraftBusterEntry].skills[skill];
		if (skill_data ~= nil and skill_data.id == skill_id) then
			return (skill_data.level + skill_data.bonus);
		end
	end

	return nil;
end

function cb:getProfessionLevel(max_level)
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
		hooksecurefunc(TradeSkillFrame.DetailsFrame, "SetSelectedRecipeID", function(self)
			local recipe_id = self.selectedRecipeID;
			local tradeskill_id = C_TradeSkillUI.GetTradeSkillLine();
			if (not tradeskill_id) then
				return;
			end
			
			for skill, skill_data in cb.omg:sortedpairs(CraftBusterOptions[CraftBusterEntry].skills) do
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
			cb:handleNode(GameTooltipTextLeft1:GetText(), GameTooltipTextLeft2:GetText(), GameTooltipTextLeft3:GetText());
			self.show_frame = true;
		end
	end);
	frame:HookScript("OnHide", function(self, ...)
		self.show_frame = false;
	end);
end

HookFrame(GameTooltip);