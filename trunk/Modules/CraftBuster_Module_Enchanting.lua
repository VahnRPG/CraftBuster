local SKILL_NAME = CBL["SKILL_ENCH"];
local SKILL_SHORT_CODE = "ench";
local SKILL_TYPE = CBG_SKILL_NORMAL;
local SKILL_ID = CBT_SKILL_ENCH;
local SKILL_SPELL_1ID = 7411;		--Enchanting
local SKILL_SPELL_2ID = 13262;		--Disenchant
local SKILL_BUST_SPELLID = 1804;
local SKILL_ACTIONS = {};

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
					--echo("Bag: " .. bag .. ", Slot: " .. slot .. " - " .. item_name .. " - " .. item_type .. ", " .. item_sub_type);
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
			--echo(SKILL_NAME .. " Check: " .. CraftBusterPlayerLevel .. " >= " .. data.ply_level .. " and " .. skill_data.level .. " >= " .. data.skill_level);
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