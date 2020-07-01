local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local CaseButton = {}

AccessorFunc(CaseButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(CaseButton, "ChoosedPanel", "ChoosedPanel")

function CaseButton:Init() 
	group = TW.Group
	self.ID = 100
	self.NotInTablet = true
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.PassCase)
	self:SetIcon("icon16/lightbulb.png")
end

function CaseButton:DoClick() 
	net.Start("TerritoryWars.PassCase")
	net.SendToServer()
	chat.AddText(Color(100, 255, 0), TW.Labels.CaseText .. " " .. TW.BringCaseReward .. " " .. TW.Labels.Points2 .. ".")
	TW.CaseState = false
	self:Remove()
end

vgui.Register("TerritoryWars.PassCaseButton", CaseButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddPassCaseButton", function(groupWindow) 
	if TW.CaseState then
		local case = vgui.Create("TerritoryWars.PassCaseButton")
		case:SetChoosePanel(groupWindow:GetChoosePanel())
		case:SetChoosedPanel(groupWindow:GetChoosedPanel())
		groupWindow:AddToChoosePanel(case)
	end
end)