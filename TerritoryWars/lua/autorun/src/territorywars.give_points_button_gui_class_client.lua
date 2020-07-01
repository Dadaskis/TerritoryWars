local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GivePointsButton = {}

function GivePointsButton:Init() 
	self.ID = 4
	self.NotInTablet = not TW.TabletPointsInteractions
	self:SetText(TW.Labels.GivePoints)
	self:SetFont("TW.SFont" .. ScrH())
	self:SetIcon("icon16/arrow_right.png")
	self:SizeToContents()
end

function GivePointsButton:DoClick() 
	vgui.Create("TerritoryWars.GivePointsWindow")
end

vgui.Register("TerritoryWars.GivePointsButton", GivePointsButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddGivePointsButton", function(groupWindow) 
	local giveMenu = vgui.Create("TerritoryWars.GivePointsButton")
	groupWindow:AddToChoosePanel(giveMenu)
end)