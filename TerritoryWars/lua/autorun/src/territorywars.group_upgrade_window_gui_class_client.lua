local TW = TerritoryWars

local UpgradeWindow = {}

local function TWFormatTime(time) 
	local result = ""
	if time.h < 10 then
		result = result .. "0"
	end
	result = result .. time.h .. ":"
	if time.m < 10 then
		result = result .. "0"
	end
	result = result .. time.m .. ":"
	if time.s < 10 then
		result = result .. "0"
	end
	result = result .. time.s
	return result
end

function UpgradeWindow:Init() 
	local groupPoints = vgui.Create("TerritoryWars.GroupPointsLabel", self)
	groupPoints:Dock(TOP)
	groupPoints:SetContentAlignment(5)

	local coolDown = vgui.Create("TerritoryWars.LabelBase", self)
	coolDown:SetFont("TW.SFont" .. ScrH())
	coolDown:SetContentAlignment(5)
	coolDown:Dock(TOP)
	function self.Think() 
		if os.time() <= (TW.GroupUpgradeCoolDownEnd) then
			coolDown:SetVisible(true)
			local time = string.FormattedTime(TW.GroupUpgradeCoolDownEnd - os.time())
			coolDown:SetText(TWFormatTime(time))
			coolDown:SizeToContents()
		else
			coolDown:SetVisible(false)
		end
	end

	self:SetSize(ScrW() * 0.7, ScrH() * 0.5)

	self.UpgradePanels = vgui.Create("TerritoryWars.ScrollPanelBase", self)
	self.UpgradePanels:Dock(FILL)

	self:Center()
	self:MakePopup()

	for _, upgrade in pairs(TW.GroupUpgradeTemplates) do 
		local upgradePanel = vgui.Create("TerritoryWars.GroupUpgradePanel", self.UpgradePanels:GetCanvas())
		upgradePanel:Dock(TOP)
		upgradePanel:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
		upgradePanel:SetUpgrade(upgrade)
		upgradePanel:InvalidateParent()
		local X, Y = upgradePanel:GetSize()
		upgradePanel:SetSize(X, ScrH() * 0.03)
	end
end

vgui.Register("TerritoryWars.UpgradeGroupWindow", UpgradeWindow, "TerritoryWars.WindowBase")