include("territorywars.gui_colors_client.lua")
include("territorywars.tool_tip_gui_class_client.lua")
include("territorywars.role_slots_window_gui_class_client.lua")
include("territorywars.button_base_gui_class_client.lua")
include("territorywars.window_base_gui_class_client.lua")
include("territorywars.panel_base_gui_class_client.lua")
include("territorywars.label_base_gui_class_client.lua")
include("territorywars.scroll_panel_base_gui_class_client.lua")
include("territorywars.main_group_window_gui_class_client.lua")
include("territorywars.group_info_button_gui_class_client.lua")
include("territorywars.color_chooser_window_gui_class_client.lua")
include("territorywars.color_chooser_window_opener_button_gui_class_client.lua")
include("territorywars.register_window_gui_class_client.lua")
include("territorywars.diplomacy_button_gui_class_client.lua")
include("territorywars.diplomacy_answer_window_gui_class_client.lua")
include("territorywars.diplomacy_reason_window_gui_class_client.lua")
include("territorywars.invite_window_gui_class_client.lua")
include("territorywars.invite_button_gui_class_client.lua")
include("territorywars.member_panel_gui_class_client.lua")
include("territorywars.leave_button_gui_class_client.lua")
include("territorywars.leader_vote_button_gui_class_client.lua")
include("territorywars.roles_menu_panel_gui_class_client.lua")
include("territorywars.give_points_window_gui_class_client.lua")
include("territorywars.give_points_button_gui_class_client.lua")
include("territorywars.group_points_label_gui_class_client.lua")
include("territorywars.roles_list_panel_gui_class_client.lua")
include("territorywars.give_points_window_gui_class_client.lua")
include("territorywars.role_data_window_gui_class_client.lua")
include("territorywars.role_panel_gui_class_client.lua")
include("territorywars.roles_menu_button_gui_class_client.lua")
include("territorywars.deposit_points_window_gui_class_client.lua")
include("territorywars.deposit_points_button_gui_class_client.lua")
include("territorywars.withdraw_points_window_gui_class_client.lua")
include("territorywars.withdraw_points_button_gui_class_client.lua")
include("territorywars.territory_settings_window_gui_class_client.lua")
include("territorywars.guide_button_gui_class_client.lua")
include("territorywars.language_switch_button_gui_class_client.lua")
include("territorywars.case_button_gui_class_client.lua")
include("territorywars.territory_bonuses_setting_window_gui_class_client.lua")
include("territorywars.territory_bonus_panel_base_gui_class_client.lua")
include("territorywars.territory_bonus_shop_unlock_panel_gui_class_client.lua")
include("territorywars.territory_bonus_income_panel_gui_class_client.lua")
include("territorywars.incomes_window_gui_class_client.lua")
include("territorywars.territory_info_window_gui_class_client.lua")
include("territorywars.flag_client.lua")
include("territorywars.buy_time_button_gui_class_client.lua")
include("territorywars.income_case_button_gui_class_client.lua")
include("territorywars.give_sweps_button_gui_class_client.lua")

local TW = TerritoryWars

if TW.RoleUpgrading then
	include("territorywars.role_upgrade_panel_gui_class_client.lua")
	include("territorywars.role_upgrade_window_gui_class_client.lua")
end

if TW.QuestsAvailable then
	include("territorywars.quest_panel_gui_class_client.lua")
	include("territorywars.quest_button_gui_class_client.lua")
	include("territorywars.quest_base_button_gui_class_client.lua")
	include("territorywars.quest_attack_button_gui_class_client.lua")
	include("territorywars.quest_killer_button_gui_class_client.lua")
	include("territorywars.quest_defend_button_gui_class_client.lua")
	include("territorywars.quest_pass_case_button_gui_class_client.lua")
	include("territorywars.group_quest_panel_gui_class_client.lua")
	include("territorywars.group_quest_button_gui_class_client.lua")
	include("territorywars.group_quest_button_base_gui_class_client.lua")
	include("territorywars.group_quest_ally_gui_class_client.lua")
	include("territorywars.group_quest_destroy_gui_class_client.lua")
	include("territorywars.group_quest_done_gui_class_client.lua")
	include("territorywars.quest_attack_flag_button_gui_class_client.lua")
	include("territorywars.quest_defend_flag_button_gui_class_client.lua")
	include("territorywars.group_quest_pass_case_button_gui_class_client.lua")
	include("territorywars.quest_moving_button_gui_class_client.lua")
	include("territorywars.quest_moving_on_flag_button_gui_class_client.lua")
	include("territorywars.group_quest_attack_button_gui_class_client.lua")
	include("territorywars.group_quest_attack_flag_button_gui_class_client.lua")
end

if TW.GroupUpgrading then
	include("territorywars.group_upgrade_panel_gui_class_client.lua")
	include("territorywars.group_upgrade_window_gui_class_client.lua")
	include("territorywars.group_upgrades_window_button_gui_class_client.lua")
end

TW.GroupShopList = {}

