local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local RoleDataWindow = {}

function RoleDataWindow:Init()
	TWUtil:SetPanelSize(0.4, 0.5, self)
	self:Center()
	self:MakePopup()
	function self:OnScreenSizeChanged() 
		self:Close()
	end

	local namePanel = vgui.Create("TerritoryWars.PanelBase", self)
	local nameLabel = vgui.Create("TerritoryWars.LabelBase", namePanel)
	self.NameInput = vgui.Create("DTextEntry", namePanel)

	nameLabel:SetText(TW.Labels.Name)
	nameLabel:SizeToContents()
	nameLabel:Dock(LEFT)

	TWUtil:SetPanelSize(0.3, 0.03, self.NameInput)
	self.NameInput:Dock(LEFT)
	self.NameInput:SetFont("TW.SFont" .. ScrH())

	namePanel:SizeToContents()
	namePanel:Dock(TOP)

	local salaryPanel = vgui.Create("TerritoryWars.PanelBase", self)
	local salaryLabel = vgui.Create("TerritoryWars.LabelBase", salaryPanel)
	self.SalaryInput = vgui.Create("DTextEntry", salaryPanel)
	self.SalaryInput:SetFont("TW.SFont" .. ScrH())

	salaryLabel:SetText(TW.Labels.Salary)
	salaryLabel:SizeToContents()
	salaryLabel:Dock(LEFT)

	TWUtil:SetPanelSize(0.3, 0.04, self.SalaryInput)
	self.SalaryInput:SetText("0")
	self.SalaryInput:Dock(LEFT)

	salaryPanel:SizeToContents()
	salaryPanel:Dock(TOP)

	local permisionsPanel = vgui.Create("TerritoryWars.ScrollPanelBase", self)
	self.CheckBoxes = {}
	for key, description in pairs(TW.PermisionsList) do
		self.CheckBoxes[key] = vgui.Create("DCheckBoxLabel", permisionsPanel)
		self.CheckBoxes[key]:SetTextColor(TW.TextColor)
		self.CheckBoxes[key]:SetFontInternal("TW.SFont" .. ScrH())
		self.CheckBoxes[key]:SetText(description)
		self.CheckBoxes[key]:SizeToContents()
		self.CheckBoxes[key]:Dock(TOP)
	end

	--permisionsPanel:SizeToContents()
	--TWUtil:SetPanelSize(
	--	0.3, table.Count(self.CheckBoxes) * 0.05, permisionsPanel)
	permisionsPanel:Dock(FILL)

	self.ChoosedColor = Color(0, 0, 0)
	local colorChooser = vgui.Create("TerritoryWars.ColorChooserOpenWindowButton", self)
	colorChooser:Dock(BOTTOM)
	colorChooser:SetText(TW.Labels.Color)
	function colorChooser.OnApply() 
		self.ChoosedColor = colorChooser.ChoosedColor
	end

	self.ApplyButton = vgui.Create("TerritoryWars.ButtonBase", self)
	self.ApplyButton:SetFontInternal("TW.SFont" .. ScrH())
	self.ApplyButton:SetText(TW.Labels.Accept)
	self.ApplyButton:Dock(BOTTOM)
end

vgui.Register("TerritoryWars.RoleDataWindow", RoleDataWindow, "TerritoryWars.WindowBase")