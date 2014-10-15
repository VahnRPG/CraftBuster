local SKILL_ID = CBT_SKILL_FRST;
local SKILL_NAME = CBL[CBT_SKILL_FRST];
local SKILL_SHORT_CODE = "frst";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 74559;		--First Aid
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[27] = {		--Dun Morogh
		["Alliance"] = {
			[2326] = { ["name"] = "Thamner Pol", ["floor"] = 0, ["pos"] = { 54.2, 50.8 } },
		},
	},
	[30] = {		--Elwynn Forest
		["Alliance"] = {
			[2329] = { ["name"] = "Michelle Belle", ["floor"] = 0, ["pos"] = { 43.4, 65.6 } },
		},
	},
	[40] = {		--Wetlands
		["Alliance"] = {
			[3181] = { ["name"] = "Fremal Doohickey", ["floor"] = 0, ["pos"] = { 10.4, 60.2 } },
		},
	},
	[381] = {		--Darnassus
		["Alliance"] = {
			[4211] = { ["name"] = "Dannelor", ["floor"] = 0, ["pos"] = { 51.6, 30.4 } },
		},
	},
	[341] = {		--Ironforge
		["Alliance"] = {
			[5150] = { ["name"] = "Nissa Firestone", ["floor"] = 0, ["pos"] = { 55.2, 58.4 } },
		},
	},
	[41] = {		--Teldrassil
		["Alliance"] = {
			[6094] = { ["name"] = "Byancie", ["floor"] = 0, ["pos"] = { 55, 49.6 } },
		},
	},
	[141] = {		--Dustwallow Marsh
		["Alliance"] = {
			[12939] = { ["name"] = "Doctor Gustaf VanHowzen", ["floor"] = 0, ["pos"] = { 67.6, 48.8 } },
		},
	},
	[471] = {		--The Exodar
		["Alliance"] = {
			[16731] = { ["name"] = "Nus", ["floor"] = 0, ["pos"] = { 39.4, 22.2 } },
		},
	},
	[464] = {		--Azuremyst Isle
		["Alliance"] = {
			[17214] = { ["name"] = "Anchorite Fateema", ["floor"] = 0, ["pos"] = { 48.4, 51.6 } },
		},
	},
	[476] = {		--Bloodmyst Isle
		["Alliance"] = {
			[17424] = { ["name"] = "Anchorite Paetheus", ["floor"] = 0, ["pos"] = { 54.6, 54 } },
		},
	},
	[465] = {		--Hellfire Peninsula
		["Alliance"] = {
			[18990] = { ["name"] = "Burko", ["floor"] = 0, ["pos"] = { 22.4, 39.2 } },
		},
		["Horde"] = {
			[18991] = { ["name"] = "Aresella", ["floor"] = 0, ["pos"] = { 26.2, 62 } },
		},
	},
	[491] = {		--Howling Fjord
		["Alliance"] = {
			[23734] = { ["name"] = "Anchorite Yazmina", ["floor"] = 0, ["pos"] = { 59.8, 62.2 } },
		},
		["Horde"] = {
			[26956] = { ["name"] = "Sally Tompkins", ["floor"] = 0, ["pos"] = { 79.4, 29.4 } },
		},
	},
	[486] = {		--Borean Tundra
		["Alliance"] = {
			[26992] = { ["name"] = "Brynna Wilson", ["floor"] = 0, ["pos"] = { 57.8, 66.2 } },
		},
		["Horde"] = {
			[29233] = { ["name"] = "Nurse Applewood", ["floor"] = 0, ["pos"] = { 41.6, 54.4 } },
		},
	},
	[611] = {		--Gilneas City
		["Alliance"] = {
			[50574] = { ["name"] = "Amelia Atherton", ["floor"] = 0, ["pos"] = { 36.8, 65.6 } },
		},
	},
	[806] = {		--The Jade Forest
		["Alliance"] = {
			[54614] = { ["name"] = "Mishka", ["floor"] = 0, ["pos"] = { 46, 84.4 } },
			[56227] = { ["name"] = "Mishka", ["floor"] = 0, ["pos"] = { 58.8, 81.6 } },
			[59619] = { ["name"] = "Mishka", ["floor"] = 0, ["pos"] = { 59.8, 86.2 } },
			[65983] = { ["name"] = "Soraka", ["floor"] = 0, ["pos"] = { 45.4, 85.8 } },
			[66527] = { ["name"] = "Mishka", ["floor"] = 0, ["pos"] = { 41.8, 92.8 } },
		},
		["Horde"] = {
			[66222] = { ["name"] = "Elder Muur", ["floor"] = 0, ["pos"] = { 28.2, 15.2 } },
		},
	},
	[301] = {		--Stormwind City
		["Alliance"] = {
			[56796] = { ["name"] = "Angela Leifeld", ["floor"] = 0, ["pos"] = { 52, 45.4 } },
		},
	},
	[905] = {		--Shrine of Seven Stars
		["Alliance"] = {
			[64482] = { ["name"] = "Healer Nan", ["floor"] = 1, ["pos"] = { 44.2, 60.6 } },
		},
	},
	[362] = {		--Thunder Bluff
		["Horde"] = {
			[2798] = { ["name"] = "Pand Stonebinder", ["floor"] = 0, ["pos"] = { 29.4, 21.4 } },
		},
	},
	[382] = {		--Undercity
		["Horde"] = {
			[4591] = { ["name"] = "Mary Edras", ["floor"] = 0, ["pos"] = { 73.4, 55.4 } },
		},
	},
	[20] = {		--Tirisfal Glades
		["Horde"] = {
			[5759] = { ["name"] = "Nurse Neela", ["floor"] = 0, ["pos"] = { 59.8, 52 } },
		},
	},
	[9] = {		--Mulgore
		["Horde"] = {
			[5939] = { ["name"] = "Vira Younghoof", ["floor"] = 0, ["pos"] = { 46.8, 60.2 } },
		},
	},
	[4] = {		--Durotar
		["Horde"] = {
			[5943] = { ["name"] = "Rawrk", ["floor"] = 0, ["pos"] = { 54, 42 } },
		},
	},
	[462] = {		--Eversong Woods
		["Horde"] = {
			[16272] = { ["name"] = "Kanaria", ["floor"] = 0, ["pos"] = { 48.4, 47.4 } },
		},
	},
	[480] = {		--Silvermoon City
		["Horde"] = {
			[16662] = { ["name"] = "Alestus", ["floor"] = 0, ["pos"] = { 77.4, 71.2 } },
		},
	},
	[475] = {		--Blade's Edge Mountains
		["Horde"] = {
			[19478] = { ["name"] = "Fera Palerunner", ["floor"] = 0, ["pos"] = { 53.8, 55 } },
		},
	},
	[544] = {		--The Lost Isles
		["Horde"] = {
			[36615] = { ["name"] = "Doc Zapnozzle", ["floor"] = 0, ["pos"] = { 35.6, 65.6 } },
		},
	},
	[321] = {		--Orgrimmar
		["Horde"] = {
			[45540] = { ["name"] = "Krenk Choplimb", ["floor"] = 1, ["pos"] = { 37, 87.2 } },
		},
	},
	[181] = {		--Azshara
		["Horde"] = {
			[49879] = { ["name"] = "Doc Zapnozzle", ["floor"] = 0, ["pos"] = { 57, 50.6 } },
		},
	},
	[903] = {		--Shrine of Two Moons
		["Horde"] = {
			[65862] = { ["name"] = "Ala\'thinel", ["floor"] = 1, ["pos"] = { 27.2, 71 } },
		},
	},
	[481] = {		--Shattrath City
		["Neutral"] = {
			[19184] = { ["name"] = "Mildred Fletcher", ["floor"] = 0, ["pos"] = { 66.4, 13.4 } },
		},
	},
	[478] = {		--Terokkar Forest
		["Neutral"] = {
			[22477] = { ["name"] = "Anchorite Ensham", ["floor"] = 0, ["pos"] = { 30.8, 76 } },
		},
	},
	[504] = {		--Dalaran
		["Neutral"] = {
			[28706] = { ["name"] = "Olisarra the Kind", ["floor"] = 1, ["pos"] = { 36.8, 36.6 } },
		},
	},
	[492] = {		--Icecrown
		["Neutral"] = {
			[33589] = { ["name"] = "Joseph Wilson", ["floor"] = 0, ["pos"] = { 71.4, 22.4 } },
		},
	},
	[809] = {		--Kun-Lai Summit
		["Neutral"] = {
			[59077] = { ["name"] = "Apothecary Cheng", ["floor"] = 0, ["pos"] = { 71.6, 92.8 } },
			[66357] = { ["name"] = "Master Bier", ["floor"] = 0, ["pos"] = { 51, 40.2 } },
		},
	},
};

local function CraftBuster_Module_FirstAid_HandleAction(skill_data)
	if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID]) then
		CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID] = {};
	end
	for action_id, data in sortedpairs(SKILL_ACTIONS) do
		if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id]) then
			if (CraftBusterPlayerLevel >= data.ply_level and skill_data.level >= data.skill_level) then
				echo(data.message);
				CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id] = true;
			end
		end
	end
end

local function CraftBuster_Module_FirstAid_DisplayActions(display_frame)
	CraftBuster_Module_BuildActionDisplay(display_frame, SKILL_ID, SKILL_ACTIONS, SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
end

local function CraftBuster_Module_FirstAid_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_FirstAid_HandleAction,
		display_action_function = CraftBuster_Module_FirstAid_DisplayActions,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_FirstAid_OnLoad();