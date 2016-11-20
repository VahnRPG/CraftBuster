local _, cb = ...;

local MAX_FRAMES = 100;

cb.worldmap_frame = {};
cb.worldmap_frame.mover_frame = CreateFrame("Frame", "CraftBuster_WorldMapFrame_MoverFrame", WorldMapFrame, "CraftBuster_MoverBar_Template");
cb.worldmap_frame.mover_frame:SetFrameStrata("FULLSCREEN_DIALOG");
cb.worldmap_frame.mover_frame:SetSize(320, 10);
cb.worldmap_frame.mover_frame:RegisterForDrag("LeftButton");
cb.worldmap_frame.mover_frame:SetScript("OnDragStart", function(self)
	if (not CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked) then
		self.dragging = true;
		self:StartMoving();
	end
end);
cb.worldmap_frame.mover_frame:SetScript("OnDragStop", function(self)
	if (not CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked) then
		self.dragging = false;
		self:StopMovingOrSizing();
	end
end);
cb.worldmap_frame.mover_frame:SetScript("OnUpdate", function(self)
	if (self.dragging) then
		cb.worldmap_frame:dragFrame();
	end
end);
cb.worldmap_frame.mover_frame:Hide();
CraftBuster_WorldMapFrame_MoverFrameTexture:SetSize(320, 16);
CraftBuster_WorldMapFrame_MoverFrameLabel:SetText(CBL["WORLDMAP_FRAME_HEADER"]);
CraftBuster_WorldMapFrame_MoverFrame_ConfigMenu:SetScript("OnClick", function(self)
	if (WorldMapFrame:IsShown()) then
		ToggleFrame(WorldMapFrame);
	end
	CraftBuster_Config_Show();
end);
CraftBuster_WorldMapFrame_MoverFrame_LockFrame:SetScript("OnClick", function(self)
	cb.worldmap_frame:lockFrame();
end);
CraftBuster_WorldMapFrame_MoverFrame_CollapseFrame:SetScript("OnClick", function(self)
	cb.worldmap_frame:collapseFrame();
end);
CraftBuster_WorldMapFrame_MoverFrame_CloseFrame:SetScript("OnClick", function(self)
	cb.worldmap_frame:closeFrame();
end);

cb.worldmap_frame.frame = CreateFrame("Frame", "CraftBuster_WorldMapFrame_Frame", WorldMapFrame, "CraftBuster_ContainerFrame_Template");
cb.worldmap_frame.frame:SetFrameStrata("FULLSCREEN_DIALOG");
cb.worldmap_frame.frame:SetSize(320, 10);
cb.worldmap_frame.frame:SetPoint("TOPLEFT", cb.worldmap_frame.mover_frame, "BOTTOMLEFT", 0, 2);
cb.worldmap_frame.frame:RegisterEvent("ADDON_LOADED");
cb.worldmap_frame.frame:RegisterEvent("WORLD_MAP_UPDATE");
cb.worldmap_frame.frame:SetScript("OnEvent", function(self, event, ...)
	return cb.worldmap_frame[event] and cb.worldmap_frame[event](cb, ...)
end);

cb.worldmap_frame.frame.none_found = cb.worldmap_frame.frame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
cb.worldmap_frame.frame.none_found:SetPoint("CENTER");
cb.worldmap_frame.frame.none_found:SetText(CBL["worldmap_frame_NONE_FOUND"]);

cb.worldmap_frame.nodes = {};
cb.worldmap_frame.gather_records = {};

function cb.worldmap_frame:ADDON_LOADED()
	for i=1,MAX_FRAMES do
		cb.worldmap_frame.nodes[i] = CreateFrame("Frame", cb.worldmap_frame.frame:GetName() .. "_NODE_LINE" .. i, cb.worldmap_frame.frame, "CraftBuster_ItemLevelsBar_Template");
		cb.worldmap_frame.nodes[i]:SetFrameStrata("FULLSCREEN_DIALOG");
	end

	cb.worldmap_frame.frame:UnregisterEvent("ADDON_LOADED");
end

function cb.worldmap_frame:WORLD_MAP_UPDATE()
	if (WorldMapFrame:IsShown()) then
		cb.worldmap_frame.update();
		cb.worldmap_frame.updatePosition();
	end
end

