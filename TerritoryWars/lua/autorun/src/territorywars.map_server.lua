util.AddNetworkString("TerritoryWars.TerritoryBonus")
util.AddNetworkString("TerritoryWars.SetTerritories")
util.AddNetworkString("TerritoryWars.ConnectTerritories")
util.AddNetworkString("TerritoryWars.DisconnectTerritories")
util.AddNetworkString("TerritoryWars.TerritoryIncomeStatus")

local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.TerritoryBonusMap = TW.TerritoryBonusMap or {}
TW.TerritoryIncomeStatus = {}

hook.Add("PlayerInitialSpawn", "TerritoryWars.SendBonuses", function(player) 
	net.Start("TerritoryWars.TerritoryBonus")
		net.WriteTable(TWUtil:GetTableData(TW.TerritoryBonusMap))
	net.Send(player)
end)

hook.Add("PlayerInitialSpawn", "TerritoryWars.SendMap", function(player) 
	net.Start("TerritoryWars.SendTerritories")
		net.WriteTable(TW.Territories)
		net.WriteInt(TW.TerritoriesMinX, 32)
		net.WriteInt(TW.TerritoriesMaxX, 32)
		net.WriteInt(TW.TerritoriesMinZ, 32)
		net.WriteInt(TW.TerritoriesMaxZ, 32)
	net.Send(player)
end)

