local _, cb = ...;

local HBD = LibStub("HereBeDragons-1.0");
local HBDPins = LibStub("HereBeDragons-Pins-1.0");

local SKILL_ALL_PROFESSIONS_TRAINERS_MAP_ICONS = {
	[30] = {		--Elwynn Forest
		["Alliance"] = {
			[47384] = { ["name"] = "Lien Farner", ["floor"] = 0, ["pos"] = { 42, 67 } },
		},
	},
	[27] = {		--Dun Morogh
		["Alliance"] = {
			[47396] = { ["name"] = "Wembil Taskwidget", ["floor"] = 0, ["pos"] = { 53.8, 52 } },
		},
	},
	[41] = {		--Teldrassil
		["Alliance"] = {
			[47420] = { ["name"] = "Iranis Shadebloom", ["floor"] = 0, ["pos"] = { 56, 52.2 } },
		},
	},
	[464] = {		--Azuremyst Isle
		["Alliance"] = {
			[47431] = { ["name"] = "Valn", ["floor"] = 0, ["pos"] = { 48.6, 52.2 } },
		},
	},
	[611] = {		--Gilneas City
		["Alliance"] = {
			[50247] = { ["name"] = "Jack \"All-Trades\" Derrington", ["floor"] = 0, ["pos"] = { 37.2, 37.4 } },
		},
	},
	[20] = {		--Tirisfal Glades
		["Horde"] = {
			[47400] = { ["name"] = "Nedric Sallow", ["floor"] = 0, ["pos"] = { 61, 51 } },
			[48619] = { ["name"] = "Therisa Sallow", ["floor"] = 0, ["pos"] = { 44.4, 53 } },
		},
	},
	[4] = {		--Durotar
		["Horde"] = {
			[47418] = { ["name"] = "Runda", ["floor"] = 0, ["pos"] = { 52.8, 42 } },
		},
	},
	[9] = {		--Mulgore
		["Horde"] = {
			[47419] = { ["name"] = "Lalum Darkmane", ["floor"] = 0, ["pos"] = { 46.4, 57.6 } },
		},
	},
	[462] = {		--Eversong Woods
		["Horde"] = {
			[47421] = { ["name"] = "Saren", ["floor"] = 0, ["pos"] = { 48.8, 46.8 } },
		},
	},
	[808] = {		--The Wandering Isle
		["Neutral"] = {
			[57620] = { ["name"] = "Whittler Dewei", ["floor"] = 0, ["pos"] = { 63, 41.4 } },
			[65043] = { ["name"] = "Elder Oakpaw", ["floor"] = 0, ["pos"] = { 50.4, 58.6 } },
		},
	},
};

local CACHED_ICONS = {};
local last_update = 0;

cb.modules.map_icons = {};
cb.modules.map_icons.frame = CreateFrame("Frame", "CraftBuster_MapIcons_Frame", UIParent);
cb.modules.map_icons.frame:RegisterEvent("ADDON_LOADED");
cb.modules.map_icons.frame:SetScript("OnEvent", function(self, event, ...)
	return cb.modules.map_icons[event] and cb.modules.map_icons[event](cb, ...)
end);

cb.modules.map_icons.tooltip_frame = CreateFrame("GameTooltip", "CraftBuster_MapIcons_Tooltip", nil, "GameTooltipTemplate");

function cb.modules.map_icons:ADDON_LOADED(self, ...)
	cb.modules.map_icons:registerModule("all", SKILL_ALL_PROFESSIONS_TRAINERS_MAP_ICONS, CBT_MAP_ICON_TRAINER);
	cb.modules.map_icons.frame:UnregisterEvent("ADDON_LOADED");
end

