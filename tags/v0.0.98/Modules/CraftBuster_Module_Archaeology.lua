local SKILL_NAME = "Archaeology";
local SKILL_SHORT_CODE = "arch";
local SKILL_ID = CBT_SKILL_ARCH;
local SKILL_SPELL_1ID = 78670;		--Archaeology
local SKILL_SPELL_2ID = 80451;		--Survey

local function CraftBuster_Module_Archaeology_OnLoad()
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
		spell_2 = SKILL_SPELL_2ID,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Archaeology_OnLoad();