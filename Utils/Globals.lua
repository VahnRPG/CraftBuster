-------------------------------------------------------------------------------
-- CraftBuster Globals
-------------------------------------------------------------------------------
CBG_MOD_NAME = "CraftBuster";
CBG_VERSION = GetAddOnMetadata(CBG_MOD_NAME, "Version");
CBG_LAST_UPDATED = GetAddOnMetadata(CBG_MOD_NAME, "X-Date");

CBG_GLOBAL_PROFILE = "CraftBuster-Global-Profile";

CBG_LOCKPICKING_LEVEL = 24;
CBG_LOCKPICKING_MAX_SKILL_LEVEL = 800;

CBG_MAX_PROFESSIONS = 9;
CBG_PROFESSION_RANKS = {
	[1] = { 0, 75, APPRENTICE },
	[2] = { 50, 150, JOURNEYMAN },
	[3] = { 125, 225, EXPERT },
	[4] = { 200, 300, ARTISAN },
	[5] = { 275, 375, MASTER },
	[6] = { 350, 450, GRAND_MASTER },
	[7] = { 425, 525, ILLUSTRIOUS },
	[8] = { 500, 600, ZEN_MASTER },
	[9] = { 600, 700, DRAENOR_MASTER },
	[10] = { 700, 800, LEGION_MASTER },
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
	[6] = { 65, 55 },		--Grand Master
	[7] = { 75, 75 },		--Illustrious Grand Master
	[8] = { 80, 80 },		--Zen Master
	[9] = { 90, 90 },		--Draenor Master
	[10] = { 100, 100 },	--Legion Master
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
		[CBT_SKILL_FRST] = { 0.75, 0.875, 0, 0.125 },
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
	[14] = CBT_SKILL_FRST,	--First Aid
	[15] = CBT_SKILL_FISH,	--Fishing
	--Rogue-only
	[16] = CBT_SKILL_PICK,	--Lockpicking
};

