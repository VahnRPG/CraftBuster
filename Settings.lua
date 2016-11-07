local DB_VERSION = 0.05;

local _, cb = ...;

cb.settings = {};
cb.settings.frame = CreateFrame("Frame", "CraftBuster_SettingsFrame", Minimap);
cb.settings.frame:RegisterEvent("ADDON_LOADED");
cb.settings.frame:SetScript("OnEvent", function(self, event, ...)
	return cb.settings[event] and cb.settings[event](qb, ...)
end);

function cb.settings:ADDON_LOADED(self, ...)
	cb.settings.frame:UnregisterEvent("ADDON_LOADED");
end