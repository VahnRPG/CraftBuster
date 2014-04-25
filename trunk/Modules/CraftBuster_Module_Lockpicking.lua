local SKILL_ID = CBT_SKILL_PICK;
local SKILL_NAME = CBL[CBT_SKILL_PICK];
local SKILL_SHORT_CODE = "pick";
local SKILL_SPELL_1ID = 1804;		--Lockpicking
local SKILL_BUST_SPELLID = 1804;

local PICK_BOXES = {
	["4632"] = "Ornate Bronze Lockbox",
	["4633"] = "Heavy Bronze Lockbox",
	["4634"] = "Iron Lockbox",
	["4636"] = "Strong Iron Lockbox",
	["4637"] = "Steel Lockbox",
	["4638"] = "Reinforced Steel Lockbox",
	["5758"] = "Mithril Lockbox",
	["5759"] = "Thorium Lockbox",
	["5760"] = "Eternium Lockbox",
	["16882"] = "Battered Junkbox",
	["16883"] = "Worn Junkbox",
	["16884"] = "Sturdy Junkbox",
	["16885"] = "Heavy Junkbox",
	["29569"] = "Strong Junkbox",
	["31952"] = "Knorium Lockbox",
	["43575"] = "Reinforced Junkbox",
	["43622"] = "Froststeel Lockbox",
	["43624"] = "Titanium Lockbox",
	["45986"] = "Tiny Titanium Lockbox",
	["63349"] = "Flame-Scarred Junkbox",
	["68729"] = "Elementium Lockbox",
	["88567"] = "Ghost Iron Lockbox",
	["88165"] = "Vine-Cracked Junkbox",
};

local function CraftBuster_Module_Lockpicking_GetBustables()
	local results = {};
	local count = 0;
	for bag=0, 4 do
		for slot=1, GetContainerNumSlots(bag) do
			local _, _, item_id = string.find(GetContainerItemLink(bag, slot) or "", "item:(%d+).+%[(.+)%]");
			if (item_id ~= nil) then
				if (PICK_BOXES[item_id] ~= nil) then
					item_id = tonumber(item_id);
					GameTooltip:SetOwner(WorldFrame);
					GameTooltip:SetBagItem(bag, slot);
					for i = 1, GameTooltip:NumLines() do
						local text = _G[GameTooltip:GetName() .. "TextLeft" .. i]:GetText();
						if (text == "Locked") then
							count = count + 1;
							results[count] = {};
							results[count].item_id = item_id;
							results[count].bag = bag;
							results[count].slot = slot;
							results[count].total = 1;
							break;
						end
					end
					GameTooltip:Hide();
				end
			end
		end
	end

	return results;
end

local function CraftBuster_Module_Lockpicking_OnLoad()
	local module_options = {
		spell_1 = SKILL_SPELL_1ID,
		spell_buster = SKILL_SPELL_1ID,
		bustable_spell = SKILL_BUST_SPELLID,
		bustable_type = LOCKED,
		bustable_function = CraftBuster_Module_Lockpicking_GetBustables,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Lockpicking_OnLoad();