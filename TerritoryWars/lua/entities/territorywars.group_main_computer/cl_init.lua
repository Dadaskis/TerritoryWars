include("shared.lua")

function ENT:SetupDataTables() 
    self:NetworkVar("Int", 0, "ComputerHealth")
end

function ENT:Draw() 
	self:DrawModel()
    local angles = self:GetAngles()
    angles.Roll = angles.Roll - 90
    cam.Start3D2D(self:GetPos() + (self:GetUp() * 2) + (angles:Up() * 38), angles, 1)
        surface.SetDrawColor(0, 0, 0)
        surface.DrawRect(15, 90, 50, 5)
        surface.SetDrawColor(255, 0, 0)
        surface.DrawRect(15, 90, 50 * (self:GetComputerHealth() / TerritoryWars.ComputerHealth), 5)
    cam.End3D2D()
end