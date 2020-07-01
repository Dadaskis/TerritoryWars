local TW = TerritoryWars

TW.MovingOnFlagQuestCreated = {}

function TW.MovingOnFlagQuest(group, player)
    local groupHaveEnemies = false
	local enemiesList = {}
	for name, group2 in pairs(TW.Groups) do 
		local points = 0 or group.Diplomacy[name]
		if points <= 5000 and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end
	if groupHaveEnemies then 
	    local quests = {}
	    for counter = 1, table.Count(enemiesList) do
	        local quest = TW.Quest(group)[1]
	        quest.PointsReward = TW.MovingOnFlagQuestPointsReward
	        quest.Type = "MOVING_ON_FLAG_QUEST"
	        quest.Available = true
            local name = select(2, table.Random(enemiesList))
            for counter = 1, table.Count(TW.FlagBonusMap) do 
            	local data, flagID = table.Random(TW.FlagBonusMap)
            	if data.Owner == name then
            		quest.Data = { flagID }
            		break
            	end
            end
            if not quest.Data or not quest.Data[1] then
            	continue
            end
            if not TW.MovingOnFlagQuestCreated[group.Name .. player:SteamID() .. ":" .. quest.Data[1]] then
            	TW.MovingOnFlagQuestCreated[group.Name .. player:SteamID() .. ":" .. quest.Data[1]] = true
            	local created = false
				local groupName = group.Name
				local steamID = player:SteamID()
				timer.Create("TerritoryWars.MovingFlagQuest" .. groupName .. steamID .. ":" .. quest.Data[1], 60, 1, function() 
					if not created then
						quest.Available = false
						TW.MovingOnFlagQuestCreated[groupName .. steamID .. ":" .. quest.Data[1]] = false
					end
				end)
            	function quest:Activate() 
            		self.Active = true
            		created = true
            		local flag = Entity(TW.FlagBonusMap[self.Data[1]].EntIndex)
	            	local counter = 0
	            	timer.Create("TerritoryWars." .. steamID .. "MovingQuest" .. self.Data[1], 1, 0, function() 
	            		local pos = Vector(-999999, -999999, -999999)
	            		if IsValid(player) then
	            			pos = player:GetPos()
	            		end
						local distance = pos:Distance(flag:GetPos())
						if distance < TW.FlagCaptureDistance then
							counter = counter + 1
						else
							counter = 0
						end
						if counter >= TW.QuestNegativeTimeLength(group, TW.MovingOnFlagQuestTimeLength) then
							TW.MovingOnFlagQuestCreated[groupName .. steamID .. ":" .. quest.Data[1]] = false
							self:Complete(player)
							timer.Remove("TerritoryWars." .. steamID .. "MovingQuest" .. self.Data[1])
						end
	            	end)
	            end
	            table.Add(quests, { quest })
	        end
        end
        return quests
    end
end

TW.QuestTypes.MovingOnFlag = TW.MovingOnFlagQuest