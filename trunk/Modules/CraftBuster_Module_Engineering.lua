local SKILL_ID = CBT_SKILL_ENGN;
local SKILL_NAME = CBL[CBT_SKILL_ENGN];
local SKILL_SHORT_CODE = "engn";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 4036;		--Engineering
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[34] = {		--Duskwood
			["Alliance"] = {
				[1676] = { ["name"] = "Finbus Geargrind", ["floor"] = 0, ["pos"] = { 77.4, 48.2 } },
			},
	},
	[27] = {		--Dun Morogh
			["Alliance"] = {
				[1702] = { ["name"] = "Bronk Guzzlegear", ["floor"] = 0, ["pos"] = { 57.2, 48.6 } },
			},
	},
	[35] = {		--Loch Modan
			["Alliance"] = {
				[3290] = { ["name"] = "Deek Fizzlebizz", ["floor"] = 0, ["pos"] = { 42.8, 10 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[4941] = { ["name"] = "Caz Twosprocket", ["floor"] = 0, ["pos"] = { 64.6, 50.4 } },
			},
	},
	[341] = {		--Ironforge
			["Alliance"] = {
				[5174] = { ["name"] = "Springspindle Fizzlegear", ["floor"] = 0, ["pos"] = { 68.4, 44.2 } },
				[7944] = { ["name"] = "Tinkmaster Overspark", ["floor"] = 0, ["pos"] = { 69.8, 49.4 } },
			},
	},
	[301] = {		--Stormwind City
			["Alliance"] = {
				[5518] = { ["name"] = "Lilliam Sparkspindle", ["floor"] = 0, ["pos"] = { 62.4, 31.4 } },
			},
	},
	[42] = {		--Darkshore
			["Alliance"] = {
				[11037] = { ["name"] = "Jenna Lemkenilli", ["floor"] = 0, ["pos"] = { 50.6, 20.6 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[16726] = { ["name"] = "Ockil", ["floor"] = 0, ["pos"] = { 54, 92.2 } },
			},
	},
	[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17222] = { ["name"] = "Artificer Daelo", ["floor"] = 0, ["pos"] = { 48.4, 50.2 } },
			},
	},
	[467] = {		--Zangarmarsh
			["Alliance"] = {
				[17634] = { ["name"] = "K. Lee Smallfry", ["floor"] = 0, ["pos"] = { 68.4, 50 } },
			},
			["Horde"] = {
				[17637] = { ["name"] = "Mack Diver", ["floor"] = 0, ["pos"] = { 34, 50.8 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18775] = { ["name"] = "Lebowski", ["floor"] = 0, ["pos"] = { 55.6, 65.4 } },
			},
			["Horde"] = {
				[18752] = { ["name"] = "Zebig", ["floor"] = 0, ["pos"] = { 54.8, 38.4 } },
			},
	},
	[473] = {		--Shadowmoon Valley
			["Alliance"] = {
				[24868] = { ["name"] = "Niobe Whizzlespark", ["floor"] = 0, ["pos"] = { 36.6, 55 } },
			},
			["Horde"] = {
				[25099] = { ["name"] = "Jonathan Garrett", ["floor"] = 0, ["pos"] = { 29.2, 28.6 } },
			},
	},
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[26907] = { ["name"] = "Tisha Longbridge", ["floor"] = 0, ["pos"] = { 59.6, 64 } },
			},
			["Horde"] = {
				[26955] = { ["name"] = "Jamesina Watterly", ["floor"] = 0, ["pos"] = { 78.4, 30 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[26991] = { ["name"] = "Sock Brightbolt", ["floor"] = 0, ["pos"] = { 57.6, 72.2 } },
			},
			["Horde"] = {
				[25277] = { ["name"] = "Chief Engineer Leveny", ["floor"] = 0, ["pos"] = { 42.6, 53.6 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[52636] = { ["name"] = "Tana Lentner", ["floor"] = 0, ["pos"] = { 49.4, 32.4 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[11017] = { ["name"] = "Roxxik", ["floor"] = 1, ["pos"] = { 56.6, 56.4 } },
				[45545] = { ["name"] = "\"Jack\" Pisarek Slamfix", ["floor"] = 1, ["pos"] = { 36.4, 86.6 } },
			},
	},
	[4] = {		--Durotar
			["Horde"] = {
				[11025] = { ["name"] = "Mukdrak", ["floor"] = 0, ["pos"] = { 52.2, 40.8 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[11031] = { ["name"] = "Franklin Lloyd", ["floor"] = 0, ["pos"] = { 76, 73 } },
			},
	},
	[480] = {		--Silvermoon City
			["Horde"] = {
				[16667] = { ["name"] = "Danwe", ["floor"] = 0, ["pos"] = { 76.4, 40.2 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[52651] = { ["name"] = "Engineer Palehoof", ["floor"] = 0, ["pos"] = { 36.4, 59.4 } },
			},
	},
	[903] = {		--Shrine of Two Moons
			["Horde"] = {
				[64924] = { ["name"] = "Guyo Crystalgear", ["floor"] = 1, ["pos"] = { 60, 42.2 } },
			},
	},
	[11] = {		--Northern Barrens
			["Neutral"] = {
				[3494] = { ["name"] = "Tinkerwiz", ["floor"] = 0, ["pos"] = { 68.4, 69.2 } },
			},
	},
	[673] = {		--The Cape of Stranglethorn
			["Neutral"] = {
				[7406] = { ["name"] = "Oglethorpe Obnoticus", ["floor"] = 0, ["pos"] = { 43, 72 } },
			},
	},
	[161] = {		--Tanaris
			["Neutral"] = {
				[8126] = { ["name"] = "Nixx Sprocketspring", ["floor"] = 0, ["pos"] = { 52.2, 28.2 } },
				[8736] = { ["name"] = "Buzzek Bracketswing", ["floor"] = 0, ["pos"] = { 51.6, 30.2 } },
			},
	},
	[9] = {		--Mulgore
			["Neutral"] = {
				[10993] = { ["name"] = "Twizwick Sprocketgrind", ["floor"] = 0, ["pos"] = { 61.2, 32.4 } },
			},
	},
	[479] = {		--Netherstorm
			["Neutral"] = {
				[19576] = { ["name"] = "Xyrol", ["floor"] = 0, ["pos"] = { 32.4, 66.6 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[28697] = { ["name"] = "Timofey Oshenko", ["floor"] = 1, ["pos"] = { 38.8, 25.4 } },
				[29513] = { ["name"] = "Didi the Wrench", ["floor"] = 1, ["pos"] = { 39.2, 25.6 } },
				[29514] = { ["name"] = "Findle Whistlesteam", ["floor"] = 1, ["pos"] = { 39.2, 25 } },
			},
	},
	[492] = {		--Icecrown
			["Neutral"] = {
				[33586] = { ["name"] = "Binkie Brightgear", ["floor"] = 0, ["pos"] = { 72.2, 20.8 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[33634] = { ["name"] = "Engineer Sinbei", ["floor"] = 0, ["pos"] = { 43.2, 64.8 } },
				[33677] = { ["name"] = "Technician Mihila", ["floor"] = 0, ["pos"] = { 37.6, 31 } },
			},
	},
	[807] = {		--Valley of the Four Winds
			["Neutral"] = {
				[55143] = { ["name"] = "Sally Fizzlefury", ["floor"] = 0, ["pos"] = { 16, 83 } },
			},
	},
};

local function CraftBuster_Module_Engineering_HandleAction(skill_data)
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

local function CraftBuster_Module_Engineering_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		action_function = CraftBuster_Module_Engineering_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Engineering_OnLoad();