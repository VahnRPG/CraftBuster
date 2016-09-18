MAX_BUSTER_ITEMS = 16;
BUSTER_ITEM_WRAP = 4;
MAX_BUSTER_LINES = ceil(MAX_BUSTER_ITEMS / BUSTER_ITEM_WRAP);
BUSTER_ICON_ROW_HEIGHT = 36;

local saved_skill = nil;
local saved_skill_id = nil;
local saved_spell_id = nil;
local bust_items = {};
local last_update = 0;

local sorting = false;
local sort_paused = 0;
local items_for_sort = {};

local timer_frame = CreateFrame("Frame", "CraftBuster_BusterFrame_Timer");
local timer_last_update = 0;
local function SetTimer(delay, callback)
	timer_last_update = 0;
	timer_frame:SetScript("OnUpdate", function(self, elapsed)
		timer_last_update = timer_last_update + elapsed;
		if (timer_last_update < delay) then
			return;
		end

		timer_last_update = 0;
		callback();
		self:SetScript("OnUpdate", nil);
	end);
end

function CraftBuster_BusterFrame_OnShow(self)
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("UNIT_SPELLCAST_START");
	self:RegisterEvent("UNIT_SPELLCAST_SENT");
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:RegisterEvent("UNIT_SPELLCAST_FAILED");
	self:RegisterEvent("UNIT_SPELLCAST_STOP");
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
end

function CraftBuster_BusterFrame_OnHide(self)
	self:UnregisterEvent("BAG_UPDATE");
	self:UnregisterEvent("UNIT_SPELLCAST_START");
	self:UnregisterEvent("UNIT_SPELLCAST_SENT");
	self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:UnregisterEvent("UNIT_SPELLCAST_FAILED");
	self:UnregisterEvent("UNIT_SPELLCAST_STOP");
	self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
end

