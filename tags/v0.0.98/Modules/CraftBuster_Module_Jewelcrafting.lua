local SKILL_NAME = CBL["SKILL_JEWL"];
local SKILL_SHORT_CODE = "jewl";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_ID = CBT_SKILL_JEWL;
local SKILL_SPELL_1ID = 25229;		--Jewelcrafting
local SKILL_SPELL_2ID = 31252;		--Prospecting
local SKILL_BUST_SPELLID = 31252;
local SKILL_ACTIONS = {};

local JEWL_ORES = {
	--vanilla
	["2840"] = "Copper Ore",
	["2771"] = "Tin Ore",
	["2772"] = "Iron Ore",
	["3858"] = "Mithril Ore",
	["10620"] = "Thorium Ore",

	--tbc
	["23424"] = "Fel Iron Ore",
	["23425"] = "Adamantite Ore",

	--wotlk
	["36909"] = "Cobalt Ore",
	["36912"] = "Saronite Ore",
	["36910"] = "Titanium Ore",

	--cata
	["53038"] = "Obsidium Ore",
	["52185"] = "Elementium Ore",
	["52183"] = "Pyrite Ore",

	--mists
	["72092"] = "Ghost Iron Ore",
	["72093"] = "Kyparite",
	["72094"] = "Black Trillium Ore",
	["72103"] = "White Trillium Ore",
};

local function CraftBuster_Module_Jewelcrafting_GetBustables()
	local results = {};
	for bag=0, 4 do
		for slot=1, GetContainerNumSlots(bag) do
			local _, _, item_id = string.find(GetContainerItemLink(bag, slot) or "", "item:(%d+).+%[(.+)%]");
			if (item_id ~= nil) then
				if (JEWL_ORES[item_id] ~= nil) then
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

local function CraftBuster_Module_Jewelcrafting_Sort()
	echo("Here: " .. SKILL_NAME);
end

local function CraftBuster_Module_Jewelcrafting_HandleAction(skill_data)
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

local function CraftBuster_Module_Jewelcrafting_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
		spell_2 = SKILL_SPELL_2ID,
		spell_buster = SKILL_SPELL_2ID,
		bustable_spell = SKILL_BUST_SPELLID,
		bustable_type = ITEM_PROSPECTABLE,
		bustable_function = CraftBuster_Module_Jewelcrafting_GetBustables,
		sort_function = CraftBuster_Module_Jewelcrafting_Sort,
		action_function = CraftBuster_Module_Jewelcrafting_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Jewelcrafting_OnLoad();