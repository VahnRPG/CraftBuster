local SKILL_NAME = CBL["SKILL_ALCH"];
local SKILL_SHORT_CODE = "alch";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_ID = CBT_SKILL_ALCH;
local SKILL_SPELL_1ID = 2259;		--Alchemy
local SKILL_ACTIONS = {};

local function CraftBuster_Module_Alchemy_HandleAction(skill_data)
	if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID]) then
		CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID] = {};
	end
	for action_id, data in sortedpairs(SKILL_ACTIONS) do
		if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id]) then
			--echo(SKILL_NAME .. " Check: " .. CraftBusterPlayerLevel .. " >= " .. data.ply_level .. " and " .. skill_data.level .. " >= " .. data.skill_level);
			if (CraftBusterPlayerLevel >= data.ply_level and skill_data.level >= data.skill_level) then
				echo(data.message);
				CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id] = true;
			end
		end
	end
end

local function CraftBuster_Module_Alchemy_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_Alchemy_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Alchemy_OnLoad();