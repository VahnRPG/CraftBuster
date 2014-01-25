local MAX_GATHER_RECORDS = 100;
local saved_gather = {
	["zones"] = {},
	["skill"] = {},
};

local function CraftBuster_GatherFrame_UpdateBar(label, data)
	local icon_frame = getglobal(label .. "Icon");
	local item_name,item_link,_,_,_,_,_,_,_,item_texture = GetItemInfo(data["item_id"]);
	getglobal(icon_frame:GetName() .. "Icon"):SetTexture(item_texture);
	icon_frame.item_id = data["item_id"];
	icon_frame.item_link = item_link;

	getglobal(label .. "Label"):SetText(data["name"]);
	getglobal(label .. "Orange"):SetText(ORANGE_FONT_COLOR_CODE .. data["levels"][1]);
	getglobal(label .. "Yellow"):SetText(YELLOW_FONT_COLOR_CODE .. data["levels"][2]);
	getglobal(label .. "Green"):SetText(GREEN_FONT_COLOR_CODE .. data["levels"][3]);
	getglobal(label .. "Grey"):SetText(GRAY_FONT_COLOR_CODE .. data["levels"][4]);

	getglobal(label):Show();
end

function CraftBuster_GatherFrame_Reset()
	saved_gather = {
		["zones"] = {},
		["skill"] = {},
	};
	
	if (getglobal("CraftBuster_GatherFrameZoneNode100") == nil) then
		local frame;
		for i=1,MAX_GATHER_RECORDS do
			frame = CreateFrame("Frame", "CraftBuster_GatherFrameZoneNode" .. i, CraftBuster_GatherFrame, "CraftBuster_Gather_BarTemplate");
			frame = CreateFrame("Frame", "CraftBuster_GatherFrameSkillNode" .. i, CraftBuster_GatherFrame, "CraftBuster_Gather_BarTemplate");
		end
	end
end

function CraftBuster_GatherFrame_AddGather(gather_data)
	if (gather_data["zones"] and next(gather_data["zones"])) then
		for i, zone_data in sortedpairs(gather_data["zones"]) do
			table.insert(saved_gather["zones"], zone_data);
		end
	end
	if (gather_data["skill"] and next(gather_data["skill"])) then
		for i, skill_data in sortedpairs(gather_data["skill"]) do
			table.insert(saved_gather["skill"], skill_data);
		end
	end
end

