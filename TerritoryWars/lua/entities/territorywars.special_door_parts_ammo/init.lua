local TW = TerritoryWars 

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize() 
	self:SetModel("models/props_lab/reciever01d.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.TWPickuped = false
	self:SetColor(Color(255, 100, 100, 255))

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 
end

function ENT:Use(player) 
	player:GiveAmmo(1, "Special door parts")
	self:Remove()
end