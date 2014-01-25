local SKILL_NAME = CBL["SKILL_SKIN"];
local SKILL_SHORT_CODE = "skin";
local SKILL_TYPE = CBG_SKILL_GATHER;
local SKILL_ID = CBT_SKILL_SKIN;
local SKILL_ACTIONS = {};

local SKILL_NODES = {};

local function CraftBuster_Module_Skinning_UpdateTooltip()
	local level = UnitLevel("mouseover");
	local level_orange = 1;
	if (level <= 10) then
	elseif (level > 10 and level <= 20) then
		level_orange = 100 - (10 * level);
	elseif (level > 20 and level <= 73) then
		level_orange = 5 * level;
	elseif (level > 73 and level <= 80) then
		level_orange = 10 * level;
	elseif (level > 80 and level <= 83) then
		level_orange = 5 * level;
	elseif (level > 83) then
		level_orange = 20 * level;
	end
	local level_yellow = level_orange + 50;
	local level_green = level_orange + 75;
	local level_grey = level_orange + 100;
	GameTooltip:AddLine(CBL["NODE_MSG"] .. ORANGE_FONT_COLOR_CODE .. " " .. level_orange .. YELLOW_FONT_COLOR_CODE .. " " .. level_yellow .. GREEN_FONT_COLOR_CODE .. " " .. level_green .. GRAY_FONT_COLOR_CODE .. " " .. level_grey);
	GameTooltip:Show();
end

local function CraftBuster_Module_Skinning_HandleNode(line_one, line_two, line_three)
	if (not CraftBusterOptions.skinnables) then
		CraftBusterOptions.skinnables = {};
	end
	SKILL_NODES = CraftBusterOptions.skinnables;

	line_one =  gsub(gsub(line_one, "|c........", ""), "|r", "");
	for node_name, item_id in sortedpairs(SKILL_NODES) do
		if (string.find(line_one, node_name) ~= nil) then
			if (line_three ~= nil and line_three == "Skinnable") then
				--echo(SKILL_NAME .. " Found: " .. node_name);
				CraftBuster_Module_Skinning_UpdateTooltip();
				return true;
			end
		end
	end
	if (line_three ~= nil and line_three == "Skinnable") then
		CraftBuster_Module_Skinning_UpdateTooltip();
		SKILL_NODES[line_one] = 1;
		CraftBusterOptions.skinnables = SKILL_NODES;
		return true;
	end

	return false;
end

local function CraftBuster_Module_Skinning_HandleAction(skill_data)
	if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID]) then
		CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID] = {};
	end
	for action_id, data in sortedpairs(SKILL_ACTIONS) do
		if (not CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id]) then
			--echo(SKILL_NAME .. " Check: " .. CraftBusterPlayerLevel .. " >= " .. data.ply_level .. " and " .. skill_data.level .. " >= " .. data.skill_level);
			if (CraftBusterPlayerLevel >= data.ply_level and skill_data.level >= data.skill_level) then
				echo(data.message);
				CraftBusterOptions[CraftBusterEntry].alerts[SKILL_ID][action_id] = true;
			end
		end
	end
end

local function CraftBuster_Module_Skinning_OnLoad()
	SKILL_ACTIONS = CraftBuster_Module_BuildBaseActions(SKILL_TYPE, SKILL_NAME, SKILL_SHORT_CODE);
	local module_options = {
		skill_type = CBG_SKILL_GATHER,
		tooltip_info = true,
		node_function = CraftBuster_Module_Skinning_HandleNode,
		action_function = CraftBuster_Module_Skinning_HandleAction,
	};
	CraftBuster_RegisterModule(SKILL_ID, SKILL_NAME, module_options);
end

CraftBuster_Module_Skinning_OnLoad();