function CraftBuster_GatherFrame_Update()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_GatherFrame_Update", skills);
		return;
	end
	if (CraftBusterOptions[CraftBusterEntry].gather_frame.show) then
		if (CraftBusterOptions[CraftBusterEntry].gather_frame.state == "expanded") then
			for i=1,MAX_GATHER_RECORDS do
				getglobal("CraftBuster_GatherFrameZoneNode" .. i):Hide();
				getglobal("CraftBuster_GatherFrameSkillNode" .. i):Hide();
			end

			local count = 0;
			local padding = 0;
			local label = "";
			if (CraftBusterOptions[CraftBusterEntry].gather_frame.show_zone_nodes and saved_gather["zones"] and next(saved_gather["zones"])) then
				padding = padding + 1;
				CraftBuster_GatherFrameZoneNodes:SetPoint("TOP", "CraftBuster_GatherFrame", "TOP", 0, -10);
				CraftBuster_GatherFrameZoneNodes:Show();
				for i, zone_data in sortedpairs(saved_gather["zones"]) do
					CraftBuster_GatherFrame_UpdateBar("CraftBuster_GatherFrameZoneNode" .. i, zone_data);
					getglobal("CraftBuster_GatherFrameZoneNode" .. i):SetPoint("TOPLEFT", "CraftBuster_GatherFrame", "TOPLEFT", 5, -((count + padding) * 20) - 5);
					count = count + 1;
				end
			else
				CraftBuster_GatherFrameZoneNodes:Hide();
			end
			if (CraftBusterOptions[CraftBusterEntry].gather_frame.show_skill_nodes and saved_gather["skill"] and next(saved_gather["skill"])) then
				padding = padding + 1;
				CraftBuster_GatherFrameSkillNodes:SetPoint("TOP", "CraftBuster_GatherFrame", "TOP", 0, -((count + padding - 1) * 20) - 10);
				CraftBuster_GatherFrameSkillNodes:Show();
				for i, skill_data in sortedpairs(saved_gather["skill"]) do
					CraftBuster_GatherFrame_UpdateBar("CraftBuster_GatherFrameSkillNode" .. i, skill_data);
					getglobal("CraftBuster_GatherFrameSkillNode" .. i):SetPoint("TOPLEFT", "CraftBuster_GatherFrame", "TOPLEFT", 5, -((count + padding) * 20) - 5);
					count = count + 1;
				end
			else
				CraftBuster_GatherFrameSkillNodes:Hide();
			end

			if (count > 0) then
				CraftBuster_GatherFrameNoneFound:Hide();
				CraftBuster_Gather_MoverFrame:Show();
				CraftBuster_Gather_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				CraftBuster_GatherFrame:SetHeight(15 + ((count + padding) * 20));
				CraftBuster_GatherFrame:Show();
			else
				CraftBuster_GatherFrameNoneFound:Show();
				CraftBuster_Gather_MoverFrame:Show();
				CraftBuster_Gather_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Collapse");
				CraftBuster_GatherFrame:SetHeight(28);
				CraftBuster_GatherFrame:Show();
			end
		else
			CraftBuster_Gather_MoverFrame:Show();
			CraftBuster_Gather_MoverFrame_CollapseFrame:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Mover_Expand");
			CraftBuster_GatherFrame:Hide();
		end
	else
		CraftBuster_Gather_MoverFrame:Hide();
		CraftBuster_GatherFrame:Hide();
	end
end

function CraftBuster_GatherFrame_Collapse_OnClick()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_GatherFrame_Collapse_OnClick");
		return;
	end
	if (CraftBuster_GatherFrame:IsShown()) then
		CraftBuster_GatherFrame:Hide();
		CraftBusterOptions[CraftBusterEntry].gather_frame.state = "collapsed";
	else
		CraftBuster_GatherFrame:Show();
		CraftBusterOptions[CraftBusterEntry].gather_frame.state = "expanded";
	end
	CraftBuster_GatherFrame_Update();
end

function CraftBuster_GatherFrame_Close_OnClick()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_GatherFrame_Close_OnClick");
		return;
	end
	CraftBuster_Gather_MoverFrame:Hide();
	CraftBuster_GatherFrame:Hide();
	if (not CraftBuster_Gather_MoverFrame:IsShown()) then
		CraftBusterOptions[CraftBusterEntry].gather_frame.show = false;
	end
end

function CraftBuster_GatherFrame_OnDrag()
	local point, _, relative_point, x, y = CraftBuster_Gather_MoverFrame:GetPoint();
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.point = point;
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.relative_point = relative_point;
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.x = x;
	CraftBusterOptions[CraftBusterEntry].gather_frame.position.y = y;
	CraftBuster_GatherFrame_UpdatePosition();
end

function CraftBuster_GatherFrame_UpdatePosition()
	if (InCombatLockdown()) then
		CraftBuster_AddLeaveCombatCommand("CraftBuster_GatherFrame_UpdatePosition");
		return;
	end
	local position = CraftBusterOptions[CraftBusterEntry].gather_frame.position;
	CraftBuster_Gather_MoverFrame:ClearAllPoints();
	CraftBuster_Gather_MoverFrame:SetPoint(position.point, nil, position.relative_point, position.x, position.y);
end

function CraftBuster_GatherFrame_ResetPosition()
	CraftBusterOptions[CraftBusterEntry].gather_frame.position = {
		point = "TOPLEFT",
		relative_point = "TOPLEFT",
		x = 490,
		y = -330,
	};
	CraftBuster_GatherFrame_UpdatePosition();
end