local TW = TerritoryWars
local TWUtil = TW.Utilities
local group 

local GroupQuestButton = {}

function GroupQuestButton:Init2() 
	self.AcceptButton:SetVisible(
		((TW.Group.LeaderSteamID == LocalPlayer():SteamID()) 
			or LocalPlayer():TWGetGroupRole().Permisions["Group quest accept"])
		and (not TW.MainWindowFromTablet or TW.QuestInteractionFromTablet)
	)
end

function GroupQuestButton:SetQuestByIndex(questIndex) 
	group = TW.Group
	self.QuestIndex = questIndex
	self.Quest = TW.GroupQuests[questIndex]
end

function GroupQuestButton:AddRewardText(orMore)
	local reward = self.Quest.PointsReward or "???"
	if isnumber(reward) and TW.GroupUpgrading and TW.GroupGroupQuestPointsRewardUpgradeEnabled then
		reward = (reward * (1 + ((TW.GroupGroupQuestPointsRewardUpgradeProcents / 100) * TW.GroupUpgrades["GroupQuestPointsReward"])))
	end
	local rewardTime = self.Quest.LifeTimeReward or "???"
	if isnumber(rewardTime) and TW.GroupUpgrading and TW.GroupGroupQuestLifeTimeRewardUpgradeEnabled then
		rewardTime = (rewardTime * (1 + ((TW.GroupGroupQuestLifeTimeRewardUpgradeProcents / 100) * TW.GroupUpgrades["GroupQuestLifeTimeReward"])))
	end
	if orMore then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. 
			TW.Labels.Reward .. ": " .. TW.Labels.Minimum .. " "  .. (reward or "???") .. " " 
				.. TW.Labels.Points2 .. ", " .. TW.Labels.Minimum .. " " .. (rewardTime or "???")
				.. " " .. TW.Labels.SecondToTimer .. "."
		)
	else		 
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. 
			TW.Labels.Reward .. ": " .. (reward or "???") .. " " 
				.. TW.Labels.Points2 .. ", " .. " " .. (rewardTime or "???")
				.. " " .. TW.Labels.SecondToTimer .. "."
		)
	end
end

function GroupQuestButton:SendSocketToActivate(index) 
	net.Start("TerritoryWars.ActivateGroupQuest")
		net.WriteInt(index, 32)
	net.SendToServer()
end

vgui.Register("TerritoryWars.GroupQuestButtonBase", GroupQuestButton, "TerritoryWars.QuestButtonBase")