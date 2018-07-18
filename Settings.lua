local DB_VERSION = 0.06;

CraftBusterOptions = {};
CraftBusterEntry = nil;
CraftBusterEntry_Personal = nil;

local _, cb = ...;

cb.settings = {};
cb.settings.frame = CreateFrame("Frame", "CraftBuster_SettingsFrame", Minimap);
cb.settings.frame:RegisterEvent("ADDON_LOADED");
cb.settings.frame:RegisterEvent("PLAYER_LEVEL_UP");
cb.settings.frame:SetScript("OnEvent", function(self, event, ...)
	return cb.settings[event] and cb.settings[event](cb, ...)
end);
cb.settings.init = false;
cb.settings.player = {
	["name"] = "",
	["level"] = 0,
	["server"] = "",
};

function cb.settings:ADDON_LOADED(self, ...)
	cb.settings.frame:UnregisterEvent("ADDON_LOADED");

	if (not CraftBusterOptions) then
		CraftBusterOptions = {};
	end
	if (not CraftBusterOptions.globals) then
		CraftBusterOptions.globals = {};
	end
	cb.settings.player.name = UnitName("player");
	cb.settings.player.level = UnitLevel("player");
	cb.settings.player.server = GetRealmName();
	CraftBusterEntry_Personal = cb.settings.player.name .. "@" .. cb.settings.player.server;
	CraftBusterEntry = CraftBusterEntry_Personal;
	if (not CraftBusterOptions.globals[CraftBusterEntry_Personal]) then
		CraftBusterOptions.globals[CraftBusterEntry_Personal] = "global";
	end
	CraftBusterEntry = CraftBusterOptions.globals[CraftBusterEntry_Personal];
	
	cb.settings:initSettings();
	cb.settings.init = true;
end

function cb.settings:PLAYER_LEVEL_UP(player_level)
	if (not player_level) then
		player_level = UnitLevel("player");
	end
	cb.settings.player.level = player_level;
	cb:updateSkills(false);
end

function cb.settings:get(entry)
	if (not entry) then
		entry = CraftBusterEntry;
	end

	if (CraftBusterOptions[entry] ~= nil) then
		return CraftBusterOptions[entry];
	end

	return {};
end

function cb.settings:initSettings(reset)
	if (cb.settings.init and not reset) then
		return;
	end

	if (not CraftBusterOptions or reset == true) then
		CraftBusterOptions = {};
		CraftBusterOptions.globals = {};
		CraftBusterOptions.globals[CraftBusterEntry_Personal] = "global";
		CraftBusterEntry = CraftBusterOptions.globals[CraftBusterEntry_Personal];
	end
	if (not CraftBusterOptions[CraftBusterEntry_Personal] or reset == "character") then
		CraftBusterOptions[CraftBusterEntry_Personal] = cb.omg:clone_table(cb.settings:default());
	end
	if (not CraftBusterOptions[CraftBusterEntry] or reset == "character") then
		CraftBusterOptions[CraftBusterEntry] = cb.omg:clone_table(cb.settings:default());
	end

	local _, player_class = UnitClass("player");
	if (player_class == "ROGUE") then
		CraftBusterOptions[CraftBusterEntry].skills_frame.bars.lockpicking = true;
	end

	cb.settings:versionSettings();
end

function cb.settings:versionSettings()
	local settings = cb.settings:get();
	if (not settings.db_version or settings.db_version < 0.02) then
		if (cb.professions.modules and next(cb.professions.modules)) then
			for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
				settings.modules[module_id].show_trainer_map_icons = true;
				settings.modules[module_id].show_station_map_icons = true;
			end
		end
	end

	if (not settings.db_version or settings.db_version < 0.03) then
		if (cb.professions.modules and next(cb.professions.modules)) then
			for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
				settings.modules[module_id].show_worldmap_icons = true;
			end
		end
	end

	if (not settings.db_version or settings.db_version < 0.04) then
		settings.skills_frame.locked = false;
	end

	if (not settings.db_version or settings.db_version < 0.05) then
		settings.buster_frame.locked = false;
	end

	if (not settings.db_version or settings.db_version < 0.06) then
		CraftBusterOptions.globals = {};
		CraftBusterOptions.globals[CraftBusterEntry_Personal] = "global";
		CraftBusterEntry = CraftBusterOptions.globals[CraftBusterEntry_Personal];
	end

	settings.db_version = DB_VERSION;
end

function cb.settings:copy(from, to)
	local from_settings = cb.settings:get(from);
	local to_settings = cb.settings:get(to);

	to_settings = cb.omg:clone_table(from_settings);
end

function cb.settings:default()
	local settings = {
		["skills"] = {
			["skill_1"] = nil,
			["skill_2"] = nil,
			["cooking"] = nil,
			["fishing"] = nil,
			["archaeology"] = nil,
			["lockpicking"] = nil,
		};
		["alerts"] = {},
		["bustables"] = {},
		["minimap"] = {
			["show"] = true,
			["position"] = 310,
		},
		["skills_frame"] = {
			["show"] = true,
			["locked"] = true,
			["state"] = "expanded",
			["position"] = {
				point = "TOPLEFT",
				relative_point = "TOPLEFT",
				x = 490,
				y = -330,
			},
			["bars"] = {
				["skill_1"] = true,
				["skill_2"] = true,
				["cooking"] = true,
				["fishing"] = true,
				["archaeology"] = true,
				["lockpicking"] = false,
			},
		},
		["zone_limit"] = 10,
		["buster_frame"] = {
			["show"] = true,
			["locked"] = true,
			["state"] = "expanded",
			["position"] = {
				point = "TOPLEFT",
				relative_point = "TOPLEFT",
				x = 490,
				y = -330,
			},
			["ignored_items"] = {},
		},
		["map_icons"] = {
			["show_world_map"] = true,
			["show_mini_map"] = false,
			["show_skills_only"] = false,
		},
		["modules"] = {},
	};

	if (cb.professions.modules and next(cb.professions.modules)) then
		for module_id, module_data in cb.omg:sortedpairs(cb.professions.modules) do
			settings.modules[module_id] = {};
			settings.modules[module_id].show_tooltips = true;
			settings.modules[module_id].show_buster = true;
			settings.modules[module_id].show_trainer_map_icons = true;
			settings.modules[module_id].show_station_map_icons = true;
			settings.modules[module_id].show_worldmap_icons = true;
		end
	end

	return settings;
end