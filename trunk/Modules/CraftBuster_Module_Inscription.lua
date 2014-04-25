local SKILL_ID = CBT_SKILL_INSC;
local SKILL_NAME = CBL[CBT_SKILL_INSC];
local SKILL_SHORT_CODE = "insc";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 45357;		--Inscription
local SKILL_SPELL_2ID = 51005;		--Milling
local SKILL_BUST_SPELLID = 51005;
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[26916] = { ["name"] = "Mindri Dinkles", ["floor"] = 0, ["pos"] = { 58.2, 62.4 } },
			},
			["Horde"] = {
				[26959] = { ["name"] = "Booker Kells", ["floor"] = 0, ["pos"] = { 79.4, 29.2 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[26995] = { ["name"] = "Tink Brightbolt", ["floor"] = 0, ["pos"] = { 57.6, 71.6 } },
			},
			["Horde"] = {
				[26977] = { ["name"] = "Adelene Sunlance", ["floor"] = 0, ["pos"] = { 41.2, 53.8 } },
			},
	},
	[301] = {		--Stormwind City
			["Alliance"] = {
				[30713] = { ["name"] = "Catarina Stanford", ["floor"] = 0, ["pos"] = { 49.6, 74 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[30715] = { ["name"] = "Feyden Darkin", ["floor"] = 0, ["pos"] = { 56.6, 31.4 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[30716] = { ["name"] = "Thoth", ["floor"] = 0, ["pos"] = { 39.8, 38.8 } },
			},
	},
	[341] = {		--Ironforge
			["Alliance"] = {
				[30717] = { ["name"] = "Elise Brightletter", ["floor"] = 0, ["pos"] = { 60.4, 44.4 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[30721] = { ["name"] = "Michael Schwan", ["floor"] = 0, ["pos"] = { 53.8, 65.4 } },
			},
			["Horde"] = {
				[30722] = { ["name"] = "Neferatti", ["floor"] = 0, ["pos"] = { 52.2, 36 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[53415] = { ["name"] = "Theoden Manners", ["floor"] = 0, ["pos"] = { 66, 49.6 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[30709] = { ["name"] = "Poshken Hardbinder", ["floor"] = 0, ["pos"] = { 28.4, 20.4 } },
			},
	},
	[480] = {		--Silvermoon City
			["Horde"] = {
				[30710] = { ["name"] = "Zantasia", ["floor"] = 0, ["pos"] = { 69.2, 23.6 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[30711] = { ["name"] = "Margaux Parchley", ["floor"] = 0, ["pos"] = { 61, 58.2 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[46716] = { ["name"] = "Nerog", ["floor"] = 1, ["pos"] = { 55.2, 55.8 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[28702] = { ["name"] = "Professor Pallin", ["floor"] = 1, ["pos"] = { 42.4, 37.6 } },
			},
	},
	[492] = {		--Icecrown
			["Neutral"] = {
				[33603] = { ["name"] = "Arthur Denny", ["floor"] = 0, ["pos"] = { 71.6, 20.8 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[33638] = { ["name"] = "Scribe Lanloer", ["floor"] = 0, ["pos"] = { 56, 74.4 } },
				[33679] = { ["name"] = "Recorder Lidio", ["floor"] = 0, ["pos"] = { 36.2, 43.8 } },
			},
	},
	[806] = {		--The Jade Forest
			["Neutral"] = {
				[56065] = { ["name"] = "Inkmaster Wei", ["floor"] = 0, ["pos"] = { 54.6, 44.2 } },
				[62327] = { ["name"] = "Scribe Rinji", ["floor"] = 0, ["pos"] = { 47.6, 35 } },
			},
	},
	[811] = {		--Vale of Eternal Blossoms
			["Neutral"] = {
				[64691] = { ["name"] = "Lorewalker Huynh", ["floor"] = 0, ["pos"] = { 82, 29.4 } },
			},
	},
};
local INSC_HERBS = {
	["765"] = {"39151"},
	["785"] = {"39334","43103"},
	["2447"] = {"39151"},
	["2449"] = {"39151"},
	["2450"] = {"39334","43103"},
	["2452"] = {"39334","43103"},
	["2453"] = {"39334","43103"},
	["3355"] = {"39338","43104"},
	["3356"] = {"39338","43104"},
	["3357"] = {"39338","43104"},
	["3358"] = {"39339","43105"},
	["3369"] = {"39338","43104"},
	["3818"] = {"39339","43105"},
	["3819"] = {"39339","43105"},
	["3820"] = {"39334","43103"},
	["3821"] = {"39339","43105"},
	["4625"] = {"39340","43106"},
	["8831"] = {"39340","43106"},
	["8836"] = {"39340","43106"},
	["8838"] = {"39340","43106"},
	["8839"] = {"39340","43106"},
	["8845"] = {"39340","43106"},
	["8846"] = {"39340","43106"},
	["13463"] = {"39341","43107"},
	["13464"] = {"39341","43107"},
	["13465"] = {"39341","43107"},
	["13466"] = {"39341","43107"},
	["13467"] = {"39341","43107"},
	["22785"] = {"39342","43108"},
	["22786"] = {"39342","43108"},
	["22787"] = {"39342","43108"},
	["22789"] = {"39342","43108"},
	["22790"] = {"39342","43108"},
	["22791"] = {"39342","43108"},
	["22792"] = {"39342","43108"},
	["22793"] = {"39342","43108"},
	["36901"] = {"39343","43109"},
	["36903"] = {"39343","43109"},
	["36904"] = {"39343","43109"},
	["36905"] = {"39343","43109"},
	["36906"] = {"39343","43109"},
	["36907"] = {"39343","43109"},
	["37921"] = {"39343","43109"},
	["39970"] = {"39343","43109"},
	["52983"] = {"61979","61980"},
	["52984"] = {"61979","61980"},
	["52985"] = {"61979","61980"},
	["52986"] = {"61979","61980"},
	["52987"] = {"61979","61980"},
	["52988"] = {"61979","61980"},
	["72234"] = {"79251","79253"},
	["72237"] = {"79251","79253"},
	["72235"] = {"79251","79253"},
	["89639"] = {"79251","79253"},
	["79010"] = {"79251","79253"},
	["79011"] = {"79251","79253"},
};

local INSC_INKS = {
	["37101"] = {"39151"},
	["39469"] = {"39151"},
	["39774"] = {"39334"},
	["43115"] = {"43103"},
	["43116"] = {"39338"},
	["43117"] = {"43104"},
	["43118"] = {"39339"},
	["43119"] = {"43105"},
	["43120"] = {"39340"},
	["43121"] = {"43106"},
	["43122"] = {"39341"},
	["43123"] = {"43107"},
	["43124"] = {"39342"},
	["43125"] = {"43108"},
	["43126"] = {"39343"},
	["43127"] = {"43109"},
	["61978"] = {"61979"},
	["61981"] = {"61980"},
	["79254"] = {"79251"},
	["79255"] = {"79253"},
};

local INSC_PIGMENTS = {
	["39151"] = {
		["name"] = "Alabaster Pigment",
		["type"] = "common",
		["herbs"] = {
			["765"] = "Silverleaf",
			["2447"] = "Peacebloom",
			["2449"] = "Earthroot",
		},
		["inks"] = {
			["37101"] = "Ivory Ink",
			["39469"] = "Moonglow Ink",
		},
	},
	["39334"] = {
		["name"] = "Dusky Pigment",
		["type"] = "common",
		["herbs"] = {
			["785"] = "Mageroyal",
			["2450"] = "Briarthorn",
			["2452"] = "Swiftthistle",
			["2453"] = "Bruiseweed",
			["3820"] = "Stranglekelp",
		},
		["inks"] = {
			["39774"] = "Midnight Ink",
		},
	},
	["39338"] = {
		["name"] = "Golden Pigment",
		["type"] = "common",
		["herbs"] = {
			["3355"] = "Wild Steelbloom",
			["3356"] = "Kingsblood",
			["3357"] = "Liferoot",
			["3369"] = "Grave Moss",
		},
		["inks"] = {
			["43116"] = "Lion's Ink",
		},
	},
	["39339"] = {
		["name"] = "Emerald Pigment",
		["type"] = "common",
		["herbs"] = {
			["3358"] = "Khadgar's Whisker",
			["3818"] = "Fadeleaf",
			["3819"] = "Dragon's Teeth",
			["3821"] = "Goldthorn",
		},
		["inks"] = {
			["43118"] = "Jadefire Ink",
		},
	},
	["39340"] = {
		["name"] = "Violet Pigment",
		["type"] = "common",
		["herbs"] = {
			["4625"] = "Firebloom",
			["8831"] = "Purple Lotus",
			["8836"] = "Arthas' Tears",
			["8838"] = "Sungrass",
			["8839"] = "Blindweed",
			["8845"] = "Ghost Mushroom",
			["8846"] = "Gromsblood",
		},
		["inks"] = {
			["43120"] = "Celestial Ink",
		},
	},
	["39341"] = {
		["name"] = "Silvery Pigment",
		["type"] = "common",
		["herbs"] = {
			["13463"] = "Dreamfoil",
			["13464"] = "Golden Sansam",
			["13465"] = "Mountain Silversage",
			["13466"] = "Sorrowmoss",
			["13467"] = "Icecap",
		},
		["inks"] = {
			["43122"] = "Shimmering Ink",
		},
	},
	["39342"] = {
		["name"] = "Nether Pigment",
		["type"] = "common",
		["herbs"] = {
			["22785"] = "Felweed",
			["22786"] = "Dreaming Glory",
			["22787"] = "Ragveil",
			["22789"] = "Terocone",
			["22790"] = "Ancient Lichen",
			["22791"] = "Netherbloom",
			["22792"] = "Nightmare Vine",
			["22793"] = "Mana Thistle",
		},
		["inks"] = {
			["43124"] = "Ethereal Ink",
		},
	},
	["39343"] = {
		["name"] = "Azure Pigment",
		["type"] = "common",
		["herbs"] = {
			["36901"] = "Goldclover",
			["36903"] = "Adder's Tongue",
			["36904"] = "Tiger Lily",
			["36905"] = "Lichbloom",
			["36906"] = "Icethorn",
			["36907"] = "Talandra's Rose",
			["37921"] = "Deadnettle",
			["39970"] = "Fire Leaf",
		},
		["inks"] = {
			["43126"] = "Ink of the Sea",
		},
	},
	["61979"] = {
		["name"] = "Ashen Pigment",
		["type"] = "common",
		["herbs"] = {
			["52983"] = "Cinderbloom",
			["52984"] = "Stormvine",
			["52985"] = "Azshara's Veil",
			["52986"] = "Heartblossom",
			["52987"] = "Twilight Jasmine",
			["52988"] = "Whiptail",
		},
		["inks"] = {
			["61978"] = "Blackfallow Ink",
		},
	},
	["79251"] = {
		["name"] = "Shadow Pigment",
		["type"] = "common",
		["herbs"] = {
			["79010"] = "Snow Lily",
			["72234"] = "Green Tea Leaf",
			["72235"] = "Silkweed",
			["72237"] = "Rain Poppy",
			["89639"] = "Desecrated Herb",
			["79011"] = "Fool's Cap",
		},
		["inks"] = {
			["79254"] = "Ink of Dreams",
		},
	},
	["43104"] = {
		["name"] = "Burnt Pigment",
		["type"] = "rare",
		["herbs"] = {
			["3355"] = "Wild Steelbloom",
			["3356"] = "Kingsblood",
			["3357"] = "Liferoot",
			["3369"] = "Grave Moss",
		},
		["inks"] = {
			["43117"] = "Dawnstar Ink",
		},
	},
	["43103"] = {
		["name"] = "Verdant Pigment",
		["type"] = "rare",
		["herbs"] = {
			["785"] = "Mageroyal",
			["2450"] = "Briarthorn",
			["2452"] = "Swiftthistle",
			["2453"] = "Bruiseweed",
			["3820"] = "Stranglekelp",
		},
		["inks"] = {
			["43115"] = "Hunter's Ink",
		},
	},
	["43107"] = {
		["name"] = "Sapphire Pigment",
		["type"] = "rare",
		["herbs"] = {
			["13463"] = "Dreamfoil",
			["13464"] = "Golden Sansam",
			["13465"] = "Mountain Silversage",
			["13466"] = "Sorrowmoss",
			["13467"] = "Icecap",
		},
		["inks"] = {
			["43123"] = "Ink of the Sky",
		},
	},
	["43106"] = {
		["name"] = "Ruby Pigment",
		["type"] = "rare",
		["herbs"] = {
			["4625"] = "Firebloom",
			["8831"] = "Purple Lotus",
			["8836"] = "Arthas' Tears",
			["8838"] = "Sungrass",
			["8839"] = "Blindweed",
			["8845"] = "Ghost Mushroom",
			["8846"] = "Gromsblood",
		},
		["inks"] = {
			["43121"] = "Fiery Ink",
		},
	},
	["43108"] = {
		["name"] = "Ebon Pigment",
		["type"] = "rare",
		["herbs"] = {
			["22785"] = "Felweed",
			["22786"] = "Dreaming Glory",
			["22787"] = "Ragveil",
			["22789"] = "Terocone",
			["22790"] = "Ancient Lichen",
			["22791"] = "Netherbloom",
			["22792"] = "Nightmare Vine",
			["22793"] = "Mana Thistle",
		},
		["inks"] = {
			["43125"] = "Darkflame Ink",
		},
	},
	["43109"] = {
		["name"] = "Icy Pigment",
		["type"] = "rare",
		["herbs"] = {
			["36901"] = "Goldclover",
			["36903"] = "Adder's Tongue",
			["36904"] = "Tiger Lily",
			["36905"] = "Lichbloom",
			["36906"] = "Icethorn",
			["36907"] = "Talandra's Rose",
			["37921"] = "Deadnettle",
			["39970"] = "Fire Leaf",
		},
		["inks"] = {
			["43127"] = "Snowfall Ink",
		},
	},
	["43105"] = {
		["name"] = "Indigo Pigment",
		["type"] = "rare",
		["herbs"] = {
			["3358"] = "Khadgar's Whisker",
			["3818"] = "Fadeleaf",
			["3819"] = "Dragon's Teeth",
			["3821"] = "Goldthorn",
		},
		["inks"] = {
			["43119"] = "Royal Ink",
		},
	},
	["61980"] = {
		["name"] = "Burning Embers",
		["type"] = "rare",
		["herbs"] = {
			["52983"] = "Cinderbloom",
			["52984"] = "Stormvine",
			["52985"] = "Azshara's Veil",
			["52986"] = "Heartblossom",
			["52987"] = "Twilight Jasmine",
			["52988"] = "Whiptail",
		},
		["inks"] = {
			["61981"] = "Inferno Ink",
		},
	},
	["79253"] = {
		["name"] = "Misty Pigment",
		["type"] = "rare",
		["herbs"] = {
			["72234"] = "Green Tea Leaf",
			["72237"] = "Rain Poppy",
			["72235"] = "Silkweed",
			["89639"] = "Desecrated Herb",
			["79010"] = "Snow Lily",
			["79011"] = "Fool's Cap",
		},
		["inks"] = {
			["79255"] = "Starlight Ink",
		},
	},
};

local function CraftBuster_Module_Inscription_GetBustables()
	local results = {};
	for bag=0, 4 do
		for slot=1, GetContainerNumSlots(bag) do
			local _, _, item_id = string.find(GetContainerItemLink(bag, slot) or "", "item:(%d+).+%[(.+)%]");
			if (item_id ~= nil) then
				if (INSC_HERBS[item_id] ~= nil) then
					item_id = tonumber(item_id);
					if (not results[item_id]) then
						results[item_id] = {};
						results[item_id].item_id = item_id;
						results[item_id].total = 0;
					end
					local _,item_count = GetContainerItemInfo(bag,slot);
					results[item_id].total = results[item_id].total + item_count;		--really? no += in lua? LAAAAAAAAAME
					--echo("Bag: " .. bag .. ", Slot: " .. slot .. " - " .. item_id .. " - " .. item_count);
				end
			end
		end
	end

	return results;
end

local function CraftBuster_Module_Inscription_Sort()
	echo("Begin Inscription Sort:");
	local sort_items = {};
	for bag=0, 4 do
		local sort_bag = 5 - bag;		--since Blizzard checks bustables in the 'last' bags first, sort them first
		for slot=1, GetContainerNumSlots(bag) do
			--local sort_slot = 100 - slot;		--do likewise for the slots
			local sort_slot = slot;		--do likewise for the slots
			local _, _, item_id = string.find(GetContainerItemLink(bag, slot) or "", "item:(%d+).+%[(.+)%]");
			if (item_id ~= nil) then
				if (INSC_HERBS[item_id] ~= nil) then
					item_id = tonumber(item_id);
					if (not sort_items[item_id]) then
						local _,_,_,_,_,_,_,max_stack = GetItemInfo(item_id);
						sort_items[item_id] = {};
						sort_items[item_id].item_id = item_id;
						sort_items[item_id].max_stack = max_stack;
						sort_items[item_id].total = 0;
						sort_items[item_id].bags = {};
					end
					local _,item_count = GetContainerItemInfo(bag,slot);
					if (item_count < sort_items[item_id].max_stack) then
						if (not sort_items[item_id].bags[sort_bag]) then
							sort_items[item_id].bags[sort_bag] = {};
						end
						if (not sort_items[item_id].bags[sort_bag][sort_slot]) then
							sort_items[item_id].bags[sort_bag][sort_slot] = 0;
						end
						sort_items[item_id].total = sort_items[item_id].total + item_count;
						sort_items[item_id].bags[sort_bag][sort_slot] = sort_items[item_id].bags[sort_bag][sort_slot] + item_count;
						echo("Bag: " .. bag .. ", Slot: " .. slot .. " - " .. item_id .. " - " .. item_count);
					end
				end
			end
		end
	end
	print_r(sort_items);
	if (sort_items and next(sort_items)) then
		for i,item_data in sortedpairs(sort_items) do
			if (tcount(item_data.bags) > 1) then
				local total_stacks = ceil(item_data.total / item_data.max_stack);
				local stack_items = {};
				stack_items.bags = {};
				for sort_bag,bag_data in sortedpairs(item_data.bags) do
					local bag = 5 - sort_bag;
					if (not stack_items.bags[bag]) then
						stack_items.bags[bag] = {};
					end
					for sort_slot,slot_data in sortedpairs(bag_data) do
						--local slot = 100 - sort_slot;
						local slot = sort_slot;
						if (not stack_items.bags[bag][slot]) then
							stack_items.bags[bag][slot] = 0;
						end
					end
				end
				--print_r(stack_items);
				for stack=1, total_stacks do
				end
			end
		end
	end

	CraftBuster_BusterFrame_SortItems();
end

local function CraftBuster_Module_Inscription_HandleAction(skill_data)
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

local function CraftBuster_Module_Inscription_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		spell_2 = SKILL_SPELL_2ID,
		spell_buster = SKILL_SPELL_2ID,
		tooltip_info = true,
		bustable_spell = SKILL_BUST_SPELLID,
		bustable_type = ITEM_MILLABLE,
		bustable_function = CraftBuster_Module_Inscription_GetBustables,
		sort_function = CraftBuster_Module_Inscription_Sort,
		action_function = CraftBuster_Module_Inscription_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Inscription_OnLoad();

local function parse_output(color, header, table_data)
	local output_txt = color .. header .. ": |r";
	local i = 1;
	for id, name in pairs(table_data) do
		if (i > 1) then
			output_txt = output_txt .. ", ";
		end
		if (i % 3 == 0 and tcount(table_data) > 3) then
			output_txt = output_txt .. "\n";
		end
		output_txt = output_txt .. name;
		i = i + 1;
	end

	return output_txt;
end

local function CraftBuster_Module_Inscription_AddMillingInfo(frame, item_link)
	if (CraftBusterOptions[CraftBusterEntry].modules[SKILL_ID].show_tooltips ~= true) then
		return;
	end

	local _, _, item_string = strfind(item_link, "^|c%x+|H(.+)|h%[.+%]");
	if (item_string) then
		local _, item_id = strsplit(":", item_string);
		if (item_id) then
			local item_type;
			local pigment_ids = {};
			if (INSC_HERBS[item_id]) then
				item_type = "herb";
				pigment_ids = INSC_HERBS[item_id];
			elseif (INSC_INKS[item_id]) then
				item_type = "ink";
				pigment_ids = INSC_INKS[item_id];
			elseif (INSC_PIGMENTS[item_id]) then
				item_type = "pigment";
				pigment_ids[1] = item_id;
			end
			if (pigment_ids and next(pigment_ids)) then
				local output_herbs = {};
				local output_inks = {};
				local output_pigments = {};
				for _, pigment_id in pairs(pigment_ids) do
					if (INSC_PIGMENTS[pigment_id]) then
						local pigment = INSC_PIGMENTS[pigment_id];
						if (item_type == "herb" or item_type == "ink") then
							output_pigments[pigment_id] = pigment["name"];
						end
						if (item_type == "pigment" or item_type == "ink") then
							output_herbs = push_table(output_herbs, pigment["herbs"]);
						end
						if (item_type == "herb" or item_type == "pigment") then
							output_inks = push_table(output_inks, pigment["inks"]);
						end
					end
				end

				local output_txt = "";
				local found = false;
				if (next(output_pigments)) then
					if (found) then
						output_txt = output_txt .. "\n";
					end
					output_txt = output_txt .. parse_output(CBG_CLR_LIGHTGREY, CBL["SKILL_INSC_PIGMENTS"], output_pigments);
					found = true;
				end
				if (next(output_herbs)) then
					if (found) then
						output_txt = output_txt .. "\n";
					end
					output_txt = output_txt .. parse_output(CBG_CLR_LIGHTGREEN, CBL["SKILL_INSC_HERBS"], output_herbs);
					found = true;
				end
				if (next(output_inks)) then
					if (found) then
						output_txt = output_txt .. "\n";
					end
					output_txt = output_txt .. parse_output(CBG_CLR_DARKBLUE, CBL["SKILL_INSC_INKS"], output_inks);
					found = true;
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
			--echo("Here: " .. item_link);
			if (item_link and GetItemInfo(item_link)) then
				CraftBuster_Module_Inscription_AddMillingInfo(self, item_link);
			end
		end
	);
end

HookFrame(GameTooltip);
HookFrame(ItemRefTooltip);