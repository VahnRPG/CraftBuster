local _, cb = ...;

local SKILL_ID = CBT_SKILL_COOK;
local SKILL_SHORT_CODE = "cook";
local profession_data = {
	["id"] = SKILL_ID,
	["name"] = CBL[SKILL_ID],
	["short_code"] = SKILL_SHORT_CODE,
	["type"] = CBG_SKILL_NORMAL,
	["spell_1"] = 2550,		--Cooking
	["spell_2"] = 818,		--Basic Campfire
	["trainer_map_icons"] = {
		[27] = {		--Dun Morogh
			["Alliance"] = {
				[1355] = { ["name"] = "Cook Ghilm", ["floor"] = 0, ["pos"] = { 75.6, 52.8 } },
				[1699] = { ["name"] = "Gremlock Pilsnor", ["floor"] = 0, ["pos"] = { 54.6, 50.6 } },
				[34708] = { ["name"] = "Caitrin Ironkettle", ["floor"] = 0, ["pos"] = { 60, 34.2 } },
			},
		},
		[30] = {		--Elwynn Forest
			["Alliance"] = {
				[1430] = { ["name"] = "Tomas", ["floor"] = 0, ["pos"] = { 44.2, 66 } },
				[34710] = { ["name"] = "Ellen Moore", ["floor"] = 0, ["pos"] = { 33.6, 50.4 } },
			},
		},
		[36] = {		--Redridge Mountains
			["Alliance"] = {
				[3087] = { ["name"] = "Crystal Boughman", ["floor"] = 0, ["pos"] = { 22.8, 40.4 } },
			},
		},
		[381] = {		--Darnassus
			["Alliance"] = {
				[4210] = { ["name"] = "Alegorn", ["floor"] = 0, ["pos"] = { 50, 36.6 } },
				[34711] = { ["name"] = "Mary Allerton", ["floor"] = 0, ["pos"] = { 61.8, 47 } },
			},
		},
		[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[4894] = { ["name"] = "Craig Nollward", ["floor"] = 0, ["pos"] = { 66.8, 45.2 } },
			},
		},
		[341] = {		--Ironforge
			["Alliance"] = {
				[5159] = { ["name"] = "Daryl Riknussun", ["floor"] = 0, ["pos"] = { 60.1, 36.4 } },
			},
		},
		[301] = {		--Stormwind City
			["Alliance"] = {
				[5482] = { ["name"] = "Stephen Ryback", ["floor"] = 0, ["pos"] = { 76.8, 53.2 } },
				[42288] = { ["name"] = "Robby Flay", ["floor"] = 0, ["pos"] = { 50.6, 71.6 } },
			},
		},
		[41] = {		--Teldrassil
			["Alliance"] = {
				[6286] = { ["name"] = "Zarrin", ["floor"] = 0, ["pos"] = { 56.6, 53.4 } },
			},
		},
		[471] = {		--The Exodar
			["Alliance"] = {
				[16719] = { ["name"] = "Mumman", ["floor"] = 0, ["pos"] = { 55, 26.6 } },
			},
		},
		[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17246] = { ["name"] = "\"Cookie\" McWeaksauce", ["floor"] = 0, ["pos"] = { 46.6, 70.4 } },
			},
		},
		[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18987] = { ["name"] = "Gaston", ["floor"] = 0, ["pos"] = { 54, 63.4 } },
			},
			["Horde"] = {
				[49789] = { ["name"] = "Allison", ["floor"] = 0, ["pos"] = { 56.8, 37.4 } },
			},
		},
		[473] = {		--Shadowmoon Valley
			["Alliance"] = {
				[19369] = { ["name"] = "Celie Steelwing", ["floor"] = 0, ["pos"] = { 37.2, 58.4 } },
			},
		},
		[491] = {		--Howling Fjord
			["Alliance"] = {
				[26905] = { ["name"] = "Brom Brewbaster", ["floor"] = 0, ["pos"] = { 58.2, 62 } },
			},
			["Horde"] = {
				[26953] = { ["name"] = "Thomas Kolichio", ["floor"] = 0, ["pos"] = { 78.6, 29.4 } },
			},
		},
		[486] = {		--Borean Tundra
			["Alliance"] = {
				[26989] = { ["name"] = "Rollick MacKreel", ["floor"] = 0, ["pos"] = { 57.8, 71.4 } },
			},
			["Horde"] = {
				[26972] = { ["name"] = "Orn Tenderhoof", ["floor"] = 0, ["pos"] = { 42, 54.2 } },
			},
		},
		[504] = {		--Dalaran
			["Alliance"] = {
				[28705] = { ["name"] = "Katherine Lee", ["floor"] = 1, ["pos"] = { 40.6, 64.6 } },
			},
			["Horde"] = {
				[29631] = { ["name"] = "Awilo Lon\'gomba", ["floor"] = 1, ["pos"] = { 70, 39 } },
			},
		},
		[611] = {		--Gilneas City
			["Alliance"] = {
				[50567] = { ["name"] = "Fielding Chesterhill", ["floor"] = 0, ["pos"] = { 36.6, 65.6 } },
			},
		},
		[37] = {		--Northern Stranglethorn
			["Horde"] = {
				[1382] = { ["name"] = "Mudduk", ["floor"] = 0, ["pos"] = { 37.2, 49.2 } },
			},
		},
		[16] = {		--Arathi Highlands
			["Horde"] = {
				[2818] = { ["name"] = "Slagg", ["floor"] = 0, ["pos"] = { 69.2, 34.4 } },
			},
		},
		[362] = {		--Thunder Bluff
			["Horde"] = {
				[3026] = { ["name"] = "Aska Mistrunner", ["floor"] = 0, ["pos"] = { 51.2, 52.8 } },
				[34714] = { ["name"] = "Mahara Goldwheat", ["floor"] = 0, ["pos"] = { 30.4, 53.2 } },
			},
		},
		[9] = {		--Mulgore
			["Horde"] = {
				[3067] = { ["name"] = "Pyall Silentstride", ["floor"] = 0, ["pos"] = { 45.6, 57.6 } },
			},
		},
		[382] = {		--Undercity
			["Horde"] = {
				[4552] = { ["name"] = "Eunice Burch", ["floor"] = 0, ["pos"] = { 62.2, 43.4 } },
				[34712] = { ["name"] = "Roberta Carter", ["floor"] = 0, ["pos"] = { 63.2, 8.4 } },
			},
		},
		[11] = {		--Northern Barrens
			["Horde"] = {
				[8306] = { ["name"] = "Duhng", ["floor"] = 0, ["pos"] = { 55.4, 61.2 } },
			},
		},
		[463] = {		--Ghostlands
			["Horde"] = {
				[16253] = { ["name"] = "Master Chef Mouldier", ["floor"] = 0, ["pos"] = { 48.4, 31 } },
			},
		},
		[462] = {		--Eversong Woods
			["Horde"] = {
				[16277] = { ["name"] = "Quarelestra", ["floor"] = 0, ["pos"] = { 48.6, 47 } },
				[34786] = { ["name"] = "Alice Rigsdale", ["floor"] = 0, ["pos"] = { 56, 52.8 } },
			},
		},
		[480] = {		--Silvermoon City
			["Horde"] = {
				[16676] = { ["name"] = "Sylann", ["floor"] = 0, ["pos"] = { 69.4, 71.4 } },
			},
		},
		[4] = {		--Durotar
			["Horde"] = {
				[34713] = { ["name"] = "Ondani Greatmill", ["floor"] = 0, ["pos"] = { 46.4, 13.8 } },
			},
		},
		[321] = {		--Orgrimmar
			["Horde"] = {
				[42506] = { ["name"] = "Marogg", ["floor"] = 1, ["pos"] = { 56.6, 62.6 } },
				[45550] = { ["name"] = "Zarbo Porkpatty", ["floor"] = 1, ["pos"] = { 39, 85.4 } },
				[46709] = { ["name"] = "Arugi", ["floor"] = 1, ["pos"] = { 56.2, 61.4 } },
			},
		},
		[20] = {		--Tirisfal Glades
			["Horde"] = {
				[47405] = { ["name"] = "The Chef", ["floor"] = 0, ["pos"] = { 61.2, 52.4 } },
			},
		},
		[467] = {		--Zangarmarsh
			["Neutral"] = {
				[18993] = { ["name"] = "Naka", ["floor"] = 0, ["pos"] = { 78.4, 63 } },
			},
		},
		[481] = {		--Shattrath City
			["Neutral"] = {
				[19185] = { ["name"] = "Jack Trapper", ["floor"] = 0, ["pos"] = { 62.4, 68.4 } },
			},
		},
		[492] = {		--Icecrown
			["Neutral"] = {
				[33587] = { ["name"] = "Bethany Cromwell", ["floor"] = 0, ["pos"] = { 72.4, 20.8 } },
			},
		},
		[673] = {		--The Cape of Stranglethorn
			["Neutral"] = {
				[54232] = { ["name"] = "Mrs. Gant", ["floor"] = 0, ["pos"] = { 42.6, 72.8 } },
			},
		},
		[806] = {		--The Jade Forest
			["Neutral"] = {
				[56707] = { ["name"] = "Chin", ["floor"] = 0, ["pos"] = { 46.2, 45.4 } },
			},
		},
		[807] = {		--Valley of the Four Winds
			["Neutral"] = {
				[58712] = { ["name"] = "Kol Ironpaw", ["floor"] = 0, ["pos"] = { 53, 51.4 } },
				[58713] = { ["name"] = "Anthea Ironpaw", ["floor"] = 0, ["pos"] = { 52.8, 51.8 } },
				[58714] = { ["name"] = "Mei Mei Ironpaw", ["floor"] = 0, ["pos"] = { 52.6, 51.4 } },
				[58715] = { ["name"] = "Yan Ironpaw", ["floor"] = 0, ["pos"] = { 52.6, 51.6 } },
				[58716] = { ["name"] = "Jian Ironpaw", ["floor"] = 0, ["pos"] = { 53.2, 51.4 } },
				[58717] = { ["name"] = "Bobo Ironpaw", ["floor"] = 0, ["pos"] = { 53, 52 } },
				[64231] = { ["name"] = "Sungshin Ironpaw", ["floor"] = 0, ["pos"] = { 53.4, 51.2 } },
			},
		},
		[809] = {		--Kun-Lai Summit
			["Neutral"] = {
				[66353] = { ["name"] = "Master Chang", ["floor"] = 0, ["pos"] = { 50.6, 41.8 } },
			},
		},
	},
};
cb.professions:registerModule(profession_data);