local SKILL_NAME = CBL["SKILL_MINE"];
local SKILL_SHORT_CODE = "mine";
local SKILL_TYPE = CBG_SKILL_GATHER;
local SKILL_ID = CBT_SKILL_MINE;
local SKILL_SPELL_1ID = 2656;		--Smelting
local SKILL_ACTIONS = {};

local SKILL_NODE_LEVELS = {
	["Copper Vein"] = {
		["rank"] = 0,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {1,25,50,100},
	},
	["Tin Vein"] = {
		["rank"] = 1,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {50,75,100,150},
	},
	["Silver Vein"] = {
		["rank"] = 2,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {65,85,110,160},
	},
	["Ooze Covered Silver Vein"] = {
		["rank"] = 3,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {75,100,125,175},
	},
	["Iron Deposit"] = {
		["rank"] = 4,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {100,125,150,200},
	},
	["Gold Vein"] = {
		["rank"] = 5,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {115,130,165,215},
	},
	["Ooze Covered Gold Vein"] = {
		["rank"] = 6,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {115,130,165,215},
	},
	["Mithril Deposit"] = {
		["rank"] = 7,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {150,175,200,250},
	},
	["Ooze Covered Mithril Deposit"] = {
		["rank"] = 8,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {150,175,200,250},
	},
	["Truesilver Deposit"] = {
		["rank"] = 9,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {165,190,215,265},
	},
	["Ooze Covered Truesilver Deposit"] = {
		["rank"] = 10,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {165,190,215,265},
	},
	["Dark Iron Deposit"] = {
		["rank"] = 11,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {175,255,280,330},
	},
	["Small Thorium Vein"] = {
		["rank"] = 12,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {200,225,250,300},
	},
	["Rich Thorium Vein"] = {
		["rank"] = 13,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {215,240,265,315},
	},
	["Fel Iron Deposit"] = {
		["rank"] = 14,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {275,325,350,400},
	},
	["Adamantite Deposit"] = {
		["rank"] = 15,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {325,350,375,425},
	},
	["Rich Adamantite Deposit"] = {
		["rank"] = 16,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {350,375,400,450},
	},
	["Nethercite Deposit"] = {
		["rank"] = 17,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {350,375,390,400},
	},
	["Cobalt Deposit"] = {
		["rank"] = 18,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {350,375,400,425},
	},
	["Khorium Vein"] = {
		["rank"] = 19,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {375,400,425,""},
	},
	["Rich Cobalt Deposit"] = {
		["rank"] = 20,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {375,400,425,450},
	},
	["Saronite Deposit"] = {
		["rank"] = 21,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {400,425,450,""},
	},
	["Rich Saronite Deposit"] = {
		["rank"] = 22,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {425,450,"",""},
	},
	["Obsidium Deposit"] = {
		["rank"] = 23,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {425,450,475,""},
	},
	["Rich Obsidium Deposit"] = {
		["rank"] = 24,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {450,475,500,""},
	},
	["Pure Saronite Deposit"] = {
		["rank"] = 25,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {450,"","",""},
	},
	["Titanium Vein"] = {
		["rank"] = 26,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {450,"","",""},
	},
	["Elementium Vein"] = {
		["rank"] = 27,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {475,500,525,""},
	},
	["Rich Elementium Vein"] = {
		["rank"] = 28,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {500,525,"",""},
	},
	["Pyrite Deposit"] = {
		["rank"] = 29,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {525,"","",""},
	},
	["Rich Pyrite Deposit"] = {
		["rank"] = 30,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {525,"","",""},
	},
	["Ghost Iron Deposit"] = {
		["rank"] = 31,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {525,550,575,600},
	},
	["Rich Ghost Iron Deposit"] = {
		["rank"] = 32,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {550,575,600,""},
	},
	["Kyparite Deposit"] = {
		["rank"] = 33,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {550,575,600,""},
	},
	["Rich Kyparite Deposit"] = {
		["rank"] = 34,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {575,600,"",""},
	},
	["Trillium Deposit"] = {
		["rank"] = 35,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {600,"","",""},
	},
	["Rich Trillium Deposit"] = {
		["rank"] = 36,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {600,"","",""},
	},
};

