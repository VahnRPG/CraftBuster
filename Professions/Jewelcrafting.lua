local _, cb = ...;

local JEWL_ORES = {
	--vanilla
	[2770] = "Copper Ore",
	[2771] = "Tin Ore",
	[2772] = "Iron Ore",
	[3858] = "Mithril Ore",
	[10620] = "Thorium Ore",

	--tbc
	[23424] = "Fel Iron Ore",
	[23425] = "Adamantite Ore",

	--wotlk
	[36909] = "Cobalt Ore",
	[36912] = "Saronite Ore",
	[36910] = "Titanium Ore",

	--cata
	[53038] = "Obsidium Ore",
	[52185] = "Elementium Ore",
	[52183] = "Pyrite Ore",

	--mists
	[72092] = "Ghost Iron Ore",
	[72093] = "Kyparite",
	[72094] = "Black Trillium Ore",
	[72103] = "White Trillium Ore",
};

local SKILL_ID = CBT_SKILL_JEWL;
local SKILL_SHORT_CODE = "jewl";
local profession_data = {
	["id"] = SKILL_ID,
	["name"] = CBL[SKILL_ID],
	["short_code"] = SKILL_SHORT_CODE,
	["type"] = CBG_SKILL_NORMAL,
	["spell_1"] = 25229,		--Jewelcrafting
	["spell_2"] = 31252,		--Prospecting
	["spell_buster"] = 31252,
	["bustable_function"] = function()
		local results = {};
		for bag=0, 4 do
			for slot=1, GetContainerNumSlots(bag) do
				local item_id = GetContainerItemID(bag, slot);
				if (item_id and JEWL_ORES[item_id]) then
					item_id = tonumber(item_id);
					if (not results[item_id]) then
						results[item_id] = {};
						results[item_id].item_id = item_id;
						results[item_id].total = 0;
					end
					local _,item_count = GetContainerItemInfo(bag,slot);
					results[item_id].total = results[item_id].total + item_count;
				end
			end
		end

		return results;
	end,
	["trainer_map_icons"] = {
		[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[5388] = { ["name"] = "Ingo Woolybush", ["floor"] = 0, ["pos"] = { 66.2, 45.2 } },
			},
		},
		[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18774] = { ["name"] = "Tatiana", ["floor"] = 0, ["pos"] = { 54.6, 63.4 } },
			},
			["Horde"] = {
				[18751] = { ["name"] = "Kalaen", ["floor"] = 0, ["pos"] = { 56.8, 37.6 } },
			},
		},
		[471] = {		--The Exodar
			["Alliance"] = {
				[19778] = { ["name"] = "Farii", ["floor"] = 0, ["pos"] = { 44.6, 24.4 } },
			},
		},
		[491] = {		--Howling Fjord
			["Alliance"] = {
				[26915] = { ["name"] = "Ounhulo", ["floor"] = 0, ["pos"] = { 59.8, 63.8 } },
			},
			["Horde"] = {
				[26960] = { ["name"] = "Carter Tiffens", ["floor"] = 0, ["pos"] = { 79.2, 28.8 } },
			},
		},
		[486] = {		--Borean Tundra
			["Alliance"] = {
				[26997] = { ["name"] = "Alestos", ["floor"] = 0, ["pos"] = { 57.4, 72.2 } },
			},
			["Horde"] = {
				[26982] = { ["name"] = "Geba\'li", ["floor"] = 0, ["pos"] = { 41.4, 53.4 } },
			},
		},
		[301] = {		--Stormwind City
			["Alliance"] = {
				[44582] = { ["name"] = "Theresa Denman", ["floor"] = 0, ["pos"] = { 63.4, 61.4 } },
			},
		},
		[341] = {		--Ironforge
			["Alliance"] = {
				[52586] = { ["name"] = "Hanner Gembold", ["floor"] = 0, ["pos"] = { 50.4, 26 } },
			},
		},
		[381] = {		--Darnassus
			["Alliance"] = {
				[52645] = { ["name"] = "Aessa Silverdew", ["floor"] = 0, ["pos"] = { 54, 31 } },
			},
		},
		[462] = {		--Eversong Woods
			["Horde"] = {
				[15501] = { ["name"] = "Aleinia", ["floor"] = 0, ["pos"] = { 48.4, 47.4 } },
			},
		},
		[480] = {		--Silvermoon City
			["Horde"] = {
				[19775] = { ["name"] = "Kalinda", ["floor"] = 0, ["pos"] = { 90.4, 74 } },
			},
		},
		[321] = {		--Orgrimmar
			["Horde"] = {
				[46675] = { ["name"] = "Lugrah", ["floor"] = 1, ["pos"] = { 72.4, 34.4 } },
			},
		},
		[382] = {		--Undercity
			["Horde"] = {
				[52587] = { ["name"] = "Neller Fayne", ["floor"] = 0, ["pos"] = { 55.8, 36 } },
			},
		},
		[362] = {		--Thunder Bluff
			["Horde"] = {
				[52657] = { ["name"] = "Nahari Cloudchaser", ["floor"] = 0, ["pos"] = { 35, 53.8 } },
			},
		},
		[481] = {		--Shattrath City
			["Neutral"] = {
				[19063] = { ["name"] = "Hamanar", ["floor"] = 0, ["pos"] = { 35.8, 20.4 } },
				[33637] = { ["name"] = "Kirembri Silvermane", ["floor"] = 0, ["pos"] = { 57.8, 75 } },
				[33680] = { ["name"] = "Nemiha", ["floor"] = 0, ["pos"] = { 36, 47 } },
			},
		},
		[479] = {		--Netherstorm
			["Neutral"] = {
				[19539] = { ["name"] = "Jazdalaad", ["floor"] = 0, ["pos"] = { 44.4, 34 } },
			},
		},
		[504] = {		--Dalaran
			["Neutral"] = {
				[28701] = { ["name"] = "Timothy Jones", ["floor"] = 1, ["pos"] = { 40.4, 35 } },
			},
		},
		[492] = {		--Icecrown
			["Neutral"] = {
				[33590] = { ["name"] = "Oluros", ["floor"] = 0, ["pos"] = { 71.4, 20.8 } },
			},
		},
		[806] = {		--The Jade Forest
			["Neutral"] = {
				[65098] = { ["name"] = "Mai the Jade Shaper", ["floor"] = 0, ["pos"] = { 48, 35 } },
			},
		},
	},
};
cb.professions:registerModule(profession_data);