local TW = TerritoryWars
local TWUtil = TW.Utilities

local DiplomacyWindow = {}

function DiplomacyWindow:Init() 
	TWUtil:SetPanelSize(0.3, 0.3, self)
	TWUtil:SetPanelPos(0.05, 0.7, self)
	self:SetTitle("")

	self.DescriptionLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.DescriptionLabel:SetFontInternal("TW.SFont" .. ScrH())
	self.DescriptionLabel:SetText("EasterEggsIsNotHere" .. " " .. TW.Labels.AllianceText .. "\n\n" .. TW.Labels.F3Notice)
	self.DescriptionLabel:SizeToContents()
	self.DescriptionLabel:Dock(TOP)

	local panel = vgui.Create("TerritoryWars.PanelBase", self)
	panel:Dock(BOTTOM)

	local yesButton = vgui.Create("TerritoryWars.ButtonBase", panel)
	yesButton:Dock(LEFT)
	yesButton:SetFontInternal("TW.SFont" .. ScrH())
	yesButton:SetText(TW.Labels.Yes)

	local noButton = vgui.Create("TerritoryWars.ButtonBase", panel)
	noButton:Dock(RIGHT)
	noButton:SetFontInternal("TW.SFont" .. ScrH())
	noButton:SetText(TW.Labels.No)

	function yesButton.DoClick() 
		net.Start("TerritoryWars.ImproveDiplomacy")
			net.WriteBool(true)
		net.SendToServer()	
		self:Close()
	end

	function noButton.DoClick() 
		net.Start("TerritoryWars.ImproveDiplomacy")
			net.WriteBool(false)
		net.SendToServer()	
		self:Close()
	end	

	local reason = vgui.Create("TerritoryWars.ButtonBase", self)
	reason:SetText(TW.Labels.DiplomacyReason)
	reason:Dock(BOTTOM)
	reason:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
	function reason.DoClick() 
		local frame = vgui.Create("TerritoryWars.WindowBase")
		frame:SetSize(ScrW() * 0.7, ScrH() * 0.5)
		frame:Center()
		frame:MakePopup()

		local label = vgui.Create("TerritoryWars.LabelBase", frame)
		label:SetFont("TW.Font" .. ScrH())
		label:SetText(TW.Labels.DiplomacyReason)
		label:SizeToContents()
		label:Dock(TOP)
		label:SetContentAlignment(5)

		local text = vgui.Create("DTextEntry", frame)
		text:SetMultiline(true)
		text:SetKeyBoardInputEnabled(true)
		text:SetVerticalScrollbarEnabled(true)
		text:SetDrawBackground(false)
		text:SetTextColor(TW.TextColor)
		text:SetFont("TW.SFont" .. ScrH())
		text:Dock(FILL)
		text:SetText(self.Reason)
	end

	function self:DeleteAppliers() 
		yesButton:Remove()
		noButton:Remove()
	end
end

function DiplomacyWindow:SetGroupName(name) 
	self.DescriptionLabel:SetText(name .. " " .. TW.Labels.AllianceText .. "\n\n" .. TW.Labels.F3Notice)
	self.DescriptionLabel:SizeToContents()
end

function DiplomacyWindow:SetReason(reason) 
	self.Reason = reason
end

vgui.Register("TerritoryWars.DiplomacyAnswerWindow", DiplomacyWindow, "TerritoryWars.WindowBase")