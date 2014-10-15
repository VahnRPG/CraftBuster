local SKILL_ID = CBT_SKILL_HERB;
local SKILL_NAME = CBL[CBT_SKILL_HERB];
local SKILL_SHORT_CODE = "herb";
local SKILL_TYPE = CBG_SKILL_GATHER;
local SKILL_SPELL_1ID = 81708;		--Lifeblood
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[36] = {		--Redridge Mountains
		["Alliance"] = {
			[812] = { ["name"] = "Alma Jainrose", ["floor"] = 0, ["pos"] = { 22, 42.2 } },
		},
	},
	[30] = {		--Elwynn Forest
		["Alliance"] = {
			[1218] = { ["name"] = "Herbalist Pomeroy", ["floor"] = 0, ["pos"] = { 39.8, 48.4 } },
		},
	},
	[40] = {		--Wetlands
		["Alliance"] = {
			[1458] = { ["name"] = "Telurinon Moonshadow", ["floor"] = 0, ["pos"] = { 11.2, 52 } },
		},
	},
	[35] = {		--Loch Modan
		["Alliance"] = {
			[1473] = { ["name"] = "Kali Healtouch", ["floor"] = 0, ["pos"] = { 36.4, 48.4 } },
		},
	},
	[41] = {		--Teldrassil
		["Alliance"] = {
			[3604] = { ["name"] = "Malorne Bladeleaf", ["floor"] = 0, ["pos"] = { 57, 53 } },
		},
	},
	[381] = {		--Darnassus
		["Alliance"] = {
			[4204] = { ["name"] = "Firodren Mooncaller", ["floor"] = 0, ["pos"] = { 49, 69 } },
		},
	},
	[141] = {		--Dustwallow Marsh
		["Alliance"] = {
			[4898] = { ["name"] = "Brant Jasperbloom", ["floor"] = 0, ["pos"] = { 64, 47.6 } },
		},
	},
	[341] = {		--Ironforge
		["Alliance"] = {
			[5137] = { ["name"] = "Reyna Stonebranch", ["floor"] = 0, ["pos"] = { 55.4, 58.4 } },
		},
	},
	[301] = {		--Stormwind City
		["Alliance"] = {
			[5566] = { ["name"] = "Tannysa", ["floor"] = 0, ["pos"] = { 54.4, 83.4 } },
		},
	},
	[471] = {		--The Exodar
		["Alliance"] = {
			[16736] = { ["name"] = "Cemmorhan", ["floor"] = 0, ["pos"] = { 27.6, 62.6 } },
		},
	},
	[476] = {		--Bloodmyst Isle
		["Alliance"] = {
			[17434] = { ["name"] = "Morae", ["floor"] = 0, ["pos"] = { 53.2, 57.6 } },
		},
	},
	[464] = {		--Azuremyst Isle
		["Alliance"] = {
			[17983] = { ["name"] = "Heur", ["floor"] = 0, ["pos"] = { 48.2, 51.4 } },
		},
	},
	[465] = {		--Hellfire Peninsula
		["Alliance"] = {
			[18776] = { ["name"] = "Rorelien", ["floor"] = 0, ["pos"] = { 53.6, 65.8 } },
		},
		["Horde"] = {
			[18748] = { ["name"] = "Ruak Stronghorn", ["floor"] = 0, ["pos"] = { 52.2, 36.2 } },
		},
	},
	[491] = {		--Howling Fjord
		["Alliance"] = {
			[26910] = { ["name"] = "Fayin Whisperleaf", ["floor"] = 0, ["pos"] = { 58.8, 63 } },
		},
		["Horde"] = {
			[26958] = { ["name"] = "Marjory Kains", ["floor"] = 0, ["pos"] = { 78.4, 28.4 } },
		},
	},
	[486] = {		--Borean Tundra
		["Alliance"] = {
			[26994] = { ["name"] = "Kirea Moondancer", ["floor"] = 0, ["pos"] = { 57.8, 71.8 } },
		},
		["Horde"] = {
			[26974] = { ["name"] = "Tansy Wildmane", ["floor"] = 0, ["pos"] = { 42, 53.6 } },
		},
	},
	[806] = {		--The Jade Forest
		["Alliance"] = {
			[67025] = { ["name"] = "Orchard Keeper Li Mei", ["floor"] = 0, ["pos"] = { 45.4, 86 } },
		},
		["Horde"] = {
			[55523] = { ["name"] = "Shokia", ["floor"] = 0, ["pos"] = { 31.8, 22.2 } },
			[56340] = { ["name"] = "Shokia", ["floor"] = 0, ["pos"] = { 28.2, 47 } },
			[56838] = { ["name"] = "Shokia", ["floor"] = 0, ["pos"] = { 28.4, 51.8 } },
			[66980] = { ["name"] = "Grower Miao", ["floor"] = 0, ["pos"] = { 27.8, 15.4 } },
		},
	},
	[20] = {		--Tirisfal Glades
		["Horde"] = {
			[2114] = { ["name"] = "Faruza", ["floor"] = 0, ["pos"] = { 59.4, 52 } },
			[33996] = { ["name"] = "William Saldean", ["floor"] = 0, ["pos"] = { 61.2, 52 } },
		},
	},
	[24] = {		--Hillsbrad Foothills
		["Horde"] = {
			[2390] = { ["name"] = "Aranae Venomblood", ["floor"] = 0, ["pos"] = { 57.2, 47.4 } },
		},
	},
	[37] = {		--Northern Stranglethorn
		["Horde"] = {
			[2856] = { ["name"] = "Angrun", ["floor"] = 0, ["pos"] = { 38.4, 48.4 } },
		},
	},
	[362] = {		--Thunder Bluff
		["Horde"] = {
			[3013] = { ["name"] = "Komin Winterhoof", ["floor"] = 0, ["pos"] = { 49.4, 39.4 } },
		},
	},
	[4] = {		--Durotar
		["Horde"] = {
			[3185] = { ["name"] = "Mishiki", ["floor"] = 0, ["pos"] = { 55.6, 75.2 } },
		},
	},
	[382] = {		--Undercity
		["Horde"] = {
			[4614] = { ["name"] = "Martha Alliestar", ["floor"] = 0, ["pos"] = { 54.4, 49.8 } },
		},
	},
	[121] = {		--Feralas
		["Horde"] = {
			[8146] = { ["name"] = "Ruw", ["floor"] = 0, ["pos"] = { 76, 43.4 } },
		},
	},
	[462] = {		--Eversong Woods
		["Horde"] = {
			[16367] = { ["name"] = "Botanist Tyniarrel", ["floor"] = 0, ["pos"] = { 37.4, 71.8 } },
		},
	},
	[480] = {		--Silvermoon City
		["Horde"] = {
			[16644] = { ["name"] = "Botanist Nathera", ["floor"] = 0, ["pos"] = { 67.4, 18 } },
		},
	},
	[321] = {		--Orgrimmar
		["Horde"] = {
			[46741] = { ["name"] = "Muraga", ["floor"] = 1, ["pos"] = { 54.4, 50.4 } },
		},
	},
	[673] = {		--The Cape of Stranglethorn
		["Neutral"] = {
			[908] = { ["name"] = "Flora Silverwind", ["floor"] = 0, ["pos"] = { 42, 74.4 } },
		},
	},
	[241] = {		--Moonglade
		["Neutral"] = {
			[12025] = { ["name"] = "Malvor", ["floor"] = 0, ["pos"] = { 45.6, 46.8 } },
		},
	},
	[504] = {		--Dalaran
		["Neutral"] = {
			[28704] = { ["name"] = "Dorothy Egan", ["floor"] = 1, ["pos"] = { 43.4, 34.4 } },
		},
	},
	[481] = {		--Shattrath City
		["Neutral"] = {
			[33639] = { ["name"] = "Botanist Alaenra", ["floor"] = 0, ["pos"] = { 38.4, 71.4 } },
			[33678] = { ["name"] = "Jijia", ["floor"] = 0, ["pos"] = { 37.8, 29.6 } },
		},
	},
	[807] = {		--Valley of the Four Winds
		["Neutral"] = {
			[65877] = { ["name"] = "Han Flowerbloom", ["floor"] = 0, ["pos"] = { 53.6, 51.2 } },
		},
	},
	[809] = {		--Kun-Lai Summit
		["Neutral"] = {
			[66355] = { ["name"] = "Master Marshall", ["floor"] = 0, ["pos"] = { 50.4, 42.2 } },
		},
	},
};
local SKILL_NODES = {
	--vanilla
	["Peacebloom"] = {
		["rank"] = 0,
		["item_id"] = 2447, --Peacebloom
		["ply_level"] = 1,
		["node_levels"] = { 1, 25, 50, 100 },
		["map_ids"] = { 4,9,11,20,27,30,35,39,41,42,181,462,463,464,476,544,545,611,808 },
	},
	["Silverleaf"] = {
		["rank"] = 1,
		["item_id"] = 765, --Silverleaf
		["ply_level"] = 1,
		["node_levels"] = { 1, 25, 50, 100 },
		["map_ids"] = { 4,9,11,20,21,27,30,35,39,41,42,181,462,463,464,476,544,545,611,808 },
	},
	["Bloodthistle"] = {
		["rank"] = 2,
		["item_id"] = 22710, --Bloodthistle
		["ply_level"] = 1,
		["node_levels"] = { 1, 25, 50, 100 },
		["map_ids"] = { 462 },
	},
	["Earthroot"] = {
		["rank"] = 3,
		["item_id"] = 2449, --Earthroot
		["ply_level"] = 1,
		["node_levels"] = { 10, 40, 65, 115 },
		["map_ids"] = { 4,9,11,20,21,27,30,35,36,39,41,42,181,462,463,464,476,544,545,611,749,808 },
	},
	["Mageroyal"] = {
		["rank"] = 4,
		["item_id"] = 785, --Mageroyal
		["ply_level"] = 1,
		["node_levels"] = { 50, 75, 100, 150 },
		["map_ids"] = { 11,21,24,34,35,36,39,40,41,42,43,81,181,463,476,607,749 },
	},
	["Briarthorn"] = {
		["rank"] = 5,
		["item_id"] = 2450, --Briarthorn
		["ply_level"] = 1,
		["node_levels"] = { 70, 95, 120, 170 },
		["map_ids"] = { 11,21,24,34,35,36,39,40,42,43,81,181,463,476,607,761 },
	},
	["Stranglekelp"] = {
		["rank"] = 6,
		["item_id"] = 3820, --Stranglekelp
		["ply_level"] = 1,
		["node_levels"] = { 85, 110, 135, 185 },
		["map_ids"] = { 16,21,22,24,26,37,38,39,40,42,43,61,141,463,476,673,688 },
	},
	["Bruiseweed"] = {
		["rank"] = 7,
		["item_id"] = 2453, --Bruiseweed
		["ply_level"] = 1,
		["node_levels"] = { 85, 125, 150, 200 },
		["map_ids"] = { 11,16,24,26,34,35,36,37,39,40,43,81,463,476,688 },
	},
	["Wild Steelbloom"] = {
		["rank"] = 8,
		["item_id"] = 3355, --Wild Steelbloom
		["ply_level"] = 1,
		["node_levels"] = { 115, 140, 165, 215 },
		["map_ids"] = { 16,26,34,37,40,43,81,101 },
	},
	["Grave Moss"] = {
		["rank"] = 9,
		["item_id"] = 3369, --Grave Moss
		["ply_level"] = 1,
		["node_levels"] = { 120, 150, 170, 220 },
		["map_ids"] = { 16,24,34,40,760 },
	},
	["Kingsblood"] = {
		["rank"] = 10,
		["item_id"] = 3356, --Kingsblood
		["ply_level"] = 1,
		["node_levels"] = { 125, 155, 175, 225 },
		["map_ids"] = { 16,22,26,34,37,40,43,101,121,141,607 },
	},
	["Liferoot"] = {
		["rank"] = 11,
		["item_id"] = 3357, --Liferoot
		["ply_level"] = 1,
		["node_levels"] = { 150, 175, 200, 250 },
		["map_ids"] = { 16,22,23,24,26,37,40,43,61,101,141,479,607,673 },
	},
	["Fadeleaf"] = {
		["rank"] = 12,
		["item_id"] = 3818, --Fadeleaf
		["ply_level"] = 1,
		["node_levels"] = { 150, 175, 200, 250 },
		["map_ids"] = { 16,22,26,121,141,673 },
	},
	["Khadgar's Whisker"] = {
		["rank"] = 13,
		["item_id"] = 3358, --Khadgar's Whisker
		["ply_level"] = 1,
		["node_levels"] = { 160, 185, 210, 260 },
		["map_ids"] = { 16,22,23,26,101,121,141,607,673 },
	},
	["Goldthorn"] = {
		["rank"] = 14,
		["item_id"] = 3821, --Goldthorn
		["ply_level"] = 1,
		["node_levels"] = { 150, 195, 220, 270 },
		["map_ids"] = { 16,26,101,121,141,673 },
	},
	["Dragon's Teeth"] = {
		["rank"] = 15,
		["item_id"] = 3819, --Dragon's Teeth
		["ply_level"] = 1,
		["node_levels"] = { 195, 225, 245, 295 },
		["map_ids"] = { 17 },
	},
	["Firebloom"] = {
		["rank"] = 16,
		["item_id"] = 4625, --Firebloom
		["ply_level"] = 1,
		["node_levels"] = { 205, 235, 255, 305 },
		["map_ids"] = { 17,28,29,161 },
	},
	["Purple Lotus"] = {
		["rank"] = 17,
		["item_id"] = 8831, --Purple Lotus
		["ply_level"] = 1,
		["node_levels"] = { 210, 235, 260, 310 },
		["map_ids"] = { 182 },
	},
	["Arthas' Tears"] = {
		["rank"] = 18,
		["item_id"] = 8836, --Arthas' Tears
		["ply_level"] = 1,
		["node_levels"] = { 220, 250, 270, 320 },
		["map_ids"] = { 760 },
	},
	["Sungrass"] = {
		["rank"] = 19,
		["item_id"] = 8838, --Sungrass
		["ply_level"] = 1,
		["node_levels"] = { 230, 255, 280, 330 },
		["map_ids"] = { 17,23,28,29,61,161,201,261,607 },
	},
	["Blindweed"] = {
		["rank"] = 20,
		["item_id"] = 8839, --Blindweed
		["ply_level"] = 1,
		["node_levels"] = { 235, 260, 285, 335 },
		["map_ids"] = { 22,26,121,201,467 },
	},
	["Ghost Mushroom"] = {
		["rank"] = 21,
		["item_id"] = 8845, --Ghost Mushroom
		["ply_level"] = 1,
		["node_levels"] = { 245, 270, 295, 345 },
		["map_ids"] = { 201,467 },
	},
	["Gromsblood"] = {
		["rank"] = 22,
		["item_id"] = 8846, --Gromsblood
		["ply_level"] = 1,
		["node_levels"] = { 250, 275, 300, 350 },
		["map_ids"] = { 19,101,182 },
	},
	["Golden Sansam"] = {
		["rank"] = 23,
		["item_id"] = 13464, --Golden Sansam
		["ply_level"] = 1,
		["node_levels"] = { 260, 280, 310, 360 },
		["map_ids"] = { 17,19,38,182,201,261,465,467,479 },
	},
	["Dreamfoil"] = {
		["rank"] = 24,
		["item_id"] = 13463, --Dreamfoil
		["ply_level"] = 1,
		["node_levels"] = { 270, 295, 320, 370 },
		["map_ids"] = { 19,29,182,201,261,465,467 },
	},
	["Mountain Silversage"] = {
		["rank"] = 25,
		["item_id"] = 13465, --Mountain Silversage
		["ply_level"] = 1,
		["node_levels"] = { 280, 305, 330, 380 },
		["map_ids"] = { 19,201,261,281,465 },
	},
	["Sorrowmoss"] = {
		["rank"] = 26,
		["item_id"] = 13466, --Sorrowmoss
		["ply_level"] = 1,
		["node_levels"] = { 285, 310, 335, 385 },
		["map_ids"] = { 38 },
	},
	["Icecap"] = {
		["rank"] = 27,
		["item_id"] = 13467, --Icecap
		["ply_level"] = 1,
		["node_levels"] = { 290, 315, 340, 370 },
		["map_ids"] = { 281 },
	},
	["Black Lotus"] = {
		["rank"] = 28,
		["item_id"] = 13468, --Black Lotus
		["ply_level"] = 1,
		["node_levels"] = { 300, 345, 375, 400 },
		["map_ids"] = { 19,23,261,281 },
	},

	--tbc
	["Felweed"] = {
		["rank"] = 29,
		["item_id"] = 22785, --Felweed
		["ply_level"] = 1,
		["node_levels"] = { 300, 325, 350, 400 },
		["map_ids"] = { 465,467,473,475,477,478,479,726,728,729 },
	},
	["Dreaming Glory"] = {
		["rank"] = 30,
		["item_id"] = 22786, --Dreaming Glory
		["ply_level"] = 1,
		["node_levels"] = { 315, 340, 365, 415 },
		["map_ids"] = { 465,467,473,475,477,478,479 },
	},
	["Ragveil"] = {
		["rank"] = 31,
		["item_id"] = 22787, --Ragveil
		["ply_level"] = 1,
		["node_levels"] = { 325, 350, 375, 425 },
		["map_ids"] = { 467,726,728 },
	},
	["Flame Cap"] = {
		["rank"] = 32,
		["item_id"] = 22788, --Flame Cap
		["ply_level"] = 1,
		["node_levels"] = { 335, 352, 400, 435 },
		["map_ids"] = { 467,726,727,728 },
	},
	["Terocone"] = {
		["rank"] = 33,
		["item_id"] = 22789, --Terocone
		["ply_level"] = 1,
		["node_levels"] = { 325, 350, 400, 425 },
		["map_ids"] = { 473,478,729 },
	},
	["Ancient Lichen"] = {
		["rank"] = 34,
		["item_id"] = 22790, --Ancient Lichen
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 450 },
		["map_ids"] = { 722,723,724,726,727,728,732 },
	},
	["Netherbloom"] = {
		["rank"] = 35,
		["item_id"] = 22791, --Netherbloom
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 450 },
		["map_ids"] = { 479,729 },
	},
	["Nightmare Vine"] = {
		["rank"] = 36,
		["item_id"] = 22792, --Nightmare Vine
		["ply_level"] = 1,
		["node_levels"] = { 365, 390, 419, 465 },
		["map_ids"] = { 465,473,475 },
	},
	["Mana Thistle"] = {
		["rank"] = 37,
		["item_id"] = 22793, --Mana Thistle
		["ply_level"] = 1,
		["node_levels"] = { 375, 415, 425, 475 },
		["map_ids"] = { 473,475,477,478,479,499 },
	},

	--wotlk
	["Goldclover"] = {
		["rank"] = 38,
		["item_id"] = 36901, --Goldclover
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 425 },
		["map_ids"] = { 486,488,490,491,493,533 },
	},
	["Firethorn"] = {
		["rank"] = 39,
		["item_id"] = 39970, --Firethorn
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 425 },
		["map_ids"] = { 486 },
	},
	["Tiger Lily"] = {
		["rank"] = 40,
		["item_id"] = 36904, --Tiger Lily
		["ply_level"] = 1,
		["node_levels"] = { 375, 400, 425, 450 },
		["map_ids"] = { 486,490,491,493,533 },
	},
	["Talandra's Rose"] = {
		["rank"] = 41,
		["item_id"] = 36907, --Talandra's Rose
		["ply_level"] = 1,
		["node_levels"] = { 375, 400, 425, 450 },
		["map_ids"] = { 490,496,522,530,534 },
	},
	["Frozen Herb"] = {
		["rank"] = 42,
		["item_id"] = "", --Frozen Herb
		["ply_level"] = 1,
		["node_levels"] = { 400, 425, 450, 475 },
		["map_ids"] = { 24,488,496,501,520 },
	},
	["Adder's Tongue"] = {
		["rank"] = 43,
		["item_id"] = 36903, --Adder's Tongue
		["ply_level"] = 1,
		["node_levels"] = { 400, 425, 450, 475 },
		["map_ids"] = { 493,530,534 },
	},
	["Lichbloom"] = {
		["rank"] = 44,
		["item_id"] = 36905, --Lichbloom
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 525 },
		["map_ids"] = { 492,495,501,524 },
	},
	["Icethorn"] = {
		["rank"] = 45,
		["item_id"] = 36906, --Icethorn
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 525 },
		["map_ids"] = { 492,495,501,524 },
	},
	["Frost Lotus"] = {
		["rank"] = 46,
		["item_id"] = 36908, --Frost Lotus
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["map_ids"] = { 501,529 },
	},

	--cata
	["Cinderbloom"] = {
		["rank"] = 47,
		["item_id"] = 52983, --Cinderbloom
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 525 },
		["map_ids"] = { 606,640,700,708,709,720 },
	},
	["Azshara's Veil"] = {
		["rank"] = 48,
		["item_id"] = 52985, --Azshara's Veil
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 525 },
		["map_ids"] = { 606,610,614,615,709 },
	},
	["Stormvine"] = {
		["rank"] = 49,
		["item_id"] = 52984, --Stormvine
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 525 },
		["map_ids"] = { 606,610,614,615 },
	},
	["Heartblossom"] = {
		["rank"] = 50,
		["item_id"] = 52986, --Heartblossom
		["ply_level"] = 1,
		["node_levels"] = { 475, 500, 525, 550 },
		["map_ids"] = { 640 },
	},
	["Whiptail"] = {
		["rank"] = 51,
		["item_id"] = 52988, --Whiptail
		["ply_level"] = 1,
		["node_levels"] = { 500, 525, 550, 575 },
		["map_ids"] = { 708,720 },
	},
	["Twilight Jasmine"] = {
		["rank"] = 52,
		["item_id"] = 52987, --Twilight Jasmine
		["ply_level"] = 1,
		["node_levels"] = { 525, 525, 550, 550 },
		["map_ids"] = { 700 },
	},

	--mists
	["Green Tea Leaf"] = {
		["rank"] = 53,
		["item_id"] = 72234, --Green Tea Leaf
		["ply_level"] = 1,
		["node_levels"] = { 500, 525, 550, 575 },
		["map_ids"] = { 806,807,809,810,811,857,858,867,887,951 },
	},
	["Rain Poppy"] = {
		["rank"] = 54,
		["item_id"] = 72237, --Rain Poppy
		["ply_level"] = 1,
		["node_levels"] = { 525, 550, 575, 600 },
		["map_ids"] = { 806,811,951 },
	},
	["Silkweed"] = {
		["rank"] = 55,
		["item_id"] = 72235, --Silkweed
		["ply_level"] = 1,
		["node_levels"] = { 545, 570, 595, 600 },
		["map_ids"] = { 806,807,857,873,951 },
	},
	["Sha-Touched Herb"] = {
		["rank"] = 57,
		["item_id"] = 89639, --Desecrated Herb
		["ply_level"] = 1,
		["node_levels"] = { 575, 600, 600, 600 },
		["map_ids"] = { 806,807,809,858 },
	},
	["Snow Lily"] = {
		["rank"] = 56,
		["item_id"] = 79010, --Snow Lily
		["ply_level"] = 1,
		["node_levels"] = { 575, 600, 600, 600 },
		["map_ids"] = { 809,810,877 },
	},
	["Fool's Cap"] = {
		["rank"] = 58,
		["item_id"] = 79011, --Fool's Cap
		["ply_level"] = 1,
		["node_levels"] = { 600, 600, 600, 600 },
		["map_ids"] = { 806,810,858,951 },
	},
};

