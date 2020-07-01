local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local IncomeCaseButton = {}

AccessorFunc(IncomeCaseButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(IncomeCaseButton, "ChoosedPanel", "ChoosedPanel")

function IncomeCaseButton:Init() 
	group = TW.Group
	self.ID = 101
	self.NotInTablet = true
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.PassCase)
	self:SetIcon("icon16/coins_add.png")
end

function IncomeCaseButton:DoClick() 
	net.Start("TerritoryWars.PassIncomeCase")
	net.SendToServer()
	chat.AddText(Color(0, 150, 0), TW.Labels.CaseText .. " " .. TW.BringIncomeCaseReward .. " " .. TW.Labels.Points2 .. ".")
	TW.IncomeCaseState = false
	self:Remove()
end

vgui.Register("TerritoryWars.PassIncomeCaseButton", IncomeCaseButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddPassIncomeCaseButton", function(groupWindow) 
	if TW.IncomeCaseState then
		local case = vgui.Create("TerritoryWars.PassIncomeCaseButton")
		case:SetChoosePanel(groupWindow:GetChoosePanel())
		case:SetChoosedPanel(groupWindow:GetChoosedPanel())
		groupWindow:AddToChoosePanel(case)
	end
end)