local SKILL_NAME = CBL["SKILL_MINE"];
local SKILL_SHORT_CODE = "mine";
local SKILL_TYPE = CBG_SKILL_GATHER;
local SKILL_ID = CBT_SKILL_MINE;
local SKILL_SPELL_1ID = 2656;		--Smelting
local SKILL_ACTIONS = {};

local SKILL_NODES = {
	--vanilla
	["Copper Vein"] = {
		["rank"] = 0,
		["item_id"] = 2770, --Copper Ore
		["ply_level"] = 1,
		["node_levels"] = { 1, 25, 50, 100 },
		["zones"] = {
			"Darkshore", "Durotar", "Azshara", "Northern Barrens",
			"Elwynn Forest", "Tirisfal Glades", "Dun Morogh", "Eversong Woods",
			"Loch Modan", "Gilneas", "Mulgore", "The Lost Isles",
			"Redridge Mountains", "Azuremyst Isle", "Bloodmyst Isle", "Westfall",
			"Ghostlands", "Silverpine Forest", "Duskwood",
			"Gilneas City", "The Wandering Isle", "The Deadmines", "Stonetalon Mountains",
			"Wetlands", "Ashenvale", "Wailing Caverns", "Southern Barrens",
			"Badlands", "Thousand Needles",
		},
	},
	["Tin Vein"] = {
		["rank"] = 1,
		["item_id"]  = 2771, --Tin Ore
		["ply_level"] = 1,
		["node_levels"] = { 50, 75, 100, 150 },
		["zones"] = {
			"Ashenvale", "Hillsbrad Foothills", "Northern Stranglethorn", "Stonetalon Mountains",
			"Redridge Mountains", "Duskwood", "Wetlands", "Loch Modan",
			"Arathi Highlands", "Silverpine Forest", "Bloodmyst Isle", "Ghostlands",
			"Darkshore", "The Deadmines", "The Hinterlands", "Blackfathom Deeps",
			"Dustwallow Marsh", "Northern Barrens", "Azshara", "Wailing Caverns",
			"Badlands",
		},
	},
	["Silver Vein"] = {
		["rank"] = 2,
		["item_id"] = 2775, --Silver Ore
		["ply_level"] = 1,
		["node_levels"] = { 65, 85, 110, 160 },
		["zones"] = {
			"Northern Stranglethorn", "Feralas", "Hillsbrad Foothills", "Stonetalon Mountains",
			"The Cape of Stranglethorn", "Arathi Highlands", "Southern Barrens", "Desolace",
			"Redridge Mountains", "Wetlands", "Duskwood", "Loch Modan",
			"Silverpine Forest", "The Hinterlands", "Thousand Needles", "Darkshore",
			"Northern Barrens", "The Deadmines", "Dustwallow Marsh", "Bloodmyst Isle",
			"Ghostlands",
		},
	},
	--[[
	["Ooze Covered Silver Vein"] = {
		["rank"] = 3,
		["item_id"] = 2775, --Silver Ore
		["ply_level"] = 1,
		["node_levels"] = { 75, 100, 125, 175 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Iron Deposit"] = {
		["rank"] = 4,
		["item_id"] = 2772, --Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 100, 125, 150, 200 },
		["zones"] = {
			"Feralas", "Desolace", "Western Plaguelands", "Eastern Plaguelands",
			"The Cape of Stranglethorn", "Southern Barrens", "Arathi Highlands", "Thousand Needles",
			"Northern Stranglethorn", "The Hinterlands", "Duskwood", "Dustwallow Marsh",
			"Wetlands", "Razorfen Kraul", "Uldaman", "Badlands",
		},
	},
	["Gold Vein"] = {
		["rank"] = 5,
		["item_id"] = 2776, --Gold Ore
		["ply_level"] = 1,
		["node_levels"] = { 115, 130, 165, 215 },
		["zones"] = {
			"Felwood", "Western Plaguelands", "Feralas", "Eastern Plaguelands",
			"Burning Steppes", "Badlands", "Southern Barrens", "Tanaris",
			"The Cape of Stranglethorn", "Thousand Needles", "Searing Gorge", "Northern Stranglethorn",
			"Desolace", "Un'Goro Crater", "Arathi Highlands", "Duskwood",
		},
	},
	--[[
	["Ooze Covered Gold Vein"] = {
		["rank"] = 6,
		["item_id"] = 2776, --Gold Ore
		["ply_level"] = 1,
		["node_levels"] = { 115, 130, 165, 215 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Mithril Deposit"] = {
		["rank"] = 7,
		["item_id"] = 3858, --Mithril Ore
		["ply_level"] = 1,
		["node_levels"] = { 150, 175, 200, 250 },
		["zones"] = {
			"Thousand Needles", "Badlands", "Burning Steppes", "Searing Gorge",
			"Felwood", "Eastern Plaguelands", "Tanaris", "Arathi Highlands",
			"Dustwallow Marsh", "Un'Goro Crater", "Feralas", "Maraudon",
			"Uldaman",
		},
	},
	["Ooze Covered Mithril Deposit"] = {
		["rank"] = 8,
		["item_id"] = 3858, --Mithril Ore
		["ply_level"] = 1,
		["node_levels"] = { 150, 175, 200, 250 },
		["zones"] = {
			"Thousand Needles", "Feralas",
		},
	},
	["Truesilver Deposit"] = {
		["rank"] = 9,
		["item_id"] = 7911, --Truesilver Ore
		["ply_level"] = 1,
		["node_levels"] = { 165, 190, 215, 265 },
		["zones"] = {
			"Winterspring", "Burning Steppes", "Felwood", "Thousand Needles",
			"Badlands", "Silithus", "Searing Gorge", "Blasted Lands",
			"Eastern Plaguelands", "Swamp of Sorrows", "Tanaris", "Un'Goro Crater",
			"Feralas", "Dustwallow Marsh", "Arathi Highlands", "The Hinterlands",
		},
	},
	["Ooze Covered Truesilver Deposit"] = {
		["rank"] = 10,
		["item_id"] = 7911, --Truesilver Ore
		["ply_level"] = 1,
		["node_levels"] = { 165, 190, 215, 265 },
		["zones"] = {
			"Un'Goro Crater", "Silithus",
		},
	},
	["Dark Iron Deposit"] = {
		["rank"] = 11,
		["item_id"] = 11370, --Dark Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 175, 255, 280, 330 },
		["zones"] = {
			"Molten Core", "Blackrock Depths",
		},
	},
	["Small Thorium Vein"] = {
		["rank"] = 12,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 200, 225, 250, 300 },
		["zones"] = {
			"Winterspring", "Silithus", "Un'Goro Crater", "Swamp of Sorrows",
			"Blasted Lands",
		},
	},
	["Ooze Covered Thorium Vein"] = {
		["rank"] = 13,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 215, 240, 265, 315 },
		["zones"] = {
			"Un'Goro Crater",
		},
	},
	["Rich Thorium Vein"] = {
		["rank"] = 14,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 215, 240, 265, 315 },
		["zones"] = {
			"Winterspring", "Silithus", "Swamp of Sorrows", "Un'Goro Crater",
			"Blasted Lands", "Dire Maul",
		},
	},
	["Ooze Covered Rich Thorium Vein"] = {
		["rank"] = 15,
		["item_id"] = 10620, --Thorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 215, 240, 265, 315 },
		["zones"] = {
			"Silithus",
		},
	},

	--tbc
	["Fel Iron Deposit"] = {
		["rank"] = 16,
		["item_id"] = 23424, --Fel Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 275, 325, 350, 400 },
		["zones"] = {
			"Hellfire Peninsula", "Zangarmarsh", "Blade's Edge Mountains", "Shadowmoon Valley",
			"Terokkar Forest", "Nagrand", "Netherstorm",
		},
	},
	["Adamantite Deposit"] = {
		["rank"] = 17,
		["item_id"] = 23425, --Adamantite Ore
		["ply_level"] = 1,
		["node_levels"] = { 325, 350, 375, 425 },
		["zones"] = {
			"Nagrand", "Blade's Edge Mountains", "Netherstorm", "Shadowmoon Valley",
			"Terokkar Forest", "Zangarmarsh", "Isle of Quel'Danas", "Sethekk Halls",
			"Auchenai Crypts", "Mana-Tombs", "The Slave Pens", "Shadow Labyrinth",
			"The Steamvault",
		},
	},
	["Rich Adamantite Deposit"] = {
		["rank"] = 18,
		["item_id"] = 23425, --Adamantite Ore
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 450 },
		["zones"] = {
			"Nagrand", "Netherstorm", "Shadowmoon Valley", "Terokkar Forest",
			"Isle of Quel'Danas", "Blade's Edge Mountains", "Shadow Labyrinth",
		},
	},
	--[[
	["Nethercite Deposit"] = {
		["rank"] = 19,
		["item_id"] = 32464, --Nethercite Ore
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 390, 400 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Khorium Vein"] = {
		["rank"] = 20,
		["item_id"] = 23426, --Khorium Ore
		["ply_level"] = 1,
		["node_levels"] = { 375, 400, 425, 450 },
		["zones"] = {
			"Nagrand", "Blade's Edge Mountains", "Netherstorm", "Terokkar Forest",
			"Shadowmoon Valley", "Isle of Quel'Danas", "Auchenai Crypts", "Mana-Tombs",
			"Shadow Labyrinth",
		},
	},

	--wotlk
	["Cobalt Deposit"] = {
		["rank"] = 21,
		["item_id"] = 36909, --Cobalt Ore
		["ply_level"] = 1,
		["node_levels"] = { 350, 375, 400, 425 },
		["zones"] = {
			"Zul'Drak", "Howling Fjord", "Borean Tundra", "Dragonblight",
			"Grizzly Hills", "Utgarde Keep", "The Storm Peaks", "Crystalsong Forest",
		},
	},
	["Rich Cobalt Deposit"] = {
		["rank"] = 22,
		["item_id"] = 36909, --Cobalt Ore
		["ply_level"] = 1,
		["node_levels"] = { 375, 400, 425, 450 },
		["zones"] = {
			"Zul'Drak", "Howling Fjord", "Borean Tundra", "Dragonblight",
			"Grizzly Hills", "The Storm Peaks", "Utgarde Keep", "Crystalsong Forest",
		},
	},
	["Saronite Deposit"] = {
		["rank"] = 23,
		["item_id"] = 36912, --Saronite Ore
		["ply_level"] = 1,
		["node_levels"] = { 400, 425, 450, 475 },
		["zones"] = {
			"Icecrown", "Sholazar Basin", "The Storm Peaks", "Wintergrasp",
			"Zul'Drak", "Halls of Stone", "Dragonblight", "Crystalsong Forest",
			"Icecrown Citadel", "Grizzly Hills",
		},
	},
	["Rich Saronite Deposit"] = {
		["rank"] = 24,
		["item_id"] = 36912, --Saronite Ore
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 500 },
		["zones"] = {
			"Icecrown", "Sholazar Basin", "Wintergrasp", "The Storm Peaks",
			"Dragonblight", "Crystalsong Forest",
		},
	},
	--[[
	["Pure Saronite Deposit"] = {
		["rank"] = 25,
		["item_id"] = 36912, --Saronite Ore
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["zones"] = {
			"",
		},
	},
	]]--
	["Titanium Vein"] = {
		["rank"] = 26,
		["item_id"] = 36910, --Titanium Ore
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["zones"] = {
			"Icecrown", "Sholazar Basin", "Wintergrasp", "The Storm Peaks",
			"Dragonblight", "Crystalsong Forest",
		},
	},

	--cata
	["Obsidium Deposit"] = {
		["rank"] = 27,
		["item_id"] = 53038, --Obsidium Ore
		["ply_level"] = 1,
		["node_levels"] = { 425, 450, 475, 500 },
		["zones"] = {
			"Deepholm", "Mount Hyjal", "Abyssal Depths", "Shimmering Expanse",
			"Kelp'thar Forest",
		},
	},
	["Rich Obsidium Deposit"] = {
		["rank"] = 28,
		["item_id"] = 53038, --Obsidium Ore
		["ply_level"] = 1,
		["node_levels"] = { 450, 475, 500, 525 },
		["zones"] = {
			"Deepholm",
		},
	},
	["Elementium Vein"] = {
		["rank"] = 29,
		["item_id"] = 52185, --Elementium Ore
		["ply_level"] = 1,
		["node_levels"] = { 475, 500, 525, 550 },
		["zones"] = {
			"Deepholm", "Twilight Highlands", "Uldum", "Tol Barad Peninsula",
			"Tol Barad",
		},
	},
	["Rich Elementium Vein"] = {
		["rank"] = 30,
		["item_id"] = 52185, --Elementium Ore
		["ply_level"] = 1,
		["node_levels"] = { 500, 515, 525, 550 },
		["zones"] = {
			"Deepholm", "Twilight Highlands", "Uldum", "Tol Barad Peninsula",
			"Tol Barad",
		},
	},
	["Pyrite Deposit"] = {
		["rank"] = 31,
		["item_id"] = 52183, --Pyrite Ore
		["ply_level"] = 1,
		["node_levels"] = { 525, 550, 565, 575 },
		["zones"] = {
			"Twilight Highlands", "Uldum",
		},
	},
	["Rich Pyrite Deposit"] = {
		["rank"] = 32,
		["item_id"] = 52183, --Pyrite Ore
		["ply_level"] = 1,
		["node_levels"] = { 525, 575, 600, 600 },
		["zones"] = {
			"Tol Barad Peninsula", "Tol Barad",
		},
	},

	--mists
	["Ghost Iron Deposit"] = {
		["rank"] = 33,
		["item_id"] = 72092, --Ghost Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 525, 550, 575, 600 },
		["zones"] = {
			"The Jade Forest", "Valley of the Four Winds", "Dread Wastes", "Townlong Steppes",
			"Kun-Lai Summit", "Krasarang Wilds", "Vale of Eternal Blossoms", "Timeless Isle",
			"The Veiled Stair", "Shado-Pan Monastery",
		},
	},
	["Rich Ghost Iron Deposit"] = {
		["rank"] = 34,
		["item_id"] = 72092, --Ghost Iron Ore
		["ply_level"] = 1,
		["node_levels"] = { 550, 575, 600, 600 },
		["zones"] = {
			"The Jade Forest", "Valley of the Four Winds", "Dread Wastes", "Kun-Lai Summit",
			"Townlong Steppes", "Vale of Eternal Blossoms", "Krasarang Wilds", "The Veiled Stair",
			"Timeless Isle",
		},
	},
	["Kyparite Deposit"] = {
		["rank"] = 35,
		["item_id"] = 72093, --Kyparite
		["ply_level"] = 1,
		["node_levels"] = { 550, 575, 600, 600 },
		["zones"] = {
			"Dread Wastes", "Townlong Steppes", "Siege of Niuzao Temple",
		},
	},
	["Rich Kyparite Deposit"] = {
		["rank"] = 36,
		["item_id"] = 72093, --Kyparite
		["ply_level"] = 1,
		["node_levels"] = { 575, 600, 600, 600 },
		["zones"] = {
			"Dread Wastes", "Townlong Steppes",
		},
	},
	["Trillium Vein"] = {
		["rank"] = 37,
		["item_id"] = 72095, --Trillium Bar
		--["item_id"] = 72094, --Black Trillium Ore
		["ply_level"] = 1,
		["node_levels"] = { 600, 600, 600, 600 },
		["zones"] = {
			"Kun-Lai Summit", "Dread Wastes", "Townlong Steppes", "Vale of Eternal Blossoms",
			"Valley of the Four Winds", "The Jade Forest",
		},
	},
	["Rich Trillium Vein"] = {
		["rank"] = 38,
		["item_id"] = 72095, --Trillium Bar
		--["item_id"] = 72103, --White Trillium Ore
		["ply_level"] = 1,
		["node_levels"] = { 600, 600, 600, 600 },
		["zones"] = {
			"Dread Wastes", "Townlong Steppes", "Vale of Eternal Blossoms", "Valley of the Four Winds",
			"The Jade Forest", "Timeless Isle",
		},
	},
};

