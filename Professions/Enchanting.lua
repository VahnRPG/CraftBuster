local _, cb = ...;

local VELLUM_ID = 38682; --Enchanting Vellum
local SELECTED_RECIPE_ID = nil;

cb.professions.enchanting = {};
function cb.professions.enchanting:build_button(tradeskill_id)
	cb.professions.enchanting.tradeskill_button = CreateFrame("BUTTON", "CraftBuster_Profession_Enchanting_Tradeskill_Button", TradeSkillFrame, "MagicButtonTemplate");
	cb.professions.enchanting.tradeskill_button:SetPoint("TOPRIGHT", TradeSkillFrame.DetailsFrame.CreateButton, "TOPLEFT", 0, 0);
	cb.professions.enchanting.tradeskill_button:SetText(CBL["TRADESKILL_ENCHANTING"]);
	cb.professions.enchanting.tradeskill_button:SetScript("OnClick", function()
		C_TradeSkillUI.SetRecipeRepeatCount(SELECTED_RECIPE_ID, 1);
		C_TradeSkillUI.CraftRecipe(SELECTED_RECIPE_ID, 1);
		UseItemByName(VELLUM_ID);
	end);
	cb.professions.enchanting.tradeskill_button:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		for i=1, CBL["TRADESKILL_NUMLINES"] do
			GameTooltip:AddLine(CBL["TRADESKILL_LINE" .. i]);
		end
		GameTooltip:Show();
	end);
	cb.professions.enchanting.tradeskill_button:SetScript("OnLeave", GameTooltip_Hide);
	cb.professions.enchanting.tradeskill_button:Hide();
end

