local TW = TerritoryWars
local TWUtil = TW.Utilities
TW.InGroup = {}

util.AddNetworkString("TerritoryWars.GroupRegisterRequest")
util.AddNetworkString("TerritoryWars.CantCreateGroupBecauseOfCount")
util.AddNetworkString("TerritoryWars.CantCreateGroupBecauseOfName")
util.AddNetworkString("TerritoryWars.CantCreateGroupBecauseYouAreInGroup")
util.AddNetworkString("TerritoryWars.OpenRegisterWindow")
util.AddNetworkString("TerritoryWars.OpenGroupWindow")
util.AddNetworkString("TerritoryWars.ShowGroupInfo")
util.AddNetworkString("TerritoryWars.GetGroupPoints")
util.AddNetworkString("TerritoryWars.GetMyPoints")
util.AddNetworkString("TerritoryWars.Invite")
util.AddNetworkString("TerritoryWars.OpenInviteWindow")
util.AddNetworkString("TerritoryWars.GivePointsToPlayerFromGroup")
util.AddNetworkString("TerritoryWars.ChangeRole")
util.AddNetworkString("TerritoryWars.GetGroup")
util.AddNetworkString("TerritoryWars.GetGroupNames")
util.AddNetworkString("TerritoryWars.CreateRole")
util.AddNetworkString("TerritoryWars.ChangeMemberRole")
util.AddNetworkString("TerritoryWars.Leave")
util.AddNetworkString("TerritoryWars.Vote")
util.AddNetworkString("TerritoryWars.SetDiplomacyEnemy")
util.AddNetworkString("TerritoryWars.SetDiplomacyNeutral")
util.AddNetworkString("TerritoryWars.SetDiplomacyAlly")
util.AddNetworkString("TerritoryWars.ImproveDiplomacy")
util.AddNetworkString("TerritoryWars.ImprovedDiplomacy")
util.AddNetworkString("TerritoryWars.InviteAccept")
util.AddNetworkString("TerritoryWars.InviteDecline")
util.AddNetworkString("TerritoryWars.GetQuests")
util.AddNetworkString("TerritoryWars.GetGroupQuests")
util.AddNetworkString("TerritoryWars.WithdrawGroupPoints")
util.AddNetworkString("TerritoryWars.DepositGroupPoints")
util.AddNetworkString("TerritoryWars.Kick")
util.AddNetworkString("TerritoryWars.DeleteRole")
util.AddNetworkString("TerritoryWars.GetMembers")
util.AddNetworkString("TerritoryWars.GetRoles")
util.AddNetworkString("TerritoryWars.GetDiplomacy")
util.AddNetworkString("TerritoryWars.PassCase")
util.AddNetworkString("TerritoryWars.CaseState")
util.AddNetworkString("TerritoryWars.IncomeCaseState")
util.AddNetworkString("TerritoryWars.GroupShopList")
util.AddNetworkString("TerritoryWars.RoleSlotUpgrade")
util.AddNetworkString("TerritoryWars.GroupDeleted")
util.AddNetworkString("TerritoryWars.QuestDoneMessage")
util.AddNetworkString("TerritoryWars.GroupQuestDoneMessage")
util.AddNetworkString("TerritoryWars.GroupLifeTime")
util.AddNetworkString("TerritoryWars.GroupEndNotification")
util.AddNetworkString("TerritoryWars.SetSalaryDelay")
util.AddNetworkString("TerritoryWars.KillerQuestInfo")
util.AddNetworkString("TerritoryWars.SetRole")
util.AddNetworkString("TerritoryWars.BuyTime")
util.AddNetworkString("TerritoryWars.GroupRoleUpgradeEnd")
util.AddNetworkString("TerritoryWars.GroupUpgradeData")
util.AddNetworkString("TerritoryWars.PassIncomeCase")
util.AddNetworkString("TerritoryWars.GetMember")
util.AddNetworkString("TerritoryWars.YouAreNotInGroup")
util.AddNetworkString("TerritoryWars.TerritoryRetainer")
util.AddNetworkString("TerritoryWars.InviteFailedLimit")
util.AddNetworkString("TerritoryWars.VoteTimeStatus")
util.AddNetworkString("TerritoryWars.SetLeader")
util.AddNetworkString("TerritoryWars.ChangeMOTD")
util.AddNetworkString("TerritoryWars.GiveSWEPs")
util.AddNetworkString("TerritoryWars.ConfiguredMessage")

