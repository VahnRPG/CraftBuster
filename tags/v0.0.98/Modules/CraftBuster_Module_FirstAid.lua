local SKILL_NAME = "First Aid";
local SKILL_SHORT_CODE = "frst";
local SKILL_ID = CBT_SKILL_FRST;
local SKILL_SPELL_1ID = 74559;		--First Aid

local function CraftBuster_Module_FirstAid_OnLoad()
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_FirstAid_OnLoad();