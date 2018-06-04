local _, cb = ...;

MAX_BUSTER_ITEMS = 16;
BUSTER_ITEM_WRAP = 4;
MAX_BUSTER_LINES = ceil(MAX_BUSTER_ITEMS / BUSTER_ITEM_WRAP);
BUSTER_ICON_ROW_HEIGHT = 36;

cb.modules.buster_frame = {};
cb.modules.buster_frame.mover_frame = CreateFrame("Frame", "CraftBuster_BusterFrame_MoverFrame", UIParent, "CraftBuster_MoverBar_Template");
cb.modules.buster_frame.mover_frame:SetSize(180, 10);
cb.modules.buster_frame.mover_frame:RegisterForDrag("LeftButton");
cb.modules.buster_frame.mover_frame:SetScript("OnDragStart", function(self)
	if (not cb.settings:get().buster_frame.locked) then
		self.dragging = true;
		self:StartMoving();
	end
end);
cb.modules.buster_frame.mover_frame:SetScript("OnDragStop", function(self)
	if (not cb.settings:get().buster_frame.locked) then
		self.dragging = false;
		self:StopMovingOrSizing();
	end
end);
cb.modules.buster_frame.mover_frame:SetScript("OnUpdate", function(self)
	if (self.dragging) then
		cb.modules.buster_frame:dragFrame();
	end
end);
cb.modules.buster_frame.mover_frame:Hide();
CraftBuster_BusterFrame_MoverFrameTexture:SetSize(180, 16);
CraftBuster_BusterFrame_MoverFrameLabel:SetText(CBL["BUSTER_FRAME_HEADER"]);
CraftBuster_BusterFrame_MoverFrame_LockFrame:SetScript("OnClick", function(self)
	cb.modules.buster_frame:lockFrame();
end);
CraftBuster_BusterFrame_MoverFrame_CollapseFrame:SetScript("OnClick", function(self)
	cb.modules.buster_frame:collapseFrame();
end);
CraftBuster_BusterFrame_MoverFrame_CloseFrame:SetScript("OnClick", function(self)
	cb.modules.buster_frame:closeFrame();
end);

cb.modules.buster_frame.frame = CreateFrame("Frame", "CraftBuster_BusterFrame_Frame", UIParent, "CraftBuster_ContainerFrame_Template");
cb.modules.buster_frame.frame:SetSize(180, 185);
cb.modules.buster_frame.frame:SetPoint("TOPLEFT", cb.modules.buster_frame.mover_frame, "BOTTOMLEFT", 0, 2);
cb.modules.buster_frame.frame:RegisterEvent("ADDON_LOADED");
cb.modules.buster_frame.frame:SetScript("OnEvent", function(self, event, ...)
	if (cb.settings.init) then
		return cb.modules.buster_frame[event] and cb.modules.buster_frame[event](cb, ...)
	end
end);
cb.modules.buster_frame.frame:SetScript("OnShow", function(self, ...)
	self:RegisterEvent("BAG_UPDATE");
	self:RegisterEvent("UNIT_SPELLCAST_START");
	self:RegisterEvent("UNIT_SPELLCAST_SENT");
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:RegisterEvent("UNIT_SPELLCAST_FAILED");
	self:RegisterEvent("UNIT_SPELLCAST_STOP");
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	self:RegisterEvent("GET_ITEM_INFO_RECEIVED");
	cb.modules.buster_frame:updatePosition();
end);
cb.modules.buster_frame.frame:SetScript("OnHide", function(self, ...)
	self:UnregisterEvent("BAG_UPDATE");
	self:UnregisterEvent("UNIT_SPELLCAST_START");
	self:UnregisterEvent("UNIT_SPELLCAST_SENT");
	self:UnregisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	self:UnregisterEvent("UNIT_SPELLCAST_FAILED");
	self:UnregisterEvent("UNIT_SPELLCAST_STOP");
	self:UnregisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	self:UnregisterEvent("GET_ITEM_INFO_RECEIVED");
end);
cb.modules.buster_frame.frame:Hide();

cb.modules.buster_frame.frame.none_found = cb.modules.buster_frame.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
cb.modules.buster_frame.frame.none_found:SetPoint("CENTER");
cb.modules.buster_frame.frame.none_found:SetText(CBL["BUSTER_FRAME_NONE_FOUND"]);