if TW.RoleUpgrading then
	util.AddNetworkString("TerritoryWars.RoleUpgrade")
end

if TW.QuestsAvailable then
	util.AddNetworkString("TerritoryWars.ActivateQuest")
	util.AddNetworkString("TerritoryWars.ActivateGroupQuest")
end

if TW.GroupUpgrading then
	util.AddNetworkString("TerritoryWars.GroupUpgrade")
end

if TW.QuestsAvailable then
	include("territorywars.quest_class_server.lua")
	include("territorywars.group_quest_class_server.lua")
	include("territorywars.attack_quest_class_server.lua")
	include("territorywars.attack_flag_quest_class_server.lua")
	include("territorywars.killer_quest_class_server.lua")
	include("territorywars.defend_quest_class_server.lua")
	include("territorywars.defend_flag_quest_class_server.lua")
	include("territorywars.pass_case_quest_class_server.lua")
	include("territorywars.destroy_enemy_group_quest_class_server.lua")
	include("territorywars.ally_group_quest_class_server.lua")
	include("territorywars.quest_done_group_quest_class_server.lua")
	include("territorywars.pass_case_group_quest_class_server.lua")
	include("territorywars.moving_quest_class_server.lua")
	include("territorywars.moving_on_flag_quest_class_server.lua")
	include("territorywars.attack_group_quest_class_server.lua")
	include("territorywars.attack_flag_group_quest_class_server.lua")
end

include("territorywars.permisions_class_server.lua")
include("territorywars.member_class_server.lua")
if TW.TerritoryCapturing then
	include("territorywars.map_server.lua")
end
include("territorywars.role_class_server.lua")
include("territorywars.group_class_server.lua")

hook.Add("TerritoryWars.QuestDone", "TerritoryWars.QuestDoneCallback", function(player, group, type, data, reward) 
	if not group then
		return
	end
	if not IsValid(player) then
		return
	end
	net.Start("TerritoryWars.QuestDoneMessage")
		net.WriteString(type)
		net.WriteTable(data)
		net.WriteInt(reward, 32)
	net.Send(player)
end)

hook.Add("TerritoryWars.GroupQuestDone", "TerritoryWars.GroupQuestDoneCallback", function(group, type, data, reward, lifeTimeReward) 
	if not group then
		return
	end
	TW.SendGroupLifeTime(group)
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GroupQuestDoneMessage")
				net.WriteString(type)
				net.WriteTable(data)
				net.WriteInt(reward, 32)
				net.WriteInt(lifeTimeReward, 32)
			net.Send(member.Player)
		end
	end
end)

function TW.PlayerToolsSpawn(player)
	if player:TWGetGroup() then
		if player:TWGetGroup().AllComputersCreated then
			if TW.TerritoryCapturing then
				player:Give("territorywars.capturer")
				player:Give("territorywars.map_tablet")
				if TW.HandGetIncome then
					player:Give("territorywars.territory_income_getter")
				end
				if TW.GiveGroupTablet then
					player:Give("territorywars.group_tablet")
				end
			end
		elseif player:TWGetGroup().ComputerCreated and player:SteamID() == player:TWGetGroup().LeaderSteamID then
			if TW.ShopActivated then
				player:Give("territorywars.shop_computer_parts")
			end
		elseif player:SteamID() == player:TWGetGroup().LeaderSteamID then
			player:Give("territorywars.leader_computer_parts")
		end
	end
end

net.Receive("TerritoryWars.GiveSWEPs", function(bytelength, player) 
	TW.PlayerToolsSpawn(player)
end)

net.Receive("TerritoryWars.ChangeMOTD", function(bytelength, player) 
	local group = player:TWGetGroup()
	if group and (player:SteamID() == group.LeaderSteamID or player:TWGetGroupRole().Permisions["MOTD"]) then
		group.MOTD = net.ReadString()
		for _, member in pairs(group.Members) do 
			if IsValid(member.Player) then
				net.Start("TerritoryWars.ChangeMOTD")
					net.WriteString(group.MOTD)
				net.Send(member.Player)
			end
		end
	end
end)

