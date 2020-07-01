local TW = TerritoryWars

local Button = {}

function Button:Init() 
    self.NotInTablet = not TW.GroupUpgradeMenuFromTablet
	self.ID = 10
	self:SetText(TW.Labels.UpgradesText)
	self:SetIcon("icon16/add.png")
end

function Button:DoClick() 
	vgui.Create("TerritoryWars.UpgradeGroupWindow")
end

vgui.Register("TerritoryWars.GroupUpgradesButton", Button, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddGroupUpgradesButton", function(groupWindow) 
	if LocalPlayer():SteamID() == TW.Group.LeaderSteamID or
		LocalPlayer():TWGetGroupRole().Permisions["Group upgrading"] then
		local upgradeButton = vgui.Create("TerritoryWars.GroupUpgradesButton")
		groupWindow:AddToChoosePanel(upgradeButton)
	end
end)