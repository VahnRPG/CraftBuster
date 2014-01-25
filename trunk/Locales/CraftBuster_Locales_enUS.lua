-------------------------------------------------------------------------------
-- CraftBuster Localization
-------------------------------------------------------------------------------
local LOCALE = GetLocale();

if (GetLocale() == "enUS") then
	CBL["SKILL_BLCK"] = "Blacksmithing";
	CBL["SKILL_LTHR"] = "Leatherworking";
	CBL["SKILL_ALCH"] = "Alchemy";
	CBL["SKILL_HERB"] = "Herbalism";
	CBL["SKILL_MINE"] = "Mining";
	CBL["SKILL_TAIL"] = "Tailoring";
	CBL["SKILL_ENGN"] = "Engineering";
	CBL["SKILL_ENCH"] = "Enchanting";
	CBL["SKILL_SKIN"] = "Skinning";
	CBL["SKILL_JEWL"] = "Jewelcrafting";
	CBL["SKILL_INSC"] = "Inscription";
	CBL["SKILL_COOK"] = "Cooking";
	CBL["SKILL_FRST"] = "First Aid";
	CBL["SKILL_FISH"] = "Fishing";
	CBL["SKILL_ARCH"] = "Archaeology";
	-- Rogue Only
	CBL["SKILL_PICK"] = "Lockpicking";

	CBL["LBL_RED"] = "Red";
	CBL["LBL_ORANGE"] = "Orange";
	CBL["LBL_YELLOW"] = "Yellow";
	CBL["LBL_GREEN"] = "Green";
	CBL["LBL_GREY"] = "Grey";

	CBL["CONFIG_TITLE_TRACK_PROFESSION"] = "Track Professions";
	CBL["CONFIG_TITLE_TRACK_GATHERING"] = "Gathering Info";
	CBL["CONFIG_TITLE_TOOLTIP_INFO"] = "Display Tooltip Info";
	CBL["CONFIG_TITLE_BUSTER_ICON"] = "Show Buster Icon";
	CBL["CONFIG_TITLE_SHOW_NODES"] = "Show Nodes";
	CBL["CONFIG_TITLE_OTHER"] = "Other";
	CBL["CONFIG_SHOW_MINIMAP"] = "Show Minimap Button";
	CBL["CONFIG_SHOW_TRACKER"] = "Show Tracker";
	CBL["CONFIG_EXPAND_TRACKER"] = "Expand Tracker";
	CBL["CONFIG_TRACKER_POSITION"] = "Tracker Position";
	CBL["CONFIG_SHOW_GATHERER"] = "Show Gatherer";
	CBL["CONFIG_SHOW_ZONE_NODES"] = "Show Zone Nodes";
	CBL["CONFIG_SHOW_SKILLUP_NODES"] = "Show Skill-Up Nodes";
	CBL["CONFIG_EXPAND_GATHERER"] = "Expand Gatherer";
	CBL["CONFIG_GATHERER_POSITION"] = "Gatherer Position";
	CBL["CONFIG_BUSTER_POSITION"] = "Buster Position";
	CBL["CONFIG_POSITION_X"] = "X:";
	CBL["CONFIG_POSITION_Y"] = "Y:";
	CBL["CONFIG_POSITION_POINT"] = "Point:";
	CBL["CONFIG_POSITION_RELATIVE_POINT"] = "Relative To:";
	CBL["CONFIG_POSITION_SET"] = "SET";
	CBL["CONFIG_POSITIONS_RESET"] = "Reset Positions";

	CBL["MINIMAP_HOVER_LINE1"] = CBG_CLR_WHITE .. "Left button to " .. CBG_CLR_LIGHTGREEN .. "Drag";
	CBL["MINIMAP_HOVER_LINE2"] = CBG_CLR_WHITE .. "Left-click for " .. CBG_CLR_OFFBLUE .. "Toggle Menu";
	CBL["MINIMAP_HOVER_LINE3"] = CBG_CLR_WHITE .. "Right-click for " .. CBG_CLR_OFFBLUE .. "Config";

	CBL["NODE_MSG"] = CBG_CLR_OFFBLUE .. "Gather Levels: |r";
	CBL["ORANGE_ACTION"] = "%sReaching level %d you can now gather from '%s' nodes.";
	CBL["YELLOW_ACTION"] = "%s'%s' has turned yellow at level %s";
	CBL["GREEN_ACTION"] = "%s'%s' has turned green at level %s";
	CBL["GREY_ACTION"] = "%s'%s' has turned grey at level %s";

	-- Inscription Localization
	CBL["SKILL_INSC_PIGMENTS"] = "Pigments";
	CBL["SKILL_INSC_INKS"] = "Inks";
	CBL["SKILL_INSC_HERBS"] = "Herbs";

	-- "Found in Zone" Localization
	CBL["SKILL_MINE_ZONE"] = CBG_CLR_ORANGE .. "Mined in Zones: |r";
	CBL["SKILL_HERB_ZONE"] = CBG_CLR_ORANGE .. "Gathered in Zones: |r";

	-- Buster Spell Localization
	CBL["BUSTER_SPELL_TOOLTIP_APPEND"] = CBG_CLR_WHITE .. " - " .. CBG_CLR_OFFBLUE .. "Buster";
	CBL["BUSTER_SPELL_TOOLTIP_LINE1"] = CBG_CLR_WHITE .. "List relevant items in bags";

	-- Buster Frame Localization
	CBL["BUSTER_CLICK"] = CBG_CLR_WHITE .. "Left-click to use ";
	CBL["BUSTER_IGNORE"] = CBG_CLR_WHITE .. "CTRL + Right-click to " .. CBG_CLR_RED .. "ignore";

	-- Tradeskill Localization
	--CBL["TRADESKILL_NUMLINES"] = 2;
	CBL["TRADESKILL_NUMLINES"] = 1;
	CBL["TRADESKILL_LINE1"] = CBG_CLR_WHITE .. "List relevant items in bags";
	--CBL["TRADESKILL_LINE2"] = CBG_CLR_WHITE .. "fasdfadsfadsf";

	-- Help Localization
	CBL["HELP_LINES"] = 3;
	CBL["HELP1"] = "Help Line 1";
	CBL["HELP2"] = "Help Line 2";
	CBL["HELP3"] = "Help Line 3";
end