TerritoryWars = {}
local TW = TerritoryWars

include("config/territorywars.config.lua")
include("src/territorywars.utility.lua")
include("src/territorywars.global.lua")

if TW.TerritoryCapturing then
	include("src/territorywars.capture_logic_shared.lua")
end
include("src/territorywars.group_shared.lua")
include("src/territorywars.territory_bonus_class_shared.lua")
include("src/territorywars.income_territory_bonus_class_shared.lua")
if TW.ShopActivated then
	include("src/territorywars.shop_shared.lua")
	include("src/territorywars.shop_unlock_territory_bonus_class_shared.lua")
end

if TW.RoleUpgrading then
	include("src/territorywars.role_upgrade_class_shared.lua")
	if TW.CritsEnabled then
		include("src/territorywars.crits_role_upgrade_class_shared.lua")
	end

	if TW.DamageEnabled then
		include("src/territorywars.damage_role_upgrade_class_shared.lua")
	end

	if TW.HealthEnabled then
		include("src/territorywars.health_role_upgrade_class_shared.lua")
	end

	if TW.DodgeEnabled then
		include("src/territorywars.dodge_role_upgrade_class_shared.lua")
	end

	if TW.ArmorEnabled then
		include("src/territorywars.armor_role_upgrade_class_shared.lua")
	end

	if TW.AdrenalineEnabled then
		include("src/territorywars.adrenalin_role_upgrade_class_shared.lua")
	end

	if TW.ArmorerEnabled then
		include("src/territorywars.armorer_role_upgrade_class_shared.lua")
	end

	if TW.MedicEnabled then
		include("src/territorywars.medic_role_upgrade_class_shared.lua")
	end

	if TW.RegenerationEnabled then
		include("src/territorywars.regeneration_role_upgrade_class_shared.lua")
	end

	if TW.RunnerEnabled then
		include("src/territorywars.runner_role_upgrade_class_shared.lua")
	end

	if TW.SpeedEnabled then
		include("src/territorywars.speed_role_upgrade_class_shared.lua")
	end

	if TW.StealthEnabled then
		include("src/territorywars.stealth_role_upgrade_class_shared.lua")
	end

	if TW.TankEnabled then
		include("src/territorywars.tank_role_upgrade_class_shared.lua")
	end

	if TW.JumpEnabled then
		include("src/territorywars.jump_role_upgrade_class_shared.lua")
	end
end

if TW.GroupUpgrading then
	include("src/territorywars.group_upgrade_class_shared.lua")
	if TW.GroupIncomeUpgradeEnabled then
		include("src/territorywars.group_income_upgrade_class_shared.lua")
	end
	if TW.QuestsAvailable then
		if TW.GroupQuestPointsRewardUpgradeEnabled then
			include("src/territorywars.group_quest_points_reward_upgrade_class_shared.lua")
		end
		if TW.GroupGroupQuestPointsRewardUpgradeEnabled then
			include("src/territorywars.group_group_quest_points_reward_upgrade_class_shared.lua")
		end
		if TW.GroupGroupQuestLifeTimeRewardUpgradeEnabled then
			include("src/territorywars.group_group_quest_lifetime_reward_upgrade_class_shared.lua")
		end
		if TW.GroupQuestPositiveTimeLengthUpgradeEnabled then
			include("src/territorywars.group_quest_positive_time_length_upgrade_class_shared.lua")
		end
		if TW.GroupQuestNegativeTimeLengthUpgradeEnabled then
			include("src/territorywars.group_quest_negative_time_length_upgrade_class_shared.lua")
		end
		if TW.GroupGroupQuestPositiveTimeLengthUpgradeEnabled then
			include("src/territorywars.group_group_quest_positive_time_length_upgrade_class_shared.lua")
		end
		if TW.GroupGroupQuestNegativeTimeLengthUpgradeEnabled then
			include("src/territorywars.group_group_quest_negative_time_length_upgrade_class_shared.lua")
		end
	end
	if TW.RoleUpgrading then
		if TW.GroupRoleUpgradeDiscountUpgradeEnabled then
			include("src/territorywars.group_role_upgrade_discount_upgrade_class_shared.lua")
		end
		if TW.RoleUpgradeCoolDown then
			if TW.GroupRoleUpgradeCooldownDiscountUpgradeEnabled then
				include("src/territorywars.group_role_upgrade_cooldown_discount_upgrade_class_shared.lua")
			end
		end
	end
	if TW.ShopActivated then
		if TW.GroupShopDiscountUpgradeEnabled then
			include("src/territorywars.group_shop_discount_upgrade_class_shared.lua")
		end
	end
end

