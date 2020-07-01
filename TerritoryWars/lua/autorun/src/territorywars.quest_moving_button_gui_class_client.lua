local TW = TerritoryWars
local TWUtil = TW.Utilities

local movingQuest = {}

function movingQuest:Init() 
	self:SetText(TW.Labels.Scout)
end

function movingQuest:QuestPanelChanged() 
	if self.Quest then
		self.DescriptionLabel:SetText(
			TW.Labels.YouNeedToGoOn .. "[" .. self.Quest.Data[1] .. 
			", " .. self.Quest.Data[2] .. "] "
		) 
		if TW.Territories[self.Quest.Data[1]] 
			and TW.Territories[self.Quest.Data[1]][self.Quest.Data[2]] 
			and TW.Territories[self.Quest.Data[1]][self.Quest.Data[2]].Name then
			self.DescriptionLabel:SetText(
				self.DescriptionLabel:GetText() .. "(" .. TW.Territories[self.Quest.Data[1]][self.Quest.Data[2]].Name .. ") "
			) 
		end
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() 
			.. TW.Labels.AndStayThere .. " " .. TW.QuestNegativeTimeLength(TW.Group, TW.MovingQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n" 
		)
		self:AddRewardText(false)
	else 
		self.DescriptionLabel:SetText("0xC0000005####")
	end
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.MovingQuestButton", movingQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.MovingQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		print(table.Count(TW.Quests))
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "MOVING_QUEST" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.MovingQuestButton")
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

hook.Add("TerritoryWars.QuestDoneMessage.MOVING_QUEST", "TerritoryWars.MovingQuestChatAdd", function(data, reward) 
	chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.Scout .. "[" .. data[1] .. ", " .. data[2] .. "]"
		.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
end)