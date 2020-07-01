local TW = TerritoryWars

TW.TextColor = Color(255, 211, 107)

function TW.PanelPaint(_, width, height) 
	draw.RoundedBox(0, 0, 0, width, height, Color(45, 45, 45, 130))
end

function TW.ToolTipPaint(_, width, height) 
	draw.RoundedBox(0, 0, 0, width, height, Color(32, 32, 32, 230))
end

function TW.ButtonPaint(self, width, height) 
	if self.TWMouseEntered then
		if self.TWMousePressed then
			draw.RoundedBox(0, 0, 0, width, height, Color(60, 60, 60))
		else
			draw.RoundedBox(0, 0, 0, width, height, Color(70, 70, 70))
		end
	else
		if self:IsEnabled() then
			draw.RoundedBox(0, 0, 0, width, height, Color(55, 55, 55))
		else
			draw.RoundedBox(0, 0, 0, width, height, Color(50, 50, 50))
		end
	end
end

function TW.WindowPaint(_, width, height) 
	draw.RoundedBox(0, 0, 0, width, height, Color(51, 51, 51, 230))
end
