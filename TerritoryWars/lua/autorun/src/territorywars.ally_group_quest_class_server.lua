local TW = TerritoryWars

TW.AllyCreatedIn = {}

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.AllyGroupQuest", function(group) 
	for name, _ in pairs(TW.AllyCreatedIn[group.Name] or {}) do 
		if TW.AllyCreatedIn[name] then
			TW.AllyCreatedIn[name][group.Name] = nil
		end
	end
	TW.AllyCreatedIn[group.Name] = nil
end)

function TW.AllyGroupQuest(group) 
	local groupHaveEnemies = false
	local enemiesList = {}
	for name, group2 in pairs(TW.Groups) do 
		local points = 0 or group.Diplomacy[name]
		if points <= 5000 and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end

	if not TW.AllyCreatedIn[group.Name] then
		TW.AllyCreatedIn[group.Name] = {}
	end

	local quests = {}

	for name, _ in pairs(enemiesList) do 
		if TW.AllyCreatedIn[group.Name][name] then
			continue
		end
		TW.AllyCreatedIn[group.Name][name] = true

		local quest = TW.GroupQuest(group)[1]
		quest.Available = true
		quest.Type = "ALLY_DIPLOMACY_QUEST"
		quest.Data = { name }
		quest.PointsReward = TW.AllyGroupQuestPointsReward
		quest.LifeTimeReward = TW.AllyGroupQuestLifeTimeReward

		hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.AllyQuest " .. group.Name .. " " .. name .. " Checker2", function(group2)
			if group2.Name == name then
				quest.Available = false
				hook.Remove("TerritoryWars.GroupDeleted", "TerritoryWars.AllyQuest " .. group.Name .. " " .. name .. " Checker2")
			end
		end)

		function quest:Activate() 
			self.Active = true
			if (group.Diplomacy[self.Data[1]] or 0) >= 5000 then
				self.PointsReward = (self.PointsReward * (group.QuestDone + 1))
				self.LifeTimeReward = TW.AllyGroupQuestLifeTimeReward * 2
				self:Complete()
				hook.Remove("TerritoryWars.GroupDeleted", "TerritoryWars.AllyQuest " .. group.Name .. " " .. name)
			else
				hook.Add("TerritoryWars.DiplomacyChanged", "TerritoryWars.Ally" .. group.Name .. " " .. name, function(group1, group2) 
					if (group1.Name == group.Name and group2.Name == name)
						or (group2.Name == group.Name and group1.Name == name) then
						if (group.Diplomacy[name] or 0) >= 5000 then
							self.PointsReward = (TW.AllyGroupQuestPointsReward * (group.QuestDone + 1))
							self.LifeTimeReward = TW.AllyGroupQuestLifeTimeReward
							self:Complete()
							hook.Remove("TerritoryWars.GroupDeleted", "TerritoryWars.AllyQuest " .. group.Name .. " " .. name)
							hook.Remove("TerritoryWars.DiplomacyChanged", "TerritoryWars.Ally" .. group.Name .. " " .. name)
						end
					end
				end)
			end
		end

		table.Add(quests, { quest })
	end

	return quests
end

TW.GroupQuestTypes.Ally = TW.AllyGroupQuest