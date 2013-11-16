local SKILL_NAME = "Cooking";
local SKILL_SHORT_CODE = "cook";
local SKILL_ID = CBT_SKILL_COOK;
local SKILL_SPELL_1ID = 2550;		--Cooking
local SKILL_SPELL_2ID = 818;		--Basic Campfire

local function CraftBuster_Module_Cooking_OnLoad()
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
		spell_2 = SKILL_SPELL_2ID,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Cooking_OnLoad();