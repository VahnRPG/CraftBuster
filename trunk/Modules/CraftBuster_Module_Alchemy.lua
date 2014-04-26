local SKILL_ID = CBT_SKILL_ALCH;
local SKILL_NAME = CBL[CBT_SKILL_ALCH];
local SKILL_SHORT_CODE = "alch";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 2259;		--Alchemy
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[30] = {		--Elwynn Forest
			["Alliance"] = {
				[1215] = { ["name"] = "Alchemist Mallory", ["floor"] = 0, ["pos"] = { 39.8, 48.4 } },
			},
	},
	[35] = {		--Loch Modan
			["Alliance"] = {
				[1470] = { ["name"] = "Ghak Healtouch", ["floor"] = 0, ["pos"] = { 37, 49.2 } },
			},
	},
	[41] = {		--Teldrassil
			["Alliance"] = {
				[3603] = { ["name"] = "Cyndra Kindwhisper", ["floor"] = 0, ["pos"] = { 57, 53 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[4160] = { ["name"] = "Ainethil", ["floor"] = 0, ["pos"] = { 54, 38.2 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[4900] = { ["name"] = "Alchemist Narett", ["floor"] = 0, ["pos"] = { 64, 47.6 } },
			},
	},
	[341] = {		--Ironforge
			["Alliance"] = {
				[5177] = { ["name"] = "Tally Berryfizz", ["floor"] = 0, ["pos"] = { 66.6, 55 } },
			},
	},
	[301] = {		--Stormwind City
			["Alliance"] = {
				[5499] = { ["name"] = "Lilyssia Nightbreeze", ["floor"] = 0, ["pos"] = { 55.6, 85.2 } },
			},
	},
	[121] = {		--Feralas
			["Alliance"] = {
				[7948] = { ["name"] = "Kylanna Windwhisper", ["floor"] = 0, ["pos"] = { 46.4, 42.8 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[16723] = { ["name"] = "Lucc", ["floor"] = 0, ["pos"] = { 27.8, 61.4 } },
			},
	},
	[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17215] = { ["name"] = "Daedal", ["floor"] = 0, ["pos"] = { 48.4, 51.4 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18802] = { ["name"] = "Alchemist Gribble", ["floor"] = 0, ["pos"] = { 53.8, 65.8 } },
			},
			["Horde"] = {
				[16588] = { ["name"] = "Apothecary Antonivich", ["floor"] = 0, ["pos"] = { 52.2, 36.4 } },
			},
	},
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[26903] = { ["name"] = "Lanolis Dewdrop", ["floor"] = 0, ["pos"] = { 58.4, 62.2 } },
			},
			["Horde"] = {
				[26951] = { ["name"] = "Wilhelmina Renel", ["floor"] = 0, ["pos"] = { 78.6, 28.4 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[26987] = { ["name"] = "Falorn Nightwhisper", ["floor"] = 0, ["pos"] = { 57.8, 71.8 } },
			},
			["Horde"] = {
				[26975] = { ["name"] = "Arthur Henslowe", ["floor"] = 0, ["pos"] = { 41.8, 54.2 } },
			},
	},
	[38] = {		--Swamp of Sorrows
			["Horde"] = {
				[1386] = { ["name"] = "Rogvar", ["floor"] = 0, ["pos"] = { 49.8, 56 } },
			},
	},
	[20] = {		--Tirisfal Glades
			["Horde"] = {
				[2132] = { ["name"] = "Carolai Anise", ["floor"] = 0, ["pos"] = { 59.4, 52 } },
			},
	},
	[24] = {		--Hillsbrad Foothills
			["Horde"] = {
				[2391] = { ["name"] = "Serge Hinott", ["floor"] = 0, ["pos"] = { 49, 66.2 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[3009] = { ["name"] = "Bena Winterhoof", ["floor"] = 0, ["pos"] = { 46.8, 33.4 } },
			},
	},
	[4] = {		--Durotar
			["Horde"] = {
				[3184] = { ["name"] = "Miao\'zan", ["floor"] = 0, ["pos"] = { 55.4, 74 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[3347] = { ["name"] = "Yelmak", ["floor"] = 1, ["pos"] = { 55.4, 45.8 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[4611] = { ["name"] = "Doctor Herbert Halsey", ["floor"] = 0, ["pos"] = { 47.4, 72.2 } },
			},
	},
	[462] = {		--Eversong Woods
			["Horde"] = {
				[16161] = { ["name"] = "Arcanist Sheynathren", ["floor"] = 0, ["pos"] = { 38.2, 72.4 } },
			},
	},
	[480] = {		--Silvermoon City
			["Horde"] = {
				[16642] = { ["name"] = "Camberon", ["floor"] = 0, ["pos"] = { 66.4, 16.4 } },
			},
	},
	[488] = {		--Dragonblight
			["Horde"] = {
				[27023] = { ["name"] = "Apothecary Bressa", ["floor"] = 0, ["pos"] = { 36.2, 48.6 } },
				[27029] = { ["name"] = "Apothecary Wormwick", ["floor"] = 0, ["pos"] = { 76.8, 62.2 } },
			},
	},
	[673] = {		--The Cape of Stranglethorn
			["Neutral"] = {
				[2837] = { ["name"] = "Jaxin Chong", ["floor"] = 0, ["pos"] = { 42.4, 74.8 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[19052] = { ["name"] = "Lorokeem", ["floor"] = 0, ["pos"] = { 45.4, 20.4 } },
				[33630] = { ["name"] = "Aelthin", ["floor"] = 0, ["pos"] = { 38.4, 71.2 } },
				[33674] = { ["name"] = "Alchemist Kanhu", ["floor"] = 0, ["pos"] = { 38.4, 30 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[28703] = { ["name"] = "Linzy Blackbolt", ["floor"] = 1, ["pos"] = { 41.8, 31.4 } },
			},
	},
	[492] = {		--Icecrown
			["Neutral"] = {
				[33588] = { ["name"] = "Crystal Brightspark", ["floor"] = 0, ["pos"] = { 71.6, 21 } },
			},
	},
	[806] = {		--The Jade Forest
			["Neutral"] = {
				[56777] = { ["name"] = "Ni Gentlepaw", ["floor"] = 0, ["pos"] = { 46.4, 45.8 } },
			},
	},
	[858] = {		--Dread Wastes
			["Neutral"] = {
				[65186] = { ["name"] = "Poisoncrafter Kil\'zit", ["floor"] = 0, ["pos"] = { 55.4, 35.2 } },
			},
	},
};

local function CraftBuster_Module_Alchemy_HandleAction(skill_data)
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

local function CraftBuster_Module_Alchemy_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_Alchemy_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Alchemy_OnLoad();