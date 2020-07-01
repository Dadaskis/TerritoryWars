local TW = TerritoryWars

TW.GroupQuestTypes = {}

function TW.GroupQuest(group) 
	local quest = TW.Quest(group)[1]
	quest.Type = "NULL_GROUP_QUEST"
	quest.LifeTimeReward = 0

	function quest:Activate(player) end

	function quest:Complete(group) 
		self.Active = false
		self.Available = false
		if not group then
			return
		end
		local reward = self.PointsReward or 0
		if TW.GroupGroupQuestPointsRewardUpgradeEnabled then
			reward = (reward * (1 + ((TW.GroupGroupQuestPointsRewardUpgradeProcents / 100) * group.Upgrades["GroupQuestPointsReward"])))
		end

		local rewardTime = self.LifeTimeReward or 0
		if TW.GroupGroupQuestLifeTimeRewardUpgradeEnabled then
			rewardTime = (rewardTime * (1 + ((TW.GroupGroupQuestLifeTimeRewardUpgradeProcents / 100) * group.Upgrades["GroupQuestLifeTimeReward"])))
		end
		group.Points = group.Points + reward
		group.LifeTime = group.LifeTime + rewardTime
		group:GenerateGroupQuests()
		TW.SendGroupLifeTime(group)
		group.QuestDone = group.QuestDone + 1
		for _, member in pairs(group.Members) do 
			if IsValid(member.Player) then
				net.Start("TerritoryWars.GetGroupPoints")
					net.WriteInt(group.Points, 32)
				net.Send(member.Player)
			end
		end
		hook.Run("TerritoryWars.GroupQuestDone", group, self.Type, self.Data or {}, reward, rewardTime)
	end

	function quest:Fail(group) 
		self.Active = false
		self.Available = false
		if not group then
			return
		end
		hook.Run("TerritoryWars.GroupQuestDone", group, self.Type, self.Data or {}, -1, -1)
		group:GenerateGroupQuests()
	end

	return { quest }
end