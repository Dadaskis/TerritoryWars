local TW = TerritoryWars
local TWUtil = TW.Utilities

local Window = {}

function Window:OnApply(reasonText) end

function Window:Init() 
	self:SetSize(ScrW() * 0.7, ScrH() * 0.5)
	self:Center()
	self:MakePopup()

	local label = vgui.Create("TerritoryWars.LabelBase", self)
	label:SetFont("TW.Font" .. ScrH())
	label:SetText(TW.Labels.DiplomacyReason)
	label:SizeToContents()
	label:Dock(TOP)
	label:SetContentAlignment(5)

	local apply = vgui.Create("TerritoryWars.ButtonBase", self)
	apply:SetText(TW.Labels.Apply)
	apply:SetFont("TW.SFont" .. ScrH())
	apply:Dock(BOTTOM)

	local input = vgui.Create("DTextEntry", self)
	input:SetMultiline(true)
	input:SetVerticalScrollbarEnabled(true)
	input:SetFont("TW.SFont" .. ScrH())
	input:Dock(FILL)

	function apply.DoClick() 
		self:OnApply(input:GetText())
		self:Close()
	end
end

vgui.Register("TerritoryWars.DiplomacyReasonWindow", Window, "TerritoryWars.WindowBase")