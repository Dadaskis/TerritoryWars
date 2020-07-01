local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.AttackFlagCreated = {}

function TW.AttackFlagQuest(group, player)
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

	quest.Type = "CAPTURE_ENEMY_FLAG"
	if groupHaveEnemies then
		local keys = table.GetKeys(TW.FlagBonusMap)
		local count = #keys
		if count == 0 then
			return
		end
		local founded = false
		for index = 1, count do 
			local flagID = keys[index]
			if not enemiesList[TW.FlagBonusMap[flagID].Owner] 
					and not TW.AttackFlagCreated[player:SteamID() .. ":" .. flagID]
					and TW.FlagBonusMap[flagID].Name 
					and #TW.FlagBonusMap[flagID].Name > 0 
					and TW.FlagBonusMap[flagID].Owner ~= group.Name then
				quest.Available = groupHaveEnemies
				quest.Data = { flagID }
				founded = true
				break
			end
		end
		if not founded then
			return
		end
	else 
		return
	end

	if TW.AttackFlagCreated[group.Name .. " " .. player:SteamID() .. ":" .. quest.Data[1]] then
		return
	end
	TW.AttackFlagCreated[group.Name .. " " .. player:SteamID() .. ":" .. quest.Data[1]] = true
	local groupName = group.Name
	local created = false
	local steamID = player:SteamID()
	timer.Create("TerritoryWars.AttackFlagQuest" .. group.Name .. " " .. steamID .. ":" .. quest.Data[1], 60, 1, function() 
		if not created then
			quest.Available = false
			TW.AttackFlagCreated[groupName .. " " .. steamID .. ":" .. quest.Data[1]] = false
		end
	end)

	quest.PointsReward = TW.AttackFlagQuestPointsReward
	quest.HaveTime = true
	
	function quest:Activate(player) 
		quest.OverTime = os.time() + TW.QuestPositiveTimeLength(group, TW.AttackFlagQuestTimeLength)
		created = true
		self.Active = true
		local repeated = 1
		timer.Create("TerritoryWars." .. group.Name .. " " .. steamID .. ":" .. quest.Data[1] .. "CaptureFlagQuest", 
			TW.QuestPositiveTimeLength(group, TW.AttackFlagQuestTimeLength) / 1000, 1000, 
		function() 
			if IsValid(player) and player:TWGetGroup() then
				if TW.FlagBonusMap[self.Data[1]].Owner == player:TWGetGroup().Name then
					self:Complete(player)
					TW.AttackFlagCreated[group.Name .. " " .. steamID .. ":" .. quest.Data[1]] = false
					timer.Remove("TerritoryWars." .. group.Name .. " " .. steamID .. ":" .. quest.Data[1] .. "CaptureFlagQuest")
				end
				if repeated >= 1000 then
					TW.AttackFlagCreated[group.Name .. " " .. steamID .. ":" .. quest.Data[1]] = false
					self:Fail()
					return
				end
				repeated = repeated + 1
			else
				TW.AttackFlagCreated[group.Name .. " " .. steamID .. ":" .. quest.Data[1]] = false
				timer.Remove("TerritoryWars." .. group.Name .. " " .. steamID .. ":" .. quest.Data[1] .. "CaptureFlagQuest")
			end
		end)
	end

	return { quest }
end

TW.QuestTypes.AttackFlag = TW.AttackFlagQuest