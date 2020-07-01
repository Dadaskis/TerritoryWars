local TW = TerritoryWars
local TWUtil = TW.Utilities

local ColorChooser = {}

AccessorFunc(ColorChooser, "ChoosedColor", "ChoosedColor")

function ColorChooser:Init() 
	self:SetTitle(TW.Labels.ChooseAColor)
	self.ChoosedColor = Color(0, 0, 0)
	TWUtil:SetPanelSize(0.4, 0.7, self)

	local panel = vgui.Create("TerritoryWars.PanelBase", self)
	panel:Dock(FILL)

	local mixer = vgui.Create("DColorMixer", panel)
	mixer:SetAlphaBar(false)
	mixer:Dock(TOP)

	local applyButton = vgui.Create("TerritoryWars.ButtonBase", panel)
	applyButton:SetText(TW.Labels.Apply)
	applyButton:SetFont("TW.Font" .. ScrH())
	applyButton:SizeToContents()
	applyButton:Dock(BOTTOM)
	
	function applyButton.DoClick() 
		self.ChoosedColor = mixer:GetColor()
		self:OnApply()
		self:Close()
	end

	self:MakePopup()
	self:Center()	
end

function ColorChooser:OnApply() end

vgui.Register("TerritoryWars.ColorChooserWindow", ColorChooser, "TerritoryWars.WindowBase")