local function CraftBuster_Module_Herbalism_BuildActions()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);

	local base_count = CBG_MAX_PROFESSIONS - 1;
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 0), 2, "0", "right") .. SKILL_SHORT_CODE .. "_1_orange"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][1],
			["action"] = CBT_ORANGE,
			["message"] = CraftBuster_Module_TranslateActionText(ORANGE_FONT_COLOR_CODE, node_name, node_data["node_levels"][1]),
			["fields"] = { node_name, node_data["node_levels"][1] },
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 1), 2, "0", "right") .. SKILL_SHORT_CODE .. "_2_yellow"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][2],
			["action"] = CBT_YELLOW,
			["message"] = CraftBuster_Module_TranslateActionText(YELLOW_FONT_COLOR_CODE, node_name, node_data["node_levels"][2]),
			["fields"] = { node_name, node_data["node_levels"][2] },
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 2), 2, "0", "right") .. SKILL_SHORT_CODE .. "_3_green"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][3],
			["action"] = CBT_GREEN,
			["message"] = CraftBuster_Module_TranslateActionText(GREEN_FONT_COLOR_CODE, node_name, node_data["node_levels"][3]),
			["fields"] = { node_name, node_data["node_levels"][3] },
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 3), 2, "0", "right") .. SKILL_SHORT_CODE .. "_4_grey"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][4],
			["action"] = CBT_GREY,
			["message"] = CraftBuster_Module_TranslateActionText(GRAY_FONT_COLOR_CODE, node_name, node_data["node_levels"][4]),
			["fields"] = { node_name, node_data["node_levels"][4] },
		};
	end
