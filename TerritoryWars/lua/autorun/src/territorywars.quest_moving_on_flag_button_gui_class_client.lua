local TW = TerritoryWars
local TWUtil = TW.Utilities

local movingQuest = {}

function movingQuest:Init() 
	self:SetText(TW.Labels.Scout)
end

function movingQuest:QuestPanelChanged() 
	if self.Quest then
		self.DescriptionLabel:SetText(
			TW.Labels.YouNeedToGoOnFlag .. " \"" .. (TW.FlagBonusMap[self.Quest.Data[1]].Name or "") .. "\" "
			.. TW.Labels.AndStayThere .. " " .. TW.QuestNegativeTimeLength(TW.Group, TW.MovingQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n" 
		)
		self:AddRewardText(false)
	else 
		self.DescriptionLabel:SetText("0xC0000005####")
	end
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.MovingOnFlagQuestButton", movingQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.MovingOnFlagQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		print(table.Count(TW.Quests))
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "MOVING_ON_FLAG_QUEST" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.MovingOnFlagQuestButton")
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

hook.Add("TerritoryWars.QuestDoneMessage.MOVING_ON_FLAG_QUEST", "TerritoryWars.MovingOnFlagQuestChatAdd", function(data, reward) 
	chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.Scout .. "[" .. (TW.FlagBonusMap[data[1]].Name or "") .. "]"
		.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
end)