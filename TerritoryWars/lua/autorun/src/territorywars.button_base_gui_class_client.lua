local TW = TerritoryWars

local Button = {}

function Button:Init() 
	self:SetTextColor(TW.TextColor)
	self:SetFont("TW.SFont" .. ScrH())
end

function Button:OnMousePressed() 
	self.TWMousePressed = true
	self:DoClick()
end

function Button:OnMouseReleased() 
	self.TWMousePressed = false
end

function Button:OnCursorEntered() 
	self.TWMouseEntered = true
end

function Button:OnCursorExited() 
	self.TWMouseEntered = false
end

Button.Paint = TW.ButtonPaint

vgui.Register("TerritoryWars.ButtonBase", Button, "DButton")