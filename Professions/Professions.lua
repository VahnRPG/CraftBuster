local _, cb = ...;

cb.professions = {};
cb.professions.modules = {};

function cb.professions:registerModule(module_options)
	local module_id = module_options["id"];
	
	cb.professions.modules[module_id] = {};
	cb.professions.modules[module_id].id = module_id;
	cb.professions.modules[module_id].name = module_options["name"];
	cb.professions.modules[module_id].short_code = module_options["short_code"];
	cb.professions.modules[module_id].skill_type = module_options["type"];
	cb.professions.modules[module_id].station_map_icons = nil;
	if (module_options["station_map_icons"]) then
		cb.professions.modules[module_id].station_map_icons = module_options["station_map_icons"];
		cb.map_icons:registerModule(module_id, module_options["station_map_icons"], CBT_MAP_ICON_STATION);
	end
	cb.professions.modules[module_id].trainer_map_icons = nil;
	if (module_options["trainer_map_icons"]) then
		cb.professions.modules[module_id].trainer_map_icons = module_options["trainer_map_icons"];
		cb.map_icons:registerModule(module_id, module_options["trainer_map_icons"], CBT_MAP_ICON_TRAINER);
	end
	cb.professions.modules[module_id].show_tooltips = module_options["show_tooltips"];
	cb.professions.modules[module_id].nodes = module_options["nodes"];
	cb.professions.modules[module_id].node_function = nil;
	if (module_options["node_function"]) then
		cb.worldmap_frame:addGatherData(module_id, module_options["nodes"]);
		if (type(module_options["node_function"]) == "function") then
			cb.professions.modules[module_id].node_function = function(line_one, line_two, line_three)
				local skill_nodes = module_options["node_function"](line_one, line_two, line_three);
				cb.professions:handleNode(skill_nodes, line_one, line_two, line_three);
			end;
		else
			cb.professions.modules[module_id].node_function = function(line_one, line_two, line_three)
				cb.professions:handleNode(cb.professions.modules[module_id].nodes, line_one, line_two, line_three);
			end;
		end
	end
	cb.professions.modules[module_id].spell_1 = nil;
	cb.professions.modules[module_id].spell_1_id = nil;
	if (module_options["spell_1"]) then
		cb.professions.modules[module_id].spell_1 = GetSpellInfo(module_options["spell_1"]);
		cb.professions.modules[module_id].spell_1_id = module_options["spell_1"];
	end
	cb.professions.modules[module_id].spell_2 = nil;
	cb.professions.modules[module_id].spell_2_id = nil;
	if (module_options["spell_2"]) then
		cb.professions.modules[module_id].spell_2 = GetSpellInfo(module_options["spell_2"]);
		cb.professions.modules[module_id].spell_2_id = module_options["spell_2"];
	end
	cb.professions.modules[module_id].spell_buster = nil;
	cb.professions.modules[module_id].spell_buster_id = nil;
	cb.professions.modules[module_id].bustable_function = nil;
	if (module_options["spell_buster"]) then
		cb.professions.modules[module_id].spell_buster = GetSpellInfo(module_options["spell_buster"]);
		cb.professions.modules[module_id].spell_buster_id = module_options["spell_buster"];
		cb.professions.modules[module_id].bustable_function = module_options["bustable_function"];
	end
	cb.professions.modules[module_id].tradeskill_function = module_options["tradeskill_function"];
	
	cb.professions.modules[module_id].messages = cb.professions:buildMessages(module_options["type"], module_options["name"], module_options["short_code"], module_options["nodes"]);
end

function cb.professions:buildMessages(skill_type, skill_name, skill_short_code, skill_nodes)
	local messages = {};
	for i=2, CBG_MAX_PROFESSIONS do
		local min_skill_level, max_skill_level, title = CBG_PROFESSION_RANKS[i][1], CBG_PROFESSION_RANKS[i][2], CBG_PROFESSION_RANKS[i][3];
		messages[cb.omg:str_pad(i-1, 2, "0", "right") .. skill_short_code .. "_level_" .. i] = {
			["ply_level"] = CBG_SKILL_PLY_LEVELS[i][skill_type],
			["skill_level"] = min_skill_level,
			["min_skill_level"] = min_skill_level,
			["max_skill_level"] = max_skill_level,
			["action"] = CBT_NEXT_LEVEL,
			["message"] = string.format(CBL["TRAINER_ACTION"], skill_name, title),
			["fields"] = { skill_name, title },
		};
	end

	if (skill_nodes and next(skill_nodes)) then
		local base_count = CBG_MAX_PROFESSIONS - 1;
		for node_name, node_data in cb.omg:sortedpairs(skill_nodes) do
			messages[cb.omg:str_pad((base_count + node_data["rank"] + 0), 2, "0", "right") .. skill_short_code .. "_1_orange"] = {
				["ply_level"] = node_data["ply_level"],
				["skill_level"] = node_data["node_levels"][1],
				["action"] = CBT_ORANGE,
				["message"] = cb.professions:translateActionText(ORANGE_FONT_COLOR_CODE, node_name, node_data["node_levels"][1]),
				["fields"] = { node_name, node_data["node_levels"][1] },
			};
			messages[cb.omg:str_pad((base_count + node_data["rank"] + 1), 2, "0", "right") .. skill_short_code .. "_2_yellow"] = {
				["ply_level"] = node_data["ply_level"],
				["skill_level"] = node_data["node_levels"][2],
				["action"] = CBT_YELLOW,
				["message"] = cb.professions:translateActionText(YELLOW_FONT_COLOR_CODE, node_name, node_data["node_levels"][2]),
				["fields"] = { node_name, node_data["node_levels"][2] },
			};
			messages[cb.omg:str_pad((base_count + node_data["rank"] + 2), 2, "0", "right") .. skill_short_code .. "_3_green"] = {
				["ply_level"] = node_data["ply_level"],
				["skill_level"] = node_data["node_levels"][3],
				["action"] = CBT_GREEN,
				["message"] = cb.professions:translateActionText(GREEN_FONT_COLOR_CODE, node_name, node_data["node_levels"][3]),
				["fields"] = { node_name, node_data["node_levels"][3] },
			};
			messages[cb.omg:str_pad((base_count + node_data["rank"] + 3), 2, "0", "right") .. skill_short_code .. "_4_grey"] = {
				["ply_level"] = node_data["ply_level"],
				["skill_level"] = node_data["node_levels"][4],
				["action"] = CBT_GREY,
				["message"] = cb.professions:translateActionText(GRAY_FONT_COLOR_CODE, node_name, node_data["node_levels"][4]),
				["fields"] = { node_name, node_data["node_levels"][4] },
			};
		end
	end

	return messages;
