local TW = TerritoryWars
local TWUtil = TW.Utilities

local SettingsWindow = {}

AccessorFunc(SettingsWindow, "AdditionalInfo", "AdditionalInfo")
AccessorFunc(SettingsWindow, "Name", "Name")

function SettingsWindow:OnApply(name, additionalInfo) 

end

function SettingsWindow:Init() 
	self:SetSize(ScrW() * 0.5, ScrH() * 0.8)
	self:MakePopup()
	self:Center()

	local panel1 = vgui.Create("TerritoryWars.PanelBase", self)
	panel1:Dock(TOP)

	local nameLabel = vgui.Create("TerritoryWars.LabelBase", panel1)
	nameLabel:SetFontInternal("TW.SFont" .. ScrH())
	nameLabel:SetText(TW.Labels.Name .. ": ")
	nameLabel:SizeToContents()
	nameLabel:Dock(LEFT)

	local nameInput = vgui.Create("DTextEntry", panel1)
	nameInput:SetFontInternal("TW.SFont" .. ScrH())
	nameInput:Dock(LEFT)
	nameInput:InvalidateParent()
	local X, Y = nameInput:GetSize()
	nameInput:SetSize(ScrW() * 0.4, Y)
	if self.Name then
		nameInput:SetText(self.Name)
	end

	local additionalInfoLabel = vgui.Create("TerritoryWars.LabelBase", self)
	additionalInfoLabel:SetFontInternal("TW.SFont" .. ScrH())
	additionalInfoLabel:SetText(TW.Labels.AdditionalInfo)
	additionalInfoLabel:SizeToContents()
	additionalInfoLabel:SetContentAlignment(5)
	additionalInfoLabel:Dock(TOP)

	local apply = vgui.Create("TerritoryWars.ButtonBase", self)
	apply:SetFontInternal("TW.SFont" .. ScrH())
	apply:SetText(TW.Labels.Apply)
	apply:Dock(BOTTOM)

	local additionalInfoInput

	function apply.DoClick() 
		self:OnApply(nameInput:GetText(), additionalInfoInput:GetText())
		self:Close()
	end

	additionalInfoInput = vgui.Create("DTextEntry", self)
	additionalInfoInput:SetFontInternal("TW.SFont" .. ScrH())
	additionalInfoInput:SetMultiline(true)
	additionalInfoInput:SetVerticalScrollbarEnabled(true)
	additionalInfoInput:Dock(FILL)

	function self:SetAdditionalInfo(info) 
		if info then
			additionalInfoInput:SetText(info)
		end
	end

	function self:SetName(name) 
		if name then
			nameInput:SetText(name)
		end
	end
end

vgui.Register("TerritoryWars.TerritorySettingsWindow", SettingsWindow, "TerritoryWars.WindowBase")