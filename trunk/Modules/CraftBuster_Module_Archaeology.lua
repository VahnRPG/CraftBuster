local SKILL_ID = CBT_SKILL_ARCH;
local SKILL_NAME = CBL[CBT_SKILL_ARCH];
local SKILL_SHORT_CODE = "arch";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 78670;		--Archaeology
local SKILL_SPELL_2ID = 80451;		--Survey
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[341] = {		--Ironforge
			["Alliance"] = {
				[39718] = { ["name"] = "Doktor Professor Ironpants", ["floor"] = 0, ["pos"] = { 75.4, 11.4 } },
			},
	},
	[301] = {		--Stormwind City
			["Alliance"] = {
				[44238] = { ["name"] = "Harrison Jones", ["floor"] = 0, ["pos"] = { 85.6, 25.8 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[47569] = { ["name"] = "Hammon the Jaded", ["floor"] = 0, ["pos"] = { 42.4, 83 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[47570] = { ["name"] = "Diya", ["floor"] = 0, ["pos"] = { 33.2, 65.2 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[47574] = { ["name"] = "Gerdra Fardelve", ["floor"] = 0, ["pos"] = { 53.6, 65.8 } },
			},
			["Horde"] = {
				[47573] = { ["name"] = "Sirabel", ["floor"] = 0, ["pos"] = { 52.4, 36 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[47576] = { ["name"] = "Falda Fardelve", ["floor"] = 0, ["pos"] = { 57.6, 71.6 } },
			},
			["Horde"] = {
				[47577] = { ["name"] = "Lindarel", ["floor"] = 0, ["pos"] = { 41.2, 53.8 } },
			},
	},
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[47578] = { ["name"] = "Hugen Goldwise", ["floor"] = 0, ["pos"] = { 58.2, 62.4 } },
			},
			["Horde"] = {
				[47568] = { ["name"] = "Ian Thomas Wall", ["floor"] = 0, ["pos"] = { 79.4, 29.2 } },
			},
	},
	[42] = {		--Darkshore
			["Alliance"] = {
				[51997] = { ["name"] = "Stephanie Krutsick", ["floor"] = 0, ["pos"] = { 50.6, 20.6 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[53421] = { ["name"] = "Faena Woolybush", ["floor"] = 0, ["pos"] = { 66.2, 45.2 } },
			},
	},
	[809] = {		--Kun-Lai Summit
			["Horde"] = {
				[47346] = { ["name"] = "Elynara", ["floor"] = 0, ["pos"] = { 81.4, 63.8 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[47382] = { ["name"] = "Adam Hossack", ["floor"] = 0, ["pos"] = { 75.8, 37.2 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[47571] = { ["name"] = "Belloc Brightblade", ["floor"] = 1, ["pos"] = { 49, 70.4 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[47572] = { ["name"] = "Otoh Greyhide", ["floor"] = 0, ["pos"] = { 75.2, 28.4 } },
			},
	},
	[928] = {		--Isle of Thunder
			["Horde"] = {
				[67586] = { ["name"] = "Elynara", ["floor"] = 0, ["pos"] = { 33.8, 33.6 } },
			},
	},
	[811] = {		--Vale of Eternal Blossoms
			["Horde"] = {
				[67837] = { ["name"] = "Elynara", ["floor"] = 0, ["pos"] = { 21, 15.2 } },
			},
			["Neutral"] = {
				[64922] = { ["name"] = "Brann Bronzebeard", ["floor"] = 0, ["pos"] = { 83.4, 31 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[47575] = { ["name"] = "Boduro the Seeker", ["floor"] = 0, ["pos"] = { 62.4, 69.4 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[47579] = { ["name"] = "Dariness the Learned", ["floor"] = 1, ["pos"] = { 48, 38.4 } },
			},
	},
};

local function CraftBuster_Module_Archaeology_HandleAction(skill_data)
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

local function CraftBuster_Module_Archaeology_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		spell_2 = SKILL_SPELL_2ID,
		action_function = CraftBuster_Module_Archaeology_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Archaeology_OnLoad();