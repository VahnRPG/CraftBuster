-------------------------------------------------------------------------------
-- CraftBuster Localization
-------------------------------------------------------------------------------
CBL = {};
CBL["MAP_NAMES"] = {};
for _,map_id in pairs(CBG_MAP_IDS) do
	if (GetMapNameByID(map_id) ~= nil) then
		CBL["MAP_NAMES"][map_id] = GetMapNameByID(map_id);
	else
		CBL["MAP_NAMES"][map_id] = "Nil map id: " .. map_id;
	end
end