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

function UpgradeWindow:SetRole(role) 
	self.UpgradePanels:GetCanvas():Clear()
	self.Role = role
	self.ComboBox:SetValue(role.Name)

	for _, upgrade in pairs(TW.UpgradeTemplates) do 
		local upgradePanel = vgui.Create("TerritoryWars.RoleUpgradePanel", self.UpgradePanels:GetCanvas())
		upgradePanel:Dock(TOP)
		upgradePanel:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
		upgradePanel:SetRole(role)
		upgradePanel:SetUpgrade(upgrade)
		upgradePanel:InvalidateParent()
		local X, Y = upgradePanel:GetSize()
		upgradePanel:SetSize(X, ScrH() * 0.03)
	end
end

function UpgradeWindow:Init() 
	self:SetSize(ScrW() * 0.5, ScrH() * 0.6)

	self:SetDraggable(true)
	self:Center()
	self:MakePopup()

	local groupPoints = vgui.Create("TerritoryWars.GroupPointsLabel", self)
	groupPoints:Dock(TOP)
	groupPoints:SetContentAlignment(5)

	local coolDown = vgui.Create("TerritoryWars.LabelBase", self)
	coolDown:SetFont("TW.SFont" .. ScrH())
	coolDown:SetContentAlignment(5)
	coolDown:Dock(TOP)
	function self.Think() 
		if os.time() <= (TW.UpgradeCoolDownEnd[self.Role.Name] or 0) then
			coolDown:SetVisible(true)
			local time = string.FormattedTime(TW.UpgradeCoolDownEnd[self.Role.Name] - os.time())
			coolDown:SetText(TWFormatTime(time))
			coolDown:SizeToContents()
		else
			coolDown:SetVisible(false)
		end
	end

	self.ComboBox = vgui.Create("DComboBox", self) 
	local comboBox = self.ComboBox
	comboBox:Dock(TOP)
	for name, role in pairs(TW.Group.Roles) do 
		comboBox:AddChoice(name)
	end
	function comboBox.OnSelect(comboBox, index, value) 
		self:SetRole(TW.Group.Roles[value])
	end

	self.UpgradePanels = vgui.Create("TerritoryWars.ScrollPanelBase", self)
	self.UpgradePanels:Dock(FILL)
end

vgui.Register("TerritoryWars.UpgradeRoleWindow", UpgradeWindow, "TerritoryWars.WindowBase")