function cb.modules.map_icons:setTooltipText(icon_data, floor_label)
	if (icon_data.icon_type == CBT_MAP_ICON_TRAINER) then
		cb.modules.map_icons.tooltip_frame:SetText(CBL["MAPICON_TITLE_TRAINER"]);
	elseif (icon_data.icon_type == CBT_MAP_ICON_STATION) then
		cb.modules.map_icons.tooltip_frame:SetText(CBL["MAPICON_TITLE_STATION"]);
	end

	local profession_label = CBL[icon_data.module_id];
	if (icon_data.module_id == "all") then
		profession_label = CBL["SKILL_ALL_PROFESSIONS"];
	end

	cb.modules.map_icons.tooltip_frame:AddLine(floor_label .. CBG_CLR_WHITE .. icon_data.npc_data["name"] .. " - " .. profession_label);
end

function cb.modules.map_icons:updateMinimap(self, elapsed)
	local angle, distance = HBDPins:GetVectorToIcon(self);
	if (not angle) then
		self:Hide();

		return;
	end

	last_update = last_update + elapsed;
	if (last_update < 0.1) then
		return;
	end

	last_update = 0;

	local show = false;
	if (not HBDPins:IsMinimapIconOnEdge(self)) then
		show = true;
	end

	if (show) then
		self.icon:Show();
	else
		self.icon:Hide();
	end
end

