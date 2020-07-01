local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local DepositPointsButton = {}

function DepositPointsButton:Init()
	self.ID = 4 
	self.NotInTablet = not TW.TabletPointsInteractions
	self:SetText(TW.Labels.DepositPoints)
	self:SetFont("TW.SFont" .. ScrH())
	self:SetIcon("icon16/arrow_down.png")
	self:SizeToContents()
end

function DepositPointsButton:DoClick() 
	vgui.Create("TerritoryWars.DepositPointsWindow")
end

vgui.Register("TerritoryWars.DepositPointsButton", DepositPointsButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddDepositPointsButton", function(groupWindow) 
	local depositMenu = vgui.Create("TerritoryWars.DepositPointsButton", groupWindow:GetChoosePanel())
	groupWindow:AddToChoosePanel(depositMenu)
	depositMenu:Dock(TOP)
end)