end

function cb.professions:handleNode(skill_nodes, line_one, line_two, line_three)
	line_one =  gsub(gsub(line_one, "|c........", ""), "|r", "");
	for node_name, node_data in cb.omg:sortedpairs(skill_nodes) do
		if (string.find(line_one, node_name, 1, true) ~= nil and skill_nodes[node_name] ~= nil) then
			GameTooltip:AddLine(CBL["NODE_MSG"] .. ORANGE_FONT_COLOR_CODE .. " " .. node_data["node_levels"][1] .. YELLOW_FONT_COLOR_CODE .. " " .. node_data["node_levels"][2] .. GREEN_FONT_COLOR_CODE .. " " .. node_data["node_levels"][3] .. GRAY_FONT_COLOR_CODE .. " " .. node_data["node_levels"][4]);
			GameTooltip:Show();
			return true;
		end
	end

	return false;
end

function cb.professions:handleGather(skill_id, zone_map_id)
	local found = false;
	local gather_data = {
		["zones"] = {},
		["skill"] = {},
	};
	
	if (cb.professions.modules[skill_id].nodes and next(cb.professions.modules[skill_id].nodes)) then
		local skill_level = cb:getSkillLevel(skill_id);
		for node_name, node_data in cb.omg:sortedpairs(cb.professions.modules[skill_id].nodes) do
			for _,map_id in pairs(node_data["map_ids"]) do
				if (map_id == zone_map_id) then
					local rank = node_data["rank"];
					gather_data["zones"][rank] = {
						["item_id"] = node_data["item_id"],
						["name"] = node_name,
						["levels"] = node_data["node_levels"],
					};
					found = true;
				end
			end
			
			if (skill_level ~= nil and skill_level < CBG_MAX_PROFESSION_RANK) then
				if (skill_level >= node_data["node_levels"][1] and skill_level < node_data["node_levels"][4]) then
					local rank = node_data["rank"];
					gather_data["skill"][rank] = {
						["item_id"] = node_data["item_id"],
						["name"] = node_name,
						["levels"] = node_data["node_levels"],
					};
					found = true;
				end
			end
		end
	end
	
	if (CraftBusterOptions[CraftBusterEntry].modules[skill_id].show_gather and found) then
		cb.gather_frame:addGatherData(gather_data);
	end
end

function cb.professions:handleSkill(skill)
	local skill_data = CraftBusterOptions[CraftBusterEntry].skills[skill];
	if (skill_data ~= nil) then
		if (cb.professions.modules[skill_data.id].messages and next(cb.professions.modules[skill_data.id].messages)) then
			cb.professions:processAction(skill_data.id, skill_data);
		end
	end
end

function cb.professions:processAction(module_id, skill_data)
	if (not CraftBusterOptions[CraftBusterEntry].alerts[module_id]) then
		CraftBusterOptions[CraftBusterEntry].alerts[module_id] = {};
	end
	
	for message_id, message_data in cb.omg:sortedpairs(cb.professions.modules[module_id].messages) do
		if (not CraftBusterOptions[CraftBusterEntry].alerts[module_id][message_id]) then
			if (cb.settings.player.level >= message_data.ply_level and skill_data.level >= message_data.skill_level) then
				cb.omg:echo(message_data.message);
				CraftBusterOptions[CraftBusterEntry].alerts[module_id][message_id] = true;
			end
		end
	end
end

function cb.professions:translateActionText(color_code, name, level)
	local output_txt = "";
	if (color_code == ORANGE_FONT_COLOR_CODE) then
		output_txt = string.format(CBL["ORANGE_ACTION"], color_code, level, name);
	elseif (color_code == YELLOW_FONT_COLOR_CODE) then
		output_txt = string.format(CBL["YELLOW_ACTION"], color_code, name, level);
	elseif (color_code == GREEN_FONT_COLOR_CODE) then
		output_txt = string.format(CBL["GREEN_ACTION"], color_code, name, level);
	elseif (color_code == GRAY_FONT_COLOR_CODE) then
		output_txt = string.format(CBL["GREY_ACTION"], color_code, name, level);
	end

	return output_txt;
end