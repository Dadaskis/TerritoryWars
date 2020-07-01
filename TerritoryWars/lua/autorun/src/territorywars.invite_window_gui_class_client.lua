local TW = TerritoryWars
local TWUtil = TW.Utilities

local InviteWindow = {}

function InviteWindow:Init()
	TWUtil:SetPanelSize(0.3, 0.3, self)
	TWUtil:SetPanelPos(0.0, 0.7, self)
	self:SetTitle("")

	self.DescriptionLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.DescriptionLabel:SetFontInternal("TW.SFont" .. ScrH())
	self.DescriptionLabel:SetText("You read this, yea?" .. " " .. TW.Labels.InvitesYou .. "\n\n" .. TW.Labels.F3Notice)
	self.DescriptionLabel:SizeToContents()
	self.DescriptionLabel:Dock(TOP)

	local panel = vgui.Create("TerritoryWars.PanelBase", self)
	panel:Dock(BOTTOM)
	function panel:Paint() end

	local yesButton = vgui.Create("TerritoryWars.ButtonBase", panel)
	yesButton:Dock(LEFT)
	yesButton:SetFontInternal("TW.SFont" .. ScrH())
	yesButton:SetText(TW.Labels.Yes)

	local noButton = vgui.Create("TerritoryWars.ButtonBase", panel)
	noButton:Dock(RIGHT)
	noButton:SetFontInternal("TW.SFont" .. ScrH())
	noButton:SetText(TW.Labels.No)

	function yesButton.DoClick() 
		net.Start("TerritoryWars.InviteAccept")
		net.SendToServer()	
		self:Close()
	end

	function noButton.DoClick() 
		net.Start("TerritoryWars.InviteDecline")
		net.SendToServer()	
		self:Close()
	end
end

function InviteWindow:SetGroupName(name)
	self.DescriptionLabel:SetText(name .. " " .. TW.Labels.InvitesYou .. "\n\n" .. TW.Labels.F3Notice)
	self.DescriptionLabel:SizeToContents()
end

vgui.Register("TerritoryWars.InviteWindow", InviteWindow, "TerritoryWars.WindowBase")