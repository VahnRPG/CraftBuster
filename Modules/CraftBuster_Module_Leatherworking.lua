local SKILL_ID = CBT_SKILL_LTHR;
local SKILL_NAME = CBL[CBT_SKILL_LTHR];
local SKILL_SHORT_CODE = "lthr";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 2108;		--Leatherworking
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[30] = {		--Elwynn Forest
		["Alliance"] = {
			[1632] = { ["name"] = "Adele Fielder", ["floor"] = 0, ["pos"] = { 46.4, 62 } },
		},
	},
	[41] = {		--Teldrassil
		["Alliance"] = {
			[3605] = { ["name"] = "Nadyia Maneweaver", ["floor"] = 0, ["pos"] = { 43.4, 43.2 } },
		},
	},
	[43] = {		--Ashenvale
		["Alliance"] = {
			[3967] = { ["name"] = "Aayndia Floralwind", ["floor"] = 0, ["pos"] = { 35.8, 52 } },
		},
	},
	[381] = {		--Darnassus
		["Alliance"] = {
			[4212] = { ["name"] = "Telonis", ["floor"] = 0, ["pos"] = { 60.4, 36.4 } },
		},
	},
	[341] = {		--Ironforge
		["Alliance"] = {
			[5127] = { ["name"] = "Fimble Finespindle", ["floor"] = 0, ["pos"] = { 39.4, 32.8 } },
		},
	},
	[301] = {		--Stormwind City
		["Alliance"] = {
			[5564] = { ["name"] = "Simon Tanner", ["floor"] = 0, ["pos"] = { 71.8, 62.8 } },
		},
	},
	[26] = {		--The Hinterlands
		["Alliance"] = {
			[11097] = { ["name"] = "Drakk Stonehand", ["floor"] = 0, ["pos"] = { 13.4, 43.4 } },
		},
	},
	[471] = {		--The Exodar
		["Alliance"] = {
			[16728] = { ["name"] = "Akham", ["floor"] = 0, ["pos"] = { 67.2, 74.2 } },
		},
	},
	[464] = {		--Azuremyst Isle
		["Alliance"] = {
			[17442] = { ["name"] = "Moordo", ["floor"] = 0, ["pos"] = { 44.8, 23.8 } },
		},
	},
	[465] = {		--Hellfire Peninsula
		["Alliance"] = {
			[18771] = { ["name"] = "Brumman", ["floor"] = 0, ["pos"] = { 54, 64 } },
		},
		["Horde"] = {
			[18754] = { ["name"] = "Barim Spilthoof", ["floor"] = 0, ["pos"] = { 56.2, 38.4 } },
		},
	},
	[491] = {		--Howling Fjord
		["Alliance"] = {
			[26911] = { ["name"] = "Bernadette Dexter", ["floor"] = 0, ["pos"] = { 59.8, 63.4 } },
		},
	},
	[486] = {		--Borean Tundra
		["Alliance"] = {
			[26998] = { ["name"] = "Rosemary Bovard", ["floor"] = 0, ["pos"] = { 57.4, 71.8 } },
		},
		["Horde"] = {
			[26996] = { ["name"] = "Awan Iceborn", ["floor"] = 0, ["pos"] = { 76.2, 37 } },
		},
	},
	[141] = {		--Dustwallow Marsh
		["Alliance"] = {
			[53436] = { ["name"] = "Eustace Tanwell", ["floor"] = 0, ["pos"] = { 66.4, 45.2 } },
		},
	},
	[37] = {		--Northern Stranglethorn
		["Horde"] = {
			[1385] = { ["name"] = "Brawn", ["floor"] = 0, ["pos"] = { 37.8, 50.4 } },
			[7871] = { ["name"] = "Se\'Jib", ["floor"] = 0, ["pos"] = { 45.2, 58.6 } },
		},
	},
	[362] = {		--Thunder Bluff
		["Horde"] = {
			[3007] = { ["name"] = "Una", ["floor"] = 0, ["pos"] = { 41.8, 42.8 } },
		},
	},
	[9] = {		--Mulgore
		["Horde"] = {
			[3069] = { ["name"] = "Chaw Stronghide", ["floor"] = 0, ["pos"] = { 45.6, 57.4 } },
		},
	},
	[321] = {		--Orgrimmar
		["Horde"] = {
			[3365] = { ["name"] = "Karolek", ["floor"] = 1, ["pos"] = { 60.8, 54.8 } },
		},
	},
	[20] = {		--Tirisfal Glades
		["Horde"] = {
			[3549] = { ["name"] = "Shelene Rhobart", ["floor"] = 0, ["pos"] = { 65.4, 60 } },
		},
	},
	[382] = {		--Undercity
		["Horde"] = {
			[4588] = { ["name"] = "Arthur Moore", ["floor"] = 0, ["pos"] = { 70.4, 57.8 } },
		},
	},
	[16] = {		--Arathi Highlands
		["Horde"] = {
			[7869] = { ["name"] = "Brumn Winterhoof", ["floor"] = 0, ["pos"] = { 21.8, 46.2 } },
		},
	},
	[101] = {		--Desolace
		["Horde"] = {
			[8153] = { ["name"] = "Narv Hidecrafter", ["floor"] = 0, ["pos"] = { 55.2, 56.2 } },
		},
	},
	[121] = {		--Feralas
		["Horde"] = {
			[11098] = { ["name"] = "Hahrana Ironhide", ["floor"] = 0, ["pos"] = { 74.4, 43 } },
		},
	},
	[462] = {		--Eversong Woods
		["Horde"] = {
			[16278] = { ["name"] = "Sathein", ["floor"] = 0, ["pos"] = { 53.6, 51.2 } },
		},
	},
	[480] = {		--Silvermoon City
		["Horde"] = {
			[16688] = { ["name"] = "Lynalis", ["floor"] = 0, ["pos"] = { 84.4, 79.8 } },
		},
	},
	[475] = {		--Blade's Edge Mountains
		["Horde"] = {
			[21087] = { ["name"] = "Grikka", ["floor"] = 0, ["pos"] = { 76.8, 65.4 } },
		},
	},
	[481] = {		--Shattrath City
		["Neutral"] = {
			[19187] = { ["name"] = "Darmari", ["floor"] = 0, ["pos"] = { 66.4, 66.4 } },
			[33635] = { ["name"] = "Daenril", ["floor"] = 0, ["pos"] = { 41.6, 63.2 } },
			[33681] = { ["name"] = "Korim", ["floor"] = 0, ["pos"] = { 37.4, 27.4 } },
		},
	},
	[504] = {		--Dalaran
		["Neutral"] = {
			[28700] = { ["name"] = "Diane Cannings", ["floor"] = 1, ["pos"] = { 35, 28.6 } },
			[29507] = { ["name"] = "Manfred Staller", ["floor"] = 1, ["pos"] = { 34.2, 29.2 } },
			[29508] = { ["name"] = "Andellion", ["floor"] = 1, ["pos"] = { 34.2, 27.4 } },
			[29509] = { ["name"] = "Namha Moonwater", ["floor"] = 1, ["pos"] = { 36.2, 28.6 } },
		},
	},
	[492] = {		--Icecrown
		["Neutral"] = {
			[33581] = { ["name"] = "Kul\'de", ["floor"] = 0, ["pos"] = { 71.8, 20.8 } },
		},
	},
	[809] = {		--Kun-Lai Summit
		["Neutral"] = {
			[65121] = { ["name"] = "Clean Pelt", ["floor"] = 0, ["pos"] = { 64.6, 60.8 } },
			[66354] = { ["name"] = "Master Cannon", ["floor"] = 0, ["pos"] = { 50.6, 42 } },
		},
	},
};

local function CraftBuster_Module_Leatherworking_HandleAction(skill_data)
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

local function CraftBuster_Module_Leatherworking_DisplayActions(display_frame)
	CraftBuster_Module_BuildActionDisplay(display_frame, SKILL_ID, SKILL_ACTIONS, SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
end

local function CraftBuster_Module_Leatherworking_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_Leatherworking_HandleAction,
		display_action_function = CraftBuster_Module_Leatherworking_DisplayActions,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Leatherworking_OnLoad();