local function CraftBuster_Module_Mining_BuildActions()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);

	local base_count = CBG_MAX_PROFESSIONS - 1;
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 0), 2, "0", "right") .. SKILL_SHORT_CODE .. "_1_orange"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][1],
			["action"] = CBT_ORANGE,
			["message"] = CraftBuster_Module_TranslateActionText(ORANGE_FONT_COLOR_CODE, node_name, node_data["node_levels"][1]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 1), 2, "0", "right") .. SKILL_SHORT_CODE .. "_2_yellow"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][2],
			["action"] = CBT_YELLOW,
			["message"] = CraftBuster_Module_TranslateActionText(YELLOW_FONT_COLOR_CODE, node_name, node_data["node_levels"][2]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 2), 2, "0", "right") .. SKILL_SHORT_CODE .. "_3_green"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][3],
			["action"] = CBT_GREEN,
			["message"] = CraftBuster_Module_TranslateActionText(GREEN_FONT_COLOR_CODE, node_name, node_data["node_levels"][3]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 3), 2, "0", "right") .. SKILL_SHORT_CODE .. "_4_grey"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["node_levels"][4],
			["action"] = CBT_GREY,
			["message"] = CraftBuster_Module_TranslateActionText(GRAY_FONT_COLOR_CODE, node_name, node_data["node_levels"][4]),
		};
	end
