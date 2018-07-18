-------------------------------------------------------------------------------
-- CraftBuster Localization
-------------------------------------------------------------------------------
CBL = {};
CBL["MAP_NAMES"] = {};
for _,map_id in pairs(CBG_MAP_IDS) do
	local map_info = C_Map.GetMapInfo(map_id);
	if (map_info ~= nil) then
		CBL["MAP_NAMES"][map_id] = map_info.name;
	else
		CBL["MAP_NAMES"][map_id] = "Invalid map info for id: " .. map_id;
	end
end