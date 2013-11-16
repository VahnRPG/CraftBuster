local SKILL_NAME = CBL["SKILL_HERB"];
local SKILL_SHORT_CODE = "herb";
local SKILL_TYPE = CBG_SKILL_GATHER;
local SKILL_ID = CBT_SKILL_HERB;
local SKILL_SPELL_1ID = 81708;		--Lifeblood
local SKILL_ACTIONS = {};

local SKILL_NODE_LEVELS = {
	["Peacebloom"] = {
		["rank"] = 0,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {1,25,50,100},
	},
	["Silverleaf"] = {
		["rank"] = 1,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {1,25,50,100},
	},
	["Bloodthistle"] = {
		["rank"] = 2,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {1,25,50,100},
	},
	["Earthroot"] = {
		["rank"] = 3,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {10,40,65,115},
	},
	["Mageroyal"] = {
		["rank"] = 4,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {50,75,100,150},
	},
	["Briarthorn"] = {
		["rank"] = 5,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {70,95,120,170},
	},
	["Stranglekelp"] = {
		["rank"] = 6,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {85,110,135,185},
	},
	["Bruiseweed"] = {
		["rank"] = 7,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {85,125,150,200},
	},
	["Wild Steelbloom"] = {
		["rank"] = 8,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {115,140,165,215},
	},
	["Grave Moss"] = {
		["rank"] = 9,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {120,150,170,220},
	},
	["Kingsblood"] = {
		["rank"] = 10,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {125,155,175,225},
	},
	["Liferoot"] = {
		["rank"] = 11,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {150,175,200,250},
	},
	["Fadeleaf"] = {
		["rank"] = 12,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {150,175,200,250},
	},
	["Khadgar's Whisker"] = {
		["rank"] = 13,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {160,185,210,260},
	},
	["Goldthorn"] = {
		["rank"] = 14,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {150,195,220,270},
	},
	["Dragon's Teeth"] = {
		["rank"] = 15,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {195,225,245,295},
	},
	["Firebloom"] = {
		["rank"] = 16,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {205,235,255,305},
	},
	["Purple Lotus"] = {
		["rank"] = 17,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {210,235,260,310},
	},
	["Arthas' Tears"] = {
		["rank"] = 18,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {220,250,270,320},
	},
	["Sungrass"] = {
		["rank"] = 19,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {230,255,280,330},
	},
	["Blindweed"] = {
		["rank"] = 20,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {235,260,285,335},
	},
	["Ghost Mushroom"] = {
		["rank"] = 21,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {245,270,295,345},
	},
	["Gromsblood"] = {
		["rank"] = 22,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {250,275,300,350},
	},
	["Golden Sansam"] = {
		["rank"] = 23,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {260,280,310,360},
	},
	["Dreamfoil"] = {
		["rank"] = 24,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {270,295,320,370},
	},
	["Mountain Silversage"] = {
		["rank"] = 25,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {280,305,330,380},
	},
	["Sorrowmoss"] = {
		["rank"] = 26,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {285,310,335,385},
	},
	["Icecap"] = {
		["rank"] = 27,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {290,315,340,370},
	},
	["Black Lotus"] = {
		["rank"] = 28,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {300,345,375,400},
	},
	["Felweed"] = {
		["rank"] = 29,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {300,325,350,400},
	},
	["Dreaming Glory"] = {
		["rank"] = 30,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {315,340,365,415},
	},
	["Ragveil"] = {
		["rank"] = 31,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {325,350,375,425},
	},
	["Flame Cap"] = {
		["rank"] = 32,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {335,352,400,435},
	},
	["Terocone"] = {
		["rank"] = 33,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {325,350,400,425},
	},
	["Ancient Lichen"] = {
		["rank"] = 34,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {340,"","",440},
	},
	["Netherbloom"] = {
		["rank"] = 35,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {350,375,"",450},
	},
	["Nightmare Vine"] = {
		["rank"] = 36,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {365,390,419,465},
	},
	["Mana Thistle"] = {
		["rank"] = 37,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {375,415,425,475},
	},
	["Goldclover"] = {
		["rank"] = 38,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {350,380,400,450},
	},
	["Firethorn"] = {
		["rank"] = 39,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {360,385,"",""},
	},
	["Tiger Lily"] = {
		["rank"] = 40,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {375,400,425,""},
	},
	["Talandra's Rose"] = {
		["rank"] = 41,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {385,"","",""},
	},
	["Frozen Herb"] = {
		["rank"] = 42,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {400,425,"",""},
	},
	["Adder's Tongue"] = {
		["rank"] = 43,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {400,"","",""},
	},
	["Lichbloom"] = {
		["rank"] = 44,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {425,"","",525},
	},
	["Icethorn"] = {
		["rank"] = 45,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {435,"","",535},
	},
	["Frost Lotus"] = {
		["rank"] = 46,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {450,"","",""},
	},
	["Cinderbloom"] = {
		["rank"] = 47,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {425,450,475,525},
	},
	["Azshara's Veil"] = {
		["rank"] = 48,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {425,450,475,525},
	},
	["Stormvine"] = {
		["rank"] = 49,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {425,450,475,525},
	},
	["Heartblossom"] = {
		["rank"] = 50,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {475,500,525,""},
	},
	["Whiptail"] = {
		["rank"] = 51,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {500,525,"",""},
	},
	["Twilight Jasmine"] = {
		["rank"] = 52,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {525,"","",""},
	},
	["Green Tea Leaf"] = {
		["rank"] = 53,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {500,525,550,575},
	},
	["Rain Poppy"] = {
		["rank"] = 54,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {525,550,575,600},
	},
	["Silkweed"] = {
		["rank"] = 55,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {545,570,595,""},
	},
	["Sha-Touched Herb"] = {
		["rank"] = 57,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {575,600,"",""},
	},
	["Snow Lily"] = {
		["rank"] = 56,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {575,600,"",""},
	},
	["Fool's Cap"] = {
		["rank"] = 58,
		["ply_level"] = 1,
		["SKILL_NODE_LEVELS"] = {600,"","",""},
	},
};

