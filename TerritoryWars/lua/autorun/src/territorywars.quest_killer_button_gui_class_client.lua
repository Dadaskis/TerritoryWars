local TW = TerritoryWars
local TWUtil = TW.Utilities

local KillerQuest = {}

function KillerQuest:Init() 
	self:SetText(TW.Labels.Killer)
end

function KillerQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(TW.Labels.YouNeedToKill .. " " ..  player.GetBySteamID(self.Quest.Data[1]):Nick() 
		.. " " .. TW.Labels.QuestIn .. " " .. TW.QuestPositiveTimeLength(TW.Group, TW.KillerQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n"
	)
	self:AddRewardText(false)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.KillerQuestButton", KillerQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.KillerQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "KILL_THE_MEMBER" then
				if quest.Available then
					if IsValid(player.GetBySteamID(quest.Data[1])) then
						local button = vgui.Create("TerritoryWars.KillerQuestButton")
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
	end
end)

hook.Add("TerritoryWars.QuestDoneMessage.KILL_THE_MEMBER", "TerritoryWars.KillerQuestChatAdd", function(data, reward) 
	if IsValid(player.GetBySteamID(data[1])) then
		if reward > 0 then
			chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.Killer .. "[" .. player.GetBySteamID(data[1]):Nick() .. "]"
				.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
		else
			chat.AddText(Color(255, 0, 0), TW.Labels.YouFailQuest1 .. TW.Labels.Killer .. "[" .. player.GetBySteamID(data[1]):Nick() .. "]"
				.. TW.Labels.YouFailQuest2)
		end
	end
end)