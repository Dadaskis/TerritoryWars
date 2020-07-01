local TW = TerritoryWars
local TWUtil = TW.Utilities

util.AddNetworkString("TerritoryWars.OpenFlagWindow")
util.AddNetworkString("TerritoryWars.SetFlagBonusMap")
util.AddNetworkString("TerritoryWars.FlagBonusMapBonuses")
util.AddNetworkString("TerritoryWars.CaptureFlag")
util.AddNetworkString("TerritoryWars.CaptureFlagIsOver")
util.AddNetworkString("TerritoryWars.RemoveFlag")
util.AddNetworkString("TerritoryWars.GetFlagIncome")
util.AddNetworkString("TerritoryWars.FlagIncomeStatus")
util.AddNetworkString("TerritoryWars.YouGetIncome")

TW.FlagBonusMap = TW.FlagBonusMap or {}
TW.FlagPositions = TW.FlagPositions or {}

hook.Add("PlayerInitialSpawn", "TerritoryWars.SendFlagsToPlayer", function(player) 
	timer.Simple(1, function() 
		for ID, data in pairs(TW.FlagBonusMap) do
			net.Start("TerritoryWars.SetFlagBonusMap")
				net.WriteInt(ID, 32)
				net.WriteTable(TWUtil:GetTableData(data))
			net.Send(player)
		end
	end)
end)

local incomeGetted = {}
net.Receive("TerritoryWars.GetFlagIncome", function(byteLength, player) 
	local flagID = net.ReadInt(32)
	if not incomeGetted[flagID] and TW.FlagBonusMap[flagID].Owner == player:TWGetGroup().Name then
		incomeGetted[flagID] = true
		net.Start("TerritoryWars.FlagIncomeStatus")
			net.WriteInt(flagID, 32)
			net.WriteBool(true)
		net.Broadcast(player)
		local time = math.huge - 1
		for _, data in pairs(TW.FlagBonusMap[flagID].Bonuses) do 
			if data.Name == "Income" then
				time = math.min(data.Properties.Delay, time)
			end
		end
		timer.Simple(time, function() 
			incomeGetted[flagID] = nil
			net.Start("TerritoryWars.FlagIncomeStatus")
				net.WriteInt(flagID, 32)
				net.WriteBool(false)
			net.Broadcast()
		end)
		local incomeGetted = false
		for _, bonus in pairs(TW.FlagBonusMap[flagID].Bonuses or {}) do 
			if bonus.Name == "Income" then
				bonus:TakePlayerPoints(player)
				if TW:GetPlayerData(player).IncomePoints > 0 then
					incomeGetted = true
				end
			end
		end
		if incomeGetted then
			net.Start("TerritoryWars.YouGetIncome")
			net.Send(player)
		end
	end
end)

if TW.Changeable then
	net.Receive("TerritoryWars.RemoveFlag", function(byteLength, player) 
		local ID = net.ReadInt(32)
		if player:IsSuperAdmin() then
			Entity(TW.FlagBonusMap[ID].EntIndex):Remove()
			TW.FlagBonusMap[ID] = nil
		end
	end)

	net.Receive("TerritoryWars.SetFlagBonusMap", function(byteLength, player) 
		local ID = net.ReadInt(32)
		local data = net.ReadTable()
		if TW.FlagBonusMap[ID] then
			TW.FlagBonusMap[ID].AdditionalInfo = data.AdditionalInfo
		end
		if player:IsSuperAdmin() then
			data.Owner = nil
			if TW.FlagBonusMap[ID] then
				data.Owner = TW.FlagBonusMap[ID].Owner
			end
			TW.FlagBonusMap[ID].Name = data.Name
			TW.FlagBonusMap[ID].AdditionalInfo = data.AdditionalInfo
			net.Start("TerritoryWars.SetFlagBonusMap")
				net.WriteInt(ID, 32)
				net.WriteTable(TWUtil:GetTableData(TW.FlagBonusMap[ID]))
			net.Broadcast()
		end
	end)

	net.Receive("TerritoryWars.FlagBonusMapBonuses", function(byteLength, player) 
		if player:IsSuperAdmin() then
			local ID = net.ReadInt(32)
			local bonuses = net.ReadTable()

			for key, bonus in pairs(bonuses) do 
				if not bonus.Deleted then
					bonuses[key] = TW.TerritoryBonuses[bonus.Name]()
					bonuses[key].Properties = bonus.Properties
				else
					bonuses[key] = nil
				end
			end

			if not TW.FlagBonusMap[ID] then
				TW.FlagBonusMap[ID] = {}
			end

			TW.FlagBonusMap[ID].Bonuses = bonuses

			net.Start("TerritoryWars.SetFlagBonusMap")
				net.WriteInt(ID, 32)
				net.WriteTable(TWUtil:GetTableData(TW.FlagBonusMap[ID]))
			net.Broadcast()
		end
	end)
end

