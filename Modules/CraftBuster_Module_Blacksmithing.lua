local SKILL_ID = CBT_SKILL_BLCK;
local SKILL_NAME = CBL[CBT_SKILL_BLCK];
local SKILL_SHORT_CODE = "blck";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 2018;		--Blacksmithing
local SKILL_ACTIONS = {};
local SKILL_STATION_MAP_ICONS = {
	[11] = {		--Northern Barrens
		["Neutral"] = {
			["192628_11_0_48.3x56.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 48.3, 56.2 } },
			["192628_11_0_67.1x73.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 67.1, 73.4 } },
		},
	},
	[161] = {		--Tanaris
		["Neutral"] = {
			["192628_161_0_51.1x30.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 51.1, 30.3 } },
		},
	},
	[16] = {		--Arathi Highlands
		["Neutral"] = {
			["192628_16_0_40.8x48"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 40.8, 48 } },
		},
	},
	[17] = {		--Badlands
		["Neutral"] = {
			["192628_17_0_65.1x36.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 65.1, 36.4 } },
		},
	},
	[19] = {		--Blasted Lands
		["Neutral"] = {
			["192628_19_0_61.7x15"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 61.7, 15 } },
		},
	},
	[201] = {		--Un'Goro Crater
		["Neutral"] = {
			["192628_201_0_55.1x61.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 55.1, 61.9 } },
		},
	},
	[20] = {		--Tirisfal Glades
		["Neutral"] = {
			["192628_20_0_62.4x51.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 62.4, 51.4 } },
		},
	},
	[21] = {		--Silverpine Forest
		["Neutral"] = {
			["192628_21_0_42.9x40.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 42.9, 40.9 } },
		},
	},
	[23] = {		--Eastern Plaguelands
		["Neutral"] = {
			["192628_23_0_75.2x53.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 75.2, 53.7 } },
		},
	},
	[261] = {		--Silithus
		["Neutral"] = {
			["192628_261_0_54.9x36.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 54.9, 36.6 } },
		},
	},
	[27] = {		--Dun Morogh
		["Neutral"] = {
			["192628_27_0_52.4x50.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 52.4, 50.3 } },
		},
	},
	[281] = {		--Winterspring
		["Neutral"] = {
			["192628_281_0_59.4x51.1"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 59.4, 51.1 } },
		},
	},
	[301] = {		--Stormwind City
		["Neutral"] = {
			["192628_301_0_26.4x20.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 26.4, 20.8 } },
			["192628_301_0_43.1x72.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 43.1, 72.2 } },
			["192628_301_0_63.4x36.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 63.4, 36.4 } },
		},
	},
	[30] = {		--Elwynn Forest
		["Neutral"] = {
			["192628_30_0_41.4x65.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 41.4, 65.6 } },
		},
	},
	[321] = {		--Orgrimmar
		["Neutral"] = {
			["192628_321_0_36x82.9"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 36, 82.9 } },
			["192628_321_0_40.4x50"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 40.4, 50 } },
			["192628_321_0_44.3x77.5"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 44.3, 77.5 } },
			["192628_321_0_56.4x56.4"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 56.4, 56.4 } },
			["192628_321_0_67.5x38.9"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 67.5, 38.9 } },
			["192628_321_0_75.7x34.4"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 75.7, 34.4 } },
			["192628_321_0_76x37.2"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 76, 37.2 } },
		},
	},
	[34] = {		--Duskwood
		["Neutral"] = {
			["192628_34_0_73.7x48.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 73.7, 48.7 } },
		},
	},
	[35] = {		--Loch Modan
		["Neutral"] = {
			["192628_35_0_34.3x46.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 34.3, 46.5 } },
		},
	},
	[362] = {		--Thunder Bluff
		["Neutral"] = {
			["192628_362_0_39.2x55.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 39.2, 55.8 } },
		},
	},
	[36] = {		--Redridge Mountains
		["Neutral"] = {
			["192628_36_0_29.3x43.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 29.3, 43.5 } },
		},
	},
	[37] = {		--Northern Stranglethorn
		["Neutral"] = {
			["192628_37_0_52.8x67.1"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 52.8, 67.1 } },
		},
	},
	[381] = {		--Darnassus
		["Neutral"] = {
			["192628_381_0_56.9x53.1"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 56.9, 53.1 } },
		},
	},
	[382] = {		--Undercity
		["Neutral"] = {
			["192628_382_0_61.4x28.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 61.4, 28.4 } },
		},
	},
	[42] = {		--Darkshore
		["Neutral"] = {
			["192628_42_0_50.8x19.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 50.8, 19.2 } },
		},
	},
	[462] = {		--Eversong Woods
		["Neutral"] = {
			["192628_462_0_43x72"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 43, 72 } },
		},
	},
	[463] = {		--Ghostlands
		["Neutral"] = {
			["192628_463_0_49.2x30.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 49.2, 30.3 } },
		},
	},
	[464] = {		--Azuremyst Isle
		["Neutral"] = {
			["192628_464_0_47.7x51.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 47.7, 51.2 } },
		},
	},
	[465] = {		--Hellfire Peninsula
		["Neutral"] = {
			["192628_465_0_24x37.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 24, 37.9 } },
			["192628_465_0_53.1x38.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 53.1, 38.5 } },
			["192628_465_0_55.4x37.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 55.4, 37.6 } },
			["192628_465_0_56.8x63.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 56.8, 63.8 } },
		},
	},
	[467] = {		--Zangarmarsh
		["Neutral"] = {
			["192628_467_0_32.5x48"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 32.5, 48 } },
			["192628_467_0_68.5x50.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 68.5, 50.2 } },
			["192628_467_0_79.4x63.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 79.4, 63.7 } },
		},
	},
	[473] = {		--Shadowmoon Valley
		["Neutral"] = {
			["192628_473_0_36.7x55"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 36.7, 55 } },
		},
	},
	[475] = {		--Blade's Edge Mountains
		["Neutral"] = {
			["192628_475_0_51.4x57.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 51.4, 57.5 } },
		},
	},
	[476] = {		--Bloodmyst Isle
		["Neutral"] = {
			["192628_476_0_56.3x54.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 56.3, 54.2 } },
		},
	},
	[477] = {		--Nagrand
		["Neutral"] = {
			["192628_477_0_53.2x69.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 53.2, 69.6 } },
			["192628_477_0_56x37.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 56, 37.3 } },
		},
	},
	[478] = {		--Terokkar Forest
		["Neutral"] = {
			["192628_478_0_48.9x45.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 48.9, 45.9 } },
			["192628_478_0_56.5x54.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 56.5, 54.9 } },
		},
	},
	[479] = {		--Netherstorm
		["Neutral"] = {
			["192628_479_0_32.4x64.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 32.4, 64.4 } },
		},
	},
	[480] = {		--Silvermoon City
		["Neutral"] = {
			["192628_480_0_79.3x39"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 79.3, 39 } },
			["192628_480_0_79.6x38.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 79.6, 38.4 } },
		},
	},
	[481] = {		--Shattrath City
		["Neutral"] = {
			["192628_481_0_37.4x31.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 37.4, 31.4 } },
			["192628_481_0_43.5x65.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 43.5, 65.4 } },
			["192628_481_0_69.4x42.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 69.4, 42.3 } },
		},
	},
	[486] = {		--Borean Tundra
		["Neutral"] = {
			["192628_486_0_41.1x55.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 41.1, 55.6 } },
			["192628_486_0_42.7x53.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 42.7, 53.3 } },
			["192628_486_0_42.7x53.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 42.7, 53.9 } },
			["192628_486_0_57.3x66.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 57.3, 66.6 } },
			["192628_486_0_57x19.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 57, 19.8 } },
		},
	},
	[488] = {		--Dragonblight
		["Neutral"] = {
			["192628_488_0_36.8x46.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 36.8, 46.9 } },
			["192628_488_0_76x63.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 76, 63.2 } },
			["192628_488_0_77.8x50.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 77.8, 50.4 } },
		},
	},
	[490] = {		--Grizzly Hills
		["Neutral"] = {
			["192628_490_0_31.3x59.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 31.3, 59.9 } },
		},
	},
	[491] = {		--Howling Fjord
		["Neutral"] = {
			["192628_491_0_29.9x42.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 29.9, 42.5 } },
			["192628_491_0_53.8x66.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 53.8, 66.9 } },
			["192628_491_0_59.6x63.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 59.6, 63.8 } },
			["192628_491_0_79.3x28.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 79.3, 28.9 } },
		},
	},
	[492] = {		--Icecrown
		["Neutral"] = {
			["192628_492_0_71.9x21"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 71.9, 21 } },
		},
	},
	[495] = {		--The Storm Peaks
		["Neutral"] = {
			["192628_495_0_41x86.4"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 41, 86.4 } },
		},
	},
	[496] = {		--Zul'Drak
		["Neutral"] = {
			["192628_496_0_41.3x67.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 41.3, 67.9 } },
		},
	},
	[4] = {		--Durotar
		["Neutral"] = {
			["192628_4_0_52x40.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 52, 40.6 } },
		},
	},
	[504] = {		--Dalaran
		["Neutral"] = {
			["192628_504_1_39.2x25.2"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 39.2, 25.2 } },
			["192628_504_1_43.1x26.4"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 43.1, 26.4 } },
			["192628_504_1_45.1x28.2"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 45.1, 28.2 } },
		},
	},
	[544] = {		--The Lost Isles
		["Neutral"] = {
			["192628_544_0_45.1x65.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 45.1, 65.9 } },
		},
	},
	[545] = {		--Gilneas
		["Neutral"] = {
			["192628_545_0_60.1x90.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 60.1, 90.7 } },
		},
	},
	[606] = {		--Mount Hyjal
		["Neutral"] = {
			["192628_606_0_62.9x21.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 62.9, 21.9 } },
		},
	},
	[640] = {		--Deepholm
		["Neutral"] = {
			["192628_640_0_47.4x51.1"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 47.4, 51.1 } },
			["192628_640_0_51.1x49.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 51.1, 49.9 } },
		},
	},
	[673] = {		--The Cape of Stranglethorn
		["Neutral"] = {
			["192628_673_0_44.1x70.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 44.1, 70.8 } },
		},
	},
	[700] = {		--Twilight Highlands
		["Neutral"] = {
			["192628_700_0_77.5x53.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 77.5, 53.9 } },
			["192628_700_0_79.2x76.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 79.2, 76.3 } },
		},
	},
	[720] = {		--Uldum
		["Neutral"] = {
			["192628_720_0_54.1x33.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 54.1, 33.3 } },
		},
	},
	[806] = {		--The Jade Forest
		["Neutral"] = {
			["192628_806_0_28.3x47.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 28.3, 47.9 } },
			["192628_806_0_28.5x13.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 28.5, 13.8 } },
			["192628_806_0_46.7x45.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 46.7, 45.7 } },
			["192628_806_0_48.4x36.8"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 48.4, 36.8 } },
			["192628_806_0_59.5x83.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 59.5, 83.7 } },
		},
	},
	[807] = {		--Valley of the Four Winds
		["Neutral"] = {
			["192628_807_0_51.3x48.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 51.3, 48.9 } },
			["192628_807_0_52.7x48"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 52.7, 48 } },
			["192628_807_0_54.1x49.3"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 54.1, 49.3 } },
			["192628_807_0_55.2x50.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 55.2, 50.5 } },
		},
	},
	[809] = {		--Kun-Lai Summit
		["Neutral"] = {
			["192628_809_0_54.2x82.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 54.2, 82.5 } },
			["192628_809_0_63.3x30.7"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 63.3, 30.7 } },
			["192628_809_0_71.4x92.2"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 71.4, 92.2 } },
		},
	},
	[858] = {		--Dread Wastes
		["Neutral"] = {
			["192628_858_0_55.8x32.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 55.8, 32.5 } },
		},
	},
	[903] = {		--Shrine of Two Moons
		["Neutral"] = {
			["192628_903_0_59x14.4"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 59, 14.4 } },
			["192628_903_1_25.9x45.1"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 25.9, 45.1 } },
			["192628_903_1_26.1x45.6"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 26.1, 45.6 } },
		},
	},
	[905] = {		--Shrine of Seven Stars
		["Neutral"] = {
			["192628_905_0_89.3x66.9"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 89.3, 66.9 } },
			["192628_905_0_90.4x67"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 90.4, 67 } },
			["192628_905_3_71.2x48.2"] = { ["name"] = "Anvil", ["floor"] = 1, ["pos"] = { 71.2, 48.2 } },
		},
	},
	[928] = {		--Isle of Thunder
		["Neutral"] = {
			["192628_928_0_32.3x33.5"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 32.3, 33.5 } },
			["192628_928_0_60.1x28.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 60.1, 28.6 } },
			["192628_928_0_64.7x73.9"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 64.7, 73.9 } },
		},
	},
	[951] = {		--Timeless Isle
		["Neutral"] = {
			["192628_951_0_38.5x46.6"] = { ["name"] = "Anvil", ["floor"] = 0, ["pos"] = { 38.5, 46.6 } },
		},
	},
};
local SKILL_TRAINER_MAP_ICONS = {
	[30] = {		--Elwynn Forest
		["Alliance"] = {
			[514] = { ["name"] = "Smith Argus", ["floor"] = 0, ["pos"] = { 41.6, 65.6 } },
		},
	},
	[27] = {		--Dun Morogh
		["Alliance"] = {
			[1241] = { ["name"] = "Tognus Flintfire", ["floor"] = 0, ["pos"] = { 52.4, 50.2 } },
		},
	},
	[34] = {		--Duskwood
		["Alliance"] = {
			[3136] = { ["name"] = "Clarise Gnarltree", ["floor"] = 0, ["pos"] = { 74, 48.4 } },
		},
	},
	[341] = {		--Ironforge
		["Alliance"] = {
			[4258] = { ["name"] = "Bengus Deepforge", ["floor"] = 0, ["pos"] = { 51.8, 40.8 } },
			[5164] = { ["name"] = "Grumnus Steelshaper", ["floor"] = 0, ["pos"] = { 49.4, 42.4 } },
			[11146] = { ["name"] = "Ironus Coldsteel", ["floor"] = 0, ["pos"] = { 50.2, 43 } },
		},
	},
	[141] = {		--Dustwallow Marsh
		["Alliance"] = {
			[4888] = { ["name"] = "Marie Holdston", ["floor"] = 0, ["pos"] = { 64.6, 50 } },
		},
	},
	[301] = {		--Stormwind City
		["Alliance"] = {
			[5511] = { ["name"] = "Therum Deepforge", ["floor"] = 0, ["pos"] = { 63.4, 37.2 } },
			[55684] = { ["name"] = "Jordan Smith", ["floor"] = 0, ["pos"] = { 64.4, 48.4 } },
		},
	},
	[471] = {		--The Exodar
		["Alliance"] = {
			[16724] = { ["name"] = "Miall", ["floor"] = 0, ["pos"] = { 60.4, 89.4 } },
		},
	},
	[465] = {		--Hellfire Peninsula
		["Alliance"] = {
			[16823] = { ["name"] = "Humphry", ["floor"] = 0, ["pos"] = { 56.8, 63.8 } },
			[21209] = { ["name"] = "Dumphry", ["floor"] = 0, ["pos"] = { 51.2, 60.2 } },
		},
		["Horde"] = {
			[16583] = { ["name"] = "Rohok", ["floor"] = 0, ["pos"] = { 53.2, 38.2 } },
		},
	},
	[464] = {		--Azuremyst Isle
		["Alliance"] = {
			[17245] = { ["name"] = "Blacksmith Calypso", ["floor"] = 0, ["pos"] = { 46.4, 71 } },
		},
	},
	[491] = {		--Howling Fjord
		["Alliance"] = {
			[26904] = { ["name"] = "Rosina Rivet", ["floor"] = 0, ["pos"] = { 59.4, 63.6 } },
		},
		["Horde"] = {
			[26952] = { ["name"] = "Kristen Smythe", ["floor"] = 0, ["pos"] = { 79.2, 29 } },
		},
	},
	[486] = {		--Borean Tundra
		["Alliance"] = {
			[26988] = { ["name"] = "Argo Strongstout", ["floor"] = 0, ["pos"] = { 57.2, 66.4 } },
		},
		["Horde"] = {
			[26981] = { ["name"] = "Crog Steelspine", ["floor"] = 0, ["pos"] = { 40.8, 55.2 } },
		},
	},
	[495] = {		--The Storm Peaks
		["Alliance"] = {
			[29924] = { ["name"] = "Brandig", ["floor"] = 0, ["pos"] = { 28.8, 74.8 } },
		},
	},
	[42] = {		--Darkshore
		["Alliance"] = {
			[43429] = { ["name"] = "Taryel Firestrike", ["floor"] = 0, ["pos"] = { 50.8, 19.2 } },
		},
	},
	[381] = {		--Darnassus
		["Alliance"] = {
			[52640] = { ["name"] = "Rolf Karner", ["floor"] = 0, ["pos"] = { 56.8, 52.8 } },
		},
	},
	[905] = {		--Shrine of Seven Stars
		["Alliance"] = {
			[64085] = { ["name"] = "Cullen Hammerbrow", ["floor"] = 1, ["pos"] = { 71.2, 48.2 } },
		},
	},
	[362] = {		--Thunder Bluff
		["Horde"] = {
			[2998] = { ["name"] = "Karn Stonehoof", ["floor"] = 0, ["pos"] = { 39.4, 55.2 } },
		},
	},
	[4] = {		--Durotar
		["Horde"] = {
			[3174] = { ["name"] = "Dwukk", ["floor"] = 0, ["pos"] = { 52, 40.6 } },
		},
	},
	[321] = {		--Orgrimmar
		["Horde"] = {
			[3355] = { ["name"] = "Saru Steelfury", ["floor"] = 1, ["pos"] = { 76.4, 34.4 } },
			[7231] = { ["name"] = "Kelgruk Bloodaxe", ["floor"] = 1, ["pos"] = { 76, 37.2 } },
			[11177] = { ["name"] = "Okothos Ironrager", ["floor"] = 1, ["pos"] = { 75.4, 34.2 } },
			[11178] = { ["name"] = "Borgosh Corebender", ["floor"] = 1, ["pos"] = { 75.4, 33.8 } },
			[37072] = { ["name"] = "Rogg", ["floor"] = 1, ["pos"] = { 44.4, 77.2 } },
			[44781] = { ["name"] = "Opuno Ironhorn", ["floor"] = 1, ["pos"] = { 40.4, 49.4 } },
			[45548] = { ["name"] = "Kark Helmbreaker", ["floor"] = 1, ["pos"] = { 36, 83 } },
		},
	},
	[11] = {		--Northern Barrens
		["Horde"] = {
			[3478] = { ["name"] = "Traugh", ["floor"] = 0, ["pos"] = { 48.2, 56.2 } },
		},
	},
	[21] = {		--Silverpine Forest
		["Horde"] = {
			[3557] = { ["name"] = "Guillaume Sorouy", ["floor"] = 0, ["pos"] = { 42.8, 40.8 } },
		},
	},
	[382] = {		--Undercity
		["Horde"] = {
			[4596] = { ["name"] = "James Van Brunt", ["floor"] = 0, ["pos"] = { 61.2, 29.2 } },
		},
	},
	[462] = {		--Eversong Woods
		["Horde"] = {
			[15400] = { ["name"] = "Arathel Sunforge", ["floor"] = 0, ["pos"] = { 59.4, 62.6 } },
		},
	},
	[480] = {		--Silvermoon City
		["Horde"] = {
			[16669] = { ["name"] = "Bemarrin", ["floor"] = 0, ["pos"] = { 79.6, 38.4 } },
		},
	},
	[473] = {		--Shadowmoon Valley
		["Horde"] = {
			[19341] = { ["name"] = "Grutah", ["floor"] = 0, ["pos"] = { 29.6, 31.4 } },
		},
	},
	[488] = {		--Dragonblight
		["Horde"] = {
			[26564] = { ["name"] = "Borus Ironbender", ["floor"] = 0, ["pos"] = { 36.6, 47 } },
			[27034] = { ["name"] = "Josric Fame", ["floor"] = 0, ["pos"] = { 75.8, 63.2 } },
		},
	},
	[903] = {		--Shrine of Two Moons
		["Horde"] = {
			[64058] = { ["name"] = "Jorunga Stonehoof", ["floor"] = 1, ["pos"] = { 25.6, 44.2 } },
		},
	},
	[673] = {		--The Cape of Stranglethorn
		["Neutral"] = {
			[2836] = { ["name"] = "Brikk Keencraft", ["floor"] = 0, ["pos"] = { 44, 70.8 } },
		},
	},
	[481] = {		--Shattrath City
		["Neutral"] = {
			[20124] = { ["name"] = "Kradu Grimblade", ["floor"] = 0, ["pos"] = { 69.4, 43 } },
			[20125] = { ["name"] = "Zula Slagfury", ["floor"] = 0, ["pos"] = { 69.8, 42.2 } },
			[33631] = { ["name"] = "Barien", ["floor"] = 0, ["pos"] = { 43.2, 64.8 } },
			[33675] = { ["name"] = "Onodo", ["floor"] = 0, ["pos"] = { 37.4, 31 } },
		},
	},
	[504] = {		--Dalaran
		["Neutral"] = {
			[28694] = { ["name"] = "Alard Schmied", ["floor"] = 1, ["pos"] = { 45.4, 27.8 } },
			[29505] = { ["name"] = "Imindril Spearsong", ["floor"] = 1, ["pos"] = { 76, 84.2 } },
			[29506] = { ["name"] = "Orland Schaeffer", ["floor"] = 1, ["pos"] = { 44.6, 28.6 } },
		},
	},
	[492] = {		--Icecrown
		["Neutral"] = {
			[33591] = { ["name"] = "Rekka the Hammer", ["floor"] = 0, ["pos"] = { 71.8, 20.8 } },
		},
	},
	[806] = {		--The Jade Forest
		["Neutral"] = {
			[65114] = { ["name"] = "Len the Hammer", ["floor"] = 0, ["pos"] = { 48.4, 36.8 } },
		},
	},
	[811] = {		--Vale of Eternal Blossoms
		["Neutral"] = {
			[65129] = { ["name"] = "Zen Master Lao", ["floor"] = 0, ["pos"] = { 21.6, 72.2 } },
		},
	},
};

local function CraftBuster_Module_Blacksmithing_HandleAction(skill_data)
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

local function CraftBuster_Module_Blacksmithing_DisplayActions(display_frame)
	CraftBuster_Module_BuildActionDisplay(display_frame, SKILL_ID, SKILL_ACTIONS, SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
end

local function CraftBuster_Module_Blacksmithing_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		station_map_icons = SKILL_STATION_MAP_ICONS,
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_Blacksmithing_HandleAction,
		display_action_function = CraftBuster_Module_Blacksmithing_DisplayActions,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Blacksmithing_OnLoad();