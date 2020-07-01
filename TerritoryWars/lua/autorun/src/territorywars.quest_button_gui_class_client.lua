local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local QuestButton = {}

AccessorFunc(QuestButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(QuestButton, "ChoosedPanel", "ChoosedPanel")

function QuestButton:Init() 
	group = TW.Group
	self.NotInTablet = not TW.QuestMenuFromTablet
	self.ID = 2
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.Quests)
	self:SetIcon("icon16/script.png")
end

function QuestButton:DoClick() 
	self.ChoosedPanel:Clear()
	local panel = vgui.Create("TerritoryWars.QuestPanel", self.ChoosedPanel)
	panel:SetChoosePanel(self.ChoosePanel)
	panel:SetChoosedPanel(self.ChoosedPanel)
end

vgui.Register("TerritoryWars.QuestButton", QuestButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddQuestButton", function(groupWindow) 
	local questButton = vgui.Create("TerritoryWars.QuestButton")
	groupWindow:AddToChoosePanel(questButton)
	questButton:SetChoosePanel(groupWindow:GetChoosePanel())
	questButton:SetChoosedPanel(groupWindow:GetChoosedPanel())
end)