if SERVER then
	resource.AddWorkshop("1694487193")
	AddCSLuaFile("config/territorywars.config.lua")
	AddCSLuaFile("src/territorywars.global.lua")
	AddCSLuaFile("src/territorywars.gui_colors_client.lua")
	AddCSLuaFile("src/territorywars.button_base_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.window_base_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.panel_base_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.label_base_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.scroll_panel_base_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.utility.lua")
	AddCSLuaFile("src/territorywars.group_shared.lua")
	AddCSLuaFile("src/territorywars.group_client.lua")
	if TW.TerritoryCapturing then
		AddCSLuaFile("src/territorywars.capture_logic_shared.lua")
		AddCSLuaFile("src/territorywars.capture_logic_client.lua")
		AddCSLuaFile("src/territorywars.map_client.lua")
	end
	if TW.ShopActivated then
		AddCSLuaFile("src/territorywars.shop_client.lua")
		AddCSLuaFile("src/territorywars.shop_shared.lua")
	end
	AddCSLuaFile("src/territorywars.font.lua")
	AddCSLuaFile("src/territorywars.role_slots_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.color_chooser_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.color_chooser_window_opener_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.register_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.diplomacy_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.diplomacy_answer_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.diplomacy_reason_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.invite_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.invite_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.main_group_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.member_panel_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.group_info_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.leave_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.leader_vote_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.roles_menu_panel_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.give_points_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.give_points_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.group_points_label_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.roles_list_panel_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.give_points_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.role_data_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.role_panel_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.roles_menu_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.deposit_points_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.deposit_points_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.withdraw_points_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.incomes_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.withdraw_points_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.guide_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.language_switch_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.territory_retainer_client.lua")
	AddCSLuaFile("src/territorywars.case_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.territory_bonus_class_shared.lua")
	AddCSLuaFile("src/territorywars.shop_unlock_territory_bonus_class_shared.lua")
	AddCSLuaFile("src/territorywars.income_territory_bonus_class_shared.lua")
	AddCSLuaFile("src/territorywars.territory_bonuses_setting_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.territory_bonus_panel_base_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.territory_bonus_shop_unlock_panel_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.territory_bonus_income_panel_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.territory_settings_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.flag_client.lua")
	AddCSLuaFile("src/territorywars.territory_info_window_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.buy_time_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.income_case_button_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.tool_tip_gui_class_client.lua")
	AddCSLuaFile("src/territorywars.give_sweps_button_gui_class_client.lua")
	if TW.RoleUpgrading then
		AddCSLuaFile("src/territorywars.role_upgrade_panel_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.role_upgrade_window_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.crits_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.damage_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.health_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.dodge_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.armor_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.adrenalin_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.armorer_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.medic_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.regeneration_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.runner_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.speed_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.stealth_role_upgrade_class_shared.lua")
		AddCSLuaFile("src/territorywars.tank_role_upgrade_class_shared.lua")
	end
	if TW.QuestsAvailable then
		AddCSLuaFile("src/territorywars.quest_panel_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_base_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_attack_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_killer_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_defend_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_pass_case_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_panel_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_button_base_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_ally_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_destroy_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_done_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_attack_flag_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_defend_flag_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_pass_case_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_moving_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.quest_moving_on_flag_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_attack_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_quest_attack_flag_button_gui_class_client.lua")
	end
	if TW.GroupUpgrading then
		AddCSLuaFile("src/territorywars.group_upgrade_panel_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_upgrade_window_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_upgrades_window_button_gui_class_client.lua")
		AddCSLuaFile("src/territorywars.group_upgrade_class_shared.lua")
		if TW.QuestsAvailable then
			if TW.GroupIncomeUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_income_upgrade_class_shared.lua")
			end
			if TW.GroupQuestPointsRewardUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_quest_points_reward_upgrade_class_shared.lua")
			end
			if TW.GroupGroupQuestPointsRewardUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_group_quest_points_reward_upgrade_class_shared.lua")
			end
			if TW.GroupGroupQuestLifeTimeRewardUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_group_quest_lifetime_reward_upgrade_class_shared.lua")
			end
			if TW.GroupQuestPositiveTimeLengthUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_quest_positive_time_length_upgrade_class_shared.lua")
			end
			if TW.GroupQuestNegativeTimeLengthUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_quest_negative_time_length_upgrade_class_shared.lua")
			end
			if TW.GroupGroupQuestPositiveTimeLengthUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_group_quest_positive_time_length_upgrade_class_shared.lua")
			end
			if TW.GroupGroupQuestNegativeTimeLengthUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_group_quest_negative_time_length_upgrade_class_shared.lua")
			end
		end
		if TW.RoleUpgrading then
			if TW.GroupRoleUpgradeDiscountUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_role_upgrade_discount_upgrade_class_shared.lua")
			end
			if TW.GroupRoleUpgradeCooldownDiscountUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_role_upgrade_cooldown_discount_upgrade_class_shared.lua")
			end
		end
		if TW.ShopActivated then
			if TW.GroupShopDiscountUpgradeEnabled then
				AddCSLuaFile("src/territorywars.group_shop_discount_upgrade_class_shared.lua")
			end
		end
	end
	if TW.TerritoryCapturing then
		include("src/territorywars.capture_logic_server.lua")
	end
	include("src/territorywars.group_server.lua")
	if TW.ShopActivated then
		include("src/territorywars.shop_server.lua")
	end
	include("src/territorywars.territory_retainer_server.lua")
	include("src/territorywars.flag_server.lua")
	include("src/territorywars.save_server.lua")
	TW:Load()
end 

if CLIENT then
	include("src/territorywars.font.lua")
	if TW.TerritoryCapturing then
		include("src/territorywars.capture_logic_client.lua")
		include("src/territorywars.map_client.lua")
	end
	include("src/territorywars.territory_retainer_client.lua")
	include("src/territorywars.group_client.lua")
	if TW.ShopActivated then
		include("src/territorywars.shop_client.lua")
	end
end