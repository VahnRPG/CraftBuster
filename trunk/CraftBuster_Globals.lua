-------------------------------------------------------------------------------
-- CraftBuster Globals
-------------------------------------------------------------------------------
CBG_MOD_NAME = "CraftBuster";
CBG_VERSION = GetAddOnMetadata(CBG_MOD_NAME, "Version");
CBG_LAST_UPDATED = GetAddOnMetadata(CBG_MOD_NAME, "X-Date");

CBG_MAX_PROFESSIONS = 8;
CBG_PROFESSION_RANKS = {
	[1] = { 0, 75, APPRENTICE },
	[2] = { 50, 150, JOURNEYMAN },
	[3] = { 125, 225, EXPERT },
	[4] = { 200, 300, ARTISAN },
	[5] = { 275, 375, MASTER },
	[6] = { 350, 450, GRAND_MASTER },
	[7] = { 425, 525, ILLUSTRIOUS },
	[8] = { 500, 600, ZEN_MASTER },
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
};

CBG_MAP_ICON_TEXTURES = {
	["trainers"] = {
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
	["stations"] = {
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