local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local DestroyGroupQuest = {}

function DestroyGroupQuest:Init() 
	self:SetText(TW.Labels.Destroy)
end

function DestroyGroupQuest:QuestPanelChanged() 
	self.DescriptionLabel:SetText(
		TW.Labels.YouMustDestroy .. " " .. self.Quest.Data[1] .. ".\n"
	)
	self:AddRewardText(true)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.DestroyGroupQuestButton", DestroyGroupQuest, "TerritoryWars.GroupQuestButtonBase")

hook.Add("TerritoryWars.GroupQuestPanelOpened", "TerritoryWars.DestroyGroupQuestButtonAdder", 
	function(availableQuests, activeQuests, choosedPanel) 
	group = TW.Group
	if table.Count(TW.GroupQuests) > 0 then
		for index, quest in pairs(TW.GroupQuests) do 
			if quest.Type and quest.Type == "DESTROY_GROUP_QUEST" then
				if quest.Available then
					local button = vgui.Create("TerritoryWars.DestroyGroupQuestButton")
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

hook.Add("TerritoryWars.GroupQuestDoneMessage.DESTROY_GROUP_QUEST", "TerritoryWars.DestroyGroupGroupQuestChatAdd", function(data, reward, lifeTimeReward) 
	chat.AddText(Color(0, 255, 0), TW.Labels.YouCompleteGroupQuest1 .. TW.Labels.Destroy .. "(" .. data[1] .. ")"
		.. TW.Labels.YouCompleteGroupQuest2 .. TW.Labels.YourGroupEarn .. ":" .. lifeTimeReward .. " " .. TW.Labels.SecondsOfLifeTime .. ", "
		.. reward .. " " .. TW.Labels.Points2 .. ".")
end)