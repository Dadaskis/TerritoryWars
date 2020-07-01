local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local AllyGroupQuest = {}

function AllyGroupQuest:Init() 
	self:SetText(TW.Labels.Ally)
end

function AllyGroupQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(
		TW.Labels.YouMustMakeAnAlly .. " " .. self.Quest.Data[1] .. ".\n"
	)
	self:AddRewardText(true)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.AllyGroupQuestButton", AllyGroupQuest, "TerritoryWars.GroupQuestButtonBase")

hook.Add("TerritoryWars.GroupQuestPanelOpened", "TerritoryWars.AllyGroupQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	group = TW.Group
	if table.Count(TW.GroupQuests) > 0 then
		for index, quest in pairs(TW.GroupQuests) do 
			if quest.Type and quest.Type == "ALLY_DIPLOMACY_QUEST" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.AllyGroupQuestButton")
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

hook.Add("TerritoryWars.GroupQuestDoneMessage.ALLY_DIPLOMACY_QUEST", "TerritoryWars.AllyGroupQuestChatAdd", function(data, reward, lifeTimeReward) 
	chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteGroupQuest1 .. TW.Labels.Ally .. "(" .. data[1] .. ")"
		.. TW.Labels.YouCompleteGroupQuest2 .. TW.Labels.YourGroupEarn .. ":" .. lifeTimeReward .. " " .. TW.Labels.SecondsOfLifeTime .. ", "
		.. reward .. " " .. TW.Labels.Points2 .. ".")
end)