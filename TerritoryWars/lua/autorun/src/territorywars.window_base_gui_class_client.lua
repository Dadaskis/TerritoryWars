local TW = TerritoryWars

local Window = {}

function Window:Init() 
	self:SetTitle("")
end

function Window:OnScreenSizeChanged() 
	self:Close()
end

Window.Paint = TW.WindowPaint

vgui.Register("TerritoryWars.WindowBase", Window, "DFrame")