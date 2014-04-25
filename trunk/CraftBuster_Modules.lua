function CraftBuster_Module_BuildBaseActions(skill_type, skill_name, skill_short_code)
	local skill_actions = {};
	for i=2,#CBG_PROFESSION_RANKS do
		local min_skill_level, max_skill_level, title = CBG_PROFESSION_RANKS[i][1], CBG_PROFESSION_RANKS[i][2], CBG_PROFESSION_RANKS[i][3];
		skill_actions[str_pad(i-1, 2, "0", "right") .. skill_short_code .. "_level_" .. i] = {
			["ply_level"] = CBG_SKILL_PLY_LEVELS[i][skill_type],
			["skill_level"] = min_skill_level,
			["action"] = CBT_NEXT_LEVEL,
			["message"] = string.format(CBL["TRAINER_ACTION"], skill_name, title),
		};
	end

	return skill_actions;
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