local SKILL_NODES = {
	["Ancient Lichen"] = 22790,
	["Arthas' Tears"] = 8836,
	["Black Lotus"] = 13468,
	["Blindweed"] = 8839,
	["Bloodthistle"] = 22710,
	["Briarthorn"] = 2450,
	["Bruiseweed"] = 2453,
	["Dreamfoil"] = 13463,
	["Dreaming Glory"] = 22786,
	["Earthroot"] = 2449,
	["Fadeleaf"] = 3818,
	["Felweed"] = 22785,
	["Firebloom"] = 4625,
	["Flame Cap"] = 22788,
	["Ghost Mushroom"] = 8845,
	["Golden Sansam"] = 13464,
	["Goldthorn"] = 3821,
	["Grave Moss"] = 3369,
	["Gromsblood"] = 8846,
	["Icecap"] = 13467,
	["Khadgar's Whisker"] = 3358,
	["Kingsblood"] = 3356,
	["Liferoot"] = 3357,
	["Mageroyal"] = 785,
	["Mana Thistle"] = 22793,
	["Mountain Silversage"] = 13465,
	["Netherbloom"] = 22791,
	["Nightmare Vine"] = 22792,
	["Peacebloom"] = 2447,
	["Plaguebloom"] = 13466,
	["Purple Lotus"] = 8831,
	["Ragveil"] = 22787,
	["Silverleaf"] = 765,
	["Stranglekelp"] = 3820,
	["Sungrass"] = 8838,
	["Terocone"] = 22789,
	["Wild Steelbloom"] = 3355,
	["Wintersbite"] = 3819,

	["Glowcap"] = 24245,
	["Netherdust Bush"] = 32468, --Netherdust Pollen
	["Sanguine Hibiscus"] = 24246,

	["Fel Lotus"] = 22794,
	["Goldclover"] = 36901,
	["Adder's Tongue"] = 36903,
	["Tiger Lily"] = 36904,
	["Lichbloom"] = 36905,
	["Icethorn"] = 36906,
	["Talandra's Rose"] = 36907,
	["Frost Lotus"] = 36908,
	["Firethorn"] = 39970,
	["Cinderbloom"] = 52983,
	["Stormvine"] = 52984,
	["Azshara's Veil"] = 52985,
	["Heartblossom"] = 52986,
	["Twilight Jasmine"] = 52987,
	["Whiptail"] = 52988,
	["Deathspore Pod"] = 52989,
	
	["Green Tea Leaf"] = 72234,
	["Rain Poppy"] = 72237,
	["Silkweed"] = 72235,
	["Sha-Touched Herb"] = 89639,
	["Snow Lily"] = 79010,
	["Fool's Cap"] = 79011,
};

local function CraftBuster_Module_Herbalism_BuildActions()
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

local function CraftBuster_Module_Herbalism_HandleNode(line_one, line_two, line_three)
	for node_name, item_id in sortedpairs(SKILL_NODES) do
		if (string.find(line_one, node_name) ~= nil and SKILL_NODE_LEVELS[node_name] ~= nil) then
			--echo(SKILL_NAME .. " Found: " .. node_name .. ", " .. item_id);
			GameTooltip:AddLine(CBL["NODE_MSG"] .. ORANGE_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][1] .. YELLOW_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][2] .. GREEN_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][3] .. GRAY_FONT_COLOR_CODE .. " " .. SKILL_NODE_LEVELS[node_name]["SKILL_NODE_LEVELS"][4]);
			GameTooltip:Show();
			return true;
		end
	end

	return false;
end

local function CraftBuster_Module_Herbalism_HandleAction(skill_data)
	if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID]) then
		CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID] = {};
	end
	for action_id, data in sortedpairs(SKILL_ACTIONS) do
		if (not CraftBusterEntry) then
			DEFAULT_CHAT_FRAME:AddMessage("Here: " .. type(CraftBusterEntry));
			DEFAULT_CHAT_FRAME:AddMessage("Here21: " .. type(SKILL_ID));
			DEFAULT_CHAT_FRAME:AddMessage("Here2: " .. type(action_id));
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

local function CraftBuster_Module_Herbalism_OnLoad()
	CraftBuster_Module_Herbalism_BuildActions();
	local module_options = {
		skill_type = CBG_SKILL_GATHER,
		spell_1 = SKILL_SPELL_1ID,
		tooltip_info = true,
		node_function = CraftBuster_Module_Herbalism_HandleNode,
		action_function = CraftBuster_Module_Herbalism_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Herbalism_OnLoad();