local astrolabe = DongleStub("Astrolabe-1.0");

local MAP_ICONS = {
	["trainers"] = {
		["blacksmithing"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["leatherworking"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["alchemy"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["herbalism"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["mining"] = {
			["horde"] = {
				["Gizzik Oregrab"] = {
					["id"] = 52170,
					["map_id"] = 321,		--Orgrimmar
					["floor"] = 1,
					["pos"] = { 36.0, 82.8 },
				},
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["tailoring"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["engineering"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["enchanting"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["skinning"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["jewelcrafting"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["inscription"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["cooking"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["first aid"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["fishing"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["archaeology"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
	},
	["stations"] = {
		["blacksmithing"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["leatherworking"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["alchemy"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["herbalism"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["mining"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["tailoring"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["engineering"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["enchanting"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["skinning"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["jewelcrafting"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["inscription"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["cooking"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["first aid"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["fishing"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
		["archaeology"] = {
			["horde"] = {
			},
			["alliance"] = {
			},
			["neutral"] = {
			},
		},
	},
};

local MAP_ICON_TEXTURES = {
	["trainers"] = {
		["blacksmithing"] = "",
		["leatherworking"] = "",
		["alchemy"] = "",
		["herbalism"] = "",
		["mining"] = "Interface\\AddOns\\CraftBuster\\Images\\MapIcon-Trainer-Mining",
		["tailoring"] = "",
		["engineering"] = "",
		["enchanting"] = "",
		["skinning"] = "",
		["jewelcrafting"] = "",
		["inscription"] = "",
		["cooking"] = "",
		["first aid"] = "",
		["fishing"] = "",
		["archaeology"] = "",
	},
	["stations"] = {
		["blacksmithing"] = "",
		["leatherworking"] = "",
		["alchemy"] = "",
		["herbalism"] = "",
		["mining"] = "Interface\\AddOns\\CraftBuster\\Images\\MapIcon-Station-Mining",
		["tailoring"] = "",
		["engineering"] = "",
		["enchanting"] = "",
		["skinning"] = "",
		["jewelcrafting"] = "",
		["inscription"] = "",
		["cooking"] = "",
		["first aid"] = "",
		["fishing"] = "",
		["archaeology"] = "",
	},
};

local CACHED_ICONS = {};

local last_update = 0;

local function CraftBuster_MapIcons_Minimap_OnUpdate(self, elapsed)
	local dist, x, y = astrolabe:GetDistanceToIcon(self);
	if (not dist) then
		self:Hide();

		return;
	end

	last_update = last_update + elapsed;
	if (last_update < 0.1) then
		return;
	end

	last_update = 0;

	if (not self.disabled) then
		local icon_on_edge = astrolabe:IsIconOnEdge(self);
		if (icon_on_edge) then
			self.icon:Hide();
		else
			self.icon:Show();
		end
	end
end

local function CraftBuster_MapIcons_World_OnEvent(self, event, ...)
	if (event == "WORLD_MAP_UPDATE") then
		if (not self.icon_data.label) then
			return;
		end

		local icon_data = self.icon_data;
		if (icon_data.worldmap_icon_frame and CraftBusterOptions[CraftBusterEntry].map_icons.show_world_map and not self.disabled) then
			local x,y = astrolabe:PlaceIconOnWorldMap(CraftBuster_MapIcons_Overlay, self, icon_data.npc_data["map_id"], icon_data.npc_data["floor"], (icon_data.npc_data["pos"][1] / 100), (icon_data.npc_data["pos"][2] / 100));

			if (x and y and (0 < x and x <= 1) and (0 < y and y <= 1)) then
				self:Show();
			else
				self:Hide();
			end
		else
			self:Hide();
		end
	end
end

local function CraftBuster_CreateMapIcon(icon_type, profession, side, npc_name, npc_data)
	local label = icon_type .. ":" .. profession .. "-" .. side .. "-" .. npc_name;

	local minimap_icon_frame = CreateFrame("Button", nil, Minimap);
	minimap_icon_frame:SetHeight(20);
	minimap_icon_frame:SetWidth(20);
	minimap_icon_frame:RegisterForClicks("RightButtonUp");
	minimap_icon_frame:SetScript("OnUpdate", CraftBuster_MapIcons_Minimap_OnUpdate);
	--minimap_icon_frame:SetScript("OnEnter", CraftBuster_MapIcons_Minimap_OnEnter);
	--minimap_icon_frame:SetScript("OnLeave", CraftBuster_MapIcons_Minimap_OnLeave);
	--minimap_icon_frame:SetScript("OnClick", CraftBuster_MapIcons_Minimap_OnClick);

	minimap_icon_frame.icon = minimap_icon_frame:CreateTexture("BACKGROUND");
	minimap_icon_frame.icon:SetTexture(MAP_ICON_TEXTURES[icon_type][profession]);
	minimap_icon_frame.icon:SetPoint("CENTER", 0, 0);
	minimap_icon_frame.icon:SetHeight(12);
	minimap_icon_frame.icon:SetWidth(12);

	if (not CraftBuster_MapIcons_Overlay) then
		local overlay = CreateFrame("Frame", "CraftBuster_MapIcons_Overlay", WorldMapButton);
		overlay:SetAllPoints(true);
	end

	local worldmap_icon_frame = CreateFrame("Button", nil, CraftBuster_MapIcons_Overlay)
	worldmap_icon_frame:SetHeight(12);
	worldmap_icon_frame:SetWidth(12);
	worldmap_icon_frame:RegisterForClicks("RightButtonUp");
	worldmap_icon_frame:RegisterEvent("WORLD_MAP_UPDATE");
	worldmap_icon_frame:SetScript("OnEvent", CraftBuster_MapIcons_World_OnEvent);
	--worldmap_icon_frame:SetScript("OnEnter", CraftBuster_MapIcons_World_OnEnter);
	--worldmap_icon_frame:SetScript("OnLeave", CraftBuster_MapIcons_World_OnLeave);
	--worldmap_icon_frame:SetScript("OnClick", CraftBuster_MapIcons_World_OnClick);

	worldmap_icon_frame.icon = worldmap_icon_frame:CreateTexture("ARTWORK");
	worldmap_icon_frame.icon:SetAllPoints();
	worldmap_icon_frame.icon:SetTexture(MAP_ICON_TEXTURES[icon_type][profession]);

	local icon = {};
	icon.label = label;
	icon.icon_type = icon_type;
	icon.profession = profession;
	icon.side = side;
	icon.npc_name = npc_name;
	icon.npc_data = npc_data;
	icon.minimap_icon_frame = minimap_icon_frame;
	icon.worldmap_icon_frame = worldmap_icon_frame;

	icon.minimap_icon_frame.icon_data = icon;
	icon.worldmap_icon_frame.icon_data = icon;
	CACHED_ICONS[label] = icon;
end

function CraftBuster_MapIcons_Init()
	local map_icon_cfg = CraftBusterOptions[CraftBusterEntry].map_icons;

	for icon_type, type_data in sortedpairs(MAP_ICONS) do
		if ((icon_type == "trainers" and map_icon_cfg.show_trainers) or (icon_type == "stations" and map_icon_cfg.show_stations)) then
			for profession, profession_data in sortedpairs(type_data) do
				for side, side_data in sortedpairs(profession_data) do
					for npc_name, npc_data in sortedpairs(side_data) do
						CraftBuster_CreateMapIcon(icon_type, profession, side, npc_name, npc_data);
					end
				end
			end
		end
	end

	CraftBuster_MapIcons_Update();
end

function CraftBuster_MapIcons_Update()
	local map_icon_cfg = CraftBusterOptions[CraftBusterEntry].map_icons;

	for cache_id, icon in sortedpairs(CACHED_ICONS) do
		if (map_icon_cfg.show_mini_map) then
			astrolabe:PlaceIconOnMinimap(icon.minimap_icon_frame, icon.npc_data["map_id"], icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
		end

		if (map_icon_cfg.show_world_map) then
			astrolabe:PlaceIconOnWorldMap(CraftBuster_MapIcons_Overlay, icon.worldmap_icon_frame, icon.npc_data["map_id"], icon.npc_data["floor"], (icon.npc_data["pos"][1] / 100), (icon.npc_data["pos"][2] / 100));
		end
	end
end