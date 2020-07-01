local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.DefendFlagCreated = {}

function TW.DefendFlagQuest(group, player) 
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

	quest.Type = "DEFEND_FLAG"

	if groupHaveEnemies then
		if table.Count(TW.FlagBonusMap) == 0 then
			return
		end
		for flagID, data in pairs(TW.FlagBonusMap) do 
			if #(TW.FlagBonusMap[flagID].Name or "") == 0 then
				continue
			end
			if data.Owner == player:TWGetGroup().Name then
				if TW.DefendFlagCreated[player:SteamID() .. ":" .. flagID] then
					continue
				end
				quest.Data = { flagID }
				quest.Available = true
			end
		end
		if #quest.Data == 0 then
			return
		end
	else
		return
	end
 
	for index, quest2 in pairs(player:TWGetGroupMember().Quests) do
		if quest2.Type == "DEFEND_FLAG" then
			if quest2.Data[1] == quest.Data[1] then
				return	
			end
		end
	end

	if TW.DefendFlagCreated[player:SteamID() .. ":" .. quest.Data[1]] then
		return
	end
	TW.DefendFlagCreated[group.Name .. " " .. player:SteamID() .. ":" .. quest.Data[1]] = true	
	local groupName = group.Name
	local created = false
	local steamID = player:SteamID()
	timer.Create("TerritoryWars.DefendFlagQuest" .. group.Name .. " " .. steamID .. ":" .. quest.Data[1], 60, 1, function() 
		if not created then
			quest.Available = false
			TW.DefendFlagCreated[groupName .. " " .. steamID .. ":" .. quest.Data[1]] = false
		end
	end)

	quest.PointsReward = TW.DefendFlagQuestPointsReward
	quest.HaveTime = true
	function quest:Activate(player) 
		quest.OverTime = os.time() + TW.QuestNegativeTimeLength(group, TW.DefendFlagQuestTimeLength)
		self.Active = true
		created = true
		timer.Simple(TW.QuestNegativeTimeLength(group, TW.DefendFlagQuestTimeLength), function() 
			if player:TWGetGroup() 
					and TW.FlagBonusMap[self.Data[1]].Owner == player:TWGetGroup().Name then
				self:Complete(player)
				TW.DefendFlagCreated[group.Name .. " " .. player:SteamID() .. ":" .. quest.Data[1]] = false
			elseif not player:TWGetGroup() then
				TW.DefendFlagCreated[group.Name .. " " .. player:SteamID() .. ":" .. quest.Data[1]] = false
			end
		end)
	end

	return { quest }
end

TW.QuestTypes.DefendFlag = TW.DefendFlagQuest