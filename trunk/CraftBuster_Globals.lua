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