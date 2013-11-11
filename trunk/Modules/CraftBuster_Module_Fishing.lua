local SKILL_NAME = "Fishing";
local SKILL_SHORT_CODE = "fish";
local SKILL_ID = CBT_SKILL_FISH;
local SKILL_SPELL_1ID = 7620;		--Fishing

local function CraftBuster_Module_Fishing_OnLoad()
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Fishing_OnLoad();