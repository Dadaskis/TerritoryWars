local TW = TerritoryWars
local TWUtil = TW.Utilities
TW.Votes = {}
TW.InGroup = {}
TW.ActiveInvites = {}
TW.ActiveImproveDiplomacy = {}

function TW.SendGroupLifeTime(group) 
	if not group then 
		return
	end
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GroupLifeTime")
				net.WriteInt(group.LifeTime, 32)
			net.Send(member.Player)
		end
	end
end

function TW.SendGroupPoints(group) 
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GetGroupPoints")
				net.WriteInt(group.Points, 32)
			net.Send(member.Player)
		end
	end
end 

function TW.SendGroupRoleUpgradeEnd(group) 
	if not group then 
		return
	end
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GroupRoleUpgradeEnd")
				net.WriteTable(group.UpgradeCoolDownEnd)
			net.Send(member.Player)
		end
	end
end

function TW.SendGroupUpgradeData(group) 
	if not group then 
		return
	end
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GroupUpgradeData")
				net.WriteInt(group.GroupUpgradeCoolDownEnd, 32)
				net.WriteInt(group.UpgradedCount, 32)
				net.WriteTable(group.Upgrades)
			net.Send(member.Player)
		end
	end
end

function TW.Group(player, color, name) 
	local group = {}
	if player and IsValid(player) then
		group.Leader = player
		group.LeaderSteamID = player:SteamID()
	end
	group.Members = {}
	group.Roles = {}
	group.Diplomacy = {}
	group.Color = color
	group.Points = 0
	group.Name = name
	group.SalaryDelay = TW.GroupStartSalaryDelay
	group.SalaryTime = os.time() + group.SalaryDelay
	group.LifeTime = os.time() + TW.GroupStartLifeTime
	group.CasesPassed = 0
	group.MOTD = "Sample text"

	if TW.ShopActivated then
		group.ShopList = {}
	end

	if TW.RoleUpgrading then
		group.UpgradeCoolDownEnd = {}
	end

	if TW.GroupUpgrading then
		group.GroupUpgradeCoolDownEnd = 0
		group.UpgradedCount = 1
		group.Upgrades = {}
		for _, data in pairs(TW.GroupUpgradeTemplates) do 
			group.Upgrades[data.Name] = 0
		end
	end

	if TW.QuestsAvailable then
		group.Quests = {}
		group.QuestDone = 0
		group.GroupQuestDone = 0
	end

	if TW.TerritoryCapturing then
		group.TerritoriesCount = 0
		group.Territories = {}
	end

	if player and IsValid(player) then
        print(group)
        print(group.Roles)
        print(TW.Labels.Novice)
        print(group.Roles[TW.Labels.Novice])
        print(TW.Role)
		group.Roles[TW.Labels.Novice] = TW.Role(group)
		group.Roles[TW.Labels.Novice].MaxSlots = TW.NoviceSlotsCount
		group.Roles[TW.Labels.Novice].CurrentSlots = 1
		group.NoviceRole = TW.Labels.Novice
	end

	function group:CreateRole(name, color, permisions, salary)
		self.Roles[name] = TW.Role(self, name, color, permisions, salary)
	end

	function group:Add(player) 
		self.Members[player:SteamID()] = TW.Member(self, player)
		player:TWSetGroup(self)
		self:GenerateQuests(player)
		TWUtil:SetGroupMemberToEveryone(self, player:SteamID())
		TWUtil:SendGroupToPlayer(player)
		if TW.GroupUpgrading then
			TW.SendGroupUpgradeData(group)
		end
		net.Start("TerritoryWars.VoteTimeStatus")
			net.WriteBool(group.VoteTime or false)
		net.Send(player)
		hook.Run("TerritoryWars.GroupAddedPlayer", self, player)
	end

	function group:Kick(player) 
		if IsValid(player) then
			self.Points = self.Points + player:TWGetGroupMember().Points
			player:TWGetGroupMember().Points = 0
			self.Members[player:SteamID()] = nil
			player:TWSetGroup(nil) 
			TWUtil:SendGroupMembersToEveryone(self)
			player:StripWeapon("territorywars.capturer")
			player:StripWeapon("territorywars.territory_income_getter")
			net.Start("TerritoryWars.GroupDeleted")
			net.Send(player)
			hook.Run("TerritoryWars.GroupKickPlayer", self, player)
			if table.Count(self.Members) == 0 then
				self:DeleteGroup()
			end
		else 
            self.Points = self.Points + player:TWGetGroupMember().Points
            self.Members[player:SteamID()] = nil
            TWUtil:SendGroupMembersToEveryone(self)
            hook.Run("TerritoryWars.GroupKickPlayer", self, player)
        end
	end

	function group:DeleteRole(name) 
		hook.Run("TerritoryWars.GroupRoleDelete", self, name)
		if name == group.NoviceRole then
			return
		end

		for _, member in pairs(self.Members) do 
			if member.Role == name then
				member.Role = group.NoviceRole
			end
		end
		group.Roles[name] = nil
		TWUtil:SendGroupRolesToEveryone(self)
		TWUtil:SendGroupMembersToEveryone(self)
	end

	function group:DeleteGroup() 
		if TW.Groups[self.Name] then
			hook.Run("TerritoryWars.GroupDeleted", self)

			if IsValid(self.Leader) then
				self.Leader:StripWeapon("territorywars.leader_computer_parts")
				self.Leader:StripWeapon("territorywars.shop_computer_parts")
			end

			for _, member in pairs(self.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.GroupDeleted")
					net.Send(member.Player)
				end
				self:Kick(member.Player)
			end

			if TW.TerritoryCapturing then
				for X, tbl in pairs(self.Territories or {}) do 
					for Y, _ in pairs(tbl) do 
						if TW.Territories[X] then
							TW.Territories[X][Y].GroupName = nil
							TW.Territories[X][Y].Color = nil
						end
					end
				end
			end

			for ID, data in pairs(TW.FlagBonusMap) do 
				if data.Owner == self.Name then
					data.Owner = nil
					net.Start("TerritoryWars.SetFlagBonusMap")
						net.WriteInt(ID, 32)
						net.WriteTable(TWUtil:GetTableData(data))
					net.Broadcast()
					if data.Bonuses then
						for index, bonus in pairs(data.Bonuses) do 
							bonus:OnUncaptured(self, 0, 0, index, ID)
						end
					end
				end
			end

			TW.Groups[group.Name] = nil		
			timer.Remove("TerritoryWars." .. self.Name .. "GroupIncomeTimer")
			timer.Remove("TerritoryWars." .. self.Name .. "VoteTime")
			timer.Remove("TerritoryWars." .. self.Name .. "GroupLifeTime")

			if TW.TerritoryCapturing then
				TW:SendTerritories()
			end
		end
	end

	function group:Invite(player) 
		TW.ActiveInvites[player:SteamID()] = group
		net.Start("TerritoryWars.Invite")
			net.WriteString(group.Name)
		net.Send(player)
		hook.Run("TerritoryWars.GroupPlayerInvite", self, player)
	end

	function group:SetDiplomacy(groupName, points, reason) 
		reason = reason or ""
		local plyGroupName = self.Name 
		if not TW.Groups[groupName].Diplomacy[plyGroupName] then
			TW.Groups[groupName].Diplomacy[plyGroupName] = 0
		end
		if points > TW.Groups[groupName].Diplomacy[plyGroupName] then
			TW.ActiveImproveDiplomacy[groupName] = { plyGroupName, points, reason }
			if IsValid(TW.Groups[groupName].Leader) then
				net.Start("TerritoryWars.ImproveDiplomacy")
					net.WriteString(plyGroupName)
					net.WriteString(reason)
					net.WriteBool(true)
				net.Send(TW.Groups[groupName].Leader)
			end
		else
			TW.Groups[groupName].Diplomacy[plyGroupName] = points
			TW.Groups[plyGroupName].Diplomacy[groupName] = points
			
			TWUtil:SendGroupDiplomacyToEveryone(self)
			TWUtil:SendGroupDiplomacyToEveryone(TW.Groups[groupName])
			for _, member in pairs(self.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.ImprovedDiplomacy")
						net.WriteBool(false)
						net.WriteString(groupName)
					net.Send(member.Player)
				end
			end
			for _, member in pairs(TW.Groups[groupName].Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.ImprovedDiplomacy")
						net.WriteBool(false)
						net.WriteString(member.Player:TWGetGroup().Name)
					net.Send(member.Player)
				end
			end
			if IsValid(TW.Groups[groupName].Leader) then
				net.Start("TerritoryWars.ImproveDiplomacy")
					net.WriteString(plyGroupName)
					net.WriteString(reason)
					net.WriteBool(false)
				net.Send(TW.Groups[groupName].Leader)
			end
			hook.Run("TerritoryWars.DiplomacyChanged", self, TW.Groups[groupName])
		end
	end

	if TW.QuestsAvailable then
		function group:GenerateQuests(player) 
			if player and IsValid(player) then
				local member = player:TWGetGroupMember()
				local quests = member.Quests

				for SteamID, member in pairs(self.Members) do 
					for index, quest in pairs(member.Quests) do 
						if not quest.Available then
							member.Quests[index] = nil
						end
					end
				end

				for key, quest in pairs(TW.QuestTypes) do 
					table.Add(quests, quest(group, player))
				end

				self:SendQuests(player)
				hook.Run("TerritoryWars.GroupGeneratedQuests", self, player)
			end
		end

		function group:GenerateGroupQuests() 
			local quests = self.Quests

			for index, quest in pairs(quests) do 
				if not quest.Available then
					quests[index] = nil
				end
			end

			for key, quest in pairs(TW.GroupQuestTypes) do 
				table.Add(quests, quest(group))
			end

			self:SendGroupQuests()
			hook.Run("TerritoryWars.GroupGeneratedGroupQuests", self)
		end

		function group:SendQuests(player) 
			net.Start("TerritoryWars.GetQuests")
				net.WriteTable(TWUtil:GetTableData(player:TWGetGroupMember().Quests))
			net.Send(player)
		end

		function group:SendGroupQuests() 
			for _, member in pairs(self.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.GetGroupQuests")
						net.WriteTable(TWUtil:GetTableData(self.Quests))
					net.Send(member.Player)
				end
			end
		end
	else
		function group:GenerateQuests() end
		function group:GenerateGroupQuests() end
	end

	function group:DepositGroupPoints(player, value) 
		if value > 0 and player.Points >= value then
			player.Points = player.Points - value
			self.Points = self.Points + value
			if IsValid(player.Player) then
				net.Start("TerritoryWars.GetMyPoints")
					net.WriteInt(player.Points, 32)
				net.Send(player.Player)
			end
			TW.SendGroupPoints(group)
		end
	end

	function group:WithdrawGroupPoints(player, value) 
		if value > 0 and self.Points >= value then
			player.Points = player.Points + value
			self.Points = self.Points - value
			if IsValid(player.Player) then
				net.Start("TerritoryWars.GetMyPoints")
					net.WriteInt(player.Points, 32)
				net.Send(player.Player)
			end
			TW.SendGroupPoints(group)
		end
	end

	function group:GivePoints(player1, player2, value) 
		if player1.Points >= value then
			player1.Points = player1.Points - value
			player2.Points = player2.Points + value
			if IsValid(player1.Player) then
				net.Start("TerritoryWars.GetMyPoints")
					net.WriteInt(player1.Points, 32)
				net.Send(player1.Player)
			end
			if IsValid(player1.Player) then
				net.Start("TerritoryWars.GetMyPoints")
					net.WriteInt(player2.Points, 32)
				net.Send(player2.Player)
			end
		end
	end

	function group:OnComputerCreated() 
		self.ComputerCreated = true
		if TW.ShopActivated then
			self.Leader:Give("territorywars.shop_computer_parts")
			net.Start("TerritoryWars.ConfiguredMessage")
				net.WriteString("Step2")
			net.Send(self.Leader)
		else
			self.AllComputersCreated = true
			if TW.TerritoryCapturing then
				net.Start("TerritoryWars.ConfiguredMessage")
					net.WriteString("Step3")
				net.Send(self.Leader)
				net.Start("TerritoryWars.ConfiguredMessage")
					net.WriteString("CapturerDescription")
				net.Send(self.Leader)
				net.Start("TerritoryWars.ConfiguredMessage")
					net.WriteString("MapTabletDescription")
				net.Send(self.Leader)
				net.Start("TerritoryWars.ConfiguredMessage")
					net.WriteString("IncomeGetterDescription")
				net.Send(self.Leader)
				self.Leader:Give("territorywars.capturer")
				self.Leader:Give("territorywars.map_tablet")
				self.Leader:Give("territorywars.territory_income_getter")
			end
		end
	end

	function group:OnShopComputerCreated() 
		self.AllComputersCreated = true
		if TW.TerritoryCapturing then
			net.Start("TerritoryWars.ConfiguredMessage")
				net.WriteString("Step3")
			net.Send(self.Leader)
			net.Start("TerritoryWars.ConfiguredMessage")
				net.WriteString("CapturerDescription")
			net.Send(self.Leader)
			net.Start("TerritoryWars.ConfiguredMessage")
				net.WriteString("MapTabletDescription")
			net.Send(self.Leader)
			net.Start("TerritoryWars.ConfiguredMessage")
				net.WriteString("IncomeGetterDescription")
			net.Send(self.Leader)
			self.Leader:Give("territorywars.capturer")
			self.Leader:Give("territorywars.map_tablet")
			self.Leader:Give("territorywars.territory_income_getter")
		end
	end

	if TW.QuestsAvailable then
		group:GenerateGroupQuests()

		timer.Create("TerritoryWars." .. name .. "QuestGenerate", 60, 0, function() 
			group:GenerateGroupQuests()
			for _, member in pairs(group.Members) do 
				if IsValid(member.Player) then
					group:GenerateQuests(member.Player)
				end
			end
		end)
	end

	timer.Create("TerritoryWars." .. name .. "GroupSalaryTimer", 1, 0, function() 
		if os.time() > group.SalaryTime then
			group.SalaryTime = os.time() + group.SalaryDelay
			TW.SendGroupLifeTime(group)
			hook.Run("TerritoryWars.GroupSalaryTime", self)
			for _, member in pairs(group.Members) do 
				if group.Points > 0 and group.Roles[member.Role].Salary > 0 and group.Points >= group.Roles[member.Role].Salary then
					member.Points = member.Points + group.Roles[member.Role].Salary
					group.Points = group.Points - group.Roles[member.Role].Salary
					if IsValid(member.Player) then
						net.Start("TerritoryWars.GetMyPoints")
							net.WriteInt(member.Points, 32)
						net.Send(member.Player)
					end
				end
			end
			TW.SendGroupPoints(group)
		end
	end)

	timer.Create("TerritoryWars." .. name .. "GroupLifeTime", 1, 0, function() 
		if os.time() > group.LifeTime then
			local results = hook.Run("TerritoryWars.OnDeleteGroupBecauseOfGroupQuests", group)
			if results then
				for _, value in pairs(results) do 
					if not value then
						group.LifeTime = os.time() + 60
						TW.SendGroupLifeTime(group)
						return
					end
				end
			end
			group:DeleteGroup()
		elseif (group.LifeTime - os.time()) / 60 < 5 and not group.NotificationCreated then
			group.NotificationCreated = true
			for _, member in pairs(group.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.GroupEndNotification")
						net.WriteInt(math.Round((group.LifeTime - os.time()) / 60), 32)
					net.Send(member.Player)
				end
			end
			timer.Simple(60, function()
				group.NotificationCreated = false
			end)
		end
	end)

    hook.Run("TerritoryWars.GroupCreated", group)

	TW:Save()

	return group
end