CBG_SKILL_FRAMES = {
	[1] = "skill_1",
	[2] = "skill_2",
	[3] = "cooking",
	[4] = "first_aid",
	[5] = "fishing",
	[6] = "archaeology",
	[7] = "lockpicking",
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
	13,		--Kalimdor
	772,	--Ahn'Qiraj: The Fallen Kingdom
	894,	--Ammen Vale
	43,		--Ashenvale
	181,	--Azshara
	464,	--Azuremyst Isle
	476,	--Bloodmyst Isle
	890,	--Camp Narache
	42,		--Darkshore
	381,	--Darnassus
	101,	--Desolace
	4,		--Durotar
	141,	--Dustwallow Marsh
	891,	--Echo Isles
	182,	--Felwood
	121,	--Feralas
	795,	--Molten Front
	241,	--Moonglade
	606,	--Mount Hyjal
	9,		--Mulgore
	11,		--Northern Barrens
	321,	--Orgrimmar
	888,	--Shadowglen
	261,	--Silithus
	607,	--Southern Barrens
	81,		--Stonetalon Mountains
	161,	--Tanaris
	41,		--Teldrassil
	471,	--The Exodar
	61,		--Thousand Needles
	362,	--Thunder Bluff
	720,	--Uldum
	201,	--Un'Goro Crater
	889,	--Valley of Trials
	281,	--Winterspring

	14,		--Eastern Kingdoms
	614,	--Abyssal Depths
	16,		--Arathi Highlands
	17,		--Badlands
	19,		--Blasted Lands
	29,		--Burning Steppes
	866,	--Coldridge Valley
	32,		--Deadwind Pass
	892,	--Deathknell
	27,		--Dun Morogh
	34,		--Duskwood
	23,		--Eastern Plaguelands
	30,		--Elwynn Forest
	462,	--Eversong Woods
	463,	--Ghostlands
	545,	--Gilneas
	611,	--Gilneas City
	24,		--Hillsbrad Foothills
	341,	--Ironforge
	499,	--Isle of Quel'Danas
	610,	--Kelp'thar Forest
	35,		--Loch Modan
	895,	--New Tinkertown
	37,		--Northern Stranglethorn
	864,	--Northshire
	36,		--Redridge Mountains
	684,	--Ruins of Gilneas
	685,	--Ruins of Gilneas City
	28,		--Searing Gorge
	615,	--Shimmering Expanse
	480,	--Silvermoon City
	21,		--Silverpine Forest
	301,	--Stormwind City
	689,	--Stranglethorn Vale
	893,	--Sunstrider Isle
	38,		--Swamp of Sorrows
	673,	--The Cape of Stranglethorn
	26,		--The Hinterlands
	502,	--The Scarlet Enclave
	20,		--Tirisfal Glades
	708,	--Tol Barad
	709,	--Tol Barad Peninsula
	700,	--Twilight Highlands
	382,	--Undercity
	613,	--Vashj'ir
	22,		--Western Plaguelands
	39,		--Westfall
	40,		--Wetlands

	466,	--Outland
	475,	--Blade's Edge Mountains
	465,	--Hellfire Peninsula
	477,	--Nagrand
	479,	--Netherstorm
	473,	--Shadowmoon Valley
	481,	--Shattrath City
	478,	--Terokkar Forest
	467,	--Zangarmarsh

	485,	--Northrend
	486,	--Borean Tundra
	510,	--Crystalsong Forest
	504,	--Dalaran
	488,	--Dragonblight
	490,	--Grizzly Hills
	491,	--Howling Fjord
	541,	--Hrothgar's Landing
	492,	--Icecrown
	493,	--Sholazar Basin
	495,	--The Storm Peaks
	501,	--Wintergrasp
	496,	--Zul'Drak

	751,	--The Maelstrom
	640,	--Deepholm
	605,	--Kezan
	544,	--The Lost Isles
	737,	--The Maelstrom

	862,	--Pandaria
	858,	--Dread Wastes
	929,	--Isle of Giants
	928,	--Isle of Thunder
	857,	--Krasarang Wilds
	809,	--Kun-Lai Summit
	905,	--Shrine of Seven Stars
	903,	--Shrine of Two Moons
	806,	--The Jade Forest
	873,	--The Veiled Stair
	808,	--The Wandering Isle
	951,	--Timeless Isle
	810,	--Townlong Steppes
	811,	--Vale of Eternal Blossoms
	807,	--Valley of the Four Winds

	962,	--Draenor
	978,	--Ashran
	941,	--Frostfire Ridge
	976,	--Frostwall
	949,	--Gorgrond
	971,	--Lunarfall
	950,	--Nagrand
	947,	--Shadowmoon Valley
	948,	--Spires of Arak
	1009,	--Stormshield
	946,	--Talador
	945,	--Tanaan Jungle
	970,	--Tanaan Jungle - Assault on the Dark Portal
	1011,	--Warspear

	1007,	--Broken Isles
	1015,	--Aszuna
	1021,	--Broken Shore
	1014,	--Dalaran
	1098,	--Eye of Azshara
	1024,	--Highmountain
	1017,	--Stormheim
	1033,	--Suramar
	1018,	--Val'sharah
	
	1068,	--Hall of the Guardian - Mage Order Hall
	1052,	--Mardum, the Shattered Abyss - Demon Hunter
	1040,	--Netherlight Temple - Priest Order Hall
	1035,	--Skyhold - Warrior Order Hall
	1077,	--The Dreamgrove - Druid Order Hall
	1057,	--The Heart of Azeroth - Shaman Order Hall
	1044,	--The Wandering Isle - Monk Order Hall
	1072,	--Trueshot Lodge - Hunter Order Hall

	401,	--Alterac Valley
	461,	--Arathi Basin
	935,	--Deepwind Gorge
	482,	--Eye of the Storm
	540,	--Isle of Conquest
	860,	--Silvershard Mines
	512,	--Strand of the Ancients
	856,	--Temple of Kotmogu
	736,	--The Battle for Gilneas
	626,	--Twin Peaks
	443,	--Warsong Gulch

	878,	--A Brewing Storm
	912,	--A Little Patience
	899,	--Arena of Annihilation
	883,	--Assault on Zan'vess
	940,	--Battle on the High Seas
	939,	--Blood in the Snow
	884,	--Brewmoon Festival
	955,	--Celestial Tournament
	900,	--Crypt of Forgotten Kings
	914,	--Dagger in the Dark
	937,	--Dark Heart of Pandaria
	920,	--Domination Point (H)
	880,	--Greenstone Village
	911,	--Lion's Landing (A)
	938,	--The Secrets of Ragefire
	906,	--Theramore's Fall (A)
	851,	--Theramore's Fall (H)
	882,	--Unga Ingoo

	688,	--Blackfathom Deeps
	704,	--Blackrock Depths
	721,	--Blackrock Spire
	699,	--Dire Maul
	691,	--Gnomeregan
	750,	--Maraudon
	680,	--Ragefire Chasm
	760,	--Razorfen Downs
	761,	--Razorfen Kraul
	764,	--Shadowfang Keep
	765,	--Stratholme
	756,	--The Deadmines
	690,	--The Stockade
	687,	--The Temple of Atal'Hakkar
	692,	--Uldaman
	749,	--Wailing Caverns
	686,	--Zul'Farrak

	755,	--Blackwing Lair
	696,	--Molten Core
	717,	--Ruins of Ahn'Qiraj
	766,	--Temple of Ahn'Qiraj

	722,	--Auchenai Crypts
	797,	--Hellfire Ramparts
	798,	--Magisters' Terrace
	732,	--Mana-Tombs
	734,	--Old Hillsbrad Foothills
	723,	--Sethekk Halls
	724,	--Shadow Labyrinth
	731,	--The Arcatraz
	733,	--The Black Morass
	725,	--The Blood Furnace
	729,	--The Botanica
	730,	--The Mechanar
	710,	--The Shattered Halls
	728,	--The Slave Pens
	727,	--The Steamvault
	726,	--The Underbog

	796,	--Black Temple
	776,	--Gruul's Lair
	775,	--Hyjal Summit
	799,	--Karazhan
	779,	--Magtheridon's Lair
	780,	--Serpentshrine Cavern
	789,	--Sunwell Plateau
	782,	--The Eye

	522,	--Ahn'kahet: The Old Kingdom
	533,	--Azjol-Nerub
	534,	--Drak'Tharon Keep
	530,	--Gundrak
	525,	--Halls of Lightning
	603,	--Halls of Reflection
	526,	--Halls of Stone
	602,	--Pit of Saron
	521,	--The Culling of Stratholme
	601,	--The Forge of Souls
	520,	--The Nexus
	528,	--The Oculus
	536,	--The Violet Hold
	542,	--Trial of the Champion
	523,	--Utgarde Keep
	524,	--Utgarde Pinnacle

	604,	--Icecrown Citadel
	535,	--Naxxramas
	718,	--Onyxia's Lair
	527,	--The Eye of Eternity
	531,	--The Obsidian Sanctum
	609,	--The Ruby Sanctum
	543,	--Trial of the Crusader
	529,	--Ulduar
	532,	--Vault of Archavon

	753,	--Blackrock Caverns
	820,	--End Time
	757,	--Grim Batol
	759,	--Halls of Origination
	819,	--Hour of Twilight
	747,	--Lost City of the Tol'vir
	768,	--The Stonecore
	769,	--The Vortex Pinnacle
	767,	--Throne of the Tides
	816,	--Well of Eternity
	781,	--Zul'Aman
	793,	--Zul'Gurub

	752,	--Baradin Hold
	754,	--Blackwing Descent
	824,	--Dragon Soul
	800,	--Firelands
	758,	--The Bastion of Twilight
	773,	--Throne of the Four Winds

	875,	--Gate of the Setting Sun
	885,	--Mogu'Shan Palace
	871,	--Scarlet Halls
	874,	--Scarlet Monastery
	898,	--Scholomance
	877,	--Shado-pan Monastery
	887,	--Siege of Niuzao Temple
	876,	--Stormstout Brewery
	867,	--Temple of the Jade Serpent

	897,	--Heart of Fear
	896,	--Mogu'shan Vaults
	953,	--Siege of Orgrimmar
	886,	--Terrace of Endless Spring
	930,	--Throne of Thunder

	984,	--Auchindoun
	964,	--Bloodmaul Slag Mines
	993,	--Grimrail Depot
	987,	--Iron Docks
	969,	--Shadowmoon Burial Grounds
	989,	--Skyreach
	1008,	--The Everbloom
	995,	--Upper Blackrock Spire

	994,	--Highmaul
	988,	--Blackrock Foundry
	1026,	--Hellfire Citadel
	
	1081,	--Black Rook Hold
	1087,	--Court of Stars
	1067,	--Darkheart Thicket
	1046,	--Eye of Azshara
	1041,	--Halls of Valor
	1042,	--Maw of Souls
	1065,	--Neltharion's Lair
	1079,	--The Arcway
	1045,	--Vault of the Wardens
	1066,	--Violet Hold

	1094,	--The Emerald Nightmare
	1088,	--The Nighthold
};