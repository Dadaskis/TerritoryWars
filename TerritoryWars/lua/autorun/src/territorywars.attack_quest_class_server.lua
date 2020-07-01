local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.AttackCreated = {}

function TW.AttackQuest(group, player)
	local quest = TW.Quest(group)[1]
	local groupHaveEnemies = false
	local enemiesList = {}

	for name, _ in pairs(TW.Groups) do 
		local points = group.Diplomacy[name]
		if (points == nil or points <= 5000) and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end

	quest.Type = "CAPTURE_ENEMY_TERRITORY"
	if groupHaveEnemies then
		local _, name = table.Random(enemiesList)
		if table.Count(TW.Groups[name].Territories) > 0 then
			local territoryCount = table.Count(TW.Groups[name].Territories)
			local X
			local Z
			local _
			local rightTerritory = false
			for counter = 1, territoryCount do
				_, X = table.Random(TW.Groups[name].Territories)
				if table.Count(TW.Groups[name].Territories[X]) > 0 then
					_, Z = table.Random(TW.Groups[name].Territories[X])
					if not TW.AttackCreated[player:SteamID() .. " " .. X .. " " .. Z] then
						rightTerritory = true
						break
					end
				end
			end
			if not rightTerritory then
				return
			end
			quest.Available = true
			quest.Data = { X, Z }
		else 
			return
		end
	else 
		return
	end

	if TW.AttackCreated[group.Name .. " " .. player:SteamID() .. " " .. quest.Data[1] .. " " .. quest.Data[2]] then
		return
	end
	TW.AttackCreated[group.Name .. " " .. player:SteamID() .. " " .. quest.Data[1] .. " " .. quest.Data[2]] = true

	quest.PointsReward = TW.AttackQuestPointsReward
	local created = false
	local groupName = group.Name
	local steamID = player:SteamID()
	timer.Create("TerritoryWars.AttackQuest" .. group.Name .. " " .. steamID .. ":" .. quest.Data[1], 60, 1, function() 
		if not created then
			quest.Available = false
			TW.AttackCreated[groupName .. " " .. steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2]] = false
		end
	end)

	quest.HaveTime = true

	function quest:Activate(player) 
		quest.OverTime = os.time() + TW.QuestPositiveTimeLength(group, TW.AttackQuestTimeLength)
		created = true
		self.Active = true
		local repeated = 1
		timer.Create("TerritoryWars." .. group.Name .. " " .. steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2] .. "CaptureQuest", 
			TW.QuestPositiveTimeLength(group, TW.AttackQuestTimeLength) / 1000, 1000, 
		function() 
			if IsValid(player) and player:TWGetGroup() then
				if player:TWGetGroup().Territories[self.Data[1]] then
					if player:TWGetGroup().Territories[self.Data[1]][self.Data[2]] then
						self:Complete(player)
						TW.AttackCreated[steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2]] = false
						timer.Remove("TerritoryWars." .. group.Name .. " " .. steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2] .. "CaptureQuest")
					end
				end
				if repeated >= 1000 then
					self:Fail()
					TW.AttackCreated[group.Name .. " " .. steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2]] = false
					return
				end
				repeated = repeated + 1
			else
				TW.AttackCreated[group.Name .. " " .. steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2]] = false
				timer.Remove("TerritoryWars." .. group.Name .. " " .. steamID .. " " .. quest.Data[1] .. " " .. quest.Data[2] .. "CaptureQuest")
			end
		end)
	end

	return { quest }
end

if TW.TerritoryCapturing then
	TW.QuestTypes.Attack = TW.AttackQuest
end