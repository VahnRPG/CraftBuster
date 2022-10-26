-------------------------------------------------------------------------------
-- CraftBuster Globals
-------------------------------------------------------------------------------
CBG_MOD_NAME = "CraftBuster";
CBG_VERSION = GetAddOnMetadata(CBG_MOD_NAME, "Version");
CBG_LAST_UPDATED = GetAddOnMetadata(CBG_MOD_NAME, "X-Date");

CBG_LOCKPICKING_LEVEL = 24;
CBG_LOCKPICKING_MAX_SKILL_LEVEL = 800;

--[[
EXPANSION_NAME0 = "Classic";
EXPANSION_NAME1 = "The Burning Crusade";
EXPANSION_NAME2 = "Wrath of the Lich King";
EXPANSION_NAME3 = "Cataclysm";
EXPANSION_NAME4 = "Mists of Pandaria";
EXPANSION_NAME5 = "Warlords of Draenor";
EXPANSION_NAME6 = "Legion";
EXPANSION_NAME7 = "Battle for Azeroth";
]]--

CBG_PROFESSION_LEVELS = {
	[1] = { 5,   300, EXPANSION_NAME0 },	--Classic
	[2] = { 58,   75, EXPANSION_NAME1 },	--The Burning Crusade
	[3] = { 58,   75, EXPANSION_NAME2 },	--Wrath of the Lich King
	[4] = { 78,   75, EXPANSION_NAME3 },	--Cataclysm
	[5] = { 78,   75, EXPANSION_NAME4 },	--Mists of Pandaria
	[6] = { 88,  100, EXPANSION_NAME5 },	--Warlords of Draenor
	[7] = { 98,  100, EXPANSION_NAME6 },	--Legion
	[8] = { 108, 150, EXPANSION_NAME7 },	--Battle for Azeroth
};

CBG_MAX_PROFESSIONS = 11;
CBG_PROFESSION_RANKS = {
	[1] = { 0, 75, APPRENTICE },
	[2] = { 50, 150, JOURNEYMAN },
	[3] = { 125, 225, EXPERT },
	[4] = { 200, 300, ARTISAN },
	[5] = { 275, 375, MASTER },
	--[[
	[6] = { 350, 450, GRAND_MASTER },
	[7] = { 425, 525, ILLUSTRIOUS },
	]]--
	[6] = { 275, 450, GRAND_MASTER },
	[7] = { 350, 525, ILLUSTRIOUS },
	[8] = { 500, 600, ZEN_MASTER },
	[9] = { 600, 700, DRAENOR_MASTER },
	[10] = { 700, 800, LEGION_MASTER },
	[11] = { 800, 950, BATTLE_FOR_AZEROTH_MASTER },
};
CBG_MAX_PROFESSION_RANK = CBG_PROFESSION_RANKS[CBG_MAX_PROFESSIONS][2];

CBG_SKILL_NORMAL = 1;
CBG_SKILL_GATHER = 2;

--This array tells the code which player level each rank is available at
--{normal_level, gathering_level}
CBG_SKILL_PLY_LEVELS = {
	[2] = { 10, 1 },		--Journeyman
	[3] = { 20, 10 },		--Expert
	[4] = { 35, 25 },		--Artisan
	[5] = { 50, 40 },		--Master
	--[6] = { 65, 55 },		--Grand Master
	[6] = { 58, 55 },		--Grand Master
	[7] = { 75, 75 },		--Illustrious Grand Master
	[8] = { 80, 80 },		--Zen Master
	[9] = { 90, 90 },		--Draenor Master
	[10] = { 100, 100 },	--Legion Master
	[11] = { 110, 110 },	--Battle for Azeroth Master
};

