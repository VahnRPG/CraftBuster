local MAX_FRAMES = 100;
local saved_nodes = {};

local function CraftBuster_WorldMap_UpdateBar(label, item_id, level_data)
	local icon_frame = _G[label .. "Icon"];
	local item_name,item_link,_,_,_,_,_,_,_,item_texture = GetItemInfo(item_id);
	_G[icon_frame:GetName() .. "Icon"]:SetTexture(item_texture);
	icon_frame.item_id = item_id;
	icon_frame.item_link = item_link;

	_G[label .. "Label"]:SetText(item_name);
	_G[label .. "Orange"]:SetText(ORANGE_FONT_COLOR_CODE .. level_data[1]);
	_G[label .. "Yellow"]:SetText(YELLOW_FONT_COLOR_CODE .. level_data[2]);
	_G[label .. "Green"]:SetText(GREEN_FONT_COLOR_CODE .. level_data[3]);
	_G[label .. "Grey"]:SetText(GRAY_FONT_COLOR_CODE .. level_data[4]);

	_G[label]:Show();
end

function CraftBuster_WorldMap_Update()
	if (InCombatLockdown()) then
		return;
	end

	if (CraftBusterOptions[CraftBusterEntry].worldmap_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].worldmap_frame.state == "expanded") then
			for i=1,MAX_FRAMES do
				_G["CraftBuster_WorldMap_Node" .. i]:Hide();
			end

			local count = 0;
			local current_map_id = GetCurrentMapAreaID();
			if (saved_nodes[current_map_id] and next(saved_nodes[current_map_id])) then
				for skill_id, skill_data in sortedpairs(saved_nodes[current_map_id]) do
					if (CraftBusterOptions[CraftBusterEntry].modules[skill_id].show_worldmap_icons) then
						for item_id, item_data in sortedpairs(skill_data) do
							count = count + 1;
							CraftBuster_WorldMap_UpdateBar("CraftBuster_WorldMap_Node" .. count, item_id, item_data);
							_G["CraftBuster_WorldMap_Node" .. count]:SetPoint("TOPLEFT", "CraftBuster_WorldMapFrame", "TOPLEFT", 5, -(count * 20) + 11);
						end
					end
				end
			end

			if (count > 0) then
				CraftBuster_WorldMapFrameNoneFound:Hide();
				CraftBuster_WorldMap_MoverFrame:Show();
				CraftBuster_WorldMap_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				CraftBuster_WorldMapFrame:SetHeight(15 + (count * 20));
				CraftBuster_WorldMapFrame:Show();
			else
				CraftBuster_WorldMapFrameNoneFound:Show();
				CraftBuster_WorldMap_MoverFrame:Show();
				CraftBuster_WorldMap_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				CraftBuster_WorldMapFrame:SetHeight(28);
				CraftBuster_WorldMapFrame:Show();
			end
		else
			CraftBuster_WorldMap_MoverFrame:Show();
			CraftBuster_WorldMap_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			CraftBuster_WorldMapFrame:Hide();
		end
	else
		CraftBuster_WorldMap_MoverFrame:Hide();
		CraftBuster_WorldMapFrame:Hide();
	end
end

function CraftBuster_WorldMap_OnLoad(self)
	for i=1,MAX_FRAMES do
		local frame = CreateFrame("Frame", "CraftBuster_WorldMap_Node" .. i, CraftBuster_WorldMapFrame, "CraftBuster_WorldMap_BarTemplate");
	end

	self:RegisterEvent("WORLD_MAP_UPDATE");
end

function CraftBuster_WorldMap_OnEvent(self, event, ...)
	if (event == "WORLD_MAP_UPDATE" and WorldMapFrame:IsShown()) then
		if (not CraftBusterEntry) then
			return;
		end

		CraftBuster_WorldMap_Update();
	end
end

function CraftBuster_WorldMap_AddNodes(skill_id, skill_nodes)
	if (skill_nodes and next(skill_nodes)) then
		for _, node_data in sortedpairs(skill_nodes) do
			if (node_data.map_ids and next(node_data.map_ids)) then
				for _, map_id in pairs(node_data.map_ids) do
					if (not saved_nodes[map_id]) then
						saved_nodes[map_id] = {};
					end
					if (not saved_nodes[map_id][skill_id]) then
						saved_nodes[map_id][skill_id] = {};
					end

					if (node_data.item_id ~= "") then
						saved_nodes[map_id][skill_id][node_data.item_id] = node_data.node_levels;
					end
				end
			end
		end
	end
end

function CraftBuster_WorldMap_Config_OnClick()
	if (WorldMapFrame:IsShown()) then
		ToggleFrame(WorldMapFrame);
	end
	CraftBuster_Config_Show();
end

function CraftBuster_WorldMap_Collapse_OnClick()
	if (InCombatLockdown()) then
		return;
	end
	if (CraftBuster_WorldMapFrame:IsShown()) then
		CraftBuster_WorldMapFrame:Hide();
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.state = "collapsed";
	else
		CraftBuster_WorldMapFrame:Show();
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.state = "expanded";
	end
	CraftBuster_WorldMap_Update();
end

function CraftBuster_WorldMap_Close_OnClick()
	if (InCombatLockdown()) then
		return;
	end
	CraftBuster_Gather_MoverFrame:Hide();
	CraftBuster_WorldMapFrame:Hide();
	if (not CraftBuster_Gather_MoverFrame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].worldmap_frame.show = false;
	end
end

function CraftBuster_WorldMap_OnDrag()
	local point, _, relative_point, x, y = CraftBuster_Gather_MoverFrame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position.y = y;
	CraftBuster_WorldMap_UpdatePosition();
end

function CraftBuster_WorldMap_UpdatePosition()
	if (InCombatLockdown()) then
		return;
	end
	local position = CraftBusterOptions[CraftBusterEntry].worldmap_frame.position;
	CraftBuster_Gather_MoverFrame:ClearAllPoints();
	CraftBuster_Gather_MoverFrame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function CraftBuster_WorldMap_ResetPosition()
	CraftBusterOptions[CraftBusterEntry].worldmap_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	CraftBuster_WorldMap_UpdatePosition();
end