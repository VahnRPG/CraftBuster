local _, cb = ...;

local MAX_FRAMES = 100;

cb.gather_frame = {};
cb.gather_frame.mover_frame = CreateFrame("Frame", "CraftBuster_GatherFrame_MoverFrame", UIParent, "CraftBuster_MoverBar_Template");
cb.gather_frame.mover_frame:SetSize(320, 10);
cb.gather_frame.mover_frame:RegisterForDrag("LeftButton");
cb.gather_frame.mover_frame:SetScript("OnDragStart", function(self)
	if (not CraftBusterOptions[CraftBusterEntry].gather_frame.locked) then
		self.dragging = true;
		self:StartMoving();
	end
end);
cb.gather_frame.mover_frame:SetScript("OnDragStop", function(self)
	if (not CraftBusterOptions[CraftBusterEntry].gather_frame.locked) then
		self.dragging = false;
		self:StopMovingOrSizing();
	end
end);
cb.gather_frame.mover_frame:SetScript("OnUpdate", function(self)
	if (self.dragging) then
		cb.gather_frame:dragFrame();
	end
end);
cb.gather_frame.mover_frame:Hide();
CraftBuster_GatherFrame_MoverFrameTexture:SetSize(320, 16);
CraftBuster_GatherFrame_MoverFrameLabel:SetText(CBL["GATHER_FRAME_HEADER"]);
CraftBuster_GatherFrame_MoverFrame_LockFrame:SetScript("OnClick", function(self)
	cb.gather_frame:lockFrame();
end);
CraftBuster_GatherFrame_MoverFrame_CollapseFrame:SetScript("OnClick", function(self)
	cb.gather_frame:collapseFrame();
end);
CraftBuster_GatherFrame_MoverFrame_CloseFrame:SetScript("OnClick", function(self)
	cb.gather_frame:closeFrame();
end);

cb.gather_frame.frame = CreateFrame("Frame", "CraftBuster_GatherFrame_Frame", UIParent, "CraftBuster_ContainerFrame_Template");
cb.gather_frame.frame:SetSize(320, 10);
cb.gather_frame.frame:SetPoint("TOPLEFT", cb.gather_frame.mover_frame, "BOTTOMLEFT", 0, 2);
cb.gather_frame.frame:RegisterEvent("ADDON_LOADED");
cb.gather_frame.frame:SetScript("OnEvent", function(self, event, ...)
	return cb.gather_frame[event] and cb.gather_frame[event](qb, ...)
end);

cb.gather_frame.frame.none_found = cb.gather_frame.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
cb.gather_frame.frame.none_found:SetPoint("CENTER");
cb.gather_frame.frame.none_found:SetText(CBL["GATHER_FRAME_NONE_FOUND"]);

cb.gather_frame.frame.zone_nodes = cb.gather_frame.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
cb.gather_frame.frame.zone_nodes:SetPoint("CENTER");
cb.gather_frame.frame.zone_nodes:SetText(CBL["GATHER_FRAME_ZONE_NODES"]);
cb.gather_frame.zone_nodes = {};

cb.gather_frame.frame.skill_nodes = cb.gather_frame.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
cb.gather_frame.frame.skill_nodes:SetPoint("CENTER");
cb.gather_frame.frame.skill_nodes:SetText(CBL["GATHER_FRAME_SKILL_NODES"]);
cb.gather_frame.skill_nodes = {};

cb.gather_frame.gather_records = {
	["zones"] = {},
	["skill"] = {},
};

function cb.gather_frame:ADDON_LOADED()
	for i=1,MAX_FRAMES do
		cb.gather_frame.zone_nodes[i] = CreateFrame("Frame", cb.gather_frame.frame:GetName() .. "_ZONE_LINE" .. i, cb.gather_frame.frame, "CraftBuster_ItemLevelsBar_Template");
		cb.gather_frame.skill_nodes[i] = CreateFrame("Frame", cb.gather_frame.frame:GetName() .. "_SKILL_LINE" .. i, cb.gather_frame.frame, "CraftBuster_ItemLevelsBar_Template");
	end

	cb.gather_frame.frame:UnregisterEvent("ADDON_LOADED");
end

