local TW = TerritoryWars
local TWUtil = TW.Utilities

util.AddNetworkString("TerritoryWars.Capturing")
util.AddNetworkString("TerritoryWars.CaptureDone")
util.AddNetworkString("TerritoryWars.SendTerritories")
util.AddNetworkString("TerritoryWars.SetTerritory")

function TW:SendTerritories() 
	net.Start("TerritoryWars.SendTerritories")
		net.WriteTable(TW.Territories)
		net.WriteInt(TW.TerritoriesMinX, 32)
		net.WriteInt(TW.TerritoriesMaxX, 32)
		net.WriteInt(TW.TerritoriesMinZ, 32)
		net.WriteInt(TW.TerritoriesMaxZ, 32)
	net.Broadcast()
end

function TW:SendTerritory(X, Z) 
	net.Start("TerritoryWars.SetTerritory")
		net.WriteInt(X, 32)
		net.WriteInt(Z, 32)
		net.WriteTable(TW.Territories[X][Z])
	net.Broadcast()
end

function TW:Capture(ply) 
	if ply:TWGetGroup() then
		local pos = ply:GetPos()
		local X = math.Round((pos.x / self.TerritoryChunkSize) - 0.5)
		local Z = math.Round((pos.y / self.TerritoryChunkSize) - 0.5)

		if not self.Territories[X] then
			self.Territories[X] = {}
		end
		
		if not self.Territories[X][Z] then
			self.Territories[X][Z] = {}
		end

		if self.Territories[X][Z].Parent then
			local tempX, tempZ = self.Territories[X][Z].Parent[1], self.Territories[X][Z].Parent[2]
			X, Z = tempX, tempZ
		end

		for _, retainer in pairs(TW.TerritoryRetainers) do 
			if retainer.TWActivated then
				local retainerPos = retainer:GetPos()
				local retainerX = math.Round((retainerPos.x / self.TerritoryChunkSize) - 0.5)
				local retainerZ = math.Round((retainerPos.y / self.TerritoryChunkSize) - 0.5)
				if X == retainerX and Z == retainerZ then
					net.Start("TerritoryWars.TerritoryRetainer")
					net.Send(ply)
					return
				end

				if self.Territories[X][Z].Childrens then
					for X, tbl in pairs(self.Territories[X][Z].Childrens) do
						for Z, _ in pairs(tbl) do
							if X == retainerX and Z == retainerZ then
								net.Start("TerritoryWars.TerritoryRetainer")
								net.Send(ply)
								return
							end
						end
					end
				end
			end
		end

		if not timer.Exists("TerritoryWars.".. "[" .. X .. "," .. Z .. "]" .. "Capture") 
				and self.Territories[X][Z].GroupName ~= ply:TWGetGroup().Name then
			local enemyName = self.Territories[X][Z].GroupName
			self.Territories[X][Z].GroupName = nil
			self.Territories[X][Z].Color = nil
			self.Territories[X][Z].Capture = true

			if self.Territories[X][Z].Childrens then
				for X, tbl in pairs(self.Territories[X][Z].Childrens) do
					for Z, _ in pairs(tbl) do
						self.Territories[X][Z].GroupName = nil
						self.Territories[X][Z].Color = nil
						self.Territories[X][Z].Capture = true
					end
				end
			end

			if self.TerritoryBonusMap[X .. " " .. Z] then
				if self.Groups[enemyName] then
					for index, bonus in pairs(self.TerritoryBonusMap[X .. " " .. Z]) do
						bonus:OnUncaptured(self.Groups[enemyName], X, Z, index, -1)
					end
				end
			end

			self:SendTerritory(X, Z)
			
			for _, member in pairs(ply:TWGetGroup().Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.Capturing")
						net.WriteInt(X, 32)
						net.WriteInt(Z, 32)
					net.Send(member.Player)
				end
			end

			timer.Create("TerritoryWars.".. "[" .. X .. "," .. Z .. "]" .. "Capture", self.TerritoryCaptureTime, 1, function()
				self.Territories[X][Z].Capture = nil
				if self.Territories[X][Z].Childrens then
					for X, tbl in pairs(self.Territories[X][Z].Childrens) do
						for Z, _ in pairs(tbl) do
							self.Territories[X][Z].Capture = nil
						end
					end
				end 
				for _, member in pairs(ply:TWGetGroup().Members) do 
					if IsValid(member.Player) then
						net.Start("TerritoryWars.CaptureDone")
							net.WriteInt(X, 32)
							net.WriteInt(Z, 32)
						net.Send(member.Player)
					end
				end
				local counter = {}
				local attackers = {}

				for name, _ in pairs(TW.Groups) do 
					counter[name] = 0
				end

				for _, ply in pairs(player.GetAll()) do 
					local pos = ply:GetPos()
					local X2 = math.Round((pos.x / self.TerritoryChunkSize) - 0.5)
					local Z2 = math.Round((pos.y / self.TerritoryChunkSize) - 0.5)

					if X == X2 and Z == Z2 then
						if ply:TWGetGroup() then
							counter[ply:TWGetGroup().Name] = counter[ply:TWGetGroup().Name] + 1
							attackers[ply:TWGetGroup().Name] = 
								table.Add(attackers[ply:TWGetGroup().Name] or nil, { ply:TWGetGroupMember() })
						end
					end
					if self.Territories[X][Z].Childrens then
						for X, tbl in pairs(self.Territories[X][Z].Childrens) do
							for Z, _ in pairs(tbl) do
								if X == X2 and Z == Z2 then
									if ply:TWGetGroup() then
										counter[ply:TWGetGroup().Name] = counter[ply:TWGetGroup().Name] + 1
										attackers[ply:TWGetGroup().Name] = 
											table.Add(attackers[ply:TWGetGroup().Name] or nil, { ply:TWGetGroupMember() })
									end
								end
							end
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
					self:SendTerritory(X, Z)
					return
				end

				for _, group in pairs(self.Groups) do 
					if group.Territories[X] then
						group.Territories[X][Z] = nil
					end
				end


				local group1 = self.Groups[maxKey]
				local group2 = self.Groups[enemyName]
				if self.TerritoryBonusMap[X .. " " .. Z] then
					for index, bonus in pairs(self.TerritoryBonusMap[X .. " " .. Z]) do
						bonus:OnCaptured(group1, X, Z, index, -1)
					end
				end
				group1.TerritoriesCount = group1.TerritoriesCount + 1
				self.Territories[X][Z].GroupName = group1.Name
				self.Territories[X][Z].Color = group1.Color
				self.Territories[X][Z].Capture = nil

				if self.Territories[X][Z].Childrens then
					for X, tbl in pairs(self.Territories[X][Z].Childrens) do
						for Z, _ in pairs(tbl) do
							self.Territories[X][Z].GroupName = group1.Name
							self.Territories[X][Z].Color = group1.Color
							self.Territories[X][Z].Capture = nil
						end
					end
				end
				if not group1.Territories[X] then
					group1.Territories[X] = {}
				end
				group1.Territories[X][Z] = true
				for _, ply in pairs(attackers[maxKey]) do 
					ply.TerritoriesCaptured = ply.TerritoriesCaptured + 1
				end

				if X > self.TerritoriesMaxX then
					self.TerritoriesMaxX = X
				elseif X < self.TerritoriesMinX then
					self.TerritoriesMinX = X
				end

				if Z > self.TerritoriesMaxZ then
					self.TerritoriesMaxZ = Z
				elseif Z < self.TerritoriesMinZ then
					self.TerritoriesMinZ = Z
				end

				if group2 then
					group2.TerritoriesCount = group2.TerritoriesCount - 1
					local groupsList = table.GetKeys(self.Groups)
					groupsList[group2.Name] = nil
					groupsList[group1.Name] = nil

					for name, _ in pairs(groupsList) do 
						if not TW.Groups[name] then
							continue
						end
						if not group1.Diplomacy[name] then
							group1.Diplomacy[name] = 0
						end
						if not group2.Diplomacy[name] then
							group2.Diplomacy[name] = 0
						end
						if group1.Diplomacy[name] > group2.Diplomacy[name] then
							group1.Diplomacy[name] = group1.Diplomacy[name] + (self.UnitsKillDiplomacyMinus * table.Count(group2.Members))
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
							group1.Diplomacy[name] = group1.Diplomacy[name] - (self.UnitsKillDiplomacyMinus * table.Count(group2.Members))
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
					TWUtil:SendGroupDiplomacyToEveryone(group1)
					TWUtil:SendGroupDiplomacyToEveryone(group2)
					hook.Run("TerritoryWars.DiplomacyChanged", group1, group2)
				end

				self:SendTerritory(X, Z)

				for SteamID, member in pairs(group1.Members) do 
					group1:GenerateQuests(member.Player)
				end
				group1:GenerateGroupQuests()
			end)
		end
	else
		net.Start("TerritoryWars.YouAreNotInGroup")
		net.Send(player)
	end
end