CBG_MAP_ICON_TEXTURES = {
	[CBT_MAP_ICON_TRAINER] = {
		--first row
		[CBT_SKILL_ALCH] = { 0, 0.125, 0, 0.125 },
		[CBT_SKILL_ARCH] = { 0.125, 0.25, 0, 0.125 },
		[CBT_SKILL_BLCK] = { 0.25, 0.375, 0, 0.125 },
		[CBT_SKILL_COOK] = { 0.375, 0.5, 0, 0.125 },
		[CBT_SKILL_ENCH] = { 0.5, 0.625, 0, 0.125 },
		[CBT_SKILL_ENGN] = { 0.625, 0.75, 0, 0.125 },
		[CBT_SKILL_FISH] = { 0.875, 1, 0, 0.125 },
		--second row
		[CBT_SKILL_HERB] = { 0, 0.125, 0.125, 0.25 },
		[CBT_SKILL_INSC] = { 0.125, 0.25, 0.125, 0.25 },
		[CBT_SKILL_JEWL] = { 0.25, 0.375, 0.125, 0.25 },
		[CBT_SKILL_LTHR] = { 0.375, 0.5, 0.125, 0.25 },
		[CBT_SKILL_MINE] = { 0.5, 0.625, 0.125, 0.25 },
		[CBT_SKILL_SKIN] = { 0.625, 0.75, 0.125, 0.25 },
		[CBT_SKILL_TAIL] = { 0.75, 0.875, 0.125, 0.25 },
		--profession
		["all"] = { 0, 0.0625, 0.375, 0.4375 },
	},
	[CBT_MAP_ICON_STATION] = {
		--first row
		[CBT_SKILL_ALCH] = { 0, 0.125, 0.5, 0.625 },
		[CBT_SKILL_BLCK] = { 0.125, 0.25, 0.5, 0.625 },
		[CBT_SKILL_ENCH] = { 0.25, 0.375,  0.5, 0.625 },
		[CBT_SKILL_INSC] = { 0.375, 0.5, 0.5, 0.625 },
		[CBT_SKILL_JEWL] = { 0.5, 0.625, 0.5, 0.625 },
		[CBT_SKILL_MINE] = { 0.625, 0.75, 0.5, 0.625 },
		[CBT_SKILL_TAIL] = { 0.75, 0.875, 0.5, 0.625 },
	},
};

CBG_SKILL_COUNT = 16;
CBG_SORTED_SKILLS = {
	--Primary
	[1] = CBT_SKILL_ALCH,	--Alchemy
	[2] = CBT_SKILL_BLCK,	--Blacksmithing
	[3] = CBT_SKILL_ENCH,	--Enchanting
	[4] = CBT_SKILL_ENGN,	--Engineering
	[5] = CBT_SKILL_HERB,	--Herbalism
	[6] = CBT_SKILL_INSC,	--Inscription
	[7] = CBT_SKILL_JEWL,	--Jewelcrafting
	[8] = CBT_SKILL_LTHR,	--Leatherworking
	[9] = CBT_SKILL_MINE,	--Mining
	[10] = CBT_SKILL_SKIN,	--Skinning
	[11] = CBT_SKILL_TAIL,	--Tailoring
	--Secondary
	[12] = CBT_SKILL_ARCH,	--Archaeology
	[13] = CBT_SKILL_COOK,	--Cooking
	[14] = CBT_SKILL_FISH,	--Fishing
	--Rogue-only
	[15] = CBT_SKILL_PICK,	--Lockpicking
};

CBG_SKILL_FRAMES = {
	[1] = "skill_1",
	[2] = "skill_2",
	[3] = "cooking",
	[4] = "fishing",
	[5] = "archaeology",
	[6] = "lockpicking",
};

-------------------------------------------------------------------------------
-- Colors
-------------------------------------------------------------------------------
CBG_CLR_MIN_ALPHA = "|c00"
CBG_CLR_MAX_ALPHA = "|cff"
CBG_CLR_DEFAULT = CBG_CLR_MAX_ALPHA .. "ffff00";
CBG_CLR_WHITE = CBG_CLR_MAX_ALPHA .. "ffffff";
CBG_CLR_RED = CBG_CLR_MAX_ALPHA .. "ff0000";
CBG_CLR_BLUE = CBG_CLR_MAX_ALPHA .. "0000ff";
CBG_CLR_OFFBLUE = CBG_CLR_MAX_ALPHA .. "00d9ec";
CBG_CLR_DARKBLUE = CBG_CLR_MAX_ALPHA .. "0066cc";
CBG_CLR_LIGHTGREY = CBG_CLR_MAX_ALPHA .. "bbbbbb";
CBG_CLR_LIGHTGREEN = CBG_CLR_MAX_ALPHA .. "20ff20";
CBG_CLR_ORANGE = CBG_CLR_MAX_ALPHA .. "ffaa00";

CBG_MOD_COLOR = CBG_CLR_MAX_ALPHA .. "66aaff";

