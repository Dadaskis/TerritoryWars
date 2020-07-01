local TW = TerritoryWars
local TWUtil = TW.Utilities

local ColorButton = {}

AccessorFunc(ColorButton, "ChoosedColor", "ChoosedColor")

function ColorButton:Init() 
	self.ChoosedColor = Color(163, 163, 163)
	self:SetIcon("icon16/color_wheel.png")
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetTextColor(TW.TextColor)
end

function ColorButton:Paint(width, height) 
	draw.RoundedBox(0, 0, 0, width, height, self.ChoosedColor)
	draw.RoundedBox(0, 1, 1, width - 4, 2, Color(100, 100, 100))
	draw.RoundedBox(0, 1, height - 4, width - 3, 2, Color(100, 100, 100))
	draw.RoundedBox(0, 1, 1, 2, height - 4, Color(100, 100, 100))
	draw.RoundedBox(0, width - 4, 1, 2, height - 4, Color(100, 100, 100))
end

function ColorButton:OnApply() end

function ColorButton:DoClick() 
	local colorChooser = vgui.Create("TerritoryWars.ColorChooserWindow")
	function colorChooser.OnApply() 
		self.ChoosedColor = colorChooser:GetChoosedColor()
		if self.ChoosedColor.r < 100 and 
			self.ChoosedColor.g < 100 and 
			self.ChoosedColor.b < 100 then
			self:SetColor(Color(255, 255, 255))
		else
			self:SetColor(Color(20, 20, 20))
		end
		self:OnApply()
	end
end

vgui.Register("TerritoryWars.ColorChooserOpenWindowButton", ColorButton, "TerritoryWars.ButtonBase")