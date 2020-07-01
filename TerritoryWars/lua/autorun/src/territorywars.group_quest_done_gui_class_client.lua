local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GoalGroupQuest = {}

function GoalGroupQuest:Init() 
	self:SetText(TW.Labels.QuestGoal)
end

function GoalGroupQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(
		TW.Labels.YouNeedToComplete .. self.Quest.Data[1] .. " " .. 
		TW.Labels.QuestsIn .. " " 
		.. TW.GroupQuestPositiveTimeLength(TW.Group, TW.QuestDoneGroupQuestTimeLength * (self.Quest.Data[1] - (self.Quest.Data[1] * 0.2)))
		.. " " .. TW.Labels.Seconds .. ".\n"
	)
	self:AddRewardText(true)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.GoalGroupQuestButton", GoalGroupQuest, "TerritoryWars.GroupQuestButtonBase")

hook.Add("TerritoryWars.GroupQuestPanelOpened", "TerritoryWars.GoalGroupQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	group = TW.Group
	if table.Count(TW.GroupQuests) > 0 then
		for index, quest in pairs(TW.GroupQuests) do 
			if quest.Type and quest.Type == "QUEST_DONE" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.GoalGroupQuestButton")
					button:SetChoosedPanel(choosedPanel)
					button:SetActivePanel(activeQuests)
					button:SetAvailablePanel(availableQuests)
					button:SetQuestByIndex(index)
					if quest.Active then
						button:SetParent(activeQuests)
					else
						button:SetParent(availableQuests)
					end
				end
			end
		end
	end
end)

hook.Add("TerritoryWars.GroupQuestDoneMessage.QUEST_DONE", "TerritoryWars.QuestDoneGroupQuestChatAdd", function(data, reward, lifeTimeReward) 
	if reward >= 0 and lifeTimeReward >= 0 then
		chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteGroupQuest1 .. TW.Labels.QuestGoal
			.. TW.Labels.YouCompleteGroupQuest2 .. TW.Labels.YourGroupEarn .. ":" .. lifeTimeReward .. " " .. TW.Labels.SecondsOfLifeTime .. ", "
			.. reward .. " " .. TW.Labels.Points2 .. ".")
	else
		chat.AddText(Color(255, 0, 0), TW.Labels.YouFailGroupQuest1 .. TW.Labels.QuestGoal .. TW.Labels.YouFailGroupQuest2)
	end
end)