end

local function CraftBuster_Module_Mining_HandleGather(zone_name)
	local skill_level = CraftBuster_GetSkillLevel(SKILL_ID);
	local gather_data = {
		["zones"] = {},
		["skill"] = {},
	};
	
	local found = false;
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		for _,zone in sortedpairs(node_data.zones) do
			if (string.find(zone, zone_name, 1, true) ~= nil) then
				local rank = node_data["rank"];
				gather_data["zones"][rank] = {
					["item_id"] = node_data["item_id"],
					["name"] = node_name,
					["levels"] = node_data["node_levels"],
				};
				found = true;
			end
		end
		
		if (skill_level ~= nil and skill_level < CBG_MAX_PROFESSION_RANK) then
			if (skill_level >= node_data["node_levels"][1] and skill_level < node_data["node_levels"][4]) then
				local rank = node_data["rank"];
				gather_data["skill"][rank] = {
					["item_id"] = node_data["item_id"],
					["name"] = node_name,
					["levels"] = node_data["node_levels"],
				};
				found = true;
			end
		end
	end

	if (CraftBusterOptions[CraftBusterEntry].modules[SKILL_ID].show_gather and found) then
		CraftBuster_GatherFrame_AddGather(gather_data);
	end
end

local function CraftBuster_Module_Mining_HandleNode(line_one, line_two, line_three)
	line_one =  gsub(gsub(line_one, "|c........", ""), "|r", "");
	for node_name, node_data in sortedpairs(SKILL_NODES) do
		if (string.find(line_one, node_name, 1, true) ~= nil and SKILL_NODES[node_name] ~= nil) then
			GameTooltip:AddLine(CBL["NODE_MSG"] .. ORANGE_FONT_COLOR_CODE .. " " .. node_data["node_levels"][1] .. YELLOW_FONT_COLOR_CODE .. " " .. node_data["node_levels"][2] .. GREEN_FONT_COLOR_CODE .. " " .. node_data["node_levels"][3] .. GRAY_FONT_COLOR_CODE .. " " .. node_data["node_levels"][4]);
			GameTooltip:Show();
			return true;
		end
	end

	return false;
