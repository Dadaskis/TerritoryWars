local TW = TerritoryWars
local TWUtil = TW.Utilities

local attackQuest = {}

function attackQuest:Init() 
	self:SetText(TW.Labels.Capture)
end

function attackQuest:QuestPanelChanged() 
	if self.Quest then
		self.DescriptionLabel:SetText(TW.Labels.YouNeedToCapture .. "[" .. self.Quest.Data[1] .. 
			", " .. self.Quest.Data[2] .. "] ")
		if TW.Territories[self.Quest.Data[1]]
			and TW.Territories[self.Quest.Data[1]][self.Quest.Data[2]] 
			and TW.Territories[self.Quest.Data[1]][self.Quest.Data[2]].Name then
			self.DescriptionLabel:SetText(
				self.DescriptionLabel:GetText() .. "(" .. TW.Territories[self.Quest.Data[1]][self.Quest.Data[2]].Name .. ") "
			) 
		end
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() 
			.. TW.Labels.QuestIn .. " " .. TW.QuestPositiveTimeLength(TW.Group, TW.AttackQuestTimeLength) .. " " .. TW.Labels.Seconds .. ".\n" 
		)
		self:AddRewardText(false)
	else
		self.DescriptionLabel:SetText("0xC0000005####")
	end

	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.CaptureQuestButton", attackQuest, "TerritoryWars.QuestButtonBase")

hook.Add("TerritoryWars.QuestPanelOpened", "TerritoryWars.AttackQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	if TW.Quests and table.Count(TW.Quests) > 0 then
		for index, quest in pairs(TW.Quests) do 
			if quest.Type and quest.Type == "CAPTURE_ENEMY_TERRITORY" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.CaptureQuestButton")
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

hook.Add("TerritoryWars.QuestDoneMessage.CAPTURE_ENEMY_TERRITORY", "TerritoryWars.CaptureQuestChatAdd", function(data, reward) 
	if reward > 0 then
		chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteQuest1 .. TW.Labels.Capture .. "[" .. data[1] .. ", " .. data[2] .. "]"
			.. TW.Labels.YouCompleteQuest2 .. TW.Labels.YouEarn .. " " .. reward .. " " .. TW.Labels.Points2 .. ".")
	else
		chat.AddText(Color(255, 0, 0), TW.Labels.YouFailQuest1 .. TW.Labels.Capture .. "[" .. data[1] .. ", " .. data[2] .. "]" 
			.. TW.Labels.YouFailQuest2)
	end
end)
