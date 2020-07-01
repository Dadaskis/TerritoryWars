local TW = TerritoryWars
local TWUtil = TW.Utilities

function TW:Save() 
	local f = file.Open("TerritoryWarsSave.Shop.txt", "w", "DATA")
	f:Write(util.TableToJSON(self.ShopList, true))
	f:Close()
	local f = file.Open("TerritoryWarsSave.Territories" .. game.GetMap() .. ".txt", "w", "DATA")
	f:Write(util.TableToJSON(self.Territories, true))
	f:Close()
	local f = file.Open("TerritoryWarsSave.TerritoryBonusMap" .. game.GetMap() .. ".txt", "w", "DATA")
	f:Write(util.TableToJSON(self.TerritoryBonusMap, true))
	f:Close()
	local f = file.Open("TerritoryWarsSave.FlagBonusMap" .. game.GetMap() .. ".txt", "w", "DATA")
	f:Write(util.TableToJSON(self.FlagBonusMap, true))
	f:Close()
	local f = file.Open("TerritoryWarsSave.PlayerData" .. game.GetMap() .. ".txt", "w", "DATA")
	f:Write(util.TableToJSON(self.PlayerData, true))
	f:Close()
	local f = file.Open("TerritoryWarsSave.Groups" .. game.GetMap() .. ".txt", "w", "DATA")
	f:Write(util.TableToJSON(self.Groups, true))
	f:Close()
end

function TW:Load()
	if file.Exists("TerritoryWarsSave.Shop.txt", "DATA") then
		local f = file.Open("TerritoryWarsSave.Shop.txt", "r", "DATA")
		self.ShopList = util.JSONToTable(f:Read(f:Size()) or "[]") or {}
		self.ShopList.Counter = self.ShopList.Counter or 0
		f:Close()
	end

	if file.Exists("TerritoryWarsSave.Territories" .. game.GetMap() .. ".txt", "DATA") then
		local f = file.Open("TerritoryWarsSave.Territories" .. game.GetMap() .. ".txt", "r", "DATA")
		self.Territories = util.JSONToTable(f:Read(f:Size()) or "[]") or {}
		f:Close()
	end

	if file.Exists("TerritoryWarsSave.TerritoryBonusMap" .. game.GetMap() .. ".txt", "DATA") then
		local f = file.Open("TerritoryWarsSave.TerritoryBonusMap" .. game.GetMap() .. ".txt", "r", "DATA")
		self.TerritoryBonusMap = util.JSONToTable(f:Read(f:Size()) or "[]") or {}
		for coord, bonuses in pairs(self.TerritoryBonusMap) do 
			for index, bonus in pairs(bonuses) do 
				local newBonus = self.TerritoryBonuses[bonus.Name]()
				for key, value in pairs(bonus) do 
					newBonus[key] = value
				end
				bonuses[index] = newBonus
			end
		end
		f:Close()
	end

	if file.Exists("TerritoryWarsSave.FlagBonusMap" .. game.GetMap() .. ".txt", "DATA") then
		local f = file.Open("TerritoryWarsSave.FlagBonusMap" .. game.GetMap() .. ".txt", "r", "DATA")
		self.FlagBonusMap = util.JSONToTable(f:Read(f:Size()) or "[]") or {}
		f:Close()
		for ID, data in pairs(self.FlagBonusMap) do 
			if data.Bonuses then
				for index, bonus in pairs(data.Bonuses) do 
					local newBonus = self.TerritoryBonuses[bonus.Name]()
					for key, value in pairs(bonus) do 
						newBonus[key] = value
					end
					data.Bonuses[index] = newBonus
				end
			end
		end
	end

	if file.Exists("TerritoryWarsSave.PlayerData" .. game.GetMap() .. ".txt", "DATA") then
		local f = file.Open("TerritoryWarsSave.PlayerData" .. game.GetMap() .. ".txt", "r", "DATA")
		self.PlayerData = util.JSONToTable(f:Read(f:Size()) or "[]") or {}
		f:Close()
		for _, data in pairs(self.PlayerData) do 
			data.InMainGroupWindow = false
			data.InShopWindow = false
			data.InFlagWindow = false
			data.InGroupRegisterWindow = false
		end
	end

	if file.Exists("TerritoryWarsSave.Groups" .. game.GetMap() .. ".txt", "DATA") then
		local f = file.Open("TerritoryWarsSave.Groups" .. game.GetMap() .. ".txt", "r", "DATA")
		local txt = f:Read(f:Size()) or "[]"
		self.Groups = util.JSONToTable(txt) or {}
		f:Close()
	end

	hook.Add("InitPostEntity", "TerritoryWars.Load", function() 
		for ID, data in SortedPairs(self.FlagBonusMap) do 
			local entity = ents.Create("territorywars.flag")
			entity:Spawn()
			self.FlagBonusMap[entity:GetCreationID()] = nil
			entity.CreationID = ID
			self.FlagBonusMap[ID].EntIndex = entity:EntIndex()
			entity:SetPos(data.Position or Vector(0, 0, 0))
			entity:SetAngles(data.Angles or Angle(0, 0, 0))
			entity:GetPhysicsObject():EnableMotion(false)
		end

		for key, group in pairs(self.Groups or {}) do 
			group.Quests = {}
			if isnumber(key) then
				self.Groups[key] = nil
				key = tostring(key)
				self.Groups[key] = group
			end
			local newGroup = self.Group(nil, group.Color, group.Name)
			for key, value in pairs(group) do 
				newGroup[key] = value
			end
			self.Groups[key] = newGroup
			group = newGroup
			for _, member in pairs(group.Members) do 
				member.Quests = {}
			end
			group.UpgradeCoolDownEnd = {}
			group.GroupUpgradeCoolDownEnd = 0
			group.ShopList = {}
			group.Quests = {}
			for ID, data in pairs(self.FlagBonusMap) do 
				if data.Bonuses and data.Owner == group.Name then
					for index, bonus in pairs(data.Bonuses) do
						bonus:OnCaptured(group, 0, 0, index, ID)
					end
				end
			end
			if TW.TerritoryCapturing then
				for X, tbl in pairs(group.Territories or {}) do 
					for Z, _ in pairs(tbl) do 
						if self.TerritoryBonusMap[X .. " " .. Z] then
							for index, bonus in pairs(self.TerritoryBonusMap[X .. " " .. Z]) do
								bonus:OnCaptured(group, X, Z, index, -1)
							end
						end
					end
				end
			end
		end

		for key, group in pairs(self.Groups or {}) do 
			group.ComputerCreated = false
			group.AllComputersCreated = false
		end

		for X, tbl in pairs(self.Territories or {}) do 
			for Z, territory in pairs(tbl) do 
				if not self.Groups[territory.GroupName] then
					territory.GroupName = nil
					territory.Color = nil
				end
			end
		end

		for flagID, data in pairs(self.FlagBonusMap) do 
			if not TW.Groups[data.Owner] then
				data.Owner = nil
			end
		end
	end)
end

timer.Create("TerritoryWars.AutoSave", TW.AutoSaveDelay, 0, function() 
	TW:Save()
end)