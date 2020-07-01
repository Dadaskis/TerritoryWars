local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local WithdrawPointsButton = {}

function WithdrawPointsButton:Init() 
	self.ID = 4
	self.NotInTablet = not TW.TabletPointsInteractions
	self:SetText(TW.Labels.WithdrawPoints)
	self:SetFont("TW.SFont" .. ScrH())
	self:SetIcon("icon16/arrow_up.png")
	self:SizeToContents()
end

function WithdrawPointsButton:DoClick() 
	vgui.Create("TerritoryWars.WithdrawPointsWindow")
end

vgui.Register("TerritoryWars.WithdrawPointsButton", WithdrawPointsButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddWithdrawPointsButton", function(groupWindow) 
	if LocalPlayer():SteamID() == TW.Group.LeaderSteamID or
			LocalPlayer():TWGetGroupRole().Permisions["Group point managing"] == true then
		local withdrawMenu = vgui.Create("TerritoryWars.WithdrawPointsButton")
		groupWindow:AddToChoosePanel(withdrawMenu)
	end
end)