-------------------------------------------------------------------------------
-- Map IDs
-------------------------------------------------------------------------------
CBG_MAP_IDS = {
	1,	--Durotar
	7,	--Mulgore
	10,	--Northern Barrens
	12,	--Kalimdor
	13,	--Eastern Kingdoms
	14,	--Arathi Highlands
	15,	--Badlands
	17,	--Blasted Lands
	18,	--Tirisfal Glades
	21,	--Silverpine Forest
	22,	--Western Plaguelands
	23,	--Eastern Plaguelands
	25,	--Hillsbrad Foothills
	26,	--The Hinterlands
	27,	--Dun Morogh
	32,	--Searing Gorge
	36,	--Burning Steppes
	37,	--Elwynn Forest
	42,	--Deadwind Pass
	47,	--Duskwood
	48,	--Loch Modan
	49,	--Redridge Mountains
	50,	--Northern Stranglethorn
	51,	--Swamp of Sorrows
	52,	--Westfall
	56,	--Wetlands
	57,	--Teldrassil
	62,	--Darkshore
	63,	--Ashenvale
	64,	--Thousand Needles
	65,	--Stonetalon Mountains
	66,	--Desolace
	69,	--Feralas
	70,	--Dustwallow Marsh
	71,	--Tanaris
	76,	--Azshara
	77,	--Felwood
	78,	--Un'Goro Crater
	80,	--Moonglade
	81,	--Silithus
	83,	--Winterspring
	84,	--Stormwind City
	85,	--Orgrimmar
	87,	--Ironforge
	88,	--Thunder Bluff
	89,	--Darnassus
	90,	--Undercity
	91,	--Alterac Valley
	92,	--Warsong Gulch
	93,	--Arathi Basin
	94,	--Eversong Woods
	95,	--Ghostlands
	97,	--Azuremyst Isle
	100,	--Hellfire Peninsula
	101,	--Outland
	102,	--Zangarmarsh
	103,	--The Exodar
	104,	--Shadowmoon Valley
	105,	--Blade's Edge Mountains
	106,	--Bloodmyst Isle
	107,	--Nagrand
	108,	--Terokkar Forest
	109,	--Netherstorm
	110,	--Silvermoon City
	111,	--Shattrath City
	112,	--Eye of the Storm
	113,	--Northrend
	114,	--Borean Tundra
	115,	--Dragonblight
	116,	--Grizzly Hills
	117,	--Howling Fjord
	118,	--Icecrown
	119,	--Sholazar Basin
	120,	--The Storm Peaks
	121,	--Zul'Drak
	122,	--Isle of Quel'Danas
	123,	--Wintergrasp
	124,	--Plaguelands: The Scarlet Enclave
	125,	--Dalaran
	127,	--Crystalsong Forest
	128,	--Strand of the Ancients
	129,	--The Nexus
	130,	--The Culling of Stratholme
	132,	--Ahn'kahet: The Old Kingdom
	133,	--Utgarde Keep
	136,	--Utgarde Pinnacle
	138,	--Halls of Lightning
	140,	--Halls of Stone
	141,	--The Eye of Eternity
	142,	--The Oculus
	147,	--Ulduar
	153,	--Gundrak
	155,	--The Obsidian Sanctum
	156,	--Vault of Archavon
	157,	--Azjol-Nerub
	160,	--Drak'Tharon Keep
	162,	--Naxxramas
	168,	--The Violet Hold
	169,	--Isle of Conquest
	170,	--Hrothgar's Landing
	171,	--Trial of the Champion
	172,	--Trial of the Crusader
	174,	--The Lost Isles
	179,	--Gilneas
	183,	--The Forge of Souls
	184,	--Pit of Saron
	185,	--Halls of Reflection
	186,	--Icecrown Citadel
	194,	--Kezan
	198,	--Mount Hyjal
	199,	--Southern Barrens
	200,	--The Ruby Sanctum
	201,	--Kelp'thar Forest
	202,	--Gilneas City
	203,	--Vashj'ir
	204,	--Abyssal Depths
	205,	--Shimmering Expanse
	206,	--Twin Peaks
	207,	--Deepholm
	210,	--The Cape of Stranglethorn
	213,	--Ragefire Chasm
	217,	--Ruins of Gilneas
	218,	--Ruins of Gilneas City
	219,	--Zul'Farrak
	220,	--The Temple of Atal'Hakkar
	221,	--Blackfathom Deeps
	224,	--Stranglethorn Vale
	225,	--The Stockade
	226,	--Gnomeregan
	230,	--Uldaman
	232,	--Molten Core
	233,	--Zul'Gurub
	234,	--Dire Maul
	241,	--Twilight Highlands
	242,	--Blackrock Depths
	244,	--Tol Barad
	245,	--Tol Barad Peninsula
	246,	--The Shattered Halls
	247,	--Ruins of Ahn'Qiraj
	248,	--Onyxia's Lair
	249,	--Uldum
	250,	--Blackrock Spire
	256,	--Auchenai Crypts
	258,	--Sethekk Halls
	260,	--Shadow Labyrinth
	261,	--The Blood Furnace
	262,	--The Underbog
	263,	--The Steamvault
	265,	--The Slave Pens
	266,	--The Botanica
	267,	--The Mechanar
	269,	--The Arcatraz
	272,	--Mana-Tombs
	273,	--The Black Morass
	274,	--Old Hillsbrad Foothills
	275,	--The Battle for Gilneas
	276,	--The Maelstrom
	277,	--Lost City of the Tol'vir
	279,	--Wailing Caverns
	280,	--Maraudon
	282,	--Baradin Hold
	283,	--Blackrock Caverns
	285,	--Blackwing Descent
	287,	--Blackwing Lair
	291,	--The Deadmines
	293,	--Grim Batol
	294,	--The Bastion of Twilight
	297,	--Halls of Origination
	300,	--Razorfen Downs
	301,	--Razorfen Kraul
	302,	--Scarlet Monastery
	306,	--ScholomanceOLD
	310,	--Shadowfang Keep
	317,	--Stratholme
	319,	--Ahn'Qiraj
	322,	--Throne of the Tides
	324,	--The Stonecore
	325,	--The Vortex Pinnacle
	327,	--Ahn'Qiraj: The Fallen Kingdom
	328,	--Throne of the Four Winds
	329,	--Hyjal Summit
	330,	--Gruul's Lair
	331,	--Magtheridon's Lair
	332,	--Serpentshrine Cavern
	333,	--Zul'Aman
	334,	--Tempest Keep
	335,	--Sunwell Plateau
	338,	--Molten Front
	339,	--Black Temple
	347,	--Hellfire Ramparts
	348,	--Magisters' Terrace
	350,	--Karazhan
	367,	--Firelands
	371,	--The Jade Forest
	376,	--Valley of the Four Winds
	378,	--The Wandering Isle
	379,	--Kun-Lai Summit
	388,	--Townlong Steppes
	390,	--Vale of Eternal Blossoms
	398,	--Well of Eternity
	399,	--Hour of Twilight
	401,	--End Time
	407,	--Darkmoon Island
	409,	--Dragon Soul
	417,	--Temple of Kotmogu
	418,	--Krasarang Wilds
	422,	--Dread Wastes
	423,	--Silvershard Mines
	424,	--Pandaria
	425,	--Northshire
	427,	--Coldridge Valley
	429,	--Temple of the Jade Serpent
	431,	--Scarlet Halls
	433,	--The Veiled Stair
	437,	--Gate of the Setting Sun
	439,	--Stormstout Brewery
	443,	--Shado-Pan Monastery
	447,	--A Brewing Storm
	450,	--Unga Ingoo
	451,	--Assault on Zan'vess
	452,	--Brewmoon Festival
	453,	--Mogu'shan Palace
	456,	--Terrace of Endless Spring
	457,	--Siege of Niuzao Temple
	460,	--Shadowglen
	461,	--Valley of Trials
	462,	--Camp Narache
	463,	--Echo Isles
	465,	--Deathknell
	467,	--Sunstrider Isle
	468,	--Ammen Vale
	469,	--New Tinkertown
	471,	--Mogu'shan Vaults
	474,	--Heart of Fear
	476,	--Scholomance
	480,	--Proving Grounds
	481,	--Crypt of Forgotten Kings
	487,	--A Little Patience
	488,	--Dagger in the Dark
	499,	--Deeprun Tram
	503,	--Brawl'gar Arena
	504,	--Isle of Thunder
	507,	--Isle of Giants
	508,	--Throne of Thunder
	518,	--Thunder King's Citadel
	519,	--Deepwind Gorge
	522,	--The Secrets of Ragefire
	524,	--Battle on the High Seas
	525,	--Frostfire Ridge
	534,	--Tanaan Jungle
	535,	--Talador
	542,	--Spires of Arak
	543,	--Gorgrond
	554,	--Timeless Isle
	556,	--Siege of Orgrimmar
	571,	--Celestial Tournament
	572,	--Draenor
	573,	--Bloodmaul Slag Mines
	574,	--Shadowmoon Burial Grounds
	582,	--Lunarfall
	588,	--Ashran
	590,	--Frostwall
	592,	--Defense of Karabor
	593,	--Auchindoun
	595,	--Iron Docks
	596,	--Blackrock Foundry
	601,	--Skyreach
	606,	--Grimrail Depot
	610,	--Highmaul
	616,	--Upper Blackrock Spire
	619,	--Broken Isles
	620,	--The Everbloom
	622,	--Stormshield
	623,	--Hillsbrad Foothills (Southshore vs. Tarren Mill)
	624,	--Warspear
	630,	--Azsuna
	634,	--Stormheim
	641,	--Val'sharah
	645,	--Twisting Nether
	646,	--Broken Shore
	649,	--Helheim
	650,	--Highmountain
	661,	--Hellfire Citadel
	671,	--The Cove of Nashal
	672,	--Mardum, the Shattered Abyss
	677,	--Vault of the Wardens
	680,	--Suramar
	694,	--Helmouth Shallows
	695,	--Skyhold
	702,	--Netherlight Temple
	703,	--Halls of Valor
	706,	--Helmouth Cliffs
	713,	--Eye of Azshara
	714,	--Niskara
	715,	--Emerald Dreamway
	716,	--Skywall
	717,	--Dreadscar Rift
	731,	--Neltharion's Lair
	732,	--Violet Hold
	733,	--Darkheart Thicket
	734,	--Hall of the Guardian
	736,	--The Beyond
	739,	--Trueshot Lodge
	740,	--Shadowgore Citadel
	742,	--Abyssal Maw
	747,	--The Dreamgrove
	749,	--The Arcway
	750,	--Thunder Totem
	751,	--Black Rook Hold
	757,	--Ursoc's Lair
	758,	--Gloaming Reef
	760,	--Malorne's Nightmare
	761,	--Court of Stars
	764,	--The Nighthold
	777,	--The Emerald Nightmare
	806,	--Trial of Valor
	824,	--Islands
	826,	--Cave of the Bloodtotem
	830,	--Krokuun
	838,	--Battle for Blackrock Mountain
	843,	--Shado-Pan Showdown
	845,	--Cathedral of Eternal Night
	850,	--Tomb of Sargeras
	858,	--Assault on Broken Shore
	862,	--Zuldazar
	863,	--Nazmir
	864,	--Vol'dun
	871,	--The Lost Glacier
	875,	--Zandalar
	876,	--Kul Tiras
	877,	--Fields of the Eternal Hunt
	882,	--Mac'Aree
	885,	--Antoran Wastes
	888,	--Hall of Communion
	889,	--Arcatraz
	895,	--Tiragarde Sound
	896,	--Drustvar
	897,	--The Deaths of Chromie
	903,	--The Seat of the Triumvirate
	904,	--Silithus Brawl
	905,	--Argus
	907,	--Seething Shore
	908,	--Ruins of Lordaeron
	909,	--Antorus, the Burning Throne
	921,	--Invasion Point: Aurinor
	922,	--Invasion Point: Bonich
	923,	--Invasion Point: Cen'gar
	924,	--Invasion Point: Naigtal
	925,	--Invasion Point: Sangua
	926,	--Invasion Point: Val
	927,	--Greater Invasion Point: Pit Lord Vilemus
	928,	--Greater Invasion Point: Mistress Alluradel
	929,	--Greater Invasion Point: Matron Folnuna
	930,	--Greater Invasion Point: Inquisitor Meto
	931,	--Greater Invasion Point: Sotanathor
	932,	--Greater Invasion Point: Occularus
	933,	--Forge of Aeons
	934,	--Atal'Dazar
	936,	--Freehold
	938,	--Gilneas Island
	939,	--Tropical Isle 8.0
	940,	--The Vindicaar
	942,	--Stormsong Valley
	946,	--Cosmic
	947,	--Azeroth
	971,	--Telogrus Rift
	973,	--The Sunwell
	974,	--Tol Dagor
	981,	--Un'gol Ruins
	1004,	--Kings' Rest
	1010,	--The MOTHERLODE!!
	1015,	--Waycrest Manor
	1021,	--Chamber of Heart
	1022,	--Uncharted Island
	1029,	--WaycrestDimension
	1032,	--Skittering Hollow
	1033,	--The Rotting Mire
	1034,	--Verdant Wilds
	1035,	--Molten Cay
	1036,	--The Dread Chain
	1037,	--Whispering Reef
	1038,	--Temple of Sethraliss
	1039,	--Shrine of the Storm
	1041,	--The Underrot
	1045,	--Thros, The Blighted Lands
	1148,	--Uldir
	1156,	--The Great Sea
	1161,	--Boralus
	1162,	--Siege of Boralus
	1165,	--Dazar'alor
	1166,	--Zanchul
	1170,	--Gorgrond - Mag'har Scenario
	1177,	--Breath Of Pa'ku
	1182,	--SalstoneMine_Stormsong
	1183,	--Thornheart
};