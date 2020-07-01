local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.QuestDoneCreatedIn = {}

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.QuestDone", function(group)
	TW.QuestDoneCreatedIn[group.Name] = nil
end)

function TW.QuestDoneGroupQuest(group) 
	local quest = TW.GroupQuest(group)[1]

	local groupHaveEnemies = false
	local enemiesList = {}
	for name, _ in pairs(TW.Groups) do 
		local points = group.Diplomacy[name]
		if (points == nil or points <= 5000) and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end

	if not groupHaveEnemies then
		return
	end

	if TW.QuestDoneCreatedIn[group.Name] then
		return
	end
	TW.QuestDoneCreatedIn[group.Name] = true
	
	quest.Available = true
	quest.Data = { group.QuestDone + math.random(5, 10) }
	quest.Type = "QUEST_DONE"
	quest.PointsReward = TW.QuestDoneGroupQuestPointsReward * quest.Data[1]
	quest.LifeTimeReward = TW.QuestDoneGroupQuestLifeTimeReward
	quest.HaveTime = true

	function quest:Activate(player) 
		quest.OverTime = os.time() + TW.GroupQuestPositiveTimeLength(group, TW.QuestDoneGroupQuestTimeLength * (self.Data[1] - (self.Data[1] * 0.2)))
		hook.Add("TerritoryWars.DeleteGroupBecauseOfGroupQuests", "TerritoryWars." .. group.Name .. "QuestDoneDontDeleteGroup", function() 
			return false
		end)
		self.Active = true
		local completed = group.QuestDone
		local repeated = 1
		timer.Create("TerritoryWars." .. group.Name .. "QuestDone", 
			(TW.GroupQuestPositiveTimeLength(group, TW.QuestDoneGroupQuestTimeLength * (self.Data[1] - (self.Data[1] * 0.2)))) / 1000, 1000, 
		function() 
			if group.QuestDone - completed >= self.Data[1] then
				self.PointsReward = TW.QuestDoneGroupQuestPointsReward * group.QuestDone
				self.LifeTimeReward = TW.QuestDoneGroupQuestLifeTimeReward
				self:Complete(group)
				TW.QuestDoneCreatedIn[group.Name] = false
				timer.Remove("TerritoryWars." .. group.Name .. "QuestDone")
				hook.Remove("TerritoryWars.DeleteGroupBecauseOfGroupQuests", "TerritoryWars." .. group.Name .. "QuestDoneDontDeleteGroup")
				return
			end
			if repeated == 1000 then
				self:Fail(group)
				TW.QuestDoneCreatedIn[group.Name] = false
				hook.Remove("TerritoryWars.DeleteGroupBecauseOfGroupQuests", "TerritoryWars." .. group.Name .. "QuestDoneDontDeleteGroup")
			end
			repeated = repeated + 1
		end)
	end

	return { quest }
end

TW.GroupQuestTypes.QuestDone = TW.QuestDoneGroupQuest