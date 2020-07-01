local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local AttackGroupQuest = {}

function AttackGroupQuest:Init() 
	self:SetText(TW.Labels.AttackGroupQuest)
end

function AttackGroupQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(
		TW.Labels.YouNeedToHoldFlag1 .. TW.GroupQuestNegativeTimeLength(TW.Group, TW.AttackGroupQuestTimeLength) .. TW.Labels.YouNeedToHoldFlag2
	)
	for index, data in ipairs(self.Quest.Data) do 
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() 
			.. "    " .. ((TW.FlagBonusMap[data[1]] or {}).Name or "") .. " "
			.. "\n"
		)
	end
	self:AddRewardText(false)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.AttackFlagGroupQuestButton", AttackGroupQuest, "TerritoryWars.GroupQuestButtonBase")

hook.Add("TerritoryWars.GroupQuestPanelOpened", "TerritoryWars.AttackFlagGroupQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	group = TW.Group
	if table.Count(TW.GroupQuests) > 0 then
		for index, quest in pairs(TW.GroupQuests) do 
			if quest.Type and quest.Type == "ATTACK_FLAG_GROUP_QUEST" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.AttackFlagGroupQuestButton")
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

hook.Add("TerritoryWars.GroupQuestDoneMessage.ATTACK_FLAG_GROUP_QUEST", "TerritoryWars.AttackGroupQuestChatAdd", function(data, reward, lifeTimeReward) 
	if reward >= 0 and lifeTimeReward >= 0 then
		chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteGroupQuest1 .. TW.Labels.AttackGroupQuest 
			.. TW.Labels.YouCompleteGroupQuest2 .. TW.Labels.YourGroupEarn .. ":" .. lifeTimeReward .. " " .. TW.Labels.SecondsOfLifeTime .. ", "
			.. reward .. " " .. TW.Labels.Points2 .. ".")
	else
		chat.AddText(Color(255, 0, 0), TW.Labels.YouFailGroupQuest1 .. TW.Labels.AttackGroupQuest 
			.. TW.Labels.YouFailGroupQuest2)
	end
end)