function CraftBuster_BusterFrame_OnEvent(self, event, ...)
	if (event == "BAG_UPDATE") then
		if (time() >= last_update) then
			last_update = time() + 1;
			CraftBuster_BusterFrame_Update(saved_skill, saved_skill_id, saved_spell_id);
		end
	elseif (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_SENT") then
		local _, spell_name, _, _, spell_id = ...;
		if (spell_id == saved_spell_id or spell_name == "Pick Lock") then
			SetTimer(1, function()
				CraftBuster_BusterFrame_Update(saved_skill, saved_skill_id, saved_spell_id);
			end);
		end
	elseif (event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_INTERRUPTED") then
		local _, _, _, _, spell_id = ...;
		if (spell_id == saved_spell_id) then
			CraftBuster_BusterFrame_Update(saved_skill, saved_skill_id, saved_spell_id);
		end
	end
end

function CraftBuster_BusterFrame_OnUpdate(self, elapsed)
--[[
	if (not sorting) then
		return;
	end

	sort_paused = sort_paused - elapsed;
	if (sort_paused > 0) then
		return;
	end

	local changed = false;
	local blocked = false;

	for bag in pairs(items_for_sort) do
		for slot in pairs(items_for_sort[bag]) do
			local split = items_for_sort[bag][slot].split;
			local dest_bag = items_for_sort[bag][slot].dest_bag;
			local dest_slot = items_for_sort[bag][slot].dest_slot;

			--see if either item slot is currently locked
			local _, _, locked1 = GetContainerItemInfo(bag, slot);
			local _, _, locked2 = GetContainerItemInfo(destinationBag, destinationSlot);
			
			if locked1 or locked2 then
				blocked = true;
			elseif bag ~= dest_bag or slot ~= dest_slot then
				if (split > 0) then
					SplitContainerItem(bag, slot, split);
					if (dest_bag == 0) then
						PutItemInBackpack();
					else
						PutItemInBag(19 + dest_bag);
					end
				else
					PickupContainerItem(bag, slot);
					PickupContainerItem(dest_bag, dest_slot);
				end
				
				local temp = items_for_sort[dest_bag][dest_slot];
				items_for_sort[dest_bag][dest_slot] = items_for_sort[bag][slot];
				items_for_sort[bag][slot] = temp;
				
				changed = true;
			end
		end
	end

	if (not changed and not blocked) then
		sorting = false;
		items_for_sort = {};
		echo("Buster Update!");
	end

	sort_paused = .05;
]]--
end

function CraftBuster_BusterFrame_Update(skill, skill_id, spell_id)
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_BusterFrame_Update", skill, skill_id, spell_id);
		return;
	end
	
	saved_skill = skill;
	saved_skill_id = skill_id;
	saved_spell_id = spell_id;
	local skill_data = CraftBusterOptions[CraftBusterEntry].skills[skill];
	local module_data = CraftBuster_Modules[saved_skill_id];
	if (CraftBusterOptions[CraftBusterEntry].buster_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].buster_frame.state == "expanded") then
			local count = 0;
			bust_items = {};
			bustables = module_data.bustable_function();
			if (bustables and next(bustables)) then
				for i,item_data in sortedpairs(bustables) do
					local ignored = CraftBusterOptions[CraftBusterEntry].buster_frame.ignored_items[item_data.item_id];
					if (not ignored and (item_data.total >= 5 or skill_id == CBT_SKILL_PICK or skill_id == CBT_SKILL_ENCH)) then
						count = count + 1;
						bust_items[count] = {};
						bust_items[count].item_id = item_data.item_id;
						if (item_data.bag ~= nil and item_data.slot ~= nil) then
							bust_items[count].bag = item_data.bag;
							bust_items[count].slot = item_data.slot;
						end
						bust_items[count].total = item_data.total;
					end
				end
			end

			CraftBuster_Buster_MoverFrame:Show();
			CraftBuster_Buster_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
			CraftBuster_BusterFrame:Show();
			if (count > 0) then
				CraftBuster_BusterFrameNoneFound:Hide();
				if (module_data.sort_function ~= nil) then
					--CraftBuster_BusterFrameActionsFrame:Show();
				end
			else
				CraftBuster_BusterFrameNoneFound:Show();
				for i=1, MAX_BUSTER_ITEMS do
					_G["CraftBuster_BusterFrameItem" .. i]:Hide();
				end
			end
			CraftBuster_BusterFrame_ScrollFrame_Update();
		else
			CraftBuster_Buster_MoverFrame:Show();
			CraftBuster_Buster_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			CraftBuster_BusterFrame:Hide();
		end
	else
		CraftBuster_Buster_MoverFrame:Hide();
		CraftBuster_BusterFrame:Hide();
	end
end

function CraftBuster_BusterFrame_ScrollFrame_OnLoad(self)
	FauxScrollFrame_SetOffset(CraftBuster_BusterFrameScrollFrame, 0);

	local button_frame;
	for i=1, MAX_BUSTER_ITEMS do
		button_frame = CreateFrame("Button", "CraftBuster_BusterFrameItem" .. i, CraftBuster_BusterFrame, "CraftBuster_Buster_ButtonTemplate");
		button_frame:SetID(i);
		if (i == 1) then
			button_frame:SetPoint("TOPLEFT", self, "TOPLEFT", 11, 0);
		elseif (mod(i, BUSTER_ITEM_WRAP) == 1) then
			button_frame:SetPoint("TOPLEFT", "CraftBuster_BusterFrameItem" .. (i - BUSTER_ITEM_WRAP), "BOTTOMLEFT", 0, -5);
		else
			button_frame:SetPoint("TOPLEFT", "CraftBuster_BusterFrameItem" .. (i - 1), "TOPRIGHT", 5, 0);
		end
	end
end

function CraftBuster_BusterFrame_ScrollFrame_Update()
	local offset = FauxScrollFrame_GetOffset(CraftBuster_BusterFrameScrollFrame);
	
	for i=1, MAX_BUSTER_ITEMS do
		local button_frame_name = "CraftBuster_BusterFrameItem" .. i;
		local button_frame = _G[button_frame_name];
		local index = (offset * BUSTER_ITEM_WRAP) + i;
		if (bust_items[index] and next(bust_items[index])) then
			local item_data = bust_items[index];

			local spell_name = GetSpellInfo(saved_spell_id);
			local item_name,item_link,_,_,_,_,_,_,_,item_texture = GetItemInfo(item_data.item_id);
			SetItemButtonTexture(button_frame, item_texture);
			SetItemButtonCount(button_frame, item_data.total);
			button_frame.spell_id = saved_spell_id;
			button_frame.item_id = item_data.item_id;
			button_frame.item_link = item_link;
			button_frame:SetAttribute("type1", "spell");
			button_frame:SetAttribute("spell1", spell_name);
			button_frame:SetAttribute("item*", ATTRIBUTE_NOOP);
			if (item_data.bag ~= nil and item_data.slot ~= nil) then
				button_frame:SetAttribute("target-bag", item_data.bag);
				button_frame:SetAttribute("target-slot", item_data.slot);
			else
				button_frame:SetAttribute("target-item", item_name);
			end
			button_frame:SetAttribute("ctrl-type2", "function");
			button_frame:SetAttribute("_function", CraftBuster_Buster_Button_Ignore_Item);
			button_frame:Show();
		else
			button_frame:Hide();
		end
	end

	FauxScrollFrame_Update(CraftBuster_BusterFrameScrollFrame, ceil(tcount(bust_items) / BUSTER_ITEM_WRAP), MAX_BUSTER_LINES, BUSTER_ICON_ROW_HEIGHT);
end

function CraftBuster_BusterFrame_Collapse_OnClick()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_BusterFrame_Collapse_OnClick");
		return;
	end
	if (CraftBusterOptions[CraftBusterEntry].buster_frame.state == "expanded") then
		CraftBuster_BusterFrame:Hide();
		if (not CraftBuster_BusterFrame:IsShown()) then
			CraftBusterOptions[CraftBusterEntry].buster_frame.state = "collapsed";
		end
	else
		CraftBuster_BusterFrame:Show();
		if (CraftBuster_BusterFrame:IsShown()) then
			CraftBusterOptions[CraftBusterEntry].buster_frame.state = "expanded";
		end
	end
	if (saved_skill_id ~= nil and saved_spell_id ~= nil) then
		CraftBuster_BusterFrame_Update(saved_skill, saved_skill_id, saved_spell_id);
	end
end

function CraftBuster_BusterFrame_Close_OnClick()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_BusterFrame_Close_OnClick");
		return;
	end
	CraftBuster_Buster_MoverFrame:Hide();
	CraftBuster_BusterFrame:Hide();
	if (not CraftBuster_Buster_MoverFrame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].buster_frame.show = false;
	end
end

function CraftBuster_BusterFrame_OnDrag()
	local point, _, relative_point, x, y = CraftBuster_Buster_MoverFrame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].buster_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].buster_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].buster_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].buster_frame.position.y = y;
	CraftBuster_BusterFrame_UpdatePosition();
