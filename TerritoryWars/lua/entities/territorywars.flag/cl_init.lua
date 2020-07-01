include("shared.lua")

function ENT:Draw() 
	self:DrawModel()
	local angle = LocalPlayer():EyeAngles()
	angle:RotateAroundAxis(angle:Forward(), 90)
	angle:RotateAroundAxis(angle:Right(), 90)
	cam.Start3D2D(
		self:GetPos() + (self:GetUp() * 150), 
		angle,
		1
	)
		surface.SetDrawColor(255, 255, 255, 255)
		if LocalPlayer():GetPos():Distance(self:GetPos()) < TerritoryWars.FlagCaptureDistance then
			surface.SetMaterial(Material("icon16/flag_green.png"))
		else
			surface.SetMaterial(Material("icon16/flag_red.png"))
		end
		surface.DrawTexturedRect(-25, -25, 25, 25)
	cam.End3D2D()
end