if TW.GroupUpgrading then
	net.Receive("TerritoryWars.GroupUpgrade", function(byteLength, player) 
		if player:TWGetGroup() then
			local permisions = player:TWGetGroupRole().Permisions
			if player:SteamID() == player:TWGetGroup().LeaderSteamID or permisions["Group upgrading"] then
				local group = player:TWGetGroup()
				local upgradeName = net.ReadString()
				TW:UpgradeGroup(group, TW.GroupUpgradeTemplates[upgradeName])
				TW.SendGroupPoints(group)
			end
		end
	end)
end

net.Receive("TerritoryWars.BuyTime", function(byteLength, player) 
	local group = player:TWGetGroup()
	if group and player:TWGetGroupMember().Points >= TW.BuyTimePoints then
		local member = player:TWGetGroupMember()
		member.Points = member.Points - TW.BuyTimePoints
		group.LifeTime = group.LifeTime + TW.BuyTimeSeconds
		TW.SendGroupLifeTime(group)
		net.Start("TerritoryWars.GetMyPoints")
			net.WriteInt(member.Points, 32)
		net.Send(player)
	end
end)

net.Receive("TerritoryWars.SetSalaryDelay", function(byteLength, player) 
	if player:SteamID() == player:TWGetGroup().LeaderSteamID then
		player:TWGetGroup().SalaryDelay = math.abs(net.ReadInt(32))
		for _, member in pairs(player:TWGetGroup().Members) do 
			if IsValid(member.Player) then
				net.Start("TerritoryWars.SetSalaryDelay")
					net.WriteInt(player:TWGetGroup().SalaryDelay, 32)
				net.Send(member.Player)
			end
		end
	end
end)

net.Receive("TerritoryWars.RoleSlotUpgrade", function(byteLength, player) 
	local group = player:TWGetGroup()
	if group then
		if player == group.Leader or player:TWGetGroupRole().Permisions["Role creating"] then
			local roleName = net.ReadString()
			local role = group.Roles[roleName]
			if group.Points >= role.SlotPrice then
				role.MaxSlots = role.MaxSlots + TW.SlotAddCount
				group.Points = group.Points - role.SlotPrice
				role.UpgradedCount = role.UpgradedCount + TW.SlotAddPrice
				role.SlotPrice = TW.SlotPrice * role.UpgradedCount
				TWUtil:SetGroupRoleToEveryone(group, role.Name)
				TW.SendGroupPoints(group)
			end
		end
	end
end)

if TW.RoleUpgrading then
	net.Receive("TerritoryWars.RoleUpgrade", function(byteLength, player) 
		if player:TWGetGroup() then
			local permisions = player:TWGetGroupRole().Permisions
			if player:SteamID() == player:TWGetGroup().LeaderSteamID or permisions["Role creating"] then
				local group = player:TWGetGroup()
				local upgradeName = net.ReadString()
				local roleName = net.ReadString()
				if TW:UpgradeRole(group, roleName, TW.UpgradeTemplates[upgradeName]) then
					for _, member in pairs(group.Members) do 
						if IsValid(member.Player) and member.Role == roleName then
							TW.UpgradeTemplates[upgradeName]:Apply(member.Player, false)
						end
					end
					TWUtil:SetGroupRoleToEveryone(group, roleName)
					TW.SendGroupPoints(group)
				end
			end
		end
	end)
end

net.Receive("TerritoryWars.PassCase", function(byteLength, player) 
	if player:TWGetGroup() and TW:GetPlayerData(player).HaveIntel then
		TW:GetPlayerData(player).HaveIntel = false
		player:TWGetGroup().CasesPassed = player:TWGetGroup().CasesPassed + 1
		player:TWGetGroup():GenerateQuests(player)
		player:TWGetGroupMember().Points = player:TWGetGroupMember().Points + TW.BringCaseReward
		hook.Run("TerritoryWars.CasePassed", player)
		net.Start("TerritoryWars.GetMyPoints")
			net.WriteInt(player:TWGetGroupMember().Points, 32)
		net.Send(player)
	end
end)

