local TW = TerritoryWars

local ToolTip = {}

function ToolTip:Init() 
	self:SetSize(ScrW() * 0.3, ScrH() * 0.55)
	self.Text = vgui.Create("DTextEntry", self)
	self.Text:SetMultiline(true)
	self.Text:SetMouseInputEnabled(true)
	self.Text:SetKeyBoardInputEnabled(false)
	self.Text:SetVerticalScrollbarEnabled(true)
	self.Text:SetTextColor(TW.TextColor)
	self.Text:SetDrawBackground(false)
	self.Text:Dock(FILL)
end

ToolTip.Paint = TW.ToolTipPaint

function ToolTip:Think() 
	local X, Y = input.GetCursorPos()
	X, Y = X + ScrW() * 0.05, Y + ScrH() * 0.055
	local X2, Y2 = self:GetSize()
	if Y + Y2 < ScrH() then
		self:SetPos(X, Y)
	else
		self:SetPos(X, ScrH() - Y2)
	end
end

function ToolTip:OnCursorMoved() 
	self:Remove()
end

function ToolTip:SetText(text) 
	self.Text:SetText(text)
end

function ToolTip:GetText() 
	return self.Text:GetText()
end

vgui.Register("TerritoryWars.ToolTip", ToolTip, "TerritoryWars.PanelBase")