cb.modules.buster_frame.frame.scroll_frame = CreateFrame("ScrollFrame", cb.modules.buster_frame.frame:GetName() .. "_ScrollFrame", cb.modules.buster_frame.frame, "FauxScrollFrameTemplate");
cb.modules.buster_frame.frame.scroll_frame:SetSize(180, 170);
cb.modules.buster_frame.frame.scroll_frame:SetPoint("TOPLEFT", cb.modules.buster_frame.frame, "TOPLEFT", 0, -11);
cb.modules.buster_frame.frame.scroll_frame:SetScript("OnVerticalScroll", function(self, offset, ...)
	FauxScrollFrame_OnVerticalScroll(self, offset, BUSTER_ICON_ROW_HEIGHT, function()
		cb.modules.buster_frame:scrollFrameUpdate();
	end);
end);

cb.modules.buster_frame.frame.scroll_frame.scroll_up = cb.modules.buster_frame.frame.scroll_frame:CreateTexture("ARTWORK");
cb.modules.buster_frame.frame.scroll_frame.scroll_up:SetSize(31, 170);
cb.modules.buster_frame.frame.scroll_frame.scroll_up:SetPoint("TOPLEFT", cb.modules.buster_frame.frame.scroll_frame, "TOPRIGHT", -2, 5);
cb.modules.buster_frame.frame.scroll_frame.scroll_up:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
cb.modules.buster_frame.frame.scroll_frame.scroll_up:SetTexCoord(0, 0.484375, 0, 1.0);
									
cb.modules.buster_frame.frame.scroll_frame.scroll_down = cb.modules.buster_frame.frame.scroll_frame:CreateTexture("ARTWORK");
cb.modules.buster_frame.frame.scroll_frame.scroll_down:SetSize(31, 106);
cb.modules.buster_frame.frame.scroll_frame.scroll_down:SetPoint("BOTTOMLEFT", cb.modules.buster_frame.frame.scroll_frame, "BOTTOMRIGHT", -2, -2);
cb.modules.buster_frame.frame.scroll_frame.scroll_down:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ScrollBar");
cb.modules.buster_frame.frame.scroll_frame.scroll_down:SetTexCoord(0.515625, 1.0, 0, 0.4140625);

cb.modules.buster_frame.item_buttons = {};
cb.modules.buster_frame.items = {};
cb.modules.buster_frame.skill_data = {
	["skill"] = nil,
	["skill_id"] = nil,
	["spell_id"] = nil,
};

function cb.modules.buster_frame:ADDON_LOADED()
	cb.modules.buster_frame.frame:UnregisterEvent("ADDON_LOADED");
end

local last_update = 0;
function cb.modules.buster_frame:BAG_UPDATE()
	if (time() >= last_update) then
		last_update = time() + 1;
		cb.modules.buster_frame:update();
	end
end

function cb.modules.buster_frame:UNIT_SPELLCAST_START(self, ...)
	cb.modules.buster_frame:handleSpellStart(self, ...);
end
function cb.modules.buster_frame:UNIT_SPELLCAST_SENT(self, ...)
	cb.modules.buster_frame:handleSpellStart(self, ...);
end
function cb.modules.buster_frame:handleSpellStart(self, ...)
	local spell_name, rank, spell_line_id_counter, spell_id = ...;
	if (spell_id == cb.modules.buster_frame.skill_data["spell_id"] or spell_name == "Pick Lock") then
		cb.omg:create_timer(2, function()
			cb.modules.buster_frame:update();
		end);
	end
end

function cb.modules.buster_frame:UNIT_SPELLCAST_SUCCEEDED(self, ...)
	cb.modules.buster_frame:handleSpellFinish(self, ...);
end
function cb.modules.buster_frame:UNIT_SPELLCAST_FAILED(self, ...)
	cb.modules.buster_frame:handleSpellFinish(self, ...);
end
function cb.modules.buster_frame:UNIT_SPELLCAST_STOP(self, ...)
	cb.modules.buster_frame:handleSpellFinish(self, ...);
end
function cb.modules.buster_frame:UNIT_SPELLCAST_INTERRUPTED(self, ...)
	cb.modules.buster_frame:handleSpellFinish(self, ...);
end
function cb.modules.buster_frame:handleSpellFinish(self, ...)
	local spell_name, rank, spell_line_id_counter, spell_id = ...;
	if (spell_id == cb.modules.buster_frame.skill_data["spell_id"] or spell_name == "Pick Lock") then
		cb.modules.buster_frame:update();
	end