net.Receive("TerritoryWars.PassIncomeCase", function(byteLength, player) 
	if player:TWGetGroup() and TW:GetPlayerData(player).IncomePoints then
		player:TWGetGroup().Points = player:TWGetGroup().Points + TW:GetPlayerData(player).IncomePoints
		TW:GetPlayerData(player).IncomePoints = 0
		player:TWGetGroup().CasesPassed = player:TWGetGroup().CasesPassed + 1
		player:TWGetGroup():GenerateQuests(player)
		player:TWGetGroupMember().Points = player:TWGetGroupMember().Points + TW.BringIncomeCaseReward
		hook.Run("TerritoryWars.IncomeCasePassed", player)
		net.Start("TerritoryWars.GetMyPoints")
			net.WriteInt(player:TWGetGroupMember().Points, 32)
		net.Send(player)
	end
end)

net.Receive("TerritoryWars.DeleteRole", function(byteLength, player) 
	if player:TWGetGroup() then
		player:TWGetGroup():DeleteRole(net.ReadString())
		TWUtil:SendGroupRolesToEveryone(player:TWGetGroup())
	end
end)

net.Receive("TerritoryWars.ActivateGroupQuest", function(byteLength, player) 
	if player:TWGetGroup()
		and (player:SteamID() == player:TWGetGroup().LeaderSteamID
			 or player:TWGetGroupRole().Permisions["Group quest accept"]) then
		local index = net.ReadInt(32)
		player:TWGetGroup().Quests[index]:Activate()
		--TWUtil:SendGroupToEveryone(player:TWGetGroup())
		player:TWGetGroup():SendGroupQuests()
	end
end)

net.Receive("TerritoryWars.ActivateQuest", function(byteLength, player) 
	if player:TWGetGroup() then
		local index = net.ReadInt(32)
		player:TWGetGroupMember().Quests[index]:Activate(player)
		--TWUtil:SendGroupToPlayer(player)
		player:TWGetGroup():SendQuests(player)
	end
end)

net.Receive("TerritoryWars.InviteAccept", function(byteLength, player)
	if TW.ActiveInvites[player:SteamID()] then
		if player:TWGetGroup() then
			if table.Count(player:TWGetGroup().Members) == 1 then
				player:TWGetGroup():DeleteGroup()
			else
				player:TWGetGroup():Kick(player)
			end
		end
		local group = TW.ActiveInvites[player:SteamID()]
		group:Add(player)
		if TW.TerritoryCapturing then
			player:Give("territorywars.capturer")
			player:Give("territorywars.map_tablet")
			if TW.HandGetIncome then
				player:Give("territorywars.territory_income_getter")
			end
		end
		TW.ActiveInvites[player:SteamID()] = nil
	end
end)

net.Receive("TerritoryWars.InviteDecline", function(byteLength, player)
	if TW.ActiveInvites[player:SteamID()] then
		TW.ActiveInvites[player:SteamID()] = nil
	end
end)

net.Receive("TerritoryWars.Kick", function(byteLength, ply) 
	if ply:TWGetGroup() then
		if ply == ply:TWGetGroup().Leader 
				or ply:TWGetGroupRole().Permisions["Kick"] then
			ply:TWGetGroup():Kick(player.GetBySteamID(net.ReadString()))
		end
	end
end)

hook.Add("PlayerInitialSpawn", "TerritoryWars.InGroupChecker", function(ply)
	timer.Simple(5, function()
		if ply:TWGetGroup() then
			local group = ply:TWGetGroup()
			group.Members[ply:SteamID()].Player = ply
			if ply:SteamID() == group.LeaderSteamID then 
				group.Leader = ply
			end
			TWUtil:SendGroupToPlayer(ply)
			local colors = {}
			for _, group in pairs(TW.Groups) do 
				colors[group.Name] = group.Color
			end
			net.Start("TerritoryWars.GetGroupNames")
				net.WriteTable(table.GetKeys(TW.Groups))
				net.WriteTable(colors)
			net.Send(ply)
			net.Start("TerritoryWars.GetMyPoints")
				net.WriteInt(ply:TWGetGroupMember().Points, 32)
			net.Send(ply)
			if TW.GroupUpgrading then
				net.Start("TerritoryWars.GroupUpgradeData")
					net.WriteInt(group.GroupUpgradeCoolDownEnd, 32)
					net.WriteInt(group.UpgradedCount, 32)
					net.WriteTable(group.Upgrades)
				net.Send(ply)
			end
			net.Start("TerritoryWars.VoteTimeStatus")
				net.WriteBool(group.VoteTime or false)
			net.Send(ply)
		end
	end)
end)

