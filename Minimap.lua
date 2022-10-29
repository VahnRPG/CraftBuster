local _, cb = ...;

cb.minimap = {};
cb.minimap.frame = CreateFrame("Frame", "CraftBuster_MinimapFrame", Minimap);
cb.minimap.frame:SetFrameStrata("LOW");
cb.minimap.frame:SetPoint("CENTER", Minimap, "CENTER");
cb.minimap.frame:SetSize(32, 32);
cb.minimap.frame:RegisterEvent("ADDON_LOADED");
cb.minimap.frame:SetScript("OnEvent", function(self, event, ...)
	if (cb.settings.init) then
		return cb.minimap[event] and cb.minimap[event](cb, ...)
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
end);
cb.minimap.frame.button:SetScript("OnDragStop", function(self)
	self.dragging = false;
end);
cb.minimap.frame.button:SetScript("OnUpdate", function(self)
	if (self.dragging) then
		cb.minimap:dragFrame();
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
	cb.minimap:update();

	cb.minimap.frame:UnregisterEvent("ADDON_LOADED");
end

function cb.minimap:update()
	if (cb.settings:get().minimap.show) then
		cb.minimap.frame:Show();
	else
		cb.minimap.frame:Hide();
	end
	cb.minimap:updatePosition();
end

function cb.minimap:dragFrame()
	local cursor_x, cursor_y = GetCursorPosition();
	local minimap_x, minimap_y = Minimap:GetCenter();
	local minimap_scale = Minimap:GetEffectiveScale();

	local position_x = (cursor_x / minimap_scale) - minimap_x;
	local position_y = (cursor_y / minimap_scale) - minimap_y;

	cb.settings:get().minimap.position = math.deg(math.atan2(position_y, position_x)) % 360;
	cb.minimap:updatePosition();
end

function cb.minimap:updatePosition()
	local radius = 105;
	local angle = cb.settings:get().minimap.position;
	
	cb.minimap.frame:SetPoint("CENTER", Minimap, "CENTER", (radius * cos(angle)), (radius * sin(angle)));
end