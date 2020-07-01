local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local PassCaseGroupQuest = {}

function PassCaseGroupQuest:Init() 
	self:SetText(TW.Labels.Cases)
end

function PassCaseGroupQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(
		TW.Labels.YouNeedBringCases1 .. TW.PassCasesGroupQuestCount 
        .. TW.Labels.YouNeedBringCases2 .. " " .. TW.Labels.QuestIn .. " " 
		.. TW.GroupQuestPositiveTimeLength(TW.Group, TW.PassCasesGroupQuestTimeLength) 
		.. " " .. TW.Labels.Seconds .. ".\n"
	)
	self:AddRewardText(false)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.PassCaseGroupQuestButton", PassCaseGroupQuest, "TerritoryWars.GroupQuestButtonBase")

hook.Add("TerritoryWars.GroupQuestPanelOpened", "TerritoryWars.PassCaseGroupQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	group = TW.Group
	if table.Count(TW.GroupQuests) > 0 then
		for index, quest in pairs(TW.GroupQuests) do 
			if quest.Type and quest.Type == "PASS_CASE" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.PassCaseGroupQuestButton")
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

hook.Add("TerritoryWars.GroupQuestDoneMessage.PASS_CASE", "TerritoryWars.PassCaseGroupQuestChatAdd", function(data, reward, lifeTimeReward) 
	if reward >= 0 and lifeTimeReward >= 0 then
		chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteGroupQuest1 .. TW.Labels.Cases 
			.. TW.Labels.YouCompleteGroupQuest2 .. TW.Labels.YourGroupEarn .. ":" .. lifeTimeReward .. " " .. TW.Labels.SecondsOfLifeTime .. ", "
			.. reward .. " " .. TW.Labels.Points2 .. ".")
	else
		chat.AddText(Color(255, 0, 0), TW.Labels.YouFailGroupQuest1 .. TW.Labels.Cases .. TW.Labels.YouFailGroupQuest2)
	end
end)