local SKILL_ID = CBT_SKILL_ENCH;
local SKILL_NAME = CBL[CBT_SKILL_ENCH];
local SKILL_SHORT_CODE = "ench";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_SPELL_1ID = 7411;		--Enchanting
local SKILL_SPELL_2ID = 13262;		--Disenchant
local SKILL_BUST_SPELLID = 1804;
local SKILL_ACTIONS = {};
local SKILL_TRAINER_MAP_ICONS = {
	[301] = {		--Stormwind City
			["Alliance"] = {
				[1317] = { ["name"] = "Lucan Cordell", ["floor"] = 0, ["pos"] = { 53, 74.2 } },
			},
	},
	[41] = {		--Teldrassil
			["Alliance"] = {
				[3606] = { ["name"] = "Alanna Raveneye", ["floor"] = 0, ["pos"] = { 39, 30 } },
			},
	},
	[381] = {		--Darnassus
			["Alliance"] = {
				[4213] = { ["name"] = "Taladan", ["floor"] = 0, ["pos"] = { 56.6, 31 } },
			},
	},
	[341] = {		--Ironforge
			["Alliance"] = {
				[5157] = { ["name"] = "Gimble Thistlefuzz", ["floor"] = 0, ["pos"] = { 60, 45.2 } },
			},
	},
	[121] = {		--Feralas
			["Alliance"] = {
				[7949] = { ["name"] = "Xylinnia Starshine", ["floor"] = 0, ["pos"] = { 46.6, 42.8 } },
			},
	},
	[30] = {		--Elwynn Forest
			["Alliance"] = {
				[11072] = { ["name"] = "Kitta Firewind", ["floor"] = 0, ["pos"] = { 64.8, 70.6 } },
			},
	},
	[471] = {		--The Exodar
			["Alliance"] = {
				[16725] = { ["name"] = "Nahogg", ["floor"] = 0, ["pos"] = { 40.4, 38.6 } },
			},
	},
	[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18773] = { ["name"] = "Johan Barnes", ["floor"] = 0, ["pos"] = { 53.6, 66 } },
			},
			["Horde"] = {
				[18753] = { ["name"] = "Felannia", ["floor"] = 0, ["pos"] = { 52.2, 36 } },
			},
	},
	[491] = {		--Howling Fjord
			["Alliance"] = {
				[26906] = { ["name"] = "Elizabeth Jackson", ["floor"] = 0, ["pos"] = { 58.6, 62.8 } },
			},
			["Horde"] = {
				[26954] = { ["name"] = "Emil Autumn", ["floor"] = 0, ["pos"] = { 78.6, 28.2 } },
			},
	},
	[486] = {		--Borean Tundra
			["Alliance"] = {
				[26990] = { ["name"] = "Alexis Marlowe", ["floor"] = 0, ["pos"] = { 57.6, 71.4 } },
			},
			["Horde"] = {
				[26980] = { ["name"] = "Eorain Dawnstrike", ["floor"] = 0, ["pos"] = { 41.2, 53.8 } },
			},
	},
	[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[53410] = { ["name"] = "Lissah Spellwick", ["floor"] = 0, ["pos"] = { 66, 49.4 } },
			},
	},
	[362] = {		--Thunder Bluff
			["Horde"] = {
				[3011] = { ["name"] = "Teg Dawnstrider", ["floor"] = 0, ["pos"] = { 45.2, 38.8 } },
			},
	},
	[321] = {		--Orgrimmar
			["Horde"] = {
				[3345] = { ["name"] = "Godan", ["floor"] = 1, ["pos"] = { 53.4, 49.4 } },
			},
	},
	[382] = {		--Undercity
			["Horde"] = {
				[4616] = { ["name"] = "Lavinia Crowe", ["floor"] = 0, ["pos"] = { 61.2, 60.4 } },
			},
	},
	[20] = {		--Tirisfal Glades
			["Horde"] = {
				[5695] = { ["name"] = "Vance Undergloom", ["floor"] = 0, ["pos"] = { 59.8, 53.2 } },
			},
	},
	[81] = {		--Stonetalon Mountains
			["Horde"] = {
				[11074] = { ["name"] = "Hgarth", ["floor"] = 0, ["pos"] = { 51.8, 59.8 } },
			},
	},
	[462] = {		--Eversong Woods
			["Horde"] = {
				[16160] = { ["name"] = "Magistrix Eredania", ["floor"] = 0, ["pos"] = { 38.2, 72.4 } },
			},
	},
	[480] = {		--Silvermoon City
			["Horde"] = {
				[16633] = { ["name"] = "Sedana", ["floor"] = 0, ["pos"] = { 69.8, 24.4 } },
			},
	},
	[481] = {		--Shattrath City
			["Neutral"] = {
				[19251] = { ["name"] = "Enchantress Volali", ["floor"] = 0, ["pos"] = { 43.2, 92.4 } },
				[19252] = { ["name"] = "High Enchanter Bardolan", ["floor"] = 0, ["pos"] = { 43.2, 92.4 } },
				[33633] = { ["name"] = "Enchantress Andiala", ["floor"] = 0, ["pos"] = { 56.2, 74.4 } },
				[33676] = { ["name"] = "Zurii", ["floor"] = 0, ["pos"] = { 36.4, 44.4 } },
			},
	},
	[479] = {		--Netherstorm
			["Neutral"] = {
				[19540] = { ["name"] = "Asarnan", ["floor"] = 0, ["pos"] = { 44.2, 33.6 } },
			},
	},
	[504] = {		--Dalaran
			["Neutral"] = {
				[28693] = { ["name"] = "Enchanter Nalthanis", ["floor"] = 1, ["pos"] = { 39.4, 41 } },
			},
	},
	[492] = {		--Icecrown
			["Neutral"] = {
				[33583] = { ["name"] = "Fael Morningsong", ["floor"] = 0, ["pos"] = { 73, 20.4 } },
			},
	},
	[806] = {		--The Jade Forest
			["Neutral"] = {
				[65127] = { ["name"] = "Lai the Spellpaw", ["floor"] = 0, ["pos"] = { 46.8, 42.8 } },
			},
	},
};