end

function CraftBuster_BusterFrame_UpdatePosition()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_BusterFrame_UpdatePosition");
		return;
	end
	local position = CraftBusterOptions[CraftBusterEntry].buster_frame.position;
	CraftBuster_Buster_MoverFrame:ClearAllPoints();
	CraftBuster_Buster_MoverFrame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function CraftBuster_BusterFrame_ResetPosition()
	CraftBusterOptions[CraftBusterEntry].buster_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	CraftBuster_BusterFrame_UpdatePosition();
end

function CraftBuster_BusterFrame_ClearIgnore()
	CraftBusterOptions[CraftBusterEntry].buster_frame.ignored_items = {};
	if (saved_skill ~= nil and saved_skill_id ~= nil and saved_spell_id ~= nil) then
		CraftBuster_BusterFrame_Update(saved_skill, saved_skill_id, saved_spell_id);
	end
end

function CraftBuster_Buster_Button_Ignore_Item(self)
	if (not InCombatLockdown() and IsControlKeyDown()) then
		CraftBusterOptions[CraftBusterEntry].buster_frame.ignored_items[self.item_id] = true;
		CraftBuster_BusterFrame_Update(saved_skill, saved_skill_id, saved_spell_id);
	end
end

function CraftBuster_Buster_Button_OnEnter(self)
	local x = self:GetRight();
	if (x >= (GetScreenWidth() / 2)) then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end
	GameTooltip:SetHyperlink(self.item_link);
	GameTooltip:AddLine(" ");
	GameTooltip:AddLine(CBL["BUSTER_CLICK"] .. GetSpellLink(self.spell_id));
	GameTooltip:AddLine(CBL["BUSTER_IGNORE"]);
	GameTooltip:Show();
end

function CraftBuster_BusterFrameSort(self)
	local module_data = CraftBuster_Modules[saved_skill_id];
	if (module_data.sort_function ~= nil) then
		CraftBuster_BusterFrameActionsFrameProcessing:Show();
		module_data.sort_function();
		CraftBuster_BusterFrameActionsFrameProcessing:Hide();
	end
end

function CraftBuster_BusterFrame_SortItems(sort_items)
	sorting = true;
	items_for_sort = sort_items;
end