function cb.gather_frame:update()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.gather_frame:update(); end);
		return;
	end

	if (CraftBusterOptions[CraftBusterEntry].gather_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded") then
			for i=1,MAX_FRAMES do
				cb.gather_frame.zone_nodes[i]:Hide();
				cb.gather_frame.skill_nodes[i]:Hide();
			end

			local count = 0;
			local padding = 0;
			if (CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes and cb.gather_frame.gather_records["zones"] and next(cb.gather_frame.gather_records["zones"])) then
				padding = padding + 1;
				cb.gather_frame.frame.zone_nodes:SetPoint("TOP", cb.gather_frame.frame, "TOP", 0, -10);
				cb.gather_frame.frame.zone_nodes:Show();
				for i, item_data in cb.omg:sortedpairs(cb.gather_frame.gather_records["zones"]) do
					local node_frame = cb.gather_frame.zone_nodes[i];
					node_frame:SetPoint("TOPLEFT", cb.gather_frame.frame, "TOPLEFT", 5, -((count + padding) * 20) - 5);
					cb.gather_frame:updateBar(node_frame, item_data);
					count = count + 1;
				end
			else
				cb.gather_frame.frame.zone_nodes:Hide();
			end
			if (CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes and cb.gather_frame.gather_records["skill"] and next(cb.gather_frame.gather_records["skill"])) then
				padding = padding + 1;
				cb.gather_frame.frame.skill_nodes:SetPoint("TOP", cb.gather_frame.frame, "TOP", 0, -((count + padding - 1) * 20) - 10);
				cb.gather_frame.frame.skill_nodes:Show();
				for i, item_data in cb.omg:sortedpairs(cb.gather_frame.gather_records["skill"]) do
					local node_frame = cb.gather_frame.skill_nodes[i];
					node_frame:SetPoint("TOPLEFT", cb.gather_frame.frame, "TOPLEFT", 5, -((count + padding) * 20) - 5);
					cb.gather_frame:updateBar(node_frame, item_data);
					count = count + 1;
				end
			else
				cb.gather_frame.frame.skill_nodes:Hide();
			end

			if (count > 0) then
				cb.gather_frame.frame.none_found:Hide();
				cb.gather_frame.mover_frame:Show();
				_G[cb.gather_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				cb.gather_frame.frame:SetHeight(15 + ((count + padding) * 20));
				cb.gather_frame.frame:Show();
			elseif (CraftBusterOptions[CraftBusterEntry].gather_frame.auto_hide) then
				cb.gather_frame.mover_frame:Hide();
				cb.gather_frame.frame:Hide();
			else
				cb.gather_frame.frame.none_found:Show();
				cb.gather_frame.mover_frame:Show();
				_G[cb.gather_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				cb.gather_frame.frame:SetHeight(28);
				cb.gather_frame.frame:Show();
			end
		else
			cb.gather_frame.mover_frame:Show();
			_G[cb.gather_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			cb.gather_frame.frame:Hide();
		end

		if (not CraftBusterOptions[CraftBusterEntry].gather_frame.locked) then
			_G[cb.gather_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Unlocked");
		else
			_G[cb.gather_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Locked");
		end
	else
		cb.gather_frame.mover_frame:Hide();
		cb.gather_frame.frame:Hide();
	end
end

function cb.gather_frame:updateBar(frame, data)
	local frame_name = frame:GetName();
	local icon_frame = _G[frame_name .. "Icon"];
	local item_name,item_link,_,_,_,_,_,_,_,item_texture = GetItemInfo(data["item_id"]);
	_G[icon_frame:GetName() .. "Icon"]:SetTexture(item_texture);
	icon_frame.item_id = data["item_id"];
	icon_frame.item_link = item_link;

	_G[frame_name .. "Label"]:SetText(data["name"]);
	_G[frame_name .. "Orange"]:SetText(ORANGE_FONT_COLOR_CODE .. data["levels"][1]);
	_G[frame_name .. "Yellow"]:SetText(YELLOW_FONT_COLOR_CODE .. data["levels"][2]);
	_G[frame_name .. "Green"]:SetText(GREEN_FONT_COLOR_CODE .. data["levels"][3]);
	_G[frame_name .. "Grey"]:SetText(GRAY_FONT_COLOR_CODE .. data["levels"][4]);

	frame:Show();
end

function cb.gather_frame:reset()
	cb.gather_frame.gather_records = {
		["zones"] = {},
		["skill"] = {},
	};
end

function cb.gather_frame:addGatherData(gather_data)
	if (gather_data["zones"] and next(gather_data["zones"])) then
		for i, zone_data in cb.omg:sortedpairs(gather_data["zones"]) do
			table.insert(cb.gather_frame.gather_records["zones"], zone_data);
		end
	end
	if (gather_data["skill"] and next(gather_data["skill"])) then
		for i, skill_data in cb.omg:sortedpairs(gather_data["skill"]) do
			table.insert(cb.gather_frame.gather_records["skill"], skill_data);
		end
	end
end

function cb.gather_frame:lockFrame()
	if (not CraftBusterOptions[CraftBusterEntry].gather_frame.locked) then
		CraftBusterOptions[CraftBusterEntry].gather_frame.locked = true;
	else
		CraftBusterOptions[CraftBusterEntry].gather_frame.locked = false;
	end
	cb.gather_frame:update();
end

function cb.gather_frame:collapseFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.gather_frame:collapseFrame(); end);
		return;
	end
	
	if (cb.gather_frame.frame:IsShown()) then
		cb.gather_frame.frame:Hide();
		CraftBusterOptions[CraftBusterEntry].gather_frame.state = "collapsed";
	else
		cb.gather_frame.frame:Show();
		CraftBusterOptions[CraftBusterEntry].gather_frame.state = "expanded";
	end
	cb.gather_frame:update();
end

function CraftBuster_GatherFrame_Collapse_OnClick()
	cb.gather_frame:collapseFrame();
end

function cb.gather_frame:closeFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.gather_frame:closeFrame(); end);
		return;
	end
	
	cb.gather_frame.mover_frame:Hide();
	cb.gather_frame.frame:Hide();
	if (not cb.gather_frame.mover_frame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].gather_frame.show = false;
	end
end

function cb.gather_frame:dragFrame()
	local point, _, relative_point, x, y = cb.gather_frame.mover_frame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.y = y;
	cb.gather_frame:updatePosition();
end

function cb.gather_frame:updatePosition()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.gather_frame:updatePosition(); end);
		return;
	end
	local position = CraftBusterOptions[CraftBusterEntry].gather_frame.position;
	cb.gather_frame.mover_frame:ClearAllPoints();
	cb.gather_frame.mover_frame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function cb.gather_frame:resetPosition()
	CraftBusterOptions[CraftBusterEntry].gather_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	cb.gather_frame:updatePosition();
end