local TW = TerritoryWars
local TWUtil = TW.Utilities

local defendQuest = {}

function defendQuest:Init() 
	self:SetText(TW.Labels.Defend)
end

function defendQuest:QuestPanelChanged() 
	if self.Quest then
		self.DescriptionLabel:SetText(
			TW.Labels.YouNeedToDefendFlag .. " \"" .. (TW.FlagBonusMap[self.Quest.Data[1]].Name or "") .. "\" " 
		    .. TW.QuestNegativeTimeLength(TW.Group, TW.DefendFlagQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n" 
		) 
		self:AddRewardText(false)
	else 
		self.DescriptionLabel:SetText("0xC0000005####")
	end
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.DefendFlagQuestButton", defendQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.DefendFlagQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "DEFEND_FLAG" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.DefendFlagQuestButton")
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

hook.Add("TerritoryWars.QuestDoneMessage.DEFEND_FLAG", "TerritoryWars.DefendFlagQuestChatAdd", function(data, reward) 
	if reward > 0 then
		chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.Defend .. "[" .. TW.FlagBonusMap[data[1]].Name .. "]"
			.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
	else
		chat.AddText(Color(255, 0, 0), TW.Labels.YouFailQuest1 .. TW.Labels.Defend .. "[" .. TW.FlagBonusMap[data[1]].Name .. "]"
			.. TW.Labels.YouFailQuest2)
	end
end)