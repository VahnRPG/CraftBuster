local _, cb = ...;

local SKILL_ID = CBT_SKILL_FISH;
local SKILL_SHORT_CODE = "fish";
local profession_data = {
	["id"] = SKILL_ID,
	["name"] = CBL[SKILL_ID],
	["short_code"] = SKILL_SHORT_CODE,
	["type"] = CBG_SKILL_NORMAL,
	["spell_1"] = 271990,	--Fishing Skills
	["spell_2"] = 7620,		--Fishing
	["trainer_map_icons"] = {
		[30] = {		--Elwynn Forest
			["Alliance"] = {
				[1651] = { ["name"] = "Lee Brown", ["floor"] = 0, ["pos"] = { 47.4, 62.2 } },
			},
		},
		[36] = {		--Redridge Mountains
			["Alliance"] = {
				[1680] = { ["name"] = "Matthew Hooper", ["floor"] = 0, ["pos"] = { 25.8, 46.2 } },
			},
		},
		[35] = {		--Loch Modan
			["Alliance"] = {
				[1683] = { ["name"] = "Warg Deepwater", ["floor"] = 0, ["pos"] = { 40.6, 39.4 } },
			},
		},
		[895] = {		--New Tinkertown
			["Alliance"] = {
				[1700] = { ["name"] = "Paxton Ganter", ["floor"] = 0, ["pos"] = { 62, 37.4 } },
			},
		},
		[40] = {		--Wetlands
			["Alliance"] = {
				[3179] = { ["name"] = "Harold Riggs", ["floor"] = 0, ["pos"] = { 8, 58.4 } },
			},
		},
		[41] = {		--Teldrassil
			["Alliance"] = {
				[3607] = { ["name"] = "Androl Oakhand", ["floor"] = 0, ["pos"] = { 54, 89.8 } },
			},
		},
		[381] = {		--Darnassus
			["Alliance"] = {
				[4156] = { ["name"] = "Astaia", ["floor"] = 0, ["pos"] = { 48.6, 60.4 } },
			},
		},
		[341] = {		--Ironforge
			["Alliance"] = {
				[5161] = { ["name"] = "Grimnur Stonebrand", ["floor"] = 0, ["pos"] = { 47.6, 7.2 } },
			},
		},
		[301] = {		--Stormwind City
			["Alliance"] = {
				[5493] = { ["name"] = "Arnold Leland", ["floor"] = 0, ["pos"] = { 54.8, 69.4 } },
			},
		},
		[121] = {		--Feralas
			["Alliance"] = {
				[7946] = { ["name"] = "Brannock", ["floor"] = 0, ["pos"] = { 45.2, 41.4 } },
			},
		},
		[471] = {		--The Exodar
			["Alliance"] = {
				[16774] = { ["name"] = "Erett", ["floor"] = 0, ["pos"] = { 31.6, 14.8 } },
			},
		},
		[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17101] = { ["name"] = "Diktynna", ["floor"] = 0, ["pos"] = { 61, 54.2 } },
			},
		},
		[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[23896] = { ["name"] = "\"Dirty\" Michael Crowe", ["floor"] = 0, ["pos"] = { 69.2, 51.8 } },
			},
		},
		[491] = {		--Howling Fjord
			["Alliance"] = {
				[26909] = { ["name"] = "Byron Welwick", ["floor"] = 0, ["pos"] = { 60.2, 64 } },
			},
			["Horde"] = {
				[26957] = { ["name"] = "Angelina Soren", ["floor"] = 0, ["pos"] = { 79.4, 27.2 } },
			},
		},
		[486] = {		--Borean Tundra
			["Alliance"] = {
				[26993] = { ["name"] = "Old Man Robert", ["floor"] = 0, ["pos"] = { 57.8, 71.4 } },
			},
			["Horde"] = {
				[32474] = { ["name"] = "Fishy Ser\'ji", ["floor"] = 0, ["pos"] = { 41.8, 54.4 } },
			},
		},
		[545] = {		--Gilneas
			["Alliance"] = {
				[50570] = { ["name"] = "Whilsey Bottomtooth", ["floor"] = 0, ["pos"] = { 63.6, 95 } },
			},
		},
		[362] = {		--Thunder Bluff
			["Horde"] = {
				[3028] = { ["name"] = "Kah Mistrunner", ["floor"] = 0, ["pos"] = { 56, 45.8 } },
			},
		},
		[321] = {		--Orgrimmar
			["Horde"] = {
				[3332] = { ["name"] = "Lumak", ["floor"] = 1, ["pos"] = { 66.4, 41.4 } },
			},
		},
		[382] = {		--Undercity
			["Horde"] = {
				[4573] = { ["name"] = "Armand Cromwell", ["floor"] = 0, ["pos"] = { 65, 30.8 } },
			},
		},
		[20] = {		--Tirisfal Glades
			["Horde"] = {
				[5690] = { ["name"] = "Clyde Kellen", ["floor"] = 0, ["pos"] = { 67.2, 51 } },
			},
		},
		[9] = {		--Mulgore
			["Horde"] = {
				[5938] = { ["name"] = "Uthan Stillwater", ["floor"] = 0, ["pos"] = { 44.8, 60 } },
			},
		},
		[4] = {		--Durotar
			["Horde"] = {
				[5941] = { ["name"] = "Lau\'Tiki", ["floor"] = 0, ["pos"] = { 57.2, 77 } },
			},
		},
		[101] = {		--Desolace
			["Horde"] = {
				[12032] = { ["name"] = "Lui\'Mala", ["floor"] = 0, ["pos"] = { 22.6, 72.4 } },
			},
		},
		[43] = {		--Ashenvale
			["Horde"] = {
				[12961] = { ["name"] = "Kil\'Hiwana", ["floor"] = 0, ["pos"] = { 10.8, 33.8 } },
			},
		},
		[26] = {		--The Hinterlands
			["Horde"] = {
				[14740] = { ["name"] = "Katoom the Angler", ["floor"] = 0, ["pos"] = { 80.4, 81.4 } },
			},
		},
		[480] = {		--Silvermoon City
			["Horde"] = {
				[16780] = { ["name"] = "Drathen", ["floor"] = 0, ["pos"] = { 76.6, 68.4 } },
			},
		},
		[467] = {		--Zangarmarsh
			["Horde"] = {
				[18018] = { ["name"] = "Zurjaya", ["floor"] = 0, ["pos"] = { 32.2, 49.4 } },
			},
			["Neutral"] = {
				[18911] = { ["name"] = "Juno Dufrain", ["floor"] = 0, ["pos"] = { 78, 66 } },
			},
		},
		[673] = {		--The Cape of Stranglethorn
			["Neutral"] = {
				[2834] = { ["name"] = "Myizz Luckycatch", ["floor"] = 0, ["pos"] = { 41.4, 73.4 } },
			},
		},
		[478] = {		--Terokkar Forest
			["Neutral"] = {
				[25580] = { ["name"] = "Old Man Barlo", ["floor"] = 0, ["pos"] = { 38.6, 12.8 } },
			},
		},
		[504] = {		--Dalaran
			["Neutral"] = {
				[28742] = { ["name"] = "Marcia Chase", ["floor"] = 1, ["pos"] = { 77, 89 } },
			},
		},
		[857] = {		--Krasarang Wilds
			["Neutral"] = {
				[63721] = { ["name"] = "Nat Pagle", ["floor"] = 0, ["pos"] = { 68.4, 43.4 } },
			},
		},
		[809] = {		--Kun-Lai Summit
			["Neutral"] = {
				[66358] = { ["name"] = "Master Lo", ["floor"] = 0, ["pos"] = { 51, 40.2 } },
			},
		},
		[807] = {		--Valley of the Four Winds
			["Neutral"] = {
				[70398] = { ["name"] = "Ben of the Booming Voice", ["floor"] = 0, ["pos"] = { 54, 47 } },
			},
		},
	},
};
cb.professions:registerModule(profession_data);