local time_count = 0;
local SKILL_ID = CBT_SKILL_ENCH;
local SKILL_SHORT_CODE = "ench";
local profession_data = {
	["id"] = SKILL_ID,
	["name"] = CBL[SKILL_ID],
	["short_code"] = SKILL_SHORT_CODE,
	["type"] = CBG_SKILL_NORMAL,
	["spell_1"] = 7411,		--Enchanting
	["spell_2"] = 13262,	--Disenchant
	["spell_buster"] = 13262,
	["bustable_function"] = function()
		local results = {};
		local count = 0;
		for bag=0, 4 do
			for slot=1, GetContainerNumSlots(bag) do
				local item_id = GetContainerItemID(bag, slot);
				if (item_id ~= nil) then
					local item_name, item_link, item_quality, _, _, item_type, item_sub_type = GetItemInfo(item_id);
					if (not item_name) then
						--[[
						if (time_count < 5) then
							time_count = time_count + 1;
							cb.omg:create_timer(2, function()
								cb.buster_frame:update();
							end);
						else
							cb.omg:echo(CBL["BUSTER_FRAME_ERRORS"]);
						end
						]]--
					elseif (item_quality > 1 and (item_type == "Weapon" or item_type == "Armor")) then
						count = count + 1;
						results[count] = {};
						results[count].item_id = tonumber(item_id);
						results[count].bag = bag;
						results[count].slot = slot;
						results[count].total = 1;
					end
				end
			end
		end

		return results;
	end,
	["trainer_map_icons"] = {
		[301] = {		--Stormwind City
			["Alliance"] = {
				[1317] = { ["name"] = "Lucan Cordell", ["floor"] = 0, ["pos"] = { 53, 74.2 } },
			},
		},
		[41] = {		--Teldrassil
			["Alliance"] = {
				[3606] = { ["name"] = "Alanna Raveneye", ["floor"] = 0, ["pos"] = { 39, 30 } },
			},
		},
		[381] = {		--Darnassus
			["Alliance"] = {
				[4213] = { ["name"] = "Taladan", ["floor"] = 0, ["pos"] = { 56.6, 31 } },
			},
		},
		[341] = {		--Ironforge
			["Alliance"] = {
				[5157] = { ["name"] = "Gimble Thistlefuzz", ["floor"] = 0, ["pos"] = { 60, 45.2 } },
			},
		},
		[121] = {		--Feralas
			["Alliance"] = {
				[7949] = { ["name"] = "Xylinnia Starshine", ["floor"] = 0, ["pos"] = { 46.6, 42.8 } },
			},
		},
		[30] = {		--Elwynn Forest
			["Alliance"] = {
				[11072] = { ["name"] = "Kitta Firewind", ["floor"] = 0, ["pos"] = { 64.8, 70.6 } },
			},
		},
		[471] = {		--The Exodar
			["Alliance"] = {
				[16725] = { ["name"] = "Nahogg", ["floor"] = 0, ["pos"] = { 40.4, 38.6 } },
			},
		},
		[465] = {		--Hellfire Peninsula
			["Alliance"] = {
				[18773] = { ["name"] = "Johan Barnes", ["floor"] = 0, ["pos"] = { 53.6, 66 } },
			},
			["Horde"] = {
				[18753] = { ["name"] = "Felannia", ["floor"] = 0, ["pos"] = { 52.2, 36 } },
			},
		},
		[491] = {		--Howling Fjord
			["Alliance"] = {
				[26906] = { ["name"] = "Elizabeth Jackson", ["floor"] = 0, ["pos"] = { 58.6, 62.8 } },
			},
			["Horde"] = {
				[26954] = { ["name"] = "Emil Autumn", ["floor"] = 0, ["pos"] = { 78.6, 28.2 } },
			},
		},
		[486] = {		--Borean Tundra
			["Alliance"] = {
				[26990] = { ["name"] = "Alexis Marlowe", ["floor"] = 0, ["pos"] = { 57.6, 71.4 } },
			},
			["Horde"] = {
				[26980] = { ["name"] = "Eorain Dawnstrike", ["floor"] = 0, ["pos"] = { 41.2, 53.8 } },
			},
		},
		[141] = {		--Dustwallow Marsh
			["Alliance"] = {
				[53410] = { ["name"] = "Lissah Spellwick", ["floor"] = 0, ["pos"] = { 66, 49.4 } },
			},
		},
		[362] = {		--Thunder Bluff
			["Horde"] = {
				[3011] = { ["name"] = "Teg Dawnstrider", ["floor"] = 0, ["pos"] = { 45.2, 38.8 } },
			},
		},
		[321] = {		--Orgrimmar
			["Horde"] = {
				[3345] = { ["name"] = "Godan", ["floor"] = 1, ["pos"] = { 53.4, 49.4 } },
			},
		},
		[382] = {		--Undercity
			["Horde"] = {
				[4616] = { ["name"] = "Lavinia Crowe", ["floor"] = 0, ["pos"] = { 61.2, 60.4 } },
			},
		},
		[20] = {		--Tirisfal Glades
			["Horde"] = {
				[5695] = { ["name"] = "Vance Undergloom", ["floor"] = 0, ["pos"] = { 59.8, 53.2 } },
			},
		},
		[81] = {		--Stonetalon Mountains
			["Horde"] = {
				[11074] = { ["name"] = "Hgarth", ["floor"] = 0, ["pos"] = { 51.8, 59.8 } },
			},
		},
		[462] = {		--Eversong Woods
			["Horde"] = {
				[16160] = { ["name"] = "Magistrix Eredania", ["floor"] = 0, ["pos"] = { 38.2, 72.4 } },
			},
		},
		[480] = {		--Silvermoon City
			["Horde"] = {
				[16633] = { ["name"] = "Sedana", ["floor"] = 0, ["pos"] = { 69.8, 24.4 } },
			},
		},
		[481] = {		--Shattrath City
			["Neutral"] = {
				[19251] = { ["name"] = "Enchantress Volali", ["floor"] = 0, ["pos"] = { 43.2, 92.4 } },
				[19252] = { ["name"] = "High Enchanter Bardolan", ["floor"] = 0, ["pos"] = { 43.2, 92.4 } },
				[33633] = { ["name"] = "Enchantress Andiala", ["floor"] = 0, ["pos"] = { 56.2, 74.4 } },
				[33676] = { ["name"] = "Zurii", ["floor"] = 0, ["pos"] = { 36.4, 44.4 } },
			},
		},
		[479] = {		--Netherstorm
			["Neutral"] = {
				[19540] = { ["name"] = "Asarnan", ["floor"] = 0, ["pos"] = { 44.2, 33.6 } },
			},
		},
		[504] = {		--Dalaran
			["Neutral"] = {
				[28693] = { ["name"] = "Enchanter Nalthanis", ["floor"] = 1, ["pos"] = { 39.4, 41 } },
			},
		},
		[492] = {		--Icecrown
			["Neutral"] = {
				[33583] = { ["name"] = "Fael Morningsong", ["floor"] = 0, ["pos"] = { 73, 20.4 } },
			},
		},
		[806] = {		--The Jade Forest
			["Neutral"] = {
				[65127] = { ["name"] = "Lai the Spellpaw", ["floor"] = 0, ["pos"] = { 46.8, 42.8 } },
			},
		},
	},
	["tradeskill_function"] = function(tradeskill_id, recipe_id)
		if (not cb.professions.enchanting.tradeskill_button) then
			cb.professions.enchanting:build_button(tradeskill_id);
		end
		
		SELECTED_RECIPE_ID = recipe_id;
		local recipe_info = recipe_id and C_TradeSkillUI.GetRecipeInfo(recipe_id);
		if (recipe_info) then
			if (GetItemCount(VELLUM_ID) > 0 and recipe_info.alternateVerb == ENSCRIBE and recipe_info.numAvailable > 0) then
				cb.professions.enchanting.tradeskill_button:Show();
			else
				cb.professions.enchanting.tradeskill_button:Hide();
			end
		end
	end,
};
cb.professions:registerModule(profession_data);