end

local function CraftBuster_Module_Herbalism_HandleGather(zone_name)
	local skill_level = CraftBuster_GetSkillLevel(SKILL_ID);
	local gather_data = {
		["zones"] = {},
		["skill"] = {},
	};
	
	local found = false;
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		for _,map_id in pairs(node_data["map_ids"]) do
			if (map_id == zone_map_id) then
				local rank = node_data["rank"];
				gather_data["zones"][rank] = {
					["item_id"] = node_data["item_id"],
					["name"] = node_name,
					["levels"] = node_data["node_levels"],
				};
				found = true;
			end
		end
		
		if (skill_level ~= nil and skill_level < CBG_MAX_PROFESSION_RANK) then
			if (skill_level >= node_data["node_levels"][1] and skill_level < node_data["node_levels"][4]) then
				local rank = node_data["rank"];
				gather_data["skill"][rank] = {
					["item_id"] = node_data["item_id"],
					["name"] = node_name,
					["levels"] = node_data["node_levels"],
				};
				found = true;
			end
		end
	end

	if (CraftBusterOptions[CraftBusterEntry].modules[SKILL_ID].show_gather and found) then
		CraftBuster_GatherFrame_AddGather(gather_data);
	end
end

local function CraftBuster_Module_Herbalism_HandleNode(line_one, line_two, line_three)
	line_one =  gsub(gsub(line_one, "|c........", ""), "|r", "");
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		if (string.find(line_one, node_name, 1, true) ~= nil and SKILL_NODES[node_name] ~= nil) then
			GameTooltip:AddLine(CBL["NODE_MSG"] .. ORANGE_FONT_COLOR_CODE .. " " .. node_data["node_levels"][1] .. YELLOW_FONT_COLOR_CODE .. " " .. node_data["node_levels"][2] .. GREEN_FONT_COLOR_CODE .. " " .. node_data["node_levels"][3] .. GRAY_FONT_COLOR_CODE .. " " .. node_data["node_levels"][4]);
			GameTooltip:Show();
			return true;
		end
	end

	return false;
