local TW = TerritoryWars

local Label = {}

function Label:Init() 
	self:SetColor(TW.TextColor)
end

vgui.Register("TerritoryWars.LabelBase", Label, "DLabel")