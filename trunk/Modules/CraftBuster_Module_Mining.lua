local SKILL_ID = CBT_SKILL_MINE;
local SKILL_NAME = CBL[CBT_SKILL_MINE];
local SKILL_SHORT_CODE = "mine";
local SKILL_TYPE = CBG_SKILL_GATHER;
local SKILL_SPELL_1ID = 2656;		--Smelting
local SKILL_ACTIONS = {};
local SKILL_STATION_MAP_ICONS = {
	[101] = {		--Desolace
			["Neutral"] = {
					["1685_101_0_58.7x46.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 58.7, 46.4 } },
					["1685_101_0_68x8.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 68, 8.5 } },
			},
	},
	[11] = {		--Northern Barrens
			["Neutral"] = {
					["1685_11_0_48.2x56.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 48.2, 56.3 } },
					["1685_11_0_62.7x16.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 62.7, 16.8 } },
					["1685_11_0_67.1x73.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 67.1, 73.4 } },
			},
	},
	[121] = {		--Feralas
			["Neutral"] = {
					["1685_121_0_51.7x48.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 51.7, 48.2 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Neutral"] = {
					["1685_141_0_35.9x31.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 35.9, 31.9 } },
					["1685_141_0_42.6x73.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 42.6, 73.5 } },
					["1685_141_0_64.6x50.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 64.6, 50.2 } },
			},
	},
	[161] = {		--Tanaris
			["Neutral"] = {
					["1685_161_0_51.1x30.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 51.1, 30.3 } },
			},
	},
	[16] = {		--Arathi Highlands
			["Neutral"] = {
					["1685_16_0_40.8x48"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 40.8, 48 } },
					["1685_16_0_67.8x34.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 67.8, 34.4 } },
			},
	},
	[17] = {		--Badlands
			["Neutral"] = {
					["1685_17_0_21.3x58"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 21.3, 58 } },
					["1685_17_0_65.1x36.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 65.1, 36.4 } },
			},
	},
	[182] = {		--Felwood
			["Neutral"] = {
					["1685_182_0_61.8x25.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 61.8, 25.9 } },
			},
	},
	[19] = {		--Blasted Lands
			["Neutral"] = {
					["1685_19_0_45.8x88.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 45.8, 88.6 } },
					["1685_19_0_61.7x15"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 61.7, 15 } },
			},
	},
	[201] = {		--Un'Goro Crater
			["Neutral"] = {
					["1685_201_0_55.1x61.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 55.1, 61.9 } },
			},
	},
	[20] = {		--Tirisfal Glades
			["Neutral"] = {
					["1685_20_0_62.4x51.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 62.4, 51.4 } },
			},
	},
	[21] = {		--Silverpine Forest
			["Neutral"] = {
					["1685_21_0_42.9x40.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 42.9, 40.9 } },
			},
	},
	[22] = {		--Western Plaguelands
			["Neutral"] = {
					["1685_22_0_44.4x13.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 44.4, 13.4 } },
			},
	},
	[23] = {		--Eastern Plaguelands
			["Neutral"] = {
					["1685_23_0_75.2x53.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 75.2, 53.7 } },
					["1685_23_0_80.9x47.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 80.9, 47.4 } },
					["1685_23_0_83.1x45.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 83.1, 45.2 } },
			},
	},
	[24] = {		--Hillsbrad Foothills
			["Neutral"] = {
					["1685_24_0_55.9x50.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 55.9, 50.6 } },
					["1685_24_0_57.6x47.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 57.6, 47.6 } },
			},
	},
	[261] = {		--Silithus
			["Neutral"] = {
					["1685_261_0_54.9x36.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 54.9, 36.6 } },
			},
	},
	[26] = {		--The Hinterlands
			["Neutral"] = {
					["1685_26_0_77.3x80.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 77.3, 80.2 } },
			},
	},
	[27] = {		--Dun Morogh
			["Neutral"] = {
					["1685_27_0_52.4x50.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 52.4, 50.3 } },
			},
	},
	[281] = {		--Winterspring
			["Neutral"] = {
					["1685_281_0_59.4x51.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 59.4, 51.1 } },
			},
	},
	[28] = {		--Searing Gorge
			["Neutral"] = {
					["1685_28_0_38.6x28.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 38.6, 28.6 } },
					["1685_28_0_42.4x66.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 42.4, 66.9 } },
			},
	},
	[29] = {		--Burning Steppes
			["Neutral"] = {
					["1685_29_0_46.8x44.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 46.8, 44.8 } },
			},
	},
	[301] = {		--Stormwind City
			["Neutral"] = {
					["1685_301_0_26.4x20.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 26.4, 20.8 } },
					["1685_301_0_43.1x72.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 43.1, 72.2 } },
					["1685_301_0_63.3x37.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 63.3, 37.5 } },
			},
	},
	[30] = {		--Elwynn Forest
			["Neutral"] = {
					["1685_30_0_41.4x65.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 41.4, 65.6 } },
					["1685_30_0_41.5x65.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 41.5, 65.5 } },
			},
	},
	[321] = {		--Orgrimmar
			["Neutral"] = {
					["1685_321_0_36.1x82.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 36.1, 82.4 } },
					["1685_321_0_40.4x50"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 40.4, 50 } },
					["1685_321_0_44.3x77.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 44.3, 77.4 } },
					["1685_321_0_56.4x56.8"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 56.4, 56.8 } },
					["1685_321_0_73.9x35.3"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 73.9, 35.3 } },
					["1685_321_0_75.7x34.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 75.7, 34.4 } },
					["1685_321_0_76.5x37.1"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 76.5, 37.1 } },
			},
	},
	[34] = {		--Duskwood
			["Neutral"] = {
					["1685_34_0_73.7x48.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 73.7, 48.6 } },
			},
	},
	[35] = {		--Loch Modan
			["Neutral"] = {
					["1685_35_0_34.3x46.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 34.3, 46.6 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Neutral"] = {
					["1685_362_0_39.4x55.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 39.4, 55.7 } },
			},
	},
	[36] = {		--Redridge Mountains
			["Neutral"] = {
					["1685_36_0_29.2x43.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 29.2, 43.8 } },
			},
	},
	[37] = {		--Northern Stranglethorn
			["Neutral"] = {
					["1685_37_0_38.8x48.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 38.8, 48.9 } },
					["1685_37_0_52.8x67.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 52.8, 67.1 } },
			},
	},
	[381] = {		--Darnassus
			["Neutral"] = {
					["1685_381_0_56.9x53.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56.9, 53.4 } },
			},
	},
	[382] = {		--Undercity
			["Neutral"] = {
					["1685_382_0_60.1x28.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 60.1, 28.6 } },
			},
	},
	[38] = {		--Swamp of Sorrows
			["Neutral"] = {
					["1685_38_0_72.6x13.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 72.6, 13.8 } },
			},
	},
	[39] = {		--Westfall
			["Neutral"] = {
					["1685_39_0_54.8x53.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 54.8, 53.6 } },
					["1685_39_0_56.7x51.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56.7, 51.5 } },
			},
	},
	[40] = {		--Wetlands
			["Neutral"] = {
					["1685_40_0_11.4x59.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 11.4, 59.7 } },
					["1685_40_0_57.8x40.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 57.8, 40.5 } },
			},
	},
	[42] = {		--Darkshore
			["Neutral"] = {
					["1685_42_0_50.9x19.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 50.9, 19.2 } },
			},
	},
	[43] = {		--Ashenvale
			["Neutral"] = {
					["1685_43_0_37.9x43.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 37.9, 43.8 } },
			},
	},
	[462] = {		--Eversong Woods
			["Neutral"] = {
					["1685_462_0_43x72"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 43, 72 } },
					["1685_462_0_47x47.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 47, 47.5 } },
			},
	},
	[463] = {		--Ghostlands
			["Neutral"] = {
					["1685_463_0_49.2x30.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 49.2, 30.3 } },
			},
	},
	[464] = {		--Azuremyst Isle
			["Neutral"] = {
					["1685_464_0_46.4x71.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 46.4, 71.2 } },
					["1685_464_0_47.7x51.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 47.7, 51.2 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Neutral"] = {
					["1685_465_0_24x37.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 24, 37.9 } },
					["1685_465_0_53.1x38.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 53.1, 38.5 } },
					["1685_465_0_55.4x37.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 55.4, 37.7 } },
					["1685_465_0_56.8x63.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56.8, 63.8 } },
			},
	},
	[467] = {		--Zangarmarsh
			["Neutral"] = {
					["1685_467_0_32.5x48"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 32.5, 48 } },
					["1685_467_0_68.5x50.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 68.5, 50.2 } },
					["1685_467_0_79.4x63.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 79.4, 63.7 } },
			},
	},
	[471] = {		--The Exodar
			["Neutral"] = {
					["1685_471_0_61x89.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 61, 89.4 } },
			},
	},
	[473] = {		--Shadowmoon Valley
			["Neutral"] = {
					["1685_473_0_29.7x31.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 29.7, 31.3 } },
					["1685_473_0_36.8x55.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 36.8, 55.1 } },
					["1685_473_0_65.5x86.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 65.5, 86.5 } },
			},
	},
	[475] = {		--Blade's Edge Mountains
			["Neutral"] = {
					["1685_475_0_51.4x57.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 51.4, 57.5 } },
			},
	},
	[476] = {		--Bloodmyst Isle
			["Neutral"] = {
					["1685_476_0_56.3x54.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56.3, 54.2 } },
			},
	},
	[477] = {		--Nagrand
			["Neutral"] = {
					["1685_477_0_53.2x69.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 53.2, 69.6 } },
					["1685_477_0_56x37.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56, 37.3 } },
			},
	},
	[478] = {		--Terokkar Forest
			["Neutral"] = {
					["1685_478_0_48.9x45.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 48.9, 45.9 } },
					["1685_478_0_56.5x54.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56.5, 54.9 } },
					["1685_478_0_77.6x38.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 77.6, 38.8 } },
			},
	},
	[479] = {		--Netherstorm
			["Neutral"] = {
					["1685_479_0_32.4x64.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 32.4, 64.4 } },
					["1685_479_0_43.4x35.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 43.4, 35.3 } },
					["1685_479_0_66.1x67.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 66.1, 67.2 } },
			},
	},
	[480] = {		--Silvermoon City
			["Neutral"] = {
					["1685_480_0_79.2x39.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 79.2, 39.1 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
					["1685_481_0_35.8x48.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 35.8, 48.2 } },
					["1685_481_0_37.4x31.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 37.4, 31.4 } },
					["1685_481_0_43.5x65.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 43.5, 65.3 } },
					["1685_481_0_58.5x75.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 58.5, 75.4 } },
					["1685_481_0_69.3x42.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 69.3, 42.6 } },
			},
	},
	[486] = {		--Borean Tundra
			["Neutral"] = {
					["1685_486_0_41.1x55.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 41.1, 55.6 } },
					["1685_486_0_42.7x53.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 42.7, 53.3 } },
					["1685_486_0_57.1x19.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 57.1, 19.9 } },
					["1685_486_0_57.3x66.6"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 57.3, 66.6 } },
			},
	},
	[488] = {		--Dragonblight
			["Neutral"] = {
					["1685_488_0_36.6x47.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 36.6, 47.1 } },
					["1685_488_0_49.4x75.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 49.4, 75.3 } },
					["1685_488_0_76x63.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 76, 63.2 } },
					["1685_488_0_77.8x50.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 77.8, 50.4 } },
			},
	},
	[490] = {		--Grizzly Hills
			["Neutral"] = {
					["1685_490_0_23.4x63.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 23.4, 63.1 } },
					["1685_490_0_31.3x59.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 31.3, 59.9 } },
					["1685_490_0_59.7x27.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 59.7, 27.9 } },
					["1685_490_0_65.3x48"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 65.3, 48 } },
			},
	},
	[491] = {		--Howling Fjord
			["Neutral"] = {
					["1685_491_0_29.9x42.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 29.9, 42.5 } },
					["1685_491_0_53.8x66.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 53.8, 66.9 } },
					["1685_491_0_59.6x63.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 59.6, 63.8 } },
					["1685_491_0_61x17"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 61, 17 } },
					["1685_491_0_79.2x28.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 79.2, 28.9 } },
			},
	},
	[492] = {		--Icecrown
			["Neutral"] = {
					["1685_492_0_71.9x21"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 71.9, 21 } },
					["1685_492_0_86.9x77.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 86.9, 77.1 } },
			},
	},
	[495] = {		--The Storm Peaks
			["Neutral"] = {
					["1685_495_0_28.8x74.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 28.8, 74.9 } },
					["1685_495_0_41x86.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 41, 86.4 } },
			},
	},
	[496] = {		--Zul'Drak
			["Neutral"] = {
					["1685_496_0_41.3x67.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 41.3, 67.9 } },
			},
	},
	[499] = {		--Isle of Quel'Danas
			["Neutral"] = {
					["1685_499_0_50.5x40.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 50.5, 40.7 } },
			},
	},
	[4] = {		--Durotar
			["Neutral"] = {
					["1685_4_0_52x40.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 52, 40.8 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
					["1685_504_0_75.8x83.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 75.8, 83.9 } },
					["1685_504_1_40.9x25.9"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 40.9, 25.9 } },
					["1685_504_1_43.1x26.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 43.1, 26.4 } },
					["1685_504_1_45.4x28.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 45.4, 28.4 } },
			},
	},
	[544] = {		--The Lost Isles
			["Neutral"] = {
					["1685_544_0_36.7x43.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 36.7, 43.8 } },
					["1685_544_0_45.1x65.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 45.1, 65.9 } },
			},
	},
	[545] = {		--Gilneas
			["Neutral"] = {
					["1685_545_0_38.3x63.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 38.3, 63.7 } },
					["1685_545_0_59.7x90.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 59.7, 90.9 } },
			},
	},
	[606] = {		--Mount Hyjal
			["Neutral"] = {
					["1685_606_0_28.8x35.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 28.8, 35.9 } },
					["1685_606_0_62.9x21.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 62.9, 21.9 } },
			},
	},
	[607] = {		--Southern Barrens
			["Neutral"] = {
					["1685_607_0_40.9x70"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 40.9, 70 } },
					["1685_607_0_49.4x66.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 49.4, 66.9 } },
					["1685_607_0_67.4x48.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 67.4, 48.3 } },
			},
	},
	[640] = {		--Deepholm
			["Neutral"] = {
					["1685_640_0_47.4x51.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 47.4, 51.1 } },
					["1685_640_0_51.1x49.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 51.1, 49.9 } },
			},
	},
	[673] = {		--The Cape of Stranglethorn
			["Neutral"] = {
					["1685_673_0_35.2x29.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 35.2, 29.9 } },
					["1685_673_0_43.8x70.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 43.8, 70.8 } },
			},
	},
	[700] = {		--Twilight Highlands
			["Neutral"] = {
					["1685_700_0_49x29.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 49, 29.1 } },
					["1685_700_0_77.2x53"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 77.2, 53 } },
					["1685_700_0_79x76.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 79, 76.8 } },
			},
	},
	[709] = {		--Tol Barad Peninsula
			["Neutral"] = {
					["1685_709_0_56.1x80.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 56.1, 80.4 } },
					["1685_709_0_74x61.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 74, 61.1 } },
			},
	},
	[720] = {		--Uldum
			["Neutral"] = {
					["1685_720_0_54.2x33.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 54.2, 33.3 } },
			},
	},
	[806] = {		--The Jade Forest
			["Neutral"] = {
					["1685_806_0_28.3x47.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 28.3, 47.9 } },
					["1685_806_0_28.5x13.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 28.5, 13.8 } },
					["1685_806_0_41.4x24.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 41.4, 24.7 } },
					["1685_806_0_46.7x45.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 46.7, 45.7 } },
					["1685_806_0_48.4x36.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 48.4, 36.8 } },
					["1685_806_0_59.5x83.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 59.5, 83.7 } },
			},
	},
	[807] = {		--Valley of the Four Winds
			["Neutral"] = {
					["1685_807_0_51.3x48.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 51.3, 48.9 } },
					["1685_807_0_52.7x48"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 52.7, 48 } },
					["1685_807_0_54.1x49.3"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 54.1, 49.3 } },
			},
	},
	[808] = {		--The Wandering Isle
			["Neutral"] = {
					["1685_808_0_49.8x60"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 49.8, 60 } },
			},
	},
	[809] = {		--Kun-Lai Summit
			["Neutral"] = {
					["1685_809_0_54.2x82.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 54.2, 82.5 } },
					["1685_809_0_57.4x61.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 57.4, 61.7 } },
					["1685_809_0_57.5x61.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 57.5, 61.7 } },
					["1685_809_0_62.9x79.8"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 62.9, 79.8 } },
					["1685_809_0_63.3x30.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 63.3, 30.7 } },
					["1685_809_0_71.4x92.1"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 71.4, 92.1 } },
			},
	},
	[810] = {		--Townlong Steppes
			["Neutral"] = {
					["1685_810_0_75.8x81.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 75.8, 81.9 } },
			},
	},
	[81] = {		--Stonetalon Mountains
			["Neutral"] = {
					["1685_81_0_49.1x61.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 49.1, 61.4 } },
					["1685_81_0_58.8x56"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 58.8, 56 } },
					["1685_81_0_65.7x64.7"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 65.7, 64.7 } },
			},
	},
	[857] = {		--Krasarang Wilds
			["Neutral"] = {
					["1685_857_0_67.7x32.2"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 67.7, 32.2 } },
			},
	},
	[858] = {		--Dread Wastes
			["Neutral"] = {
					["1685_858_0_50.9x11.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 50.9, 11.5 } },
					["1685_858_0_55.9x32.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 55.9, 32.4 } },
			},
	},
	[903] = {		--Shrine of Two Moons
			["Neutral"] = {
					["1685_903_0_59x14.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 59, 14.4 } },
					["1685_903_1_26.1x45.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 26.1, 45.4 } },
			},
	},
	[905] = {		--Shrine of Seven Stars
			["Neutral"] = {
					["1685_905_0_90.4x67"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 90.4, 67 } },
					["1685_905_3_69.9x47.1"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 69.9, 47.1 } },
					["1685_905_3_70.5x47.4"] = { ["name"] = "Forge", ["floor"] = 1, ["pos"] = { 70.5, 47.4 } },
			},
	},
	[928] = {		--Isle of Thunder
			["Neutral"] = {
					["1685_928_0_32.3x33.5"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 32.3, 33.5 } },
					["1685_928_0_60.1x28.4"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 60.1, 28.4 } },
					["1685_928_0_64.8x73.9"] = { ["name"] = "Forge", ["floor"] = 0, ["pos"] = { 64.8, 73.9 } },
			},
	},
};
local SKILL_TRAINER_MAP_ICONS = {
	[35] = {		--Loch Modan
			["Alliance"] = {
				[1681] = { ["name"] = "Brock Stoneseeker", ["floor"] = 0, ["pos"] = { 37, 46.8 } },
			},
	},
	[27] = {		--Dun Morogh
			["Alliance"] = {
				[1701] = { ["name"] = "Dank Drizzlecut", ["floor"] = 0, ["pos"] = { 76.4, 53.6 } },
				[5392] = { ["name"] = "Yarr Hammerstone", ["floor"] = 0, ["pos"] = { 57.2, 48.6 } },
			},
	},
	[34] = {		--Duskwood
			["Alliance"] = {
				[3137] = { ["name"] = "Matt Johnson", ["floor"] = 0, ["pos"] = { 73.8, 49.2 } },
			},
	},
	[341] = {		--Ironforge
			["Alliance"] = {
				[4254] = { ["name"] = "Geofram Bouldertoe", ["floor"] = 0, ["pos"] = { 50, 26.2 } },
			},
	},
	[301] = {		--Stormwind City
			["Alliance"] = {
				[5513] = { ["name"] = "Gelman Stonehand", ["floor"] = 0, ["pos"] = { 59.6, 37.6 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[16752] = { ["name"] = "Muaat", ["floor"] = 0, ["pos"] = { 59.4, 86.8 } },
			},
	},
	[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17488] = { ["name"] = "Dulvi", ["floor"] = 0, ["pos"] = { 48.8, 51 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18779] = { ["name"] = "Hurnak Grimmord", ["floor"] = 0, ["pos"] = { 56.6, 63.8 } },
			},
			["Horde"] = {
				[18747] = { ["name"] = "Krugosh", ["floor"] = 0, ["pos"] = { 55.4, 37.6 } },
			},
	},
	[476] = {		--Bloodmyst Isle
			["Alliance"] = {
				[18804] = { ["name"] = "Prospector Nachlan", ["floor"] = 0, ["pos"] = { 56.2, 54.2 } },
			},
	},
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[26912] = { ["name"] = "Grumbol Stoutpick", ["floor"] = 0, ["pos"] = { 59.8, 63.8 } },
			},
			["Horde"] = {
				[26962] = { ["name"] = "Jonathan Lewis", ["floor"] = 0, ["pos"] = { 79.2, 29 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[26999] = { ["name"] = "Fendrig Redbeard", ["floor"] = 0, ["pos"] = { 57.4, 66.2 } },
			},
			["Horde"] = {
				[26976] = { ["name"] = "Brunna Ironaxe", ["floor"] = 0, ["pos"] = { 42.4, 53 } },
			},
	},
	[42] = {		--Darkshore
			["Alliance"] = {
				[43431] = { ["name"] = "Periale", ["floor"] = 0, ["pos"] = { 51.4, 19 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[52642] = { ["name"] = "Foreman Pernic", ["floor"] = 0, ["pos"] = { 50.2, 33.6 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[53409] = { ["name"] = "\"Kobold\" Kerik", ["floor"] = 0, ["pos"] = { 64.6, 49.8 } },
			},
	},
	[806] = {		--The Jade Forest
			["Alliance"] = {
				[67024] = { ["name"] = "Rockseeker Guo", ["floor"] = 0, ["pos"] = { 45, 85.8 } },
			},
			["Horde"] = {
				[66979] = { ["name"] = "Stonebreaker Ruian", ["floor"] = 0, ["pos"] = { 27.8, 14.8 } },
			},
			["Neutral"] = {
				[65092] = { ["name"] = "Smeltmaster Ashpaw", ["floor"] = 0, ["pos"] = { 46, 29.4 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[3001] = { ["name"] = "Brek Stonehoof", ["floor"] = 0, ["pos"] = { 34.4, 57.4 } },
			},
	},
	[4] = {		--Durotar
			["Horde"] = {
				[3175] = { ["name"] = "Krunn", ["floor"] = 0, ["pos"] = { 51.8, 40.8 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[3357] = { ["name"] = "Makaru", ["floor"] = 1, ["pos"] = { 72.4, 35 } },
				[46357] = { ["name"] = "Gonto", ["floor"] = 1, ["pos"] = { 44.6, 78.4 } },
				[52170] = { ["name"] = "Gizzik Oregrab", ["floor"] = 1, ["pos"] = { 36, 82.4 } },
			},
	},
	[21] = {		--Silverpine Forest
			["Horde"] = {
				[3555] = { ["name"] = "Johan Focht", ["floor"] = 0, ["pos"] = { 43.4, 40.4 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[4598] = { ["name"] = "Brom Killian", ["floor"] = 0, ["pos"] = { 55.4, 36.2 } },
			},
	},
	[480] = {		--Silvermoon City
			["Horde"] = {
				[16663] = { ["name"] = "Belil", ["floor"] = 0, ["pos"] = { 79.2, 42.8 } },
			},
	},
	[161] = {		--Tanaris
			["Neutral"] = {
				[8128] = { ["name"] = "Pikkle", ["floor"] = 0, ["pos"] = { 51, 29 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[28698] = { ["name"] = "Jedidiah Handers", ["floor"] = 1, ["pos"] = { 41.2, 26 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[33640] = { ["name"] = "Hanlir", ["floor"] = 0, ["pos"] = { 58, 75 } },
				[33682] = { ["name"] = "Fono", ["floor"] = 0, ["pos"] = { 36, 48.4 } },
			},
	},
	[809] = {		--Kun-Lai Summit
			["Neutral"] = {
				[66360] = { ["name"] = "Master Brandom", ["floor"] = 0, ["pos"] = { 48.6, 44.4 } },
			},
	},
};
local SKILL_NODES = {
	--vanilla
	["Copper Vein"] = {
		["rank"] = 0,
		["item_id"] = 2770, --Copper Ore
		["ply_level"] = 1,
		["node_levels"] = { 1, 25, 50, 100 },
		["zones"] = {
			"Darkshore", "Durotar", "Azshara", "Northern Barrens",
			"Elwynn Forest", "Tirisfal Glades", "Dun Morogh", "Eversong Woods",
			"Loch Modan", "Gilneas", "Mulgore", "The Lost Isles",
			"Redridge Mountains", "Azuremyst Isle", "Bloodmyst Isle", "Westfall",
			"Ghostlands", "Silverpine Forest", "Duskwood",
			"Gilneas City", "The Wandering Isle", "The Deadmines", "Stonetalon Mountains",
			"Wetlands", "Ashenvale", "Wailing Caverns", "Southern Barrens",
			"Badlands", "Thousand Needles",
		},
	},
	["Tin Vein"] = {
		["rank"] = 1,
		["item_id"]  = 2771, --Tin Ore
		["ply_level"] = 1,
		["node_levels"] = { 50, 75, 100, 150 },
		["zones"] = {
			"Ashenvale", "Hillsbrad Foothills", "Northern Stranglethorn", "Stonetalon Mountains",
			"Redridge Mountains", "Duskwood", "Wetlands", "Loch Modan",
			"Arathi Highlands", "Silverpine Forest", "Bloodmyst Isle", "Ghostlands",
			"Darkshore", "The Deadmines", "The Hinterlands", "Blackfathom Deeps",
			"Dustwallow Marsh", "Northern Barrens", "Azshara", "Wailing Caverns",
			"Badlands",
		},
	},
	["Silver Vein"] = {
		["rank"] = 2,
		["item_id"] = 2775, --Silver Ore
		["ply_level"] = 1,
		["node_levels"] = { 65, 85, 110, 160 },
		["zones"] = {
			"Northern Stranglethorn", "Feralas", "Hillsbrad Foothills", "Stonetalon Mountains",
			"The Cape of Stranglethorn", "Arathi Highlands", "Southern Barrens", "Desolace",
			"Redridge Mountains", "Wetlands", "Duskwood", "Loch Modan",
			"Silverpine Forest", "The Hinterlands", "Thousand Needles", "Darkshore",
			"Northern Barrens", "The Deadmines", "Dustwallow Marsh", "Bloodmyst Isle",
			"Ghostlands",
		},
	},
	--[[
	["Ooze Covered Silver Vein"] = {
		["rank"] = 3,
		["item_id"] = 2775, --Silver Ore
		["ply_level"] = 1,
		["node_levels"] = { 75, 100, 125, 175 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Iron Deposit"] = {
		["rank"] = 4,
		["item_id"] = 2772, --Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 100, 125, 150, 200 },
		["zones"] = {
			"Feralas", "Desolace", "Western Plaguelands", "Eastern Plaguelands",
			"The Cape of Stranglethorn", "Southern Barrens", "Arathi Highlands", "Thousand Needles",
			"Northern Stranglethorn", "The Hinterlands", "Duskwood", "Dustwallow Marsh",
			"Wetlands", "Razorfen Kraul", "Uldaman", "Badlands",
		},
	},
	["Gold Vein"] = {
		["rank"] = 5,
		["item_id"] = 2776, --Gold Ore
		["ply_level"] = 1,
		["node_levels"] = { 115, 130, 165, 215 },
		["zones"] = {
			"Felwood", "Western Plaguelands", "Feralas", "Eastern Plaguelands",
			"Burning Steppes", "Badlands", "Southern Barrens", "Tanaris",
			"The Cape of Stranglethorn", "Thousand Needles", "Searing Gorge", "Northern Stranglethorn",
			"Desolace", "Un'Goro Crater", "Arathi Highlands", "Duskwood",
		},
	},
	--[[
	["Ooze Covered Gold Vein"] = {
		["rank"] = 6,
		["item_id"] = 2776, --Gold Ore
		["ply_level"] = 1,
		["node_levels"] = { 115, 130, 165, 215 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Mithril Deposit"] = {
		["rank"] = 7,
		["item_id"] = 3858, --Mithril Ore
		["ply_level"] = 1,
		["node_levels"] = { 150, 175, 200, 250 },
		["zones"] = {
			"Thousand Needles", "Badlands", "Burning Steppes", "Searing Gorge",
			"Felwood", "Eastern Plaguelands", "Tanaris", "Arathi Highlands",
			"Dustwallow Marsh", "Un'Goro Crater", "Feralas", "Maraudon",
			"Uldaman",
		},
	},
	["Ooze Covered Mithril Deposit"] = {
		["rank"] = 8,
		["item_id"] = 3858, --Mithril Ore
		["ply_level"] = 1,
		["node_levels"] = { 150, 175, 200, 250 },
		["zones"] = {
			"Thousand Needles", "Feralas",
		},
	},
	["Truesilver Deposit"] = {
		["rank"] = 9,
		["item_id"] = 7911, --Truesilver Ore
		["ply_level"] = 1,
		["node_levels"] = { 165, 190, 215, 265 },
		["zones"] = {
			"Winterspring", "Burning Steppes", "Felwood", "Thousand Needles",
			"Badlands", "Silithus", "Searing Gorge", "Blasted Lands",
			"Eastern Plaguelands", "Swamp of Sorrows", "Tanaris", "Un'Goro Crater",
			"Feralas", "Dustwallow Marsh", "Arathi Highlands", "The Hinterlands",
		},
	},
	["Ooze Covered Truesilver Deposit"] = {
		["rank"] = 10,
		["item_id"] = 7911, --Truesilver Ore
		["ply_level"] = 1,
		["node_levels"] = { 165, 190, 215, 265 },
		["zones"] = {
			"Un'Goro Crater", "Silithus",
		},
	},
	["Dark Iron Deposit"] = {
		["rank"] = 11,
		["item_id"] = 11370, --Dark Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 175, 255, 280, 330 },
		["zones"] = {
			"Molten Core", "Blackrock Depths",
		},
	},
	["Small Thorium Vein"] = {
		["rank"] = 12,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 200, 225, 250, 300 },
		["zones"] = {
			"Winterspring", "Silithus", "Un'Goro Crater", "Swamp of Sorrows",
			"Blasted Lands",
		},
	},
	["Ooze Covered Thorium Vein"] = {
		["rank"] = 13,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 215, 240, 265, 315 },
		["zones"] = {
			"Un'Goro Crater",
		},
	},
	["Rich Thorium Vein"] = {
		["rank"] = 14,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 215, 240, 265, 315 },
		["zones"] = {
			"Winterspring", "Silithus", "Swamp of Sorrows", "Un'Goro Crater",
			"Blasted Lands", "Dire Maul",
		},
	},
	["Ooze Covered Rich Thorium Vein"] = {
		["rank"] = 15,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 215, 240, 265, 315 },
		["zones"] = {
			"Silithus",
		},
	},

	--tbc
	["Fel Iron Deposit"] = {
		["rank"] = 16,
		["item_id"] = 23424, --Fel Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 275, 325, 350, 400 },
		["zones"] = {
			"Hellfire Peninsula", "Zangarmarsh", "Blade's Edge Mountains", "Shadowmoon Valley",
			"Terokkar Forest", "Nagrand", "Netherstorm",
		},
	},
	["Adamantite Deposit"] = {
		["rank"] = 17,
		["item_id"] = 23425, --Adamantite Ore
		["ply_level"] = 1,
		["node_levels"] = { 325, 350, 375, 425 },
		["zones"] = {
			"Nagrand", "Blade's Edge Mountains", "Netherstorm", "Shadowmoon Valley",
			"Terokkar Forest", "Zangarmarsh", "Isle of Quel'Danas", "Sethekk Halls",
			"Auchenai Crypts", "Mana-Tombs", "The Slave Pens", "Shadow Labyrinth",
			"The Steamvault",
		},
	},
	["Rich Adamantite Deposit"] = {
		["rank"] = 18,
		["item_id"] = 23425, --Adamantite Ore
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 450 },
		["zones"] = {
			"Nagrand", "Netherstorm", "Shadowmoon Valley", "Terokkar Forest",
			"Isle of Quel'Danas", "Blade's Edge Mountains", "Shadow Labyrinth",
		},
	},
	--[[
	["Nethercite Deposit"] = {
		["rank"] = 19,
		["item_id"] = 32464, --Nethercite Ore
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 390, 400 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Khorium Vein"] = {
		["rank"] = 20,
		["item_id"] = 23426, --Khorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 375, 400, 425, 450 },
		["zones"] = {
			"Nagrand", "Blade's Edge Mountains", "Netherstorm", "Terokkar Forest",
			"Shadowmoon Valley", "Isle of Quel'Danas", "Auchenai Crypts", "Mana-Tombs",
			"Shadow Labyrinth",
		},
	},

	--wotlk
	["Cobalt Deposit"] = {
		["rank"] = 21,
		["item_id"] = 36909, --Cobalt Ore
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 425 },
		["zones"] = {
			"Zul'Drak", "Howling Fjord", "Borean Tundra", "Dragonblight",
			"Grizzly Hills", "Utgarde Keep", "The Storm Peaks", "Crystalsong Forest",
		},
	},
	["Rich Cobalt Deposit"] = {
		["rank"] = 22,
		["item_id"] = 36909, --Cobalt Ore
		["ply_level"] = 1,
		["node_levels"] = { 375, 400, 425, 450 },
		["zones"] = {
			"Zul'Drak", "Howling Fjord", "Borean Tundra", "Dragonblight",
			"Grizzly Hills", "The Storm Peaks", "Utgarde Keep", "Crystalsong Forest",
		},
	},
	["Saronite Deposit"] = {
		["rank"] = 23,
		["item_id"] = 36912, --Saronite Ore
		["ply_level"] = 1,
		["node_levels"] = { 400, 425, 450, 475 },
		["zones"] = {
			"Icecrown", "Sholazar Basin", "The Storm Peaks", "Wintergrasp",
			"Zul'Drak", "Halls of Stone", "Dragonblight", "Crystalsong Forest",
			"Icecrown Citadel", "Grizzly Hills",
		},
	},
	["Rich Saronite Deposit"] = {
		["rank"] = 24,
		["item_id"] = 36912, --Saronite Ore
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 500 },
		["zones"] = {
			"Icecrown", "Sholazar Basin", "Wintergrasp", "The Storm Peaks",
			"Dragonblight", "Crystalsong Forest",
		},
	},
	--[[
	["Pure Saronite Deposit"] = {
		["rank"] = 25,
		["item_id"] = 36912, --Saronite Ore
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Titanium Vein"] = {
		["rank"] = 26,
		["item_id"] = 36910, --Titanium Ore
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["zones"] = {
			"Icecrown", "Sholazar Basin", "Wintergrasp", "The Storm Peaks",
			"Dragonblight", "Crystalsong Forest",
		},
	},

	--cata
	["Obsidium Deposit"] = {
		["rank"] = 27,
		["item_id"] = 53038, --Obsidium Ore
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 500 },
		["zones"] = {
			"Deepholm", "Mount Hyjal", "Abyssal Depths", "Shimmering Expanse",
			"Kelp'thar Forest",
		},
	},
	["Rich Obsidium Deposit"] = {
		["rank"] = 28,
		["item_id"] = 53038, --Obsidium Ore
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["zones"] = {
			"Deepholm",
		},
	},
	["Elementium Vein"] = {
		["rank"] = 29,
		["item_id"] = 52185, --Elementium Ore
		["ply_level"] = 1,
		["node_levels"] = { 475, 500, 525, 550 },
		["zones"] = {
			"Deepholm", "Twilight Highlands", "Uldum", "Tol Barad Peninsula",
			"Tol Barad",
		},
	},
	["Rich Elementium Vein"] = {
		["rank"] = 30,
		["item_id"] = 52185, --Elementium Ore
		["ply_level"] = 1,
		["node_levels"] = { 500, 515, 525, 550 },
		["zones"] = {
			"Deepholm", "Twilight Highlands", "Uldum", "Tol Barad Peninsula",
			"Tol Barad",
		},
	},
	["Pyrite Deposit"] = {
		["rank"] = 31,
		["item_id"] = 52183, --Pyrite Ore
		["ply_level"] = 1,
		["node_levels"] = { 525, 550, 565, 575 },
		["zones"] = {
			"Twilight Highlands", "Uldum",
		},
	},
	["Rich Pyrite Deposit"] = {
		["rank"] = 32,
		["item_id"] = 52183, --Pyrite Ore
		["ply_level"] = 1,
		["node_levels"] = { 525, 575, 600, 600 },
		["zones"] = {
			"Tol Barad Peninsula", "Tol Barad",
		},
	},

	--mists
	["Ghost Iron Deposit"] = {
		["rank"] = 33,
		["item_id"] = 72092, --Ghost Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 525, 550, 575, 600 },
		["zones"] = {
			"The Jade Forest", "Valley of the Four Winds", "Dread Wastes", "Townlong Steppes",
			"Kun-Lai Summit", "Krasarang Wilds", "Vale of Eternal Blossoms", "Timeless Isle",
			"The Veiled Stair", "Shado-Pan Monastery",
		},
	},
	["Rich Ghost Iron Deposit"] = {
		["rank"] = 34,
		["item_id"] = 72092, --Ghost Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 550, 575, 600, 600 },
		["zones"] = {
			"The Jade Forest", "Valley of the Four Winds", "Dread Wastes", "Kun-Lai Summit",
			"Townlong Steppes", "Vale of Eternal Blossoms", "Krasarang Wilds", "The Veiled Stair",
			"Timeless Isle",
		},
	},
	["Kyparite Deposit"] = {
		["rank"] = 35,
		["item_id"] = 72093, --Kyparite
		["ply_level"] = 1,
		["node_levels"] = { 550, 575, 600, 600 },
		["zones"] = {
			"Dread Wastes", "Townlong Steppes", "Siege of Niuzao Temple",
		},
	},
	["Rich Kyparite Deposit"] = {
		["rank"] = 36,
		["item_id"] = 72093, --Kyparite
		["ply_level"] = 1,
		["node_levels"] = { 575, 600, 600, 600 },
		["zones"] = {
			"Dread Wastes", "Townlong Steppes",
		},
	},
	["Trillium Vein"] = {
		["rank"] = 37,
		["item_id"] = 72095, --Trillium Bar
		--["item_id"] = 72094, --Black Trillium Ore
		["ply_level"] = 1,
		["node_levels"] = { 600, 600, 600, 600 },
		["zones"] = {
			"Kun-Lai Summit", "Dread Wastes", "Townlong Steppes", "Vale of Eternal Blossoms",
			"Valley of the Four Winds", "The Jade Forest",
		},
	},
	["Rich Trillium Vein"] = {
		["rank"] = 38,
		["item_id"] = 72095, --Trillium Bar
		--["item_id"] = 72103, --White Trillium Ore
		["ply_level"] = 1,
		["node_levels"] = { 600, 600, 600, 600 },
		["zones"] = {
			"Dread Wastes", "Townlong Steppes", "Vale of Eternal Blossoms", "Valley of the Four Winds",
			"The Jade Forest", "Timeless Isle",
		},
	},
};

local function CraftBuster_Module_Mining_BuildActions()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);

	local base_count = CBG_MAX_PROFESSIONS - 1;
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 0), 2, "0", "right") .. SKILL_SHORT_CODE .. "_1_orange"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][1],
			["action"] = CBT_ORANGE,
			["message"] = CraftBuster_Module_TranslateActionText(ORANGE_FONT_COLOR_CODE, node_name, node_data["node_levels"][1]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 1), 2, "0", "right") .. SKILL_SHORT_CODE .. "_2_yellow"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][2],
			["action"] = CBT_YELLOW,
			["message"] = CraftBuster_Module_TranslateActionText(YELLOW_FONT_COLOR_CODE, node_name, node_data["node_levels"][2]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 2), 2, "0", "right") .. SKILL_SHORT_CODE .. "_3_green"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][3],
			["action"] = CBT_GREEN,
			["message"] = CraftBuster_Module_TranslateActionText(GREEN_FONT_COLOR_CODE, node_name, node_data["node_levels"][3]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 3), 2, "0", "right") .. SKILL_SHORT_CODE .. "_4_grey"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][4],
			["action"] = CBT_GREY,
			["message"] = CraftBuster_Module_TranslateActionText(GRAY_FONT_COLOR_CODE, node_name, node_data["node_levels"][4]),
		};
	end
end

local function CraftBuster_Module_Mining_HandleGather(zone_name)
	local skill_level = CraftBuster_GetSkillLevel(SKILL_ID);
	local gather_data = {
		["zones"] = {},
		["skill"] = {},
	};
	
	local found = false;
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		for _,zone in sortedpairs(node_data.zones) do
			if (string.find(zone, zone_name, 1, true) ~= nil) then
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

local function CraftBuster_Module_Mining_HandleNode(line_one, line_two, line_three)
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

local function CraftBuster_Module_Mining_HandleAction(skill_data)
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

local function CraftBuster_Module_Mining_OnLoad()
	CraftBuster_Module_Mining_BuildActions();
	local module_options = {
		skill_type = CBG_SKILL_GATHER,
		station_map_icons = SKILL_STATION_MAP_ICONS,
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		tooltip_info = true,
		gather_function = CraftBuster_Module_Mining_HandleGather,
		node_function = CraftBuster_Module_Mining_HandleNode,
		action_function = CraftBuster_Module_Mining_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Mining_OnLoad();

local function CraftBuster_Module_Mining_AddZoneInfo(frame, item_link)
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
					for _,zone_name in ipairs(node_data["zones"]) do
						if (found_zones[zone_name] == nil) then
							zones[count] = zone_name;
							found_zones[zone_name] = zone_name;
							count = count + 1;
						end
					end
				end
			end

			if (found_item) then
				count = 0;
				local zone_limit = CraftBusterOptions[CraftBusterEntry].zone_limit;
				local output_txt = CBL["SKILL_MINE_ZONE"];

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
				CraftBuster_Module_Mining_AddZoneInfo(self, item_link);
			end
		end
	);
end

HookFrame(GameTooltip);
HookFrame(ItemRefTooltip);