local SKILL_ID = CBT_SKILL_TAIL;
local SKILL_NAME = CBL[CBT_SKILL_TAIL];
local SKILL_SHORT_CODE = "tail";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 3908;		--Tailoring
local SKILL_ACTIONS = {};
local SKILL_STATION_MAP_ICONS = {
	[807] = {		--Valley of the Four Winds
			["Neutral"] = {
					["The Silken Fields"] = { ["name"] = "The Silken Fields", ["floor"] = 0, ["pos"] = { 61, 57.9 } },
			},
	},
};
local SKILL_TRAINER_MAP_ICONS = {
	[30] = {		--Elwynn Forest
			["Alliance"] = {
				[1103] = { ["name"] = "Eldrin", ["floor"] = 0, ["pos"] = { 79.2, 69 } },
			},
	},
	[301] = {		--Stormwind City
			["Alliance"] = {
				[1346] = { ["name"] = "Georgio Bolero", ["floor"] = 0, ["pos"] = { 53.2, 81.4 } },
				[9584] = { ["name"] = "Jalane Ayrole", ["floor"] = 0, ["pos"] = { 40.2, 84.4 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[4159] = { ["name"] = "Me\'lynn", ["floor"] = 0, ["pos"] = { 59.4, 37.4 } },
			},
	},
	[341] = {		--Ironforge
			["Alliance"] = {
				[5153] = { ["name"] = "Jormund Stonebrow", ["floor"] = 0, ["pos"] = { 43.8, 28.8 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[11052] = { ["name"] = "Timothy Worthington", ["floor"] = 0, ["pos"] = { 66.2, 51.6 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[16729] = { ["name"] = "Refik", ["floor"] = 0, ["pos"] = { 64.2, 68.4 } },
			},
	},
	[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17487] = { ["name"] = "Erin Kelly", ["floor"] = 0, ["pos"] = { 46.4, 70.4 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18772] = { ["name"] = "Hama", ["floor"] = 0, ["pos"] = { 54.6, 63.6 } },
			},
			["Horde"] = {
				[18749] = { ["name"] = "Dalinna", ["floor"] = 0, ["pos"] = { 56.6, 37.2 } },
			},
	},
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[26914] = { ["name"] = "Benjamin Clegg", ["floor"] = 0, ["pos"] = { 58.6, 62.6 } },
			},
			["Horde"] = {
				[26964] = { ["name"] = "Alexandra McQueen", ["floor"] = 0, ["pos"] = { 79.4, 30.6 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[27001] = { ["name"] = "Darin Goodstitch", ["floor"] = 0, ["pos"] = { 57.4, 72.2 } },
			},
			["Horde"] = {
				[26969] = { ["name"] = "Raenah", ["floor"] = 0, ["pos"] = { 41.4, 53.4 } },
			},
	},
	[42] = {		--Darkshore
			["Alliance"] = {
				[43428] = { ["name"] = "Faeyrin Willowmoon", ["floor"] = 0, ["pos"] = { 50.6, 20.8 } },
			},
	},
	[24] = {		--Hillsbrad Foothills
			["Horde"] = {
				[2399] = { ["name"] = "Daryl Stack", ["floor"] = 0, ["pos"] = { 58, 47.8 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[3004] = { ["name"] = "Tepa", ["floor"] = 0, ["pos"] = { 44, 45 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[3363] = { ["name"] = "Magar", ["floor"] = 1, ["pos"] = { 60.6, 59 } },
				[44783] = { ["name"] = "Hiwahi Three-Feathers", ["floor"] = 1, ["pos"] = { 38.8, 50.2 } },
				[45559] = { ["name"] = "Nivi Weavewell", ["floor"] = 1, ["pos"] = { 41, 79.4 } },
			},
	},
	[11] = {		--Northern Barrens
			["Horde"] = {
				[3484] = { ["name"] = "Kil\'hala", ["floor"] = 0, ["pos"] = { 49.8, 61.2 } },
			},
	},
	[20] = {		--Tirisfal Glades
			["Horde"] = {
				[3523] = { ["name"] = "Bowen Brisboise", ["floor"] = 0, ["pos"] = { 52.4, 55.6 } },
			},
	},
	[607] = {		--Southern Barrens
			["Horde"] = {
				[3704] = { ["name"] = "Mahani", ["floor"] = 0, ["pos"] = { 41.4, 47 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[4576] = { ["name"] = "Josef Gregorian", ["floor"] = 0, ["pos"] = { 70.4, 29.4 } },
				[4578] = { ["name"] = "Josephine Lister", ["floor"] = 0, ["pos"] = { 86.4, 22.2 } },
			},
	},
	[462] = {		--Eversong Woods
			["Horde"] = {
				[16366] = { ["name"] = "Sempstress Ambershine", ["floor"] = 0, ["pos"] = { 37.4, 71.8 } },
			},
	},
	[480] = {		--Silvermoon City
			["Horde"] = {
				[16640] = { ["name"] = "Keelen Sheets", ["floor"] = 0, ["pos"] = { 57, 51 } },
			},
	},
	[673] = {		--The Cape of Stranglethorn
			["Neutral"] = {
				[2627] = { ["name"] = "Grarnik Goodstitch", ["floor"] = 0, ["pos"] = { 43.4, 73 } },
			},
	},
	[182] = {		--Felwood
			["Neutral"] = {
				[11557] = { ["name"] = "Meilosh", ["floor"] = 0, ["pos"] = { 64.8, 5.2 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[28699] = { ["name"] = "Charles Worth", ["floor"] = 1, ["pos"] = { 74.8, 84.8 } },
			},
	},
	[492] = {		--Icecrown
			["Neutral"] = {
				[33580] = { ["name"] = "Dustin Vail", ["floor"] = 0, ["pos"] = { 73, 20.8 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[33636] = { ["name"] = "Miralisse", ["floor"] = 0, ["pos"] = { 41.4, 63.4 } },
				[33684] = { ["name"] = "Weaver Aoa", ["floor"] = 0, ["pos"] = { 37.4, 27.2 } },
			},
	},
	[807] = {		--Valley of the Four Winds
			["Neutral"] = {
				[57405] = { ["name"] = "Silkmaster Tsai", ["floor"] = 0, ["pos"] = { 62.6, 59.6 } },
			},
	},
};

local function CraftBuster_Module_Tailoring_HandleAction(skill_data)
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

local function CraftBuster_Module_Tailoring_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		station_map_icons = SKILL_STATION_MAP_ICONS,
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_Tailoring_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Tailoring_OnLoad();