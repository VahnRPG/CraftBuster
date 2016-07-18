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

local tooltip = CreateFrame("GameTooltip", "CraftBuster_MapIcons_Tooltip", nil, "GameTooltipTemplate");
--local dropdown = CreateFrame("Frame", "CraftBuster_MapIcons_Dropdown", nil, "UIDropDownMenuTemplate");
local last_update = 0;

local function CraftBuster_MapIcons_SetTooltipText(icon_data, floor_label)
	if (icon_data.icon_type == CBT_MAP_ICON_TRAINER) then
		tooltip:SetText(CBL["MAPICON_TITLE_TRAINER"]);
	elseif (icon_data.icon_type == CBT_MAP_ICON_STATION) then
		tooltip:SetText(CBL["MAPICON_TITLE_STATION"]);
	end

	local profession_label = CBL[icon_data.module_id];
	if (icon_data.module_id == "all") then
		profession_label = CBL["SKILL_ALL_PROFESSIONS"];
	end

	tooltip:AddLine(floor_label .. CBG_CLR_WHITE .. icon_data.npc_data["name"] .. " - " .. profession_label);
end

local function CraftBuster_MapIcons_Minimap_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		if (not self.icon_data.label) then
			return;
		end

		local icon_data = self.icon_data;
		HBDPins:AddMinimapIconMF(CBG_MOD_NAME, self, icon_data.map_id, icon_data.npc_data["floor"], (icon_data.npc_data["pos"][1] / 100), (icon_data.npc_data["pos"][2] / 100));
	end
end

local function CraftBuster_MapIcons_Minimap_OnUpdate(self, elapsed)
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

local function CraftBuster_MapIcons_Minimap_OnEnter(self, event, ...)
	if (not self.icon_data.label) then
		return;
	end

	if (self.icon:IsShown()) then
		if (UIParent:IsVisible()) then
			tooltip:SetParent(UIParent);
		else
			tooltip:SetParent(self);
		end
		tooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");

		local floor_label = "";
		local _, _, _, floor = HBD:GetPlayerZonePosition();
		if (floor < self.icon_data.npc_data["floor"]) then
			floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:0:16|t";
		elseif (floor > self.icon_data.npc_data["floor"]) then
			floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:16:32|t";
		end

		CraftBuster_MapIcons_SetTooltipText(self.icon_data, floor_label);

		tooltip:Show();
	end
end

local function CraftBuster_MapIcons_Minimap_OnLeave(self)
	if (not self.icon_data.label) then
		return;
	end

	if (self.icon:IsShown()) then
		tooltip:Hide();
	end
end

local function CraftBuster_MapIcons_Minimap_OnClick(self, button, down)
	if (not self.icon_data.label) then
		return;
	end

	if (self.icon:IsShown() and (self.icon_data.map_id ~= GetCurrentMapAreaID())) then
		--echo("Minimap OnClick: " .. self.icon_data.label);
	end
end

local function CraftBuster_MapIcons_World_OnEvent(self, event, ...)
	if (event == "WORLD_MAP_UPDATE") then
		if (not self.icon_data.label or not CraftBusterEntry) then
			return;
		end

		local show = false;
		local icon_data = self.icon_data;
		if (icon_data.worldmap_icon_frame and CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map) then
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
end

local function CraftBuster_MapIcons_World_OnEnter(self, event, ...)
	if (self.icon:IsShown()) then
		if (UIParent:IsVisible()) then
			tooltip:SetParent(UIParent);
		else
			tooltip:SetParent(self);
		end
		tooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");

		local floor_label = "";
		local floor = GetCurrentMapDungeonLevel();
		if (floor < self.icon_data.npc_data["floor"]) then
			floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:0:16|t";
		elseif (floor > self.icon_data.npc_data["floor"]) then
			floor_label = "|TInterface\\Minimap\\Minimap-PositionArrows:0:0:0:0:16:32:0:16:16:32|t";
		end
		CraftBuster_MapIcons_SetTooltipText(self.icon_data, floor_label);

		tooltip:Show();
	end
end

local function CraftBuster_MapIcons_World_OnLeave(self)
	if (self.icon:IsShown()) then
		tooltip:Hide();
	end
end

local function CraftBuster_MapIcons_World_OnClick(self, button, down)
	if (self.icon:IsShown()) then
		--echo("World OnClick: " .. self.icon_data.label);
	end
end

