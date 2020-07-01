local TW = TerritoryWars
local TWUtil = TW.Utilities

local BonusPanel = {}

AccessorFunc(BonusPanel, "Bonus", "Bonus")

function BonusPanel:Init()
	self.DescriptionLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.DescriptionLabel:SetFont("TW.SFont" .. ScrH())
	self.DescriptionLabel:Dock(LEFT)

	self.SettingsButton = vgui.Create("DImageButton", self)
	self.SettingsButton:SetImage("icon16/cog.png")
	self.SettingsButton:SetStretchToFit(false)
	self.SettingsButton:Dock(RIGHT)
	self.SettingsButton:InvalidateParent()
	TWUtil:SetPanelSize(0.02, 0.02, self.SettingsButton)
	self.SettingsButton:SetMouseInputEnabled(true)

	local deleteButton = vgui.Create("DImageButton", self)
	deleteButton:SetImage("icon16/cross.png")
	deleteButton:SetStretchToFit(false)
	deleteButton:Dock(RIGHT)
	deleteButton:InvalidateParent()
	TWUtil:SetPanelSize(0.02, 0.02, deleteButton)
	deleteButton:SetMouseInputEnabled(true)	
	function deleteButton.DoClick() 
		self.Bonus.Deleted = true
		self:Remove()
	end
end

vgui.Register("TerritoryWars.TerritoryBonusPanelBase", BonusPanel, "TerritoryWars.PanelBase")