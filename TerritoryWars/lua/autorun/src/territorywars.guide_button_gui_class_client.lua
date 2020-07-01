local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GuideButton = {}

AccessorFunc(GuideButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(GuideButton, "ChoosedPanel", "ChoosedPanel")

function GuideButton:Init() 
	group = TW.Group
	self.ID = 1001
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.GuideButton)
	self:SetIcon("icon16/book_addresses.png")
end

function GuideButton:DoClick() 
	self.ChoosedPanel:Clear()

	self.DescriptionLabel = vgui.Create("DTextEntry", self.ChoosedPanel)
	self.DescriptionLabel:SetKeyBoardInputEnabled(false)
	self.DescriptionLabel:SetMultiline(true)
	self.DescriptionLabel:SetVerticalScrollbarEnabled(true)
	self.DescriptionLabel:SetTextColor(TW.TextColor)
	self.DescriptionLabel:SetDrawBackground(false)
	self.DescriptionLabel:SetFont("TW.SFont" .. ScrH())
	self.DescriptionLabel:SetText(TW.Labels.Guide)
	self.DescriptionLabel:Dock(FILL)
end

vgui.Register("TerritoryWars.GuideButton", GuideButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddGuideButton", function(groupWindow) 
	local guide = vgui.Create("TerritoryWars.GuideButton")
	groupWindow:AddToChoosePanel(guide)
	guide:SetChoosePanel(groupWindow:GetChoosePanel())
	guide:SetChoosedPanel(groupWindow:GetChoosedPanel())
end)