local VELLUM_ID = 38682; --Enchanting Vellum

local tradeskill_button = nil;

local SKILL_TRANSLATE_NAME = {
	--[""] = "CharacterHeadSlot",
	--[""] = "CharacterNeckSlot",
	--[""] = "CharacterShoulderSlot",
	["Cloak"] = "CharacterBackSlot",
	["Chest"] = "CharacterChestSlot",
	--[""] = "CharacterShirtSlot",
	--[""] = "CharacterTabardSlot",
	["Bracer"] = "CharacterWristSlot",
	["Gloves"] = "CharacterHandsSlot",
	--[""] = "CharacterWaistSlot",
	--[""] = "CharacterLegsSlot",
	["Boots"] = "CharacterFeetSlot",
	--[""] = "CharacterFinger0Slot",
	--[""] = "CharacterFinger1Slot",
	--[""] = "CharacterTrinket0Slot",
	--[""] = "CharacterTrinket1Slot",
	["Weapon"] = "CharacterMainHandSlot",
	["2H Weapon"] = "CharacterMainHandSlot",
	["Shield"] = "CharacterSecondaryHandSlot",
	["Ranged"] = "CharacterRangedSlot",
};

local function CraftBuster_Module_Enchanting_GetBustables()
	local results = {};
	local count = 0;
	for bag=0, 4 do
		for slot=1, GetContainerNumSlots(bag) do
			local _, _, item_id = string.find(GetContainerItemLink(bag, slot) or "", "item:(%d+).+%[(.+)%]");
			if (item_id ~= nil) then
				local item_name,item_link,item_quality,_,_,item_type,item_sub_type = GetItemInfo(item_id);
				if (item_quality > 1 and (item_type == "Weapon" or item_type == "Armor")) then
					item_id = tonumber(item_id);
					count = count + 1;
					results[count] = {};
					results[count].item_id = item_id;
					results[count].bag = bag;
					results[count].slot = slot;
					results[count].total = 1;
				end
			end
		end
	end

	return results;
end

local function CraftBuster_Module_Enchanting_HandleAction(skill_data)
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

local function CraftBuster_Module_Enchanting_CheckMake(tradeskill_id)
	if (GetItemCount(VELLUM_ID) <= 0) then
		return false;
	end

	local reagents = GetTradeSkillNumReagents(tradeskill_id);
	for i=1, reagents do
		local _,_,reagent_count, player_reagent = GetTradeSkillReagentInfo(tradeskill_id, i);
		if (player_reagent < reagent_count) then
			return false;
		end
	end

	return true;
end

local function CraftBuster_Module_Enchanting_Tradeskill_OnClick()
	DoTradeSkill(GetTradeSkillSelectionIndex());
	UseItemByName(VELLUM_ID);
end

local function CraftBuster_Module_Enchanting_HandleTradeskill(tradeskill_id)
	if (not tradeskill_button) then
		tradeskill_button = CreateFrame("BUTTON", "CraftBuster_Module_EnchantingEquipmentButton", TradeSkillFrame, "MagicButtonTemplate");
		tradeskill_button:SetPoint("TOPRIGHT", "TradeSkillCreateButton", "TOPLEFT", 0, 0);
		tradeskill_button:SetText("Vellum");
		tradeskill_button:SetScript("OnClick", CraftBuster_Module_Enchanting_Tradeskill_OnClick);
		tradeskill_button:SetScript("OnEnter", function(self)
			GameTooltip_SetDefaultAnchor(GameTooltip, self);
			for i=1, CBL["TRADESKILL_NUMLINES"] do
				GameTooltip:AddLine(CBL["TRADESKILL_LINE" .. i]);
			end
			GameTooltip:Show();
		end);
		tradeskill_button:SetScript("OnLeave", GameTooltip_Hide);
		tradeskill_button:Hide();
	end
	
	local _,_,_,_,tradeskill_type = GetTradeSkillInfo(tradeskill_id);
	if (tradeskill_type == ENSCRIBE and CraftBuster_Module_Enchanting_CheckMake(tradeskill_id)) then
		tradeskill_button:Show();
	else
		tradeskill_button:Hide();
	end
end

local function CraftBuster_Module_Enchanting_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		trainer_map_icons = SKILL_TRAINER_MAP_ICONS,
		spell_1 = SKILL_SPELL_1ID,
		spell_2 = SKILL_SPELL_2ID,
		spell_buster = SKILL_SPELL_2ID,
		bustable_spell = SKILL_BUST_SPELLID,
		bustable_function = CraftBuster_Module_Enchanting_GetBustables,
		action_function = CraftBuster_Module_Enchanting_HandleAction,
		tradeskill_function = CraftBuster_Module_Enchanting_HandleTradeskill,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Enchanting_OnLoad();