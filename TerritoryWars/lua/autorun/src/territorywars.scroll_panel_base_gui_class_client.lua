local TW = TerritoryWars

local Panel = {}

function Panel:Init() 
	self:GetCanvas().Paint = TW.PanelPaint
	self:GetVBar().Paint = TW.PanelPaint
	self:GetVBar().btnGrip.Paint = TW.ButtonPaint
end

vgui.Register("TerritoryWars.ScrollPanelBase", Panel, "DScrollPanel")