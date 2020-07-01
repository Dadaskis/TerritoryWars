local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GroupQuestButton = {}

AccessorFunc(GroupQuestButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(GroupQuestButton, "ChoosedPanel", "ChoosedPanel")

function GroupQuestButton:Init() 
	group = TW.Group
	self.NotInTablet = not TW.GroupQuestMenuFromTablet
	self.ID = 3
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.GroupQuests)
	self:SetIcon("icon16/script_error.png")
end

function GroupQuestButton:DoClick() 
	self.ChoosedPanel:Clear()
	local panel = vgui.Create("TerritoryWars.GroupQuestPanel", self.ChoosedPanel)
	panel:SetChoosePanel(self.ChoosePanel)
	panel:SetChoosedPanel(self.ChoosedPanel)
end

vgui.Register("TerritoryWars.GroupQuestButton", GroupQuestButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddGroupQuestButton", function(groupWindow) 
	local questButton = vgui.Create("TerritoryWars.GroupQuestButton")
	groupWindow:AddToChoosePanel(questButton)
	questButton:SetChoosePanel(groupWindow:GetChoosePanel())
	questButton:SetChoosedPanel(groupWindow:GetChoosedPanel())
end)