local function CraftBuster_CreateMapIcon(map_id, icon_type, module_id, side, npc_id, npc_data)
	local label = map_id .. "_" .. icon_type .. "_" .. module_id .. "_" .. side .. "_" .. npc_id;

	local x1, x2, y1, y2 = unpack(CBG_MAP_ICON_TEXTURES[icon_type][module_id]);
	local minimap_icon_frame = CreateFrame("Button", nil, Minimap);
	minimap_icon_frame:SetHeight(20);
	minimap_icon_frame:SetWidth(20);
	minimap_icon_frame:RegisterForClicks("RightButtonUp");
	minimap_icon_frame:RegisterEvent("PLAYER_ENTERING_WORLD");
	minimap_icon_frame:SetScript("OnEvent", CraftBuster_MapIcons_Minimap_OnEvent);
	minimap_icon_frame:SetScript("OnUpdate", CraftBuster_MapIcons_Minimap_OnUpdate);
	minimap_icon_frame:SetScript("OnEnter", CraftBuster_MapIcons_Minimap_OnEnter);
	minimap_icon_frame:SetScript("OnLeave", CraftBuster_MapIcons_Minimap_OnLeave);
	minimap_icon_frame:SetScript("OnClick", CraftBuster_MapIcons_Minimap_OnClick);

	minimap_icon_frame.icon = minimap_icon_frame:CreateTexture("BACKGROUND");
	minimap_icon_frame.icon:SetPoint("CENTER", 0, 0);
	minimap_icon_frame.icon:SetTexture("Interface\\AddOns\\CraftBuster\\Images\\CraftBuster_MapIcons");
	minimap_icon_frame.icon:SetTexCoord(x1, x2, y1, y2);
	minimap_icon_frame.icon:SetHeight(16);
	minimap_icon_frame.icon:SetWidth(16);

	if (not CraftBuster_MapIcons_Overlay) then
		local overlay = CreateFrame("Frame", "CraftBuster_MapIcons_Overlay", WorldMapButton);
		overlay:SetAllPoints(true);
	end

	local worldmap_icon_frame = CreateFrame("Button", nil, CraftBuster_MapIcons_Overlay)
	worldmap_icon_frame:SetHeight(14);
	worldmap_icon_frame:SetWidth(14);
	worldmap_icon_frame:RegisterForClicks("RightButtonUp");
	worldmap_icon_frame:RegisterEvent("WORLD_MAP_UPDATE");
	worldmap_icon_frame:SetScript("OnEvent", CraftBuster_MapIcons_World_OnEvent);
	worldmap_icon_frame:SetScript("OnEnter", CraftBuster_MapIcons_World_OnEnter);
	worldmap_icon_frame:SetScript("OnLeave", CraftBuster_MapIcons_World_OnLeave);
	worldmap_icon_frame:SetScript("OnClick", CraftBuster_MapIcons_World_OnClick);

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

	--HBDPins:AddMinimapIconWorld(icon.minimap_icon_frame, icon.map_id, icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
	--HBDPins:AddWorldMapIconMF(CraftBuster_MapIcons_Overlay, icon.worldmap_icon_frame, icon.map_id, icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
	HBDPins:AddMinimapIconMF(CBG_MOD_NAME, icon.minimap_icon_frame, icon.map_id, icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
	HBDPins:AddWorldMapIconMF(CBG_MOD_NAME, icon.worldmap_icon_frame, icon.map_id, icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
end

function CraftBuster_MapIcons_RegisterInit()
	CraftBuster_MapIcons_RegisterModule("all", SKILL_ALL_PROFESSIONS_TRAINERS_MAP_ICONS, CBT_MAP_ICON_TRAINER);
end

function CraftBuster_MapIcons_RegisterModule(module_id, map_icons, icon_type)
	for map_id, map_data in pairs(map_icons) do
		for side, side_data in sortedpairs(map_data) do
			for npc_id, npc_data in sortedpairs(side_data) do
				CraftBuster_CreateMapIcon(map_id, icon_type, module_id, side, npc_id, npc_data);
			end
		end
	end
end

function CraftBuster_MapIcons_Init()
end

function CraftBuster_MapIcons_Update()
	local map_icon_cfg = CraftBusterOptions[CraftBusterEntry].map_icons;
	local current_map_id = GetCurrentMapAreaID();
	local player_side = UnitFactionGroup("player");

	for label, icon in sortedpairs(CACHED_ICONS) do
		local show_map_icons = true;
		if (icon.module_id == "all") then
			show_map_icons = true;
		elseif (icon.icon_type == CBT_MAP_ICON_TRAINER) then
			show_map_icons = CraftBusterOptions[CraftBusterEntry].modules[icon.module_id].show_trainer_map_icons;
		elseif (icon.icon_type == CBT_MAP_ICON_STATION) then
			show_map_icons = CraftBusterOptions[CraftBusterEntry].modules[icon.module_id].show_station_map_icons;
		end

		if ((icon.side == player_side or icon.side == "Neutral") and show_map_icons) then
			if (map_icon_cfg.show_mini_map and current_map_id == icon.map_id) then
				icon.minimap_icon_frame:Show();
				icon.minimap_icon_frame.icon:Show();
				icon.minimap_icon_frame:SetScript("OnUpdate", CraftBuster_MapIcons_Minimap_OnUpdate);
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

function CraftBuster_MapIcons_DisplayPosition()
	local x, y, map_id, floor = HBD:GetPlayerZonePosition();
	echo("Map: " .. GetMapNameByID(map_id) .. " (" .. map_id .. "), Floor: " .. floor .. " -> " .. round(x * 100, 1) .. ", " .. round(y * 100, 1));
end