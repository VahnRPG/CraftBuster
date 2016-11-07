local _, cb = ...;

cb.minimap = {};
cb.minimap.frame = CreateFrame("Frame", "CraftBuster_MinimapFrame", Minimap);
cb.minimap.frame:SetFrameStrata("LOW");
cb.minimap.frame:SetPoint("TOPLEFT", Minimap, "RIGHT");
cb.minimap.frame:SetSize(32, 32);
cb.minimap.frame:EnableMouse(true);
cb.minimap.frame:RegisterEvent("ADDON_LOADED");
cb.minimap.frame:SetScript("OnEvent", function(self, event, ...)
	if (CraftBusterInit) then
		return cb.minimap[event] and cb.minimap[event](qb, ...)
	end
end);

--<Frame name="CraftBuster_MinimapFrame" parent="Minimap" enableMouse="true" hidden="false" frameStrata="LOW">
cb.minimap.frame.button = CreateFrame("Button", cb.minimap.frame:GetName() .. "_Button", cb.minimap.frame);
cb.minimap.frame.button:SetPoint("TOPLEFT", cb.minimap.frame, "TOPLEFT");
cb.minimap.frame.button:SetSize(32, 32);
cb.minimap.frame.button:SetNormalTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Minimap_ButtonUp");
cb.minimap.frame.button:SetPushedTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_Minimap_ButtonDown");
cb.minimap.frame.button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");
cb.minimap.frame.button:RegisterForDrag("LeftButton");
cb.minimap.frame.button:RegisterForClicks("RightButtonDown");
cb.minimap.frame.button:SetScript("OnDragStart", function(self)
	self.dragging = true;
	self:StartMoving();
end);
cb.minimap.frame.button:SetScript("OnDragStop", function(self)
	self.dragging = false;
	self:StopMovingOrSizing();
end);
cb.minimap.frame.button:SetScript("OnUpdate", function(self)
	if (self.dragging) then
		cb.minimap:dragFrame(cb.minimap.frame:GetName());
	end
end);
cb.minimap.frame.button:SetScript("OnEnter", function(self, button, down)
	GameTooltip:SetOwner(cb.minimap.frame, "ANCHOR_LEFT");
	GameTooltip:AddLine(CBG_MOD_COLOR .. CBG_MOD_NAME);
	GameTooltip:AddLine(CBL["MINIMAP_HOVER_LINE1"]);
	GameTooltip:AddLine(CBL["MINIMAP_HOVER_LINE2"]);
	GameTooltip:Show();
end);
cb.minimap.frame.button:SetScript("OnLeave", function(self, button, down)
	GameTooltip:Hide();
end);
cb.minimap.frame.button:SetScript("OnClick", function(self, button, down)
	if (button == "RightButton") then
		CraftBuster_Config_Show();
	end
end);

function cb.minimap:ADDON_LOADED()
	if (CraftBusterOptions[CraftBusterEntry].minimap.show) then
		cb.minimap.frame:Show();
	else
		cb.minimap.frame:Hide();
	end
	cb.minimap:updatePosition(cb.minimap.frame:GetName());

	cb.minimap.frame:UnregisterEvent("ADDON_LOADED");
end

function cb.minimap:dragFrame(frame_name)
	local xpos, ypos = GetCursorPosition();
	local xmin, ymin = Minimap:GetLeft(), Minimap:GetBottom();

	xpos = (xmin - xpos) / UIParent:GetScale() + 80;
	ypos = (ypos / UIParent:GetScale()) - ymin - 80;

	local angle = math.deg(math.atan2(ypos, xpos));
	if (angle < 0) then
		angle = angle + 360;
	end;

	CraftBusterOptions[CraftBusterEntry].minimap.position = angle;
	cb.minimap:updatePosition(frame_name);
end

function cb.minimap:updatePosition(frame_name)
	local radius = 80;
	local angle = CraftBusterOptions[CraftBusterEntry].minimap.position;

	_G[frame_name]:SetPoint("TOPLEFT", "Minimap", "TOPLEFT", (52 - (radius * cos(angle))), ((radius * sin(angle)) - 52));
end