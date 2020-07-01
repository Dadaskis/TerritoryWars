local TW = TerritoryWars
local TWUtil = TW.Utilities

local attackQuest = {}

function attackQuest:Init() 
	self:SetText(TW.Labels.Capture)
end

function attackQuest:QuestPanelChanged() 
	if self.Quest then
		self.DescriptionLabel:SetText(
			TW.Labels.YouNeedToCaptureFlag .. " \"" .. (TW.FlagBonusMap[self.Quest.Data[1]].Name or "") .. "\" "
			.. TW.Labels.QuestIn .. " " 
			.. TW.QuestPositiveTimeLength(TW.Group, TW.AttackFlagQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n" 
		)
		self:AddRewardText(false)
	else
		self.DescriptionLabel:SetText("0xC0000005####")
	end

	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.CaptureFlagQuestButton", attackQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.AttackFlagQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "CAPTURE_ENEMY_FLAG" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.CaptureFlagQuestButton")
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

hook.Add("TerritoryWars.QuestDoneMessage.CAPTURE_ENEMY_FLAG", "TerritoryWars.CaptureFlagQuestChatAdd", function(data, reward) 
	if reward > 0 then
		chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.Capture .. "[" .. (TW.FlagBonusMap[data[1]].Name or "") .. "]"
			.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
	else
		chat.AddText(Color(255, 0, 0), TW.Labels.YouFailQuest1 .. TW.Labels.Capture .. "[" .. (TW.FlagBonusMap[data[1]].Name or "") .. "]"
			.. TW.Labels.YouFailQuest2)
	end
end)