if TW.Changeable then
	net.Receive("TerritoryWars.SetTerritories", function(byteLength, player) 
		local X = net.ReadInt(32)
		local Z = net.ReadInt(32)
		local data = net.ReadTable()
		if TW.Territories[X] and TW.Territories[X][Z] then
			TW.Territories[X][Z].AdditionalData = data.AdditionalData
		end
		if player:IsSuperAdmin() then
			data.GroupName = nil
			if TW.Territories[X] and TW.Territories[X][Z] then
				data.GroupName = TW.Territories[X][Z].Owner
			end
			TW.Territories[X][Z] = data
			net.Start("TerritoryWars.SetTerritories")
				net.WriteInt(X, 32)
				net.WriteInt(Z, 32)
				net.WriteTable(TW.Territories[X][Z])
			net.Broadcast()
			TW:Save()
		end
	end)

	net.Receive("TerritoryWars.ConnectTerritories", function(byteLength, player) 
		local territory1Coord = net.ReadTable()
		local territory2Coord = net.ReadTable()

		if player:IsSuperAdmin() then
			local X1, Z1 = territory1Coord[1], territory1Coord[2]
			local X2, Z2 = territory2Coord[1], territory2Coord[2]

			if not TW.Territories[X1] then
				TW.Territories[X1] = {}
			end

			if not TW.Territories[X2] then
				TW.Territories[X2] = {}
			end

			territory1 = TW.Territories[X1][Z1]
			territory2 = TW.Territories[X2][Z2]

			if not territory1 then
				TW.Territories[X1][Z1] = {}
				territory1 = TW.Territories[X1][Z1]
			end
			if not territory2 then
				TW.Territories[X2][Z2] = {}
				territory2 = TW.Territories[X2][Z2]
			end
			if not territory1.Parent and not territory2.Parent then
				territory2.Parent = territory1Coord
				territory1.Parent = territory1Coord
				TW.TerritoryBonusMap[territory2Coord[1] .. " " .. territory2Coord[2]] = nil
				territory1.Childrens = {}
				territory1.Childrens[X2] = {}
				territory1.Childrens[X2][Z2] = true
				TW:SendTerritories()
				TW:Save()
			elseif not territory1.Parent or not territory2.Parent then
				if territory2.Parent then
					territory1, territory2 = territory2, territory1
					territory1Coord, territory2Coord = territory2Coord, territory1Coord
				end
				territory2.Parent = territory1.Parent
				TW.TerritoryBonusMap[territory2Coord[1] .. " " .. territory2Coord[2]] = nil
				local territory1 = TW.Territories[territory1.Parent[1]][territory1.Parent[2]]
				if not territory1.Childrens[X2] then
					territory1.Childrens[X2] = {}
				end
				territory1.Childrens[X2][Z2] = true	
				TW:SendTerritories()
				TW:Save()
			elseif territory1.Parent and territory2.Parent then
				if territory1.Parent[1] ~= territory2.Parent[1] 
						and territory1.Parent[2] ~= territory2.Parent[2] then
					local parentX, parentZ = territory1.Parent[1], territory1.Parent[2]
					territory1 = TW.Territories[parentX][parentZ]
					territory2 = TW.Territories[territory2.Parent[1]][territory2.Parent[2]]
					TW.TerritoryBonusMap[territory2Coord[1] .. " " .. territory2Coord[2]] = nil
					if territory2.Childrens then
						for X, tbl in pairs(territory2.Childrens) do 
							if not territory1.Childrens[X] then
								territory1.Childrens[X] = {}
							end
							for Z, value in pairs(tbl) do 
								territory1.Childrens[X][Z] = value
								TW.Territories[X][Z].Parent = { parentX, parentZ }
							end
						end
					end
					territory2.Childrens = nil
					territory2.Parent = { parentX, parentZ }
					TW:SendTerritories()
					TW:Save()
				else
					local parent = TW.Territories[territory1.Parent[1]][territory1.Parent[2]]
					if table.Count(parent.Childrens) == 0 then
						parent.Parent = nil
						parent.Childrens = nil
						TW.TerritoryBonusMap[territory1.Parent[1] .. " " .. territory1.Parent[2]] = nil
					end
				end
			end
		end
	end)

	net.Receive("TerritoryWars.DisconnectTerritories", function(byteLength, player) 
		local territoryCoord = net.ReadTable()
		if player:IsSuperAdmin() then
			local X1, Z1 = territoryCoord[1], territoryCoord[2]
			local territory = TW.Territories[X1][Z1]
			if not TW.Territories[X1] then
				return
			end
			if not territory then
				return
			end
			territory.Color = nil
			territory.GroupName = nil
			TW.TerritoryBonusMap[X1 .. " " .. Z1] = nil
			TW.Territories[X1][Z1] = nil
			if territory.Childrens then
				if table.Count(territory.Childrens) > 0 then
					local keys = table.GetKeys(territory.Childrens)
					local X
					for _, key in pairs(keys) do
						X = key
						if X and table.Count(territory.Childrens[X]) > 0 then
							break
						end
					end
					if X then
						keys = table.GetKeys(territory.Childrens[X])
						local Z 
						for _, key in pairs(keys) do
							Z = key
							if Z and territory.Childrens[X][Z] then
								break
							end
						end
						if Z then
							territory.Childrens[X][Z] = nil
							if table.Count(territory.Childrens[X]) == 0 then
								territory.Childrens[X] = nil
							end
							if territory.Childrens[X1] then
								territory.Childrens[X1][Z1] = nil
								if table.Count(territory.Childrens[X1]) == 0 then
									territory.Childrens[X1] = nil
								end
							end
							local childrens = territory.Childrens
							territory.Parent = nil
							territory.Childrens = nil
							local color = territory.Color
							local groupName = territory.GroupName
							territory = TW.Territories[X][Z]
							territory.Color = nil
							territory.GroupName = nil
							territory.Parent = { X, Z }
							territory.Childrens = childrens
							for X, tbl in pairs(territory.Childrens) do 
								for Z, _ in pairs(tbl) do 
									TW.Territories[X][Z].Parent = territory.Parent
								end
							end
							
							TW:SendTerritories()
							TW:Save()
							return
						end
					end
				else
					territory.Childrens = nil
					territory.Parent = nil
					TW:SendTerritories()
					TW:Save()
				end
			else
				local parent = territory.Parent
				if parent then
					parent = TW.Territories[parent[1]][parent[2]]
					if parent then
						if parent.Childrens then
							if parent.Childrens[X1] then
								parent.Childrens[X1][Z1] = nil
							end
							if parent.Childrens[X1] then
								if table.Count(parent.Childrens[X1]) == 0 then
									parent.Childrens[X1] = nil
								end
							end
							if table.Count(parent.Childrens) == 0 then
								parent.Childrens = nil
								parent.Parent = nil
							end
						end
					end
					territory.Parent = nil
					territory.Color = nil
					territory.GroupName = nil
					TW:SendTerritories()
					TW:Save()
				end
			end
		end
	end)

	net.Receive("TerritoryWars.TerritoryBonus", function(byteLength, player) 
		local key = net.ReadString()
		local bonuses = net.ReadTable()

		if player:IsSuperAdmin() then
			for key, bonus in pairs(bonuses) do 
				if not bonus.Deleted then
					bonuses[key] = TW.TerritoryBonuses[bonus.Name]()
					bonuses[key].Properties = bonus.Properties
				else
					bonuses[key] = nil
				end
			end

			TW.TerritoryBonusMap[key] = bonuses

			net.Start("TerritoryWars.TerritoryBonus")
				net.WriteTable(TWUtil:GetTableData(TW.TerritoryBonusMap))
			net.Broadcast()
			
			TW:Save()
		end
	end)
end