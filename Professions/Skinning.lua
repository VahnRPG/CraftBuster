local _, cb = ...;

local SKILL_ID = CBT_SKILL_SKIN;
local SKILL_SHORT_CODE = "skin";
local profession_data = {
	["id"] = SKILL_ID,
	["name"] = CBL[SKILL_ID],
	["short_code"] = SKILL_SHORT_CODE,
	["type"] = CBG_SKILL_GATHER,
	["show_tooltips"] = true,
	["node_function"] = function(line_one, line_two, line_three)
		if (not line_three or line_three ~= "Skinnable") then
			return {};
		end

		local level = UnitLevel("mouseover");
		local level_orange = 1;
		if (level <= 10) then
		elseif (level > 10 and level <= 20) then
			level_orange = 100 - (10 * level);
		elseif (level > 20 and level <= 73) then
			level_orange = 5 * level;
		elseif (level > 73 and level <= 83) then
			level_orange = 5 * level + ((level - 73) * 5);
		elseif (level == 84) then
			level_orange = 470;
		elseif (level == 85) then
			level_orange = 490;
		elseif (level == 86) then
			level_orange = 510;
		elseif (level >= 87) then
			level_orange = level * 5 + 95;
		end

		local node_name =  gsub(gsub(line_one, "|c........", ""), "|r", "");
		local results = {};
		results[node_name] = {
			["rank"] = 0,
			["item_id"] = 2770, --Copper Ore
			["ply_level"] = 1,
			["node_levels"] = {
				[1] = math.min(level_orange, CBG_MAX_PROFESSION_RANK),
				[2] = math.min(level_orange + 50, CBG_MAX_PROFESSION_RANK),
				[3] = math.min(level_orange + 75, CBG_MAX_PROFESSION_RANK),
				[4] = math.min(level_orange + 100, CBG_MAX_PROFESSION_RANK),
			},
			["map_ids"] = { },
		};

		return results;
	end,
	["trainer_map_icons"] = {
		[301] = {		--Stormwind City
			["Alliance"] = {
				[1292] = { ["name"] = "Maris Granger", ["floor"] = 0, ["pos"] = { 72, 62 } },
			},
		},
		[41] = {		--Teldrassil
			["Alliance"] = {
				[6287] = { ["name"] = "Radnaal Maneweaver", ["floor"] = 0, ["pos"] = { 43.6, 43.8 } },
			},
		},
		[341] = {		--Ironforge
			["Alliance"] = {
				[6291] = { ["name"] = "Balthus Stoneflayer", ["floor"] = 0, ["pos"] = { 39.4, 31.8 } },
			},
		},
		[381] = {		--Darnassus
			["Alliance"] = {
				[6292] = { ["name"] = "Eladriel", ["floor"] = 0, ["pos"] = { 60.2, 37 } },
			},
		},
		[36] = {		--Redridge Mountains
			["Alliance"] = {
				[6295] = { ["name"] = "Wilma Ranthal", ["floor"] = 0, ["pos"] = { 78.6, 63.6 } },
			},
		},
		[30] = {		--Elwynn Forest
			["Alliance"] = {
				[6306] = { ["name"] = "Helene Peltskinner", ["floor"] = 0, ["pos"] = { 46.2, 62.2 } },
			},
		},
		[471] = {		--The Exodar
			["Alliance"] = {
				[16763] = { ["name"] = "Remere", ["floor"] = 0, ["pos"] = { 65.4, 74.8 } },
			},
		},
		[464] = {		--Azuremyst Isle
			["Alliance"] = {
				[17441] = { ["name"] = "Gurf", ["floor"] = 0, ["pos"] = { 44.6, 23.4 } },
			},
		},
		[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18777] = { ["name"] = "Jelena Nightsky", ["floor"] = 0, ["pos"] = { 54.4, 63.2 } },
			},
			["Horde"] = {
				[18755] = { ["name"] = "Moorutu", ["floor"] = 0, ["pos"] = { 56.2, 38.4 } },
			},
		},
		[491] = {		--Howling Fjord
			["Alliance"] = {
				[26913] = { ["name"] = "Frederic Burrhus", ["floor"] = 0, ["pos"] = { 59.8, 63.6 } },
			},
		},
		[486] = {		--Borean Tundra
			["Alliance"] = {
				[27000] = { ["name"] = "Trapper Jack", ["floor"] = 0, ["pos"] = { 57.4, 71.8 } },
			},
			["Horde"] = {
				[26986] = { ["name"] = "Tiponi Stormwhisper", ["floor"] = 0, ["pos"] = { 76.2, 37.4 } },
			},
		},
		[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[53437] = { ["name"] = "Humbert Tanwell", ["floor"] = 0, ["pos"] = { 66.4, 45.2 } },
			},
		},
		[806] = {		--The Jade Forest
			["Alliance"] = {
				[67026] = { ["name"] = "Hao of the Stag\'s Horns", ["floor"] = 0, ["pos"] = { 44.8, 85.6 } },
			},
			["Horde"] = {
				[55180] = { ["name"] = "Shademaster Kiryn", ["floor"] = 0, ["pos"] = { 28.2, 22 } },
				[56478] = { ["name"] = "Shademaster Kiryn", ["floor"] = 0, ["pos"] = { 27, 49 } },
				[56841] = { ["name"] = "Shademaster Kiryn", ["floor"] = 0, ["pos"] = { 29, 50.8 } },
				[66981] = { ["name"] = "Trapper Ri", ["floor"] = 0, ["pos"] = { 27.8, 15.4 } },
			},
		},
		[20] = {		--Tirisfal Glades
			["Horde"] = {
				[6289] = { ["name"] = "Rand Rhobart", ["floor"] = 0, ["pos"] = { 65.4, 60 } },
			},
		},
		[9] = {		--Mulgore
			["Horde"] = {
				[6290] = { ["name"] = "Yonn Deepcut", ["floor"] = 0, ["pos"] = { 45.8, 57.4 } },
			},
		},
		[382] = {		--Undercity
			["Horde"] = {
				[7087] = { ["name"] = "Killian Hagey", ["floor"] = 0, ["pos"] = { 70.4, 58.4 } },
			},
		},
		[321] = {		--Orgrimmar
			["Horde"] = {
				[7088] = { ["name"] = "Thuwd", ["floor"] = 1, ["pos"] = { 61, 54.4 } },
				[44782] = { ["name"] = "Rento", ["floor"] = 1, ["pos"] = { 39.4, 49.4 } },
			},
		},
		[362] = {		--Thunder Bluff
			["Horde"] = {
				[7089] = { ["name"] = "Mooranta", ["floor"] = 0, ["pos"] = { 44.4, 42.6 } },
			},
		},
		[121] = {		--Feralas
			["Horde"] = {
				[8144] = { ["name"] = "Kulleg Stonehorn", ["floor"] = 0, ["pos"] = { 74.4, 43 } },
			},
		},
		[101] = {		--Desolace
			["Horde"] = {
				[12030] = { ["name"] = "Malux", ["floor"] = 0, ["pos"] = { 23.2, 69.8 } },
			},
		},
		[462] = {		--Eversong Woods
			["Horde"] = {
				[16273] = { ["name"] = "Mathreyn", ["floor"] = 0, ["pos"] = { 53.8, 51.2 } },
			},
		},
		[480] = {		--Silvermoon City
			["Horde"] = {
				[16692] = { ["name"] = "Tyn", ["floor"] = 0, ["pos"] = { 84.4, 79.2 } },
			},
		},
		[481] = {		--Shattrath City
			["Neutral"] = {
				[19180] = { ["name"] = "Seymour", ["floor"] = 0, ["pos"] = { 63.6, 65.4 } },
				[33641] = { ["name"] = "Irduil", ["floor"] = 0, ["pos"] = { 40.8, 63.4 } },
				[33683] = { ["name"] = "Dremm", ["floor"] = 0, ["pos"] = { 37.4, 27.8 } },
			},
		},
		[504] = {		--Dalaran
			["Neutral"] = {
				[28696] = { ["name"] = "Derik Marks", ["floor"] = 1, ["pos"] = { 35.2, 28.6 } },
			},
		},
		[807] = {		--Valley of the Four Winds
			["Neutral"] = {
				[63825] = { ["name"] = "Mr. Pleeb", ["floor"] = 0, ["pos"] = { 16, 83 } },
			},
		},
	},
};
cb.professions:registerModule(profession_data);