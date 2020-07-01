local TW = TerritoryWars
local TWUtil = TW.Utilities

local PassCaseQuest = {}

function PassCaseQuest:Init() 
	self:SetText(TW.Labels.PassCase)
end

function PassCaseQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(TW.Labels.YouNeedToPassCase .. " " 
		.. TW.Labels.QuestIn .. " " .. TW.QuestPositiveTimeLength(TW.Group, TW.PassCaseQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n"
	)
	self:AddRewardText(false)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.PassCaseQuestButton", PassCaseQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.PassCaseQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "PASS_CASE" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.PassCaseQuestButton")
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

hook.Add("TerritoryWars.QuestDoneMessage.PASS_CASE", "TerritoryWars.PassCaseQuestChatAdd", function(data, reward) 
	chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.PassCase
		.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
end)