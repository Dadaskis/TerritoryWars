local TW = TerritoryWars

TW.MovingQuestCreated = {}

function TW.MovingQuest(group, player)
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
	        quest.PointsReward = TW.MovingQuestPointsReward
	        quest.Type = "MOVING_QUEST"
	        quest.Available = true
            local name = select(2, table.Random(enemiesList))
            local enemyGroup = TW.Groups[name]
            local enemyTerritories = enemyGroup.Territories
            if not enemyTerritories then
            	continue
            end
            local territoriesX, X = table.Random(enemyTerritories)
            if not territoriesX then
            	continue
            end
            local _, Z = table.Random(territoriesX)
            local territory = TW.Territories[X][Z]
            if X and Z and territory then
            	if territory.Parent then
            		X, Z = territory.Parent[1], territory.Parent[2]
            	end
            end
            if not X or not Z then 
            	continue
            end
            if not TW.MovingQuestCreated[group.Name .. player:SteamID() .. ":" .. X .. ":" .. Z] then
            	quest.Data = { X, Z }
            	TW.MovingQuestCreated[group.Name .. player:SteamID() .. ":" .. X .. ":" .. Z] = true
            	local created = false
				local groupName = group.Name
				local steamID = player:SteamID()
				timer.Create("TerritoryWars.MovingQuest" .. group.Name .. steamID .. ":" .. X .. ":" .. Z, 60, 1, function() 
					if not created then
						quest.Available = false
						TW.MovingQuestCreated[groupName .. steamID .. ":" .. X .. ":" .. Z] = false
					end
				end)
            	function quest:Activate() 
            		quest.Active = true
            		created = true
	            	local counter = 0
	            	timer.Create("TerritoryWars." .. group.Name .. steamID .. "MovingQuest" .. X .. ":" .. Z, 1, 0, function() 
	            		local pos = Vector(-999999, -999999, -999999)
	            		if IsValid(player) then
	            			pos = player:GetPos()
	            		end
						local X2 = math.Round((pos.x / TW.TerritoryChunkSize) - 0.5)
						local Z2 = math.Round((pos.y / TW.TerritoryChunkSize) - 0.5)
						local territory = (TW.Territories[X2] or {})[Z2]
						if territory and territory.Parent then
							X2, Z2 = territory.Parent[1], territory.Parent[2]
						end
						if X == X2 and Z == Z2 then
							counter = counter + 1
						else
							counter = 0
						end
						if counter >= TW.QuestNegativeTimeLength(group, TW.MovingQuestTimeLength) then
							TW.MovingQuestCreated[group.Name .. steamID .. ":" .. X .. ":" .. Z] = false
							self:Complete(player)
							timer.Remove("TerritoryWars." .. group.Name .. steamID .. "MovingQuest" .. X .. ":" .. Z)
						end
	            	end)
	            end
	            table.Add(quests, { quest })
	        end
        end
        return quests
    end
end

TW.QuestTypes.Moving = TW.MovingQuest