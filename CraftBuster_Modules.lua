function CraftBuster_Module_BuildBaseActions(skill_type, skill_name, skill_short_code)
	local skill_actions = {};
	for i=2,#CBG_PROFESSION_RANKS do
		local min_skill_level, max_skill_level, title = CBG_PROFESSION_RANKS[i][1], CBG_PROFESSION_RANKS[i][2], CBG_PROFESSION_RANKS[i][3];
		skill_actions[str_pad(i-1, 2, "0", "right") .. skill_short_code .. "_level_" .. i] = {
			["ply_level"] = CBG_SKILL_PLY_LEVELS[i][skill_type],
			["skill_level"] = min_skill_level,
			["action"] = CBT_NEXT_LEVEL,
			["message"] = string.format(CBL["TRAINER_ACTION"], skill_name, title),
			["fields"] = { skill_name, title },
		};
	end

	return skill_actions;
end

function CraftBuster_Module_BuildActionDisplay(display_frame, skill_id, skill_actions, skill_type, skill_name, skill_short_code)
	local messages = {
		["trainer"] = {},
		["nodes"] = {},
	};

	for action_id, data in sortedpairs(skill_actions) do
		local displayed = false;
		if (CraftBusterOptions[CraftBusterEntry].alerts[skill_id] ~= nil and CraftBusterOptions[CraftBusterEntry].alerts[skill_id][action_id] ~= nil) then
			displayed = CraftBusterOptions[CraftBusterEntry].alerts[skill_id][action_id];
		end

		if (data.action == CBT_NEXT_LEVEL) then
			local message = {
				["displayed"] = displayed,
				["title"] = data.fields[1],
				["ply_level"] = data.ply_level,
				["skill_level"] = data.skill_level,
			};
			table.insert(messages["trainer"], message);
		else
			local node_name = data.fields[1];
			if (not messages["nodes"][node_name]) then
				messages["nodes"][node_name] = {};
				messages["nodes"][node_name]["title"] = node_name;
				messages["nodes"][node_name][CBT_ORANGE] = false;
				messages["nodes"][node_name][CBT_YELLOW] = false;
				messages["nodes"][node_name][CBT_GREEN] = false;
				messages["nodes"][node_name][CBT_GREY] = false;
			end

			if (data.action == CBT_ORANGE) then
				messages["nodes"][node_name][CBT_ORANGE] = displayed;
			elseif (data.action == CBT_YELLOW) then
				messages["nodes"][node_name][CBT_YELLOW] = displayed;
			elseif (data.action == CBT_GREEN) then
				messages["nodes"][node_name][CBT_GREEN] = displayed;
			elseif (data.action == CBT_GREY) then
				messages["nodes"][node_name][CBT_GREY] = displayed;
			end
		end
	end
end

function CraftBuster_Module_TranslateActionText(color_code, name, level)
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