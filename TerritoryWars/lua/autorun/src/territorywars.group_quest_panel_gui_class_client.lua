local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GroupQuestPanel = {}

GroupQuestPanel.LastGroupQuestsReceived = 0
function GroupQuestPanel:Think() 
	if self.LastGroupQuestsReceived < TW.GroupQuestsReceived then
		print(self.LastGroupQuestsReceived, TW.GroupQuestsReceived)
		self.LastGroupQuestsReceived = TW.GroupQuestsReceived
		self.AvailableQuests:GetCanvas():Clear()
		self.ActiveQuests:GetCanvas():Clear()
		hook.Run("TerritoryWars.GroupQuestPanelOpened", 
			self.AvailableQuests:GetCanvas(), self.ActiveQuests:GetCanvas(), self.QuestChoosedPanel)
	end
end

vgui.Register("TerritoryWars.GroupQuestPanel", GroupQuestPanel, "TerritoryWars.QuestPanel")