end

local function CraftBuster_Module_Mining_HandleAction(skill_data)
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

local function CraftBuster_Module_Mining_OnLoad()
	CraftBuster_Module_Mining_BuildActions();
	local module_options = {
		skill_type = CBG_SKILL_GATHER,
		spell_1 = SKILL_SPELL_1ID,
		tooltip_info = true,
		gather_function = CraftBuster_Module_Mining_HandleGather,
		node_function = CraftBuster_Module_Mining_HandleNode,
		action_function = CraftBuster_Module_Mining_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Mining_OnLoad();

local function CraftBuster_Module_Mining_AddZoneInfo(frame, item_link)
	if (CraftBusterOptions[CraftBusterEntry].modules[SKILL_ID].show_tooltips ~= true) then
		return;
	end

	local _, _, item_string = strfind(item_link, "^|c%x+|H(.+)|h%[.+%]");
	if (item_string) then
		local _, item_id = strsplit(":", item_string);
		if (item_id) then
			item_id = tonumber(item_id);
			local found_item = false;
			local zones = {};
			local found_zones = {};
			local count = 0;
			for node_name, node_data in sortedpairs(SKILL_NODES) do
				if (item_id == node_data["item_id"]) then
					found_item = true;
					for _,zone_name in ipairs(node_data["zones"]) do
						if (found_zones[zone_name] == nil) then
							zones[count] = zone_name;
							found_zones[zone_name] = zone_name;
							count = count + 1;
						end
					end
				end
			end

			if (found_item) then
				count = 0;
				local zone_limit = CraftBusterOptions[CraftBusterEntry].zone_limit;
				local output_txt = CBL["SKILL_MINE_ZONE"];

				local found = false;
				for _,zone_name in pairs(zones) do
					if (found) then
						output_txt = output_txt .. ", ";
					end

					--add some newlines to make it pretty
					local test = output_txt .. zone_name;
					local start_from = 1;
					if (string.find(test, "\n[^\n]*$") ~= nil) then
						start_from = string.find(test, "\n[^\n]*$");
					end
					if (string.len(string.sub(test, start_from)) > 40) then
						output_txt = output_txt .. "\n  ";
					end

					output_txt = output_txt .. zone_name;

					found = true;
					count = count + 1;
					if (tcount(zones) <= 10) then
						--let items with only a few zones to display them all
					elseif (zone_limit > 0 and count >= zone_limit) then
						break;
					end
				end
				
				frame:AddLine(output_txt);
			end
		end
	end
	
	frame:Show();
end

local function HookFrame(frame)
	frame:HookScript("OnTooltipSetItem",
		function(self, ...)
			local item_link = select(2, self:GetItem());
			if (item_link and GetItemInfo(item_link)) then
				CraftBuster_Module_Mining_AddZoneInfo(self, item_link);
			end
		end
	);
end

HookFrame(GameTooltip);
HookFrame(ItemRefTooltip);