end

local function CraftBuster_Module_Herbalism_HandleAction(skill_data)
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

local function CraftBuster_Module_Herbalism_DisplayActions(display_frame)
	CraftBuster_Module_BuildActionDisplay(display_frame, SKILL_ID, SKILL_ACTIONS, SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
end

local function CraftBuster_Module_Herbalism_OnLoad()
	CraftBuster_Module_Herbalism_BuildActions();
	local module_options = {
		skill_type = CBG_SKILL_GATHER,
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		tooltip_info = true,
		has_worldmap = true,
		gather_function = CraftBuster_Module_Herbalism_HandleGather,
		node_function = CraftBuster_Module_Herbalism_HandleNode,
		action_function = CraftBuster_Module_Herbalism_HandleAction,
		display_action_function = CraftBuster_Module_Herbalism_DisplayActions,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
	CraftBuster_WorldMap_AddNodes(SKILL_ID, SKILL_NODES);
end

CraftBuster_Module_Herbalism_OnLoad();

local function CraftBuster_Module_Herbalism_AddZoneInfo(frame, item_link)
	if (CraftBusterOptions[CraftBusterEntry].modules[SKILL_ID].show_tooltips ~= true) then
		return;
	end

	local _, _, item_string = strfind(item_link, "^|c%x+|H(.+)|h%[.+%]");
	if (item_string) then
		local _, item_id = strsplit(":", item_string);
		if (item_id) then
			item_id = tonumber(item_id);
			local found_item = false;
			local zones = {};
			local found_zones = {};
			local count = 0;
			for node_name, node_data in sortedpairs(SKILL_NODES) do
				if (item_id == node_data["item_id"]) then
					found_item = true;
					for _,map_id in pairs(node_data["map_ids"]) do
						if (found_zones[map_id] == nil) then 
							zones[count] = CBL["MAP_NAMES"][map_id];
							found_zones[map_id] = map_id;
							count = count + 1;
						end
					end
				end
			end

			if (found_item) then
				count = 0;
				local zone_limit = CraftBusterOptions[CraftBusterEntry].zone_limit;
				local output_txt = CBL["SKILL_HERB_ZONE"];

				local found = false;
				for _,zone_name in pairs(zones) do
					if (found) then
						output_txt = output_txt .. ", ";
					end

					--add some newlines to make it pretty
					local test = output_txt .. zone_name;
					local start_from = 1;
					if (string.find(test, "\n[^\n]*$") ~= nil) then
						start_from = string.find(test, "\n[^\n]*$");
					end
					if (string.len(string.sub(test, start_from)) > 40) then
						output_txt = output_txt .. "\n  ";
					end

					output_txt = output_txt .. zone_name;

					found = true;
					count = count + 1;
					if (tcount(zones) <= 10) then
						--let items with only a few zones to display them all
					elseif (zone_limit > 0 and count >= zone_limit) then
						break;
					end
				end
				
				frame:AddLine(output_txt);
			end
		end
	end
	
	frame:Show();
end

local function HookFrame(frame)
	frame:HookScript("OnTooltipSetItem",
		function(self, ...)
			local item_link = select(2, self:GetItem());
			if (item_link and GetItemInfo(item_link)) then
				CraftBuster_Module_Herbalism_AddZoneInfo(self, item_link);
			end
		end
	);
end

HookFrame(GameTooltip);
HookFrame(ItemRefTooltip);