local SKILL_NODES = {
	--vanilla
	["Copper Vein"] = 2770, --Copper Ore
	["Tin Vein"] = 2771, --Tin Ore
	["Silver Vein"] = 2775, --Silver Ore
	["Ooze Covered Silver Vein"] = 2775, --Silver Ore
	["Iron Deposit"] = 2772, --Iron Ore
	["Gold Vein"] = 2776, --Gold Ore
	["Ooze Covered Gold Vein"] = 2776, --Gold Ore
	["Mithril Deposit"] = 3858, --Mithril Ore
	["Ooze Covered Mithril Deposit"] = 3858, --Mithril Ore
	["Truesilver Deposit"] = 7911, --Truesilver Ore
	["Ooze Covered Truesilver Deposit"] = 7911, --Truesilver Ore
	["Dark Iron Deposit"] = 11370, --Dark Iron Ore
	["Small Thorium Vein"] = 10620, --Thorium Ore
	["Ooze Covered Thorium Vein"] = 10620, --Thorium Ore
	["Rich Thorium Vein"] = 10620, --Thorium Ore
	["Ooze Covered Rich Thorium Vein"] = 10620, --Thorium Ore

	--tbc
	["Fel Iron Deposit"] = 23424, --Fel Iron Ore
	["Adamantite Deposit"] = 23425, --Adamantite Ore
	["Rich Adamantite Deposit"] = 23425, --Adamantite Ore
	["Khorium Vein"] = 23426, --Khorium Ore
	["Nethercite Deposit"] = 32464, --Nethercite Ore
	
	--wotlk
	["Cobalt Deposit"] = 36909, --Cobalt Ore
	["Rich Cobalt Deposit"] = 36909, --Cobalt Ore
	["Saronite Deposit"] = 36912, --Saronite Ore
	["Rich Saronite Deposit"] = 36912, --Saronite Ore
	["Titanium Vein"] = 36910, --Titanium Ore

	--cata
	["Obsidium Deposit"] = 53038, --Obsidium Ore
	["Rich Obsidium Deposit"] = 53038, --Obsidium Ore
	["Elementium Vein"] = 52185, --Elementium Ore
	["Rich Elementium Vein"] = 52185, --Elementium Ore
	["Pyrite Deposit"] = 52183, --Pyrite Ore
	["Rich Pyrite Deposit"] = 52183, --Pyrite Ore

	--mists
	["Ghost Iron Deposit"] = 72092, --Ghost Iron Ore
	["Rich Ghost Iron Deposit"] = 72092, --Ghost Iron Ore
	["Kyparite Deposit"] = 72093, --Kyparite
	["Rich Kyparite Deposit"] = 72093, --Kyparite
	["Trillium Deposit"] = 72094, --Black Trillium Ore
	["Rich Trillium Deposit"] = 72103, --White Trillium Ore
};

local function CraftBuster_Module_Mining_BuildActions()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);

	local base_count = CBG_MAX_PROFESSIONS - 1;
	for node_name, node_data in sortedpairs(SKILL_NODE_LEVELS) do
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 0), 2, "0", "right") .. SKILL_SHORT_CODE .. "_1_orange"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["SKILL_NODE_LEVELS"][1],
			["action"] = CBT_ORANGE,
			["message"] = CraftBuster_Module_TranslateActionText(ORANGE_FONT_COLOR_CODE, node_name, node_data["SKILL_NODE_LEVELS"][1]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 1), 2, "0", "right") .. SKILL_SHORT_CODE .. "_2_yellow"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["SKILL_NODE_LEVELS"][2],
			["action"] = CBT_YELLOW,
			["message"] = CraftBuster_Module_TranslateActionText(YELLOW_FONT_COLOR_CODE, node_name, node_data["SKILL_NODE_LEVELS"][2]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 2), 2, "0", "right") .. SKILL_SHORT_CODE .. "_3_green"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["SKILL_NODE_LEVELS"][3],
			["action"] = CBT_GREEN,
			["message"] = CraftBuster_Module_TranslateActionText(GREEN_FONT_COLOR_CODE, node_name, node_data["SKILL_NODE_LEVELS"][3]),
		};
		SKILL_ACTIONS[str_pad((base_count + node_data["rank"] + 3), 2, "0", "right") .. SKILL_SHORT_CODE .. "_4_grey"] = {
			["ply_level"] = node_data["ply_level"],
			["skill_level"] = node_data["SKILL_NODE_LEVELS"][4],
			["action"] = CBT_GREY,
			["message"] = CraftBuster_Module_TranslateActionText(GRAY_FONT_COLOR_CODE, node_name, node_data["SKILL_NODE_LEVELS"][4]),
		};
	end
end

local function CraftBuster_Module_Mining_HandleNode(line_one, line_two, line_three)
	for node_name, item_id in sortedpairs(SKILL_NODES) do
		if (string.find(line_one, node_name) ~= nil and SKILL_NODE_LEVELS[node_name] ~= nil) then
			--echo(SKILL_NAME .. " Found: " .. node_name .. ", " .. item_id);
			GameTooltip:AddLine(CBL["NODE_MSG"] .. ORANGE_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][1] .. YELLOW_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][2] .. GREEN_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][3] .. GRAY_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][4]);
			--GameTooltipTextLeft2:SetText(line_two .. " -" .. ORANGE_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][1] .. YELLOW_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][2] .. GREEN_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][3] .. GRAY_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][4]);
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
		--echo("Here: " .. CraftBusterEntry .. ", " .. SKILL_ID .. " -" .. action_id);
		if (not CraftBusterEntry) then
			DEFAULT_CHAT_FRAME:AddMessage("Here3: " .. type(CraftBusterEntry));
			DEFAULT_CHAT_FRAME:AddMessage("Here4: " .. type(SKILL_ID));
			DEFAULT_CHAT_FRAME:AddMessage("Here5: " .. type(action_id));
		end
		if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id]) then
			--echo(SKILL_NAME .. " Check: " .. CraftBusterPlayerLevel .. " >= " .. data.ply_level .. " and " .. skill_data.level .. " >= " .. data.skill_level);
			if (CraftBusterPlayerLevel >= data.ply_level and data.skill_level ~= "" and skill_data.level >= data.skill_level) then
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
		node_function = CraftBuster_Module_Mining_HandleNode,
		action_function = CraftBuster_Module_Mining_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Mining_OnLoad();