function cb.modules.map_icons:createMapIcon(map_id, icon_type, module_id, side, npc_id, npc_data)
	local label = map_id .. "_" .. icon_type .. "_" .. module_id .. "_" .. side .. "_" .. npc_id;
	
	local x1, x2, y1, y2 = unpack(CBG_MAP_ICON_TEXTURES[icon_type][module_id]);
	local minimap_icon_frame = CreateFrame("Button", nil, Minimap);
	minimap_icon_frame:SetHeight(20);
	minimap_icon_frame:SetWidth(20);
	minimap_icon_frame:RegisterForClicks("RightButtonUp");
	minimap_icon_frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	minimap_icon_frame:SetScript("OnEvent", function(self, event, ...)
		if (event == "PLAYER_ENTERING_WORLD") then
			if (not self.icon_data.label) then
				return;
			end

			local icon_data = self.icon_data;
			HBDPins:AddMinimapIconMF(CBG_MOD_NAME, self, icon_data.map_id, icon_data.npc_data["floor"], (icon_data.npc_data["pos"][1] / 100), (icon_data.npc_data["pos"][2] / 100));
			minimap_icon_frame:UnregisterEvent("PLAYER_ENTERING_WORLD");
		end
	end);
	minimap_icon_frame:SetScript("OnUpdate", function(self, elapsed)
		cb.modules.map_icons:updateMinimap(self, elapsed);
	end);
	minimap_icon_frame:SetScript("OnEnter", function(self, event, ...)
		if (not self.icon_data.label) then
			return;
		end

		if (self.icon:IsShown()) then
			if (UIParent:IsVisible()) then
				cb.modules.map_icons.tooltip_frame:SetParent(UIParent);
			else
				cb.modules.map_icons.tooltip_frame:SetParent(self);
			end
			cb.modules.map_icons.tooltip_frame:SetOwner(self, "ANCHOR_BOTTOMLEFT");

			local floor_label = "";
			local _, _, _, floor = HBD:GetPlayerZonePosition();
			if (floor < self.icon_data.npc_data["floor"]) then
				floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:0:16|t";
			elseif (floor > self.icon_data.npc_data["floor"]) then
				floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:16:32|t";
			end

			cb.modules.map_icons:setTooltipText(self.icon_data, floor_label);
			cb.modules.map_icons.tooltip_frame:Show();
		end
	end);
	minimap_icon_frame:SetScript("OnLeave", function(self)
		if (not self.icon_data.label) then
			return;
		end

		if (self.icon:IsShown()) then
			cb.modules.map_icons.tooltip_frame:Hide();
		end
	end);
	minimap_icon_frame:SetScript("OnClick", function(self, button, down)
		if (not self.icon_data.label) then
			return;
		end

		if (self.icon:IsShown() and (self.icon_data.map_id ~= GetCurrentMapAreaID())) then
			--cb.omg:echo("Minimap OnClick: " .. self.icon_data.label);
		end
	end);
	
	minimap_icon_frame.icon = minimap_icon_frame:CreateTexture("BACKGROUND");
	minimap_icon_frame.icon:SetPoint("CENTER", 0, 0);
	minimap_icon_frame.icon:SetTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_MapIcons");
	minimap_icon_frame.icon:SetTexCoord(x1, x2, y1, y2);
	minimap_icon_frame.icon:SetHeight(16);
	minimap_icon_frame.icon:SetWidth(16);

	if (not _G["CraftBuster_MapIcons_Overlay"]) then
		local overlay = CreateFrame("Frame", "CraftBuster_MapIcons_Overlay", WorldMapButton);
		overlay:SetAllPoints(true);
	end

	local worldmap_icon_frame = CreateFrame("Button", nil, CraftBuster_MapIcons_Overlay)
	worldmap_icon_frame:SetHeight(14);
	worldmap_icon_frame:SetWidth(14);
	worldmap_icon_frame:RegisterForClicks("RightButtonUp");
	worldmap_icon_frame:RegisterEvent("WORLD_MAP_UPDATE");
	worldmap_icon_frame:SetScript("OnEvent", function(self, event, ...)
		if (event == "WORLD_MAP_UPDATE") then
			if (not self.icon_data.label or not CraftBusterEntry) then
				return;
			end

			local show = false;
			local icon_data = self.icon_data;
			if (icon_data.worldmap_icon_frame and cb.settings:get().map_icons.show_world_map) then
				if (icon_data.map_id == GetCurrentMapAreaID()) then
					HBDPins:AddWorldMapIconMF(CBG_MOD_NAME, self, icon_data.map_id, icon_data.npc_data["floor"], (icon_data.npc_data["pos"][1] / 100), (icon_data.npc_data["pos"][2] / 100));
					show = true;
				end
			end

			if (show) then
				self:Show();
			else
				self:Hide();
			end
		end
	end);
	worldmap_icon_frame:SetScript("OnEnter", function(self, event, ...)
		if (self.icon:IsShown()) then
			if (UIParent:IsVisible()) then
				cb.modules.map_icons.tooltip_frame:SetParent(UIParent);
			else
				cb.modules.map_icons.tooltip_frame:SetParent(self);
			end
			cb.modules.map_icons.tooltip_frame:SetOwner(self, "ANCHOR_BOTTOMLEFT");

			local floor_label = "";
			local floor = GetCurrentMapDungeonLevel();
			if (floor < self.icon_data.npc_data["floor"]) then
				floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:0:16|t";
			elseif (floor > self.icon_data.npc_data["floor"]) then
				floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:16:32|t";
			end

			cb.modules.map_icons:setTooltipText(self.icon_data, floor_label);
			cb.modules.map_icons.tooltip_frame:Show();
		end
	end);
	worldmap_icon_frame:SetScript("OnLeave", function(self)
		if (self.icon:IsShown()) then
			cb.modules.map_icons.tooltip_frame:Hide();
		end
	end);
	worldmap_icon_frame:SetScript("OnClick", function(self, button, down)
		if (self.icon:IsShown()) then
			--cb.omg:echo("World OnClick: " .. self.icon_data.label);
		end
	end);
	
	worldmap_icon_frame.icon = worldmap_icon_frame:CreateTexture("ARTWORK");
	worldmap_icon_frame.icon:SetAllPoints();
	worldmap_icon_frame.icon:SetTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_MapIcons");
	worldmap_icon_frame.icon:SetTexCoord(x1, x2, y1, y2);

	local icon = {};
	icon.label = label;
	icon.map_id = map_id;
	icon.icon_type = icon_type;
	icon.module_id = module_id;
	icon.side = side;
	icon.npc_id = npc_id;
	icon.npc_data = npc_data;
	icon.minimap_icon_frame = minimap_icon_frame;
	icon.worldmap_icon_frame = worldmap_icon_frame;

	icon.minimap_icon_frame.icon_data = icon;
	icon.worldmap_icon_frame.icon_data = icon;
	CACHED_ICONS[label] = icon;

	HBDPins:AddMinimapIconMF(CBG_MOD_NAME, icon.minimap_icon_frame, icon.map_id, icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
	HBDPins:AddWorldMapIconMF(CBG_MOD_NAME, icon.worldmap_icon_frame, icon.map_id, icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
end

function cb.modules.map_icons:registerModule(module_id, map_icons, icon_type)
	for map_id, map_data in pairs(map_icons) do
		for side, side_data in cb.omg:sortedpairs(map_data) do
			for npc_id, npc_data in cb.omg:sortedpairs(side_data) do
				cb.modules.map_icons:createMapIcon(map_id, icon_type, module_id, side, npc_id, npc_data);
			end
		end
	end
end

function cb.modules.map_icons:update()
	local map_icon_cfg = cb.settings:get().map_icons;
	local current_map_id = GetCurrentMapAreaID();
	local player_side = UnitFactionGroup("player");

	local skills = {};
	for skill, skill_data in cb.omg:sortedpairs(cb.settings:get().skills) do
		skills[skill] = skill_data.id;
	end

	for label, icon in cb.omg:sortedpairs(CACHED_ICONS) do
		local show_map_icons = true;
		if (icon.module_id == "all") then
			show_map_icons = true;
		elseif (icon.icon_type == CBT_MAP_ICON_TRAINER) then
			if (CraftBusterOptions.globals[CraftBusterEntry_Personal] == "global" and cb.settings:get().map_icons.show_skills_only) then
				if (cb.omg:in_array(icon.module_id, skills)) then
					show_map_icons = cb.settings:get().modules[icon.module_id].show_trainer_map_icons;
				else
					show_map_icons = false;
				end
			else
				show_map_icons = cb.settings:get().modules[icon.module_id].show_trainer_map_icons;
			end
		elseif (icon.icon_type == CBT_MAP_ICON_STATION) then
			show_map_icons = cb.settings:get().modules[icon.module_id].show_station_map_icons;
		end

		if ((icon.side == player_side or icon.side == "Neutral") and show_map_icons) then
			if (map_icon_cfg.show_mini_map and current_map_id == icon.map_id) then
				icon.minimap_icon_frame:Show();
				icon.minimap_icon_frame.icon:Show();
				icon.minimap_icon_frame:SetScript("OnUpdate", function(self, elapsed)
					cb.modules.map_icons:updateMinimap(self, elapsed);
				end);
			else
				icon.minimap_icon_frame:Hide();
				icon.minimap_icon_frame.icon:Hide();
				icon.minimap_icon_frame:SetScript("OnUpdate", nil);
			end

			if (map_icon_cfg.show_world_map) then
				icon.worldmap_icon_frame:Show();
				icon.worldmap_icon_frame.icon:Show();
				icon.worldmap_icon_frame:RegisterEvent("WORLD_MAP_UPDATE");
			else
				icon.worldmap_icon_frame:Hide();
				icon.worldmap_icon_frame.icon:Hide();
				icon.worldmap_icon_frame:UnregisterEvent("WORLD_MAP_UPDATE");
			end
		else
			icon.minimap_icon_frame:Hide();
			icon.minimap_icon_frame.icon:Hide();
			icon.minimap_icon_frame:SetScript("OnUpdate", nil);

			icon.worldmap_icon_frame:Hide();
			icon.worldmap_icon_frame.icon:Hide();
			icon.worldmap_icon_frame:UnregisterEvent("WORLD_MAP_UPDATE");
		end
	end
end

function cb.modules.map_icons:displayPosition()
	local x, y, map_id, floor = HBD:GetPlayerZonePosition();
	cb.omg:echo("Map: " .. GetMapNameByID(map_id) .. " (" .. map_id .. "), Floor: " .. floor .. " -> " .. cb.omg:round(x * 100, 1) .. ", " .. cb.omg:round(y * 100, 1));
end