TW.GroupReceived = 0
TW.PointsReceived = 0
TW.RolesReceived = 0
TW.MembersReceived = 0
TW.DiplomacyReceived = 0
TW.GroupPointsReceived = 0
TW.GroupQuestsReceived = 0
TW.QuestsReceived = 0
TW.GroupUpgradesReceived = 0
TW.MOTDReceived = 0

TW.CaseState = false
TW.IncomeCaseState = false

TW.Points = 0
TW.UpgradeCoolDownEnd = {}

TW.GroupUpgradeCoolDownEnd = 0
TW.GroupUpgradedCount = 1
TW.GroupUpgrades = {}

net.Receive("TerritoryWars.ChangeMOTD", function() 
	TW.Group.MOTD = net.ReadString()
	TW.MOTDReceived = RealTime()
end)

net.Receive("TerritoryWars.SetLeader", function() 
	TW.Group.LeaderSteamID = net.ReadString()
end)

net.Receive("TerritoryWars.VoteTimeStatus", function() 
	TW.VoteTime = net.ReadBool()
end)

net.Receive("TerritoryWars.ConfiguredMessage", function() 
	local index = net.ReadString()
	chat.AddText(Color(255, 0, 0), TW.Labels[index])
end)

net.Receive("TerritoryWars.InviteFailedLimit", function() 
	chat.AddText(Color(255, 0, 0), TW.Labels.YouCantInvite1 .. group.NoviceRole.Name .. TW.Labels.YouCantInvite2)
end)

net.Receive("TerritoryWars.TerritoryRetainer", function() 
	chat.AddText(Color(255, 0, 0), TW.Labels.TerritoryRetainerText)
end)

net.Receive("TerritoryWars.GetMember", function() 
	if TW.Group then
		local steamID = net.ReadString()
		local data = net.ReadTable()
		TW.Group.Members[steamID] = data
	end
end)

net.Receive("TerritoryWars.SetRole", function() 
	if TW.Group then
		local roleName = net.ReadString() 
		local data = net.ReadTable()
		TW.Group.Roles[roleName] = data
		TW.RolesReceived = RealTime()
	end
end)

net.Receive("TerritoryWars.GroupUpgradeData", function() 
	TW.GroupUpgradesReceived = RealTime()
	TW.GroupUpgradeCoolDownEnd = net.ReadInt(32)
	TW.GroupUpgradedCount = net.ReadInt(32)
	TW.GroupUpgrades = net.ReadTable()
end)

net.Receive("TerritoryWars.GroupRoleUpgradeEnd", function() 
	TW.UpgradeCoolDownEnd = net.ReadTable()
end)

net.Receive("TerritoryWars.GroupLifeTime", function() 
	if TW.Group then
		TW.Group.LifeTime = net.ReadInt(32)
	end
end)

net.Receive("TerritoryWars.GetGroupPoints", function() 
	TW.GroupPoints = net.ReadInt(32)
	TW.GroupPointsReceived = RealTime()
end)

net.Receive("TerritoryWars.GetMyPoints", function() 
	TW.Points = net.ReadInt(32)
	TW.PointsReceived = RealTime()
end)

net.Receive("TerritoryWars.GetGroupNames", function() 
	TW.GroupNames = net.ReadTable()
	TW.GroupColors = net.ReadTable()
end)
	
net.Receive("TerritoryWars.GetQuests", function() 
	TW.Quests = net.ReadTable()
	TW.QuestsReceived = RealTime()
end)

net.Receive("TerritoryWars.GetGroupQuests", function() 
	TW.GroupQuests = net.ReadTable()
	TW.GroupQuestsReceived = RealTime()
end)

net.Receive("TerritoryWars.GetGroup", function() 
	local steamID = net.ReadString()
	local group = net.ReadTable()

	TW.GroupReceived = RealTime()
	TW.MembersReceived = RealTime()
	TW.RolesReceived = RealTime()
	TW.DiplomacyReceived = RealTime()
	TW.GroupQuestsReceived = RealTime()
	TW.QuestsReceived = RealTime()
	TW.Groups[group.Name] = group
	TW.Group = group

	TW.GroupQuests = group.Quests
	TW.Quests = TW.Group.Members[steamID].Quests
	TW.GroupShopList = group.ShopList
end)

net.Receive("TerritoryWars.GetMembers", function() 
	local members = net.ReadTable()
	TW.MembersReceived = RealTime()
	if TW.Group then
		TW.Group.Members = members
	end
end)

net.Receive("TerritoryWars.GetRoles", function() 
	local roles = net.ReadTable()
	TW.RolesReceived = RealTime()
	if TW.Group then
		TW.Group.Roles = roles
	end
end)

net.Receive("TerritoryWars.GetDiplomacy", function() 
	local diplomacy = net.ReadTable()
	TW.DiplomacyReceived = RealTime()
	if TW.Group then
		TW.Group.Diplomacy = diplomacy
	end
end)

net.Receive("TerritoryWars.GroupShopList", function() 
	TW.GroupShopList = net.ReadTable() or {}
end)

net.Receive("TerritoryWars.CaseState", function() 
	TW.CaseState = net.ReadBool()
	if TW.CaseState then
		chat.AddText(Color(150, 0, 0), TW.Labels.YouGetSpecialCase)
	end
end)

net.Receive("TerritoryWars.IncomeCaseState", function() 
	TW.IncomeCaseState = net.ReadBool()
end)

net.Receive("TerritoryWars.SetSalaryDelay", function() 
	if TW.Group then
		TW.Group.SalaryDelay = net.ReadInt(32)
	end
end)

hook.Add("InitPostEntity", "TerritoryWars.ClientInit", function()
	net.Receive("TerritoryWars.ImprovedDiplomacy", function() 
		if net.ReadBool() then
			chat.AddText(
				Color(0, 130, 0),
				TW.Labels.DiplomacyImprove,
				" ",
				net.ReadString(),
				"."
			)
		else
			chat.AddText(
				Color(130, 0, 0),
				TW.Labels.DiplomacyWorsen,
				" ",
				net.ReadString(),
				"."
			)
		end
	end)

	net.Receive("TerritoryWars.KillerQuestInfo", function()
		if net.ReadBool() then 
			chat.AddText(
				Color(255, 0, 0),
				"[TerritoryWars] ",
				TW.Labels.KillerText1,
				net.ReadString(),
				TW.Labels.KillerText2
			)
		else
			chat.AddText(
				Color(255, 0, 0),
				"[TerritoryWars] ",
				TW.Labels.KillerComplete,
				" (",
				net.ReadString(),
				")."
			)
		end
	end)

	net.Receive("TerritoryWars.GroupEndNotification", function() 
		local minutes = net.ReadInt(32)
		chat.AddText(Color(255, 0, 0), TW.Labels.Remains .. minutes .. TW.Labels.ToDeletingGroup)
	end)

	net.Receive("TerritoryWars.QuestDoneMessage", function() 
		local type = net.ReadString()
		local data = net.ReadTable()
		local reward = net.ReadInt(32)
		if TW.GroupQuestPointsRewardUpgradeEnabled then
			reward = (reward * (1 + ((TW.GroupQuestPointsRewardUpgradeProcents / 100) * TW.GroupUpgrades["QuestPointsReward"])))
		end
		hook.Run("TerritoryWars.QuestDoneMessage." .. type, data, reward)
	end)

	net.Receive("TerritoryWars.GroupQuestDoneMessage", function() 
		local type = net.ReadString()
		local data = net.ReadTable()
		local reward = net.ReadInt(32)
		local lifeTime = net.ReadInt(32)
		if TW.GroupGroupQuestPointsRewardUpgradeEnabled then
			reward = (reward * (1 + ((TW.GroupGroupQuestPointsRewardUpgradeProcents / 100) * TW.GroupUpgrades["GroupQuestPointsReward"])))
		end
		if TW.GroupGroupQuestLifeTimeRewardUpgradeEnabled then
			lifeTime = (lifeTime * (1 + ((TW.GroupGroupQuestPointsRewardUpgradeProcents / 100) * TW.GroupUpgrades["GroupQuestPointsReward"])))
		end
		hook.Run("TerritoryWars.GroupQuestDoneMessage." .. type, data, reward, lifeTime)
	end)

	net.Receive("TerritoryWars.CantCreateGroupBecauseOfCount", function() 
		chat.AddText(Color(255, 0, 0), TW.Labels.CantCreateGroupBecauseOfCount .. ".")
	end)

	net.Receive("TerritoryWars.CantCreateGroupBecauseOfName", function() 
		chat.AddText(Color(255, 0, 0), TW.Labels.CantCreateGroupBecauseOfName .. ".")
	end)

	net.Receive("TerritoryWars.CantCreateGroupBecauseYouAreInGroup", function() 
		chat.AddText(Color(255, 0, 0), TW.Labels.CantCreateGroupBecauseYouAreInGroup .. ".")
	end)

	net.Receive("TerritoryWars.OpenRegisterWindow", function() 
		vgui.Create("TerritoryWars.RegisterWindow")
	end)

	net.Receive("TerritoryWars.ImproveDiplomacy", function() 
		local window = vgui.Create("TerritoryWars.DiplomacyAnswerWindow")
		window:SetGroupName(net.ReadString())
		window:SetReason(net.ReadString())
		if not net.ReadBool() then
			window:DeleteAppliers()
		end
	end)

	net.Receive("TerritoryWars.GroupDeleted", function() 
		LocalPlayer():TWSetGroup()
		TW.Groups = {}
	end)

	net.Receive("TerritoryWars.OpenGroupWindow", function() 
		local TWUtil = TW.Utilities

		vgui.Create("TerritoryWars.GroupWindow")
	end)

	net.Receive("TerritoryWars.Invite", function() 
		local groupName = net.ReadString()
		local inviteWindow = vgui.Create("TerritoryWars.InviteWindow")	
		inviteWindow:SetGroupName(groupName)
	end)
end)