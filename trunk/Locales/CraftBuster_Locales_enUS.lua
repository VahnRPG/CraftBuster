-------------------------------------------------------------------------------
-- CraftBuster enUS Localization
-------------------------------------------------------------------------------
--if (GetLocale() == "enUS") then
	--Primary
	CBL[CBT_SKILL_ALCH] = "Alchemy";
	CBL[CBT_SKILL_BLCK] = "Blacksmithing";
	CBL[CBT_SKILL_ENCH] = "Enchanting";
	CBL[CBT_SKILL_ENGN] = "Engineering";
	CBL[CBT_SKILL_HERB] = "Herbalism";
	CBL[CBT_SKILL_INSC] = "Inscription";
	CBL[CBT_SKILL_JEWL] = "Jewelcrafting";
	CBL[CBT_SKILL_LTHR] = "Leatherworking";
	CBL[CBT_SKILL_MINE] = "Mining";
	CBL[CBT_SKILL_SKIN] = "Skinning";
	CBL[CBT_SKILL_TAIL] = "Tailoring";
	--Secondary
	CBL[CBT_SKILL_ARCH] = "Archaeology";
	CBL[CBT_SKILL_COOK] = "Cooking";
	CBL[CBT_SKILL_FRST] = "First Aid";
	CBL[CBT_SKILL_FISH] = "Fishing";
	--Rogue Only
	CBL[CBT_SKILL_PICK] = "Lockpicking";

	CBL["SKILL_ALL_PROFESSIONS"] = "All Professions";

	CBL["LBL_RED"] = "Red";
	CBL["LBL_ORANGE"] = "Orange";
	CBL["LBL_YELLOW"] = "Yellow";
	CBL["LBL_GREEN"] = "Green";
	CBL["LBL_GREY"] = "Grey";

	CBL["BINDING_TOGGLE_SKILL_FRAME"] = "Toggle Skill Frame";
	CBL["BINDING_OPEN_SKILL_1"] = "Toggle Skill 1 Window";
	CBL["BINDING_OPEN_SKILL_1_BUSTER"] = "Toggle Skill 1 Buster Window";
	CBL["BINDING_OPEN_SKILL_2"] = "Toggle Skill 2 Window";
	CBL["BINDING_OPEN_SKILL_2_BUSTER"] = "Toggle Skill 2 Buster Window";
	CBL["BINDING_OPEN_COOKING"] = "Toggle Cooking Window";
	CBL["BINDING_OPEN_FIRST_AID"] = "Toggle First Aid Window";
	CBL["BINDING_OPEN_ARCHAEOLOGY"] = "Toggle Archaeology Window";
	CBL["BINDING_OPEN_LOCKPICKING_BUSTER"] = "Toggle Lockpicking Buster Window";

	CBL["CONFIG_TITLE_TRACK_PROFESSION"] = "Track Professions";
	CBL["CONFIG_TITLE_TRACK_GATHERING"] = "Gathering Info";
	CBL["CONFIG_TITLE_TOOLTIP_INFO"] = "Display Tooltip Info";
	CBL["CONFIG_TITLE_BUSTER_ICON"] = "Show Buster Icon";
	CBL["CONFIG_TITLE_SHOW_NODES"] = "Show Nodes";
	CBL["CONFIG_TITLE_SHOW_WORLDMAP_PROFESSIONS"] = "Professions in Nodes List";
	CBL["CONFIG_TITLE_SHOW_PROFESSION_GATHERS"] = "Show Profession Gathers";
	CBL["CONFIG_TITLE_OTHER"] = "Other";
	CBL["CONFIG_ALERTS_TAB_TRAINER"] = "Trainer Alerts";
	CBL["CONFIG_ALERTS_TAB_NODES"] = "Node Alerts";
	CBL["CONFIG_SHOW_MINIMAP"] = "Show Minimap Button";
	CBL["CONFIG_SHOW_WORLD_MAP_ICONS"] = "Show World Map Icons";
	CBL["CONFIG_SHOW_MINIMAP_ICONS"] = "Show Minimap Icons";
	CBL["CONFIG_TITLE_TRAINER_MAP_ICONS"] = "Trainer Map Icons";
	CBL["CONFIG_TITLE_STATION_MAP_ICONS"] = "Station Map Icons";
	CBL["CONFIG_MAP_ICON_" .. CBL[CBT_SKILL_BLCK]] = "Anvil";
	CBL["CONFIG_MAP_ICON_" .. CBL[CBT_SKILL_MINE]] = "Forge";
	CBL["CONFIG_MAP_ICON_" .. CBL[CBT_SKILL_TAIL]] = "Tailoring";
	CBL["CONFIG_MAP_ICON_CHECK_ALL"] = "Un/Check All";
	CBL["CONFIG_SHOW_TRACKER"] = "Show Tracker";
	CBL["CONFIG_EXPAND_TRACKER"] = "Expand Tracker";
	CBL["CONFIG_TRACKER_POSITION"] = "Tracker Position";
	CBL["CONFIG_SHOW_WORLDMAP"] = "Show Nodes List";
	CBL["CONFIG_EXPAND_WORLDMAP"] = "Expand Nodes List";
	CBL["CONFIG_SHOW_GATHERER"] = "Show Gatherer";
	CBL["CONFIG_SHOW_ZONE_NODES"] = "Show Zone Nodes";
	CBL["CONFIG_SHOW_SKILLUP_NODES"] = "Show Skill-Up Nodes";
	CBL["CONFIG_EXPAND_GATHERER"] = "Expand Gatherer";
	CBL["CONFIG_AUTOHIDE_GATHERER"] = "Auto-Hide Gatherer";
	CBL["CONFIG_WORLDMAP_POSITION"] = "World Map Nodes List Position";
	CBL["CONFIG_GATHERER_POSITION"] = "Gatherer Position";
	CBL["CONFIG_BUSTER_POSITION"] = "Buster Position";
	CBL["CONFIG_POSITION_X"] = "X:";
	CBL["CONFIG_POSITION_Y"] = "Y:";
	CBL["CONFIG_POSITION_POINT"] = "Point:";
	CBL["CONFIG_POSITION_RELATIVE_POINT"] = "Relative To:";
	CBL["CONFIG_POSITION_SET"] = "SET";
	CBL["CONFIG_POSITIONS_RESET"] = "Reset Positions";

	CBL["MINIMAP_HOVER_LINE1"] = CBG_CLR_WHITE .. "Left button to " .. CBG_CLR_LIGHTGREEN .. "Drag";
	--CBL["MINIMAP_HOVER_LINE2"] = CBG_CLR_WHITE .. "Left-click for " .. CBG_CLR_OFFBLUE .. "Toggle Menu";
	CBL["MINIMAP_HOVER_LINE3"] = CBG_CLR_WHITE .. "Right-click for " .. CBG_CLR_OFFBLUE .. "Config";

	CBL["MAPICON_TITLE_TRAINER"] = CBG_CLR_OFFBLUE .. "Trainer: ";
	CBL["MAPICON_TITLE_STATION"] = CBG_CLR_OFFBLUE .. "Station: ";

	CBL["NODE_MSG"] = CBG_CLR_OFFBLUE .. "Gather Levels: |r";
	CBL["TRAINER_ACTION"] = "Visit your %s trainer to learn %s proficiency";
	CBL["ORANGE_ACTION"] = "%sReaching level %d you can now gather from '%s' nodes.";
	CBL["YELLOW_ACTION"] = "%s'%s' has turned yellow at level %s";
	CBL["GREEN_ACTION"] = "%s'%s' has turned green at level %s";
	CBL["GREY_ACTION"] = "%s'%s' has turned grey at level %s";

	CBL["SKILL_FRAME_VISIT_TRAINER"] = "Visit your %s trainer\nto learn %s proficiency";
	CBL["SKILL_FRAME_LEVEL_UP"] = "At level %s, visit your\n%s trainer to learn\n%s proficiency";

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
	CBL["TRADESKILL_NUMLINES"] = 1;
	CBL["TRADESKILL_LINE1"] = CBG_CLR_WHITE .. "List relevant items in bags";
--end