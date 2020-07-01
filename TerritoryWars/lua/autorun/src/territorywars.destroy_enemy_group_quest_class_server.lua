local TW = TerritoryWars

TW.DestroyCreatedIn = {}

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.DestroyGroupQuest", function(group) 
	for name, _ in pairs(TW.DestroyCreatedIn[group.Name] or {}) do 
		if TW.DestroyCreatedIn[name] then 
			TW.DestroyCreatedIn[name][group.Name] = nil
		end
	end
	TW.DestroyCreatedIn[group.Name] = nil
end)

function TW.DestroyEnemyGroupQuest(group) 
	local groupName = group.Name
	local groupHaveEnemies = false
	local enemiesList = {}
	for name, group2 in pairs(TW.Groups) do 
		local points = 0 or group.Diplomacy[name]
		if points <= 5000 and groupName ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end

	if not TW.DestroyCreatedIn[groupName] then
		TW.DestroyCreatedIn[groupName] = {}
	end

	local quests = {}

	for name, _ in pairs(enemiesList) do 
		if TW.DestroyCreatedIn[groupName][name] then
			continue
		end
		TW.DestroyCreatedIn[groupName][name] = true
		local quest = TW.GroupQuest(group)[1]
		quest.Available = true
		quest.Type = "DESTROY_GROUP_QUEST"
		quest.Data = { name }
		quest.PointsReward = TW.DestroyGroupQuestPointsReward
		quest.LifeTimeReward = TW.DestroyGroupQuestLifeTimeReward

		hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.DestroyQuest " .. groupName .. " " .. name .. " Checker2", function(group2)
			if group2.Name == name then
				quest.Available = false
				hook.Remove("TerritoryWars.GroupDeleted", "TerritoryWars.DestroyQuest " .. groupName .. " " .. name .. " Checker2")
				TW.DestroyCreatedIn[groupName][name] = nil
			end
		end)

		function quest:Activate() 
			quest.Active = true
			hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.DestroyQuest " .. groupName .. " " .. name .. " Checker", function(group2)
				if group2.Name == name then
					self.PointsReward = TW.DestroyGroupQuestPointsReward * (group.QuestDone + 1)
					self.LifeTimeReward = TW.DestroyGroupQuestLifeTimeReward
					TW.DestroyCreatedIn[groupName][name] = nil
					self:Complete(group)
					hook.Remove("TerritoryWars.GroupDeleted", "TerritoryWars.DestroyQuest " .. groupName .. " " .. name .. " Checker")
				end
			end)
		end

		table.Add(quests, { quest })
	end

	return quests
end

TW.GroupQuestTypes.Destroy = TW.DestroyEnemyGroupQuest