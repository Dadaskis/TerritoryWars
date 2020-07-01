local TW = TerritoryWars

TW.QuestTypes = {}

function TW.Quest(group) 
	local quest = {}
	quest.Available = false
	quest.Active = false
	quest.Data = {}
	quest.Type = "NULL_QUEST"
	quest.PointsReward = 0
	quest.GroupName = group.Name
	quest.HaveTime = false
	quest.OverTime = 0

	function quest:Activate(player) end

	function quest:Complete(player) 
		local member = player:TWGetGroupMember()
		if TW.GroupUpgrading and TW.GroupQuestPointsRewardUpgradeEnabled then
			member.Points = member.Points + 
				(self.PointsReward * (1 + ((TW.GroupQuestPointsRewardUpgradeProcents / 100) * group.Upgrades["QuestPointsReward"])))
		else
			member.Points = member.Points + self.PointsReward
		end
		self.Active = false
		self.Available = false
		player:TWGetGroup():GenerateQuests(player)
		player:TWGetGroup():GenerateGroupQuests()
		hook.Run("TerritoryWars.QuestDone", player, group, self.Type, self.Data, self.PointsReward)
		net.Start("TerritoryWars.GetMyPoints")
			net.WriteInt(player:TWGetGroupMember().Points, 32)
		net.Send(player)
		player:TWGetGroup().QuestDone = player:TWGetGroup().QuestDone + 1
	end

	function quest:Fail() 
		self.Active = false
		self.Available = false
		hook.Run("TerritoryWars.QuestDone", player, group, self.Type, self.Data, -1)
		group:GenerateQuests(player)
	end

	return { quest }
end