function cb.worldmap_frame:update()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.worldmap_frame:update(); end);
		return;
	end

	if (CraftBusterOptions[CraftBusterEntry].worldmap_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].worldmap_frame.state == "expanded") then
			for i=1,MAX_FRAMES do
				cb.worldmap_frame.nodes[i]:Hide();
			end

			local count = 0;
			local current_map_id = GetCurrentMapAreaID();
			if (cb.worldmap_frame.gather_records[current_map_id] and next(cb.worldmap_frame.gather_records[current_map_id])) then
				for skill_id, skill_data in cb.omg:sortedpairs(cb.worldmap_frame.gather_records[current_map_id]) do
					if (CraftBusterOptions[CraftBusterEntry].modules[skill_id].show_worldmap_icons) then
						for i, item_data in cb.omg:sortedpairs(skill_data) do
							count = count + 1;
							local node_frame = cb.worldmap_frame.nodes[i];
							node_frame:SetPoint("TOPLEFT", cb.worldmap_frame.frame, "TOPLEFT", 5, -(count * 20) + 11);
							cb.worldmap_frame:updateBar(node_frame, item_data);
						end
					end
				end
			end

			if (count > 0) then
				cb.worldmap_frame.frame.none_found:Hide();
				cb.worldmap_frame.mover_frame:Show();
				_G[cb.worldmap_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				cb.worldmap_frame.frame:SetHeight(15 + (count * 20));
				cb.worldmap_frame.frame:Show();
			elseif (CraftBusterOptions[CraftBusterEntry].worldmap_frame.auto_hide) then
				cb.worldmap_frame.mover_frame:Hide();
				cb.worldmap_frame.frame:Hide();
			else
				cb.worldmap_frame.frame.none_found:Show();
				cb.worldmap_frame.mover_frame:Show();
				_G[cb.worldmap_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				cb.worldmap_frame.frame:SetHeight(28);
				cb.worldmap_frame.frame:Show();
			end
		else
			cb.worldmap_frame.mover_frame:Show();
			_G[cb.worldmap_frame.mover_frame:GetName() .. "_CollapseFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			cb.worldmap_frame.frame:Hide();
		end

		if (not CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked) then
			_G[cb.worldmap_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Unlocked");
		else
			_G[cb.worldmap_frame.mover_frame:GetName() .. "_LockFrame"]:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Locked");
		end
	else
		cb.worldmap_frame.mover_frame:Hide();
		cb.worldmap_frame.frame:Hide();
	end
end

function cb.worldmap_frame:updateBar(frame, data)
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

function cb.worldmap_frame:addGatherData(skill_id, skill_nodes)
	if (skill_nodes and next(skill_nodes)) then
		for node_name, node_data in cb.omg:sortedpairs(skill_nodes) do
			if (node_data.map_ids and next(node_data.map_ids)) then
				for _, map_id in pairs(node_data.map_ids) do
					if (not cb.worldmap_frame.gather_records[map_id]) then
						cb.worldmap_frame.gather_records[map_id] = {};
					end
					if (not cb.worldmap_frame.gather_records[map_id][skill_id]) then
						cb.worldmap_frame.gather_records[map_id][skill_id] = {};
					end
					
					local rank = node_data["rank"] + 1;
					gather_data = {
						["item_id"] = node_data["item_id"],
						["name"] = node_name,
						["levels"] = node_data["node_levels"],
					};

					cb.worldmap_frame.gather_records[map_id][skill_id][rank] = gather_data;
				end
			end
		end
	end
end

function cb.worldmap_frame:lockFrame()
	if (not CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked) then
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked = true;
	else
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.locked = false;
	end
	cb.worldmap_frame:update();
end

function cb.worldmap_frame:collapseFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.worldmap_frame:collapseFrame(); end);
		return;
	end
	
	if (cb.worldmap_frame.frame:IsShown()) then
		cb.worldmap_frame.frame:Hide();
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.state = "collapsed";
	else
		cb.worldmap_frame.frame:Show();
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.state = "expanded";
	end
	cb.worldmap_frame:update();
end

function CraftBuster_WorldMapFrame_Collapse_OnClick()
	cb.worldmap_frame:collapseFrame();
end

function cb.worldmap_frame:closeFrame()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.worldmap_frame:closeFrame(); end);
		return;
	end
	
	cb.worldmap_frame.mover_frame:Hide();
	cb.worldmap_frame.frame:Hide();
	if (not cb.worldmap_frame.mover_frame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.show = false;
	end
end

function cb.worldmap_frame:dragFrame()
	local point, _, relative_point, x, y = cb.worldmap_frame.mover_frame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.y = y;
	cb.worldmap_frame:updatePosition();
end

function cb.worldmap_frame:updatePosition()
	if (InCombatLockdown()) then
		cb:addLeaveCombatCommand(function() cb.worldmap_frame:updatePosition(); end);
		return;
	end
	local position = CraftBusterOptions[CraftBusterEntry].worldmap_frame.position;
	cb.worldmap_frame.mover_frame:ClearAllPoints();
	cb.worldmap_frame.mover_frame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function cb.worldmap_frame:resetPosition()
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	cb.worldmap_frame:updatePosition();
end