end

function cb.modules.buster_frame:GET_ITEM_INFO_RECEIVED(self, ...)
	cb.modules.buster_frame:update();
end

function cb.modules.buster_frame:updateSkill(skill, skill_id, spell_id)
	cb.modules.buster_frame.skill_data = {
		["skill"] = skill,
		["skill_id"] = skill_id,
		["spell_id"] = spell_id,
	};
end

function cb.modules.buster_frame:update()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.modules.buster_frame:update(); end);
		return;
	end
	
	local skill_id = cb.modules.buster_frame.skill_data["skill_id"];
	if (skill_id and cb.settings:get().buster_frame.show) then
		if (cb.settings:get().buster_frame.state == "expanded") then
			local module_data = cb.professions.modules[skill_id];
			local count = 0;
			cb.modules.buster_frame.items = {};

			bustables = module_data.bustable_function();
			if (bustables and next(bustables)) then
				for i,item_data in cb.omg:sortedpairs(bustables) do
					local ignored = cb.settings:get().buster_frame.ignored_items[item_data.item_id];
					if (not ignored and (item_data.total >= 5 or skill_id == CBT_SKILL_PICK or skill_id == CBT_SKILL_ENCH)) then
						count = count + 1;
						cb.modules.buster_frame.items[count] = {};
						cb.modules.buster_frame.items[count].item_id = item_data.item_id;
						if (item_data.bag ~= nil and item_data.slot ~= nil) then
							cb.modules.buster_frame.items[count].bag = item_data.bag;
							cb.modules.buster_frame.items[count].slot = item_data.slot;
						end
						cb.modules.buster_frame.items[count].total = item_data.total;
					end
				end
			end

			cb.modules.buster_frame.mover_frame:Show();
			_G[cb.modules.buster_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
			cb.modules.buster_frame.frame:Show();
			if (count > 0) then
				cb.modules.buster_frame.frame.none_found:Hide();
			else
				cb.modules.buster_frame.frame.none_found:Show();
				for i=1, MAX_BUSTER_ITEMS do
					_G["CraftBuster_BusterFrame_Item" .. i]:Hide();
				end
			end
			cb.modules.buster_frame:scrollFrameUpdate();
		else
			cb.modules.buster_frame.mover_frame:Show();
			_G[cb.modules.buster_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			cb.modules.buster_frame.frame:Hide();
		end

		if (not cb.settings:get().buster_frame.locked) then
			_G[cb.modules.buster_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Unlocked");
		else
			_G[cb.modules.buster_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Locked");
		end
	else
		cb.modules.buster_frame.mover_frame:Hide();
		cb.modules.buster_frame.frame:Hide();
	end
end

function cb.modules.buster_frame:scrollFrameInit()
	FauxScrollFrame_SetOffset(cb.modules.buster_frame.frame.scroll_frame, 0);
	
	for i=1, MAX_BUSTER_ITEMS do
		cb.modules.buster_frame.item_buttons[i] = CreateFrame("Button", "CraftBuster_BusterFrame_Item" .. i, cb.modules.buster_frame.frame, "CraftBuster_BusterFrame_Button_Template");
		if (i == 1) then
			cb.modules.buster_frame.item_buttons[i]:SetPoint("TOPLEFT", cb.modules.buster_frame.frame.scroll_frame, "TOPLEFT", 11, 0);
		elseif (mod(i, BUSTER_ITEM_WRAP) == 1) then
			cb.modules.buster_frame.item_buttons[i]:SetPoint("TOPLEFT", "CraftBuster_BusterFrame_Item" .. (i - BUSTER_ITEM_WRAP), "BOTTOMLEFT", 0, -5);
		else
			cb.modules.buster_frame.item_buttons[i]:SetPoint("TOPLEFT", "CraftBuster_BusterFrame_Item" .. (i - 1), "TOPRIGHT", 5, 0);
		end
		cb.modules.buster_frame.item_buttons[i]:SetID(i);
		cb.modules.buster_frame.item_buttons[i]:SetScript("OnEnter", function(self, ...)
			if (self.item_link) then
				local x = self:GetRight();
				if (x >= (GetScreenWidth() / 2)) then
					GameTooltip:SetOwner(self, "ANCHOR_LEFT");
				else
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				end
				GameTooltip:SetHyperlink(self.item_link);
				GameTooltip:AddLine(" ");
				GameTooltip:AddLine(CBL["BUSTER_FRAME_CLICK"] .. GetSpellLink(self.spell_id));
				GameTooltip:AddLine(CBL["BUSTER_FRAME_IGNORE"]);
				GameTooltip:Show();
			end
		end);
	end
end
cb.modules.buster_frame:scrollFrameInit();

function cb.modules.buster_frame:scrollFrameUpdate()
	local offset = FauxScrollFrame_GetOffset(cb.modules.buster_frame.frame.scroll_frame);
	
	for i=1, MAX_BUSTER_ITEMS do
		local button_frame_name = "CraftBuster_BusterFrame_Item" .. i;
		local button_frame = _G[button_frame_name];
		local index = (offset * BUSTER_ITEM_WRAP) + i;
		if (cb.modules.buster_frame.items[index] and next(cb.modules.buster_frame.items[index])) then
			local item_data = cb.modules.buster_frame.items[index];

			local spell_name = GetSpellInfo(cb.modules.buster_frame.skill_data["spell_id"]);
			local item_name,item_link,_,_,_,_,_,_,_,item_texture = GetItemInfo(item_data.item_id);
			SetItemButtonTexture(button_frame, item_texture);
			SetItemButtonCount(button_frame, item_data.total);
			button_frame.spell_id = cb.modules.buster_frame.skill_data["spell_id"];
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
			button_frame:SetAttribute("_function", function()
				if (not InCombatLockdown() and IsControlKeyDown()) then
					cb.settings:get().buster_frame.ignored_items[item_data.item_id] = true;
					cb.modules.buster_frame:update();
				end
			end);
			button_frame:Show();
		else
			button_frame:Hide();
		end
	end

	FauxScrollFrame_Update(cb.modules.buster_frame.frame.scroll_frame, ceil(cb.omg:tcount(cb.modules.buster_frame.items) / BUSTER_ITEM_WRAP), MAX_BUSTER_LINES, BUSTER_ICON_ROW_HEIGHT);
end

function cb.modules.buster_frame:clearIgnore()
	cb.settings:get().buster_frame.ignored_items = {};
	cb.modules.buster_frame:update();
end

function cb.modules.buster_frame:lockFrame()
	if (not cb.settings:get().buster_frame.locked) then
		cb.settings:get().buster_frame.locked = true;
	else
		cb.settings:get().buster_frame.locked = false;
	end
	cb.modules.buster_frame:update();
end

function cb.modules.buster_frame:collapseFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.modules.buster_frame:collapseFrame(); end);
		return;
	end
	
	if (cb.modules.buster_frame.frame:IsShown()) then
		cb.modules.buster_frame.frame:Hide();
		cb.settings:get().buster_frame.state = "collapsed";
	else
		cb.modules.buster_frame.frame:Show();
		cb.settings:get().buster_frame.state = "expanded";
	end
	cb.modules.buster_frame:update();
end

function CraftBuster_BusterFrame_Collapse_OnClick()
	cb.modules.buster_frame:collapseFrame();
end

function cb.modules.buster_frame:closeFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.modules.buster_frame:closeFrame(); end);
		return;
	end
	
	cb.modules.buster_frame.mover_frame:Hide();
	cb.modules.buster_frame.frame:Hide();
	if (not cb.modules.buster_frame.mover_frame:IsShown()) then
		cb.settings:get().buster_frame.show = false;
	end
end

function cb.modules.buster_frame:dragFrame()
	local point, _, relative_point, x, y = cb.modules.buster_frame.mover_frame:GetPoint();
	cb.settings:get().buster_frame.position.point = point;
	cb.settings:get().buster_frame.position.relative_point = relative_point;
	cb.settings:get().buster_frame.position.x = x;
	cb.settings:get().buster_frame.position.y = y;
	cb.modules.buster_frame:updatePosition();
end

function cb.modules.buster_frame:updatePosition()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.modules.buster_frame:updatePosition(); end);
		return;
	end
	local position = cb.settings:get().buster_frame.position;
	cb.modules.buster_frame.mover_frame:ClearAllPoints();
	cb.modules.buster_frame.mover_frame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function cb.modules.buster_frame:resetPosition()
	cb.settings:get().buster_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	cb.modules.buster_frame:updatePosition();
end