net.Receive("TerritoryWars.CaptureFlag", function(byteLength, ply) 
	local flagID = net.ReadInt(32)
	local entity = Entity(TW.FlagBonusMap[flagID].EntIndex)
	for _, retainer in pairs(TW.TerritoryRetainers) do 
		if retainer.TWActivated then
			local retainerPos = retainer:GetPos()
			local distance = retainerPos:Distance(entity:GetPos())
			if distance < TW.TerritoryRetainerFlagRadius then
				net.Start("TerritoryWars.TerritoryRetainer")
				net.Send(ply)
				return
			end
		end
	end
	entity:SetColor(Color(255, 100, 100))
	local enemyName = TW.FlagBonusMap[flagID].Owner
	local group = ply:TWGetGroup()
	if enemyName and TW.Groups[enemyName] then
		if TW.FlagBonusMap[flagID].Bonuses then
			for index, bonus in pairs(TW.FlagBonusMap[flagID].Bonuses) do
				bonus:OnUncaptured(TW.Groups[enemyName], 0, 0, index, flagID)
			end
		end
	end
	local pos = entity:GetPos()
	local X = math.Round((pos.x / TW.TerritoryChunkSize) - 0.5)
	local Z = math.Round((pos.y / TW.TerritoryChunkSize) - 0.5)
	for _, member in pairs(ply:TWGetGroup().Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.CaptureFlag")
				net.WriteInt(X, 32)
				net.WriteInt(Z, 32)
			net.Send(member.Player)
		end
	end
	TW.FlagBonusMap[flagID].Owner = nil
	if not TW.FlagBonusMap[flagID].Capture then
		TW.FlagBonusMap[flagID].Capture = true
		net.Start("TerritoryWars.SetFlagBonusMap")
			net.WriteInt(flagID, 32)
			net.WriteTable(TWUtil:GetTableData(TW.FlagBonusMap[flagID]))
		net.Broadcast()
		timer.Simple(TW.TerritoryCaptureTime, function() 
			for _, member in pairs((group or {}).Members or {}) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.CaptureFlagIsOver")
					net.Send(member.Player)
				end
			end
			TW.FlagBonusMap[flagID].Capture = false
			local counter = {}
			local attackers = {}

			for name, _ in pairs(TW.Groups) do 
				counter[name] = 0
			end

			for _, ply in pairs(player.GetAll()) do 
				local distance = ply:GetPos():Distance(entity:GetPos())
				if distance < TW.FlagCaptureDistance then
					if ply:TWGetGroup() then
						counter[ply:TWGetGroup().Name] = counter[ply:TWGetGroup().Name] + 1
						attackers[ply:TWGetGroup().Name] = 
							table.Add(attackers[ply:TWGetGroup().Name] or nil, { ply:TWGetGroupMember() })
					end
				end
			end

			local max, maxKey = 0, ""

			for name, count in pairs(counter) do 
				if max < count then
					maxKey = name
					max = count
				end
			end

			if max == 0 and maxKey == "" then
				net.Start("TerritoryWars.SetFlagBonusMap")
					net.WriteInt(flagID, 32)
					net.WriteTable(TWUtil:GetTableData(TW.FlagBonusMap[flagID]))
				net.Broadcast()
				entity:SetColor(Color(255, 255, 255))
				return
			end

			TW.FlagBonusMap[flagID].Owner = maxKey
			local group1 = TW.Groups[maxKey]
			local group2 = TW.Groups[enemyName]
			if TW.FlagBonusMap[flagID].Bonuses then
				for index, bonus in pairs(TW.FlagBonusMap[flagID].Bonuses) do
					bonus:OnCaptured(group1, 0, 0, index, flagID)
				end
			end

			entity:SetColor(Color(100, 255, 100))
			timer.Simple(10, function() 
				entity:SetColor(Color(255, 255, 255))
			end)
			net.Start("TerritoryWars.SetFlagBonusMap")
				net.WriteInt(flagID, 32)
				net.WriteTable(TWUtil:GetTableData(TW.FlagBonusMap[flagID]))
			net.Broadcast()

			if group2 then
				local groupsList = table.GetKeys(TW.Groups)
				groupsList[group2.Name] = nil
				groupsList[group1.Name] = nil

				for name, _ in pairs(groupsList) do 
					if not group1.Diplomacy[name] then
						group1.Diplomacy[name] = 0
					end
					if not group2.Diplomacy[name] then
						group2.Diplomacy[name] = 0
					end
					if group1.Diplomacy[name] > group2.Diplomacy[name] then
						group1.Diplomacy[name] = group1.Diplomacy[name] + (TW.UnitsKillDiplomacyMinus * table.Count(group2.Members))
						for _, member in pairs(group2.Members) do 
							if IsValid(member.Player) then
								net.Start("TerritoryWars.ImprovedDiplomacy")
									net.WriteBool(true)
									net.WriteString(group1.Name)
								net.Send(member.Player)
							end
						end
						hook.Run("TerritoryWars.DiplomacyChanged", group1, TW.Groups[name])
					else
						group1.Diplomacy[name] = group1.Diplomacy[name] - (TW.UnitsKillDiplomacyMinus * table.Count(group2.Members))
						for _, member in pairs(group2.Members) do 
							if IsValid(member.Player) then
								net.Start("TerritoryWars.ImprovedDiplomacy")
									net.WriteBool(false)
									net.WriteString(group1.Name)
								net.Send(member.Player)
							end
						end
						hook.Run("TerritoryWars.DiplomacyChanged", group1, TW.Groups[name])
					end
				end
				hook.Run("TerritoryWars.DiplomacyChanged", group1, group2)
				TWUtil:SendGroupDiplomacyToEveryone(group1)
				TWUtil:SendGroupDiplomacyToEveryone(group2)
			end
		end)
	end
end)