hook.Add("PlayerDeath", "TerritoryWars.DiplomacyMinusBecauseOfKill", function(killedPlayer, _, killer) 
	if killer:IsPlayer() and killedPlayer:IsPlayer() then
		if TW:GetPlayerData(killedPlayer).HaveIntel then
			TW:GetPlayerData(killedPlayer).HaveIntel = false
			net.Start("TerritoryWars.CaseState")
				net.WriteBool(false)
			net.Send(killedPlayer)
			local case = ents.Create("territorywars.intel_case_temp")
			case:Spawn()
			case:SetPos(killedPlayer:GetPos() + Vector(0, 0, 50))
		end

		if (TW:GetPlayerData(killedPlayer).IncomePoints or 0) > 0 or TW.OnKillPointsCaseSpawn then
			local case = ents.Create("territorywars.income_case_temp")
			case:Spawn()
			case:SetPos(killedPlayer:GetPos() + Vector(0, 0, 70))

			case.TWPoints = (TW:GetPlayerData(killedPlayer).IncomePoints or 0) 
            if TW.OnKillPointsCaseSpawn then
                local memberOrGroup = false
                if killedPlayer:TWGetGroup().Points >= killedPlayer:TWGetGroupMember().Points then
                    memberOrGroup = true
                end
                if memberOrGroup then
                    case.TWPoints = case.TWPoints + (killedPlayer:TWGetGroup().Points * (TW.PointsCaseProcents / 100))
                else
                    case.TWPoints = case.TWPoints + (killedPlayer:TWGetGroupMember().Points * (TW.PointsCaseProcents / 100))
                end
            end

			TW:GetPlayerData(killedPlayer).IncomePoints = 0
			net.Start("TerritoryWars.CaseState")
				net.WriteBool(false)
			net.Send(killedPlayer)
		end

		if killer:TWGetGroup() and killedPlayer:TWGetGroup() then
			local group1 = killer:TWGetGroup()
			local group2 = killedPlayer:TWGetGroup()

			if not group2 or not group1 or group1 == group2 then
				return
			end

			if not group2.Diplomacy[killer:TWGetGroup().Name] then
				group2.Diplomacy[killer:TWGetGroup().Name] = 0
			end
			group2.Diplomacy[group1.Name] = 
				group2.Diplomacy[group1.Name] - TW.UnitsKillDiplomacyMinus

			if not group1.Diplomacy[group2.Name] then
				group1.Diplomacy[group2.Name] = 0
			end
			group1.Diplomacy[group2.Name] = 
				group1.Diplomacy[group2.Name] - TW.UnitsKillDiplomacyMinus

			local groupsList = table.GetKeys(TW.Groups)

			if #groupsList > 0 then
				for _, name in pairs(groupsList) do 
					if name == group1.Name or name == group2.Name then
						continue
					end
					if not group1.Diplomacy[name] then
						group1.Diplomacy[name] = 0
					end
					if not group2.Diplomacy[name] then
						group2.Diplomacy[name] = 0
					end
					if group1.Diplomacy[name] > group2.Diplomacy[name] then
						group1.Diplomacy[name] = group1.Diplomacy[name] + TW.UnitsKillDiplomacyMinus
						for _, member in pairs(TW.Groups[name].Members) do 
							if IsValid(member.Player) then
								net.Start("TerritoryWars.ImprovedDiplomacy")
									net.WriteBool(true)
									net.WriteString(group1.Name)
								net.Send(member.Player)
							end
						end
					else
						group1.Diplomacy[name] = group1.Diplomacy[name] - TW.UnitsKillDiplomacyMinus
						for _, member in pairs(TW.Groups[name].Members) do 
							if IsValid(member.Player) then
								net.Start("TerritoryWars.ImprovedDiplomacy")
									net.WriteBool(false)
									net.WriteString(group1.Name)
								net.Send(member.Player)
							end
						end
					end
				end
			end

			for _, member in pairs(group1.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.ImprovedDiplomacy")
						net.WriteBool(false)
						net.WriteString(group2.Name)
					net.Send(member.Player)
				end
			end
			for _, member in pairs(group2.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.ImprovedDiplomacy")
						net.WriteBool(false)
						net.WriteString(group1.Name)
					net.Send(member.Player)
				end
			end

			TWUtil:SendGroupDiplomacyToEveryone(group1)
			TWUtil:SendGroupDiplomacyToEveryone(group2)

			hook.Run("TerritoryWars.DiplomacyChanged", group1, group2)
		end
	end
end)

hook.Add("PlayerSpawn", "TerritoryWars.ToolsGiveOnSpawn", function(player) 
	TW.PlayerToolsSpawn(player)
	if player:TWGetGroup() then
		player:TWGetGroupMember().Nick = player:Nick() 
		if TW.RoleUpgrading then
			for name, upgrade in pairs(TW.UpgradeTemplates) do 
				upgrade:Apply(player, true)
			end
		end
	end
end)

net.Receive("TerritoryWars.ImproveDiplomacy", function(byteLength, player) 
	if net.ReadBool() then
		local groupName = player:TWGetGroup().Name 
		local groupName2 = TW.ActiveImproveDiplomacy[groupName][1]
		local points = TW.ActiveImproveDiplomacy[groupName][2]
		player:TWGetGroup().Diplomacy[groupName2] = points
		TW.Groups[groupName2].Diplomacy[groupName] = points
		TWUtil:SendGroupDiplomacyToEveryone(player:TWGetGroup())
		TWUtil:SendGroupDiplomacyToEveryone(TW.Groups[groupName2])
		for _, member in pairs(player:TWGetGroup().Members) do 
			if IsValid(member.Player) then
				net.Start("TerritoryWars.ImprovedDiplomacy")
					net.WriteBool(true)
					net.WriteString(groupName2)
				net.Send(member.Player)
			end
		end
		for _, member in pairs(TW.Groups[groupName2].Members) do 
			if IsValid(member.Player) then
				net.Start("TerritoryWars.ImprovedDiplomacy")
					net.WriteBool(true)
					net.WriteString(player:TWGetGroup().Name)
				net.Send(member.Player)
			end
		end
		hook.Run("TerritoryWars.DiplomacyChanged", player:TWGetGroup(), TW.Groups[groupName2])
	else
		TW.ActiveImproveDiplomacy[player:TWGetGroup().Name] = nil
	end
end)

net.Receive("TerritoryWars.SetDiplomacyEnemy", function(byteLength, player) 
	player:TWGetGroup():SetDiplomacy(net.ReadString(), -5000, net.ReadString())
end)

net.Receive("TerritoryWars.SetDiplomacyNeutral", function(byteLength, player) 
	player:TWGetGroup():SetDiplomacy(net.ReadString(), 0, net.ReadString())
end)

net.Receive("TerritoryWars.SetDiplomacyAlly", function(byteLength, player) 
	player:TWGetGroup():SetDiplomacy(net.ReadString(), 5000 + (TW.UnitsKillDiplomacyMinus * 10), net.ReadString())
end)

net.Receive("TerritoryWars.GetGroupNames", function(byteLength, player)
	local colors = {}
	for _, group in pairs(TW.Groups) do 
		colors[group.Name] = group.Color
	end
	net.Start("TerritoryWars.GetGroupNames")
		net.WriteTable(table.GetKeys(TW.Groups))
		net.WriteTable(colors)
	net.Send(player)
end)

net.Receive("TerritoryWars.GetGroupPoints", function(byteLength, player) 
	if TW:GetPlayerData(player) and player:TWGetGroup() then
		if player:SteamID() == player:TWGetGroup().LeaderSteamID 
			or player:TWGetGroupRole().Permisions["Group point managing"] then
			net.Start("TerritoryWars.GetGroupPoints")
				net.WriteInt(player:TWGetGroup().Points, 32)
			net.Send(player)
		end
	end
end)

net.Receive("TerritoryWars.WithdrawGroupPoints", function(byteLength, player) 
	local value = net.ReadInt(32)
	player:TWGetGroup():WithdrawGroupPoints(player:TWGetGroupMember(), value)
end)

net.Receive("TerritoryWars.DepositGroupPoints", function(byteLength, player) 
	local value = net.ReadInt(32)
	player:TWGetGroup():DepositGroupPoints(player:TWGetGroupMember(), value)
end)

net.Receive("TerritoryWars.GivePointsToPlayerFromGroup", function(byteLength, player) 
	local group = player:TWGetGroup()
	local player2 = group.Members[net.ReadString()]
	local count = net.ReadInt(32)
	group:GivePoints(player:TWGetGroupMember(), player2, math.abs(count))
end)

net.Receive("TerritoryWars.Invite", function(byteLength, ply) 
	local group = ply:TWGetGroup()
	if group then
		if ply == group.Leader or 
				ply:TWGetGroupRole().Permisions["Invite"] then
			if group.Roles[group.NoviceRole].CurrentSlots < group.Roles[group.NoviceRole].MaxSlots then
				local steamID = net.ReadString()
				group:Invite(player.GetBySteamID(steamID))
			else
				net.Start("TerritoryWars.InviteFailedLimit")
				net.Send(ply)
			end
		end
	end
end)

net.Receive("TerritoryWars.GroupRegisterRequest", function(byteLength, ply) 
	local name = net.ReadString()
	local color = net.ReadTable()

	if table.Count(TW.Groups) >= TW.MaxGroupCount then
		net.Start("TerritoryWars.CantCreateGroupBecauseOfCount")
		net.Send(ply)
		return
	end

	if TW.Groups[name] then
		net.Start("TerritoryWars.CantCreateGroupBecauseOfName")
		net.Send(ply)
		return
	end

	if ply:TWGetGroup() then
		ply:TWGetGroup():Kick(ply)
	end

	if gmod.GetGamemode().Name == "DarkRP" then
		if ply:getDarkRPVar("money") >= TW.GroupCreationMoney then
			ply:addMoney(-TW.GroupCreationMoney)
		end
	end

	local group = TW.Group(ply, color, name)
	TW.Groups[name] = group
	group:Add(ply)
	group:GenerateGroupQuests()

	local colors = {}
	for _, group in pairs(TW.Groups) do 
		colors[group.Name] = group.Color
	end
	net.Start("TerritoryWars.GetGroupNames")
		net.WriteTable(table.GetKeys(TW.Groups))
		net.WriteTable(colors)
	net.Broadcast() 

	TWUtil:SendGroupToPlayer(ply)

	ply:Give("territorywars.leader_computer_parts")
	net.Start("TerritoryWars.ConfiguredMessage")
		net.WriteString("Step1")
	net.Send(ply)
end)

net.Receive("TerritoryWars.ChangeRole", function(byteLength, player) 
	if player:TWGetGroup() then
		if player:SteamID() == player:TWGetGroup().LeaderSteamID
				or player:TWGetGroupRole().Permisions["Role creating"] then
			local role = player:TWGetGroup().Roles[net.ReadString()]
			local newName = net.ReadString()
			role.Salary = math.abs(net.ReadInt(32))
			role.Permisions = net.ReadTable()
			role.Color = net.ReadTable()
			if role.Name == player:TWGetGroup().NoviceRole then
				player:TWGetGroup().NoviceRole = newName
			end
			if role.Name ~= newName then
				for _, member in pairs(player:TWGetGroup().Members) do 
					member.Role = newName
				end
				player:TWGetGroup().Roles[role.Name] = nil
				player:TWGetGroup().Roles[newName] = role
				role.Name = newName
				TWUtil:SendGroupToEveryone(player:TWGetGroup())
			else
				TWUtil:SetGroupRoleToEveryone(player:TWGetGroup(), role.Name)
			end
		end
	end
end)

net.Receive("TerritoryWars.CreateRole", function(byteLength, player) 
	if TW:GetPlayerData(player) and player:TWGetGroup() then
		local permisions = player:TWGetGroupRole().Permisions
		if player:SteamID() == player:TWGetGroup().LeaderSteamID or permisions["Role creating"] then
			if player:TWGetGroup().Points >= TW.RoleCreatePrice then
				local name = net.ReadString()
				local salary = net.ReadInt(32)
				local permisions = net.ReadTable()
				local color = net.ReadTable()

				player:TWGetGroup():CreateRole(name, color, permisions, salary)

				player:TWGetGroup().Points = player:TWGetGroup().Points - TW.RoleCreatePrice
				TWUtil:SetGroupRoleToEveryone(player:TWGetGroup(), name)

				TW.SendGroupPoints(player:TWGetGroup())
			end
		end
	end
end)

net.Receive("TerritoryWars.ChangeMemberRole", function(byteLength, player) 
	if player:TWGetGroup() then
		local permisions = player:TWGetGroupRole().Permisions
		if player:SteamID() == player:TWGetGroup().LeaderSteamID 
				or permisions["Role changing"] then
			local membersSteamID = net.ReadString()
			local roleName = net.ReadString() 
			local group = player:TWGetGroup()
			if group.Roles[roleName]
					and group.Members[membersSteamID] then
				if group.Roles[roleName].CurrentSlots < group.Roles[roleName].MaxSlots then
					local member = group.Members[membersSteamID]
					group.Roles[member.Role].CurrentSlots = group.Roles[member.Role].CurrentSlots - 1
					group.Roles[roleName].CurrentSlots = group.Roles[roleName].CurrentSlots + 1
					member.Role = roleName
					if IsValid(member.Player) and TW.RoleUpgrading then
						for name, tier in pairs(group.Roles[member.Role].Upgrades) do 
							TW.UpgradeTemplates[string.Split(name, "Upgrade")[1]]:Apply(member.Player, false)
						end
					end
				else
					player:ChatPrint(TW.Labels.ThisRoleIsFull)
				end
				TWUtil:SendGroupMembersToEveryone(player:TWGetGroup())
			end
		end
	end
end)
 
net.Receive("TerritoryWars.Leave", function(byteLength, ply) 
	if ply:TWGetGroup() then
		if table.Count(ply:TWGetGroup().Members) == 1 then
			ply:TWGetGroup():DeleteGroup()
		elseif ply:SteamID() == ply:TWGetGroup().LeaderSteamID then
			local group = TW.Groups[ply:TWGetGroup().Name]
			group.Leader = nil
			group.LeaderSteamID = nil
			group.VoteTime = true
			for _, member in pairs(ply:TWGetGroup().Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.VoteTimeStatus")
						net.WriteBool(true)
					net.Send(member.Player)
					net.Start("TerritoryWars.SetLeader")
						net.WriteString("nil")
					net.Send(member.Player)
				end
			end
			TW.Votes[group.Name] = {}
			timer.Create("TerritoryWars." .. group.Name .. "VoteTime", 60 * 5, 1, function() 
				local maxVotes, selectedLeader = -1, ""
				for SteamID, countOfVotes in pairs(TW.Votes[group.Name]) do 
					if maxVotes < countOfVotes then
						maxVotes = countOfVotes
						selectedLeader = SteamID
					end
				end
				if maxVotes == -1 then
					group:DeleteGroup()
					timer.Remove("TerritoryWars." .. group.Name .. "VoteTime")
					return
				end
				group.Leader = player.GetBySteamID(selectedLeader)
				group.LeaderSteamID = selectedLeader
				for _, member in pairs(group.Members) do 
					member.Voted = nil
				end
				group.VoteTime = nil
				for _, member in pairs(ply:TWGetGroup().Members) do 
					if IsValid(member.Player) then
						net.Start("TerritoryWars.VoteTimeStatus")
							net.WriteBool(false)
						net.Send(member.Player)
						net.Start("TerritoryWars.SetLeader")
							net.WriteString(selectedLeader)
						net.Send(member.Player)
					end
				end
			end)
			ply:TWGetGroup():Kick(ply)
		else
			ply:TWGetGroup():Kick(ply)
		end
	end
end)

net.Receive("TerritoryWars.Vote", function(byteLength, player)
	if TW:GetPlayerData(player) and player:TWGetGroup() then
		local group = player:TWGetGroup()
		local voteTo = net.ReadString()
		if group.VoteTime and not group.Members[player:SteamID()].Voted then
			if not TW.Votes[group.Name][voteTo] then
				TW.Votes[group.Name][voteTo] = 0
			end
			TW.Votes[group.Name][voteTo] = TW.Votes[group.Name][voteTo] + 1
			group.Members[player:SteamID()].Voted = true
		end
	end
end)