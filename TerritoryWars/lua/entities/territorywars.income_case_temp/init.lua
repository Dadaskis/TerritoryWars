local TW = TerritoryWars 

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize() 
	self:SetModel("models/props_c17/SuitCase001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetColor(Color(100, 100, 255, 255))

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 
end

function ENT:Use(player) 
	TW:GetPlayerData(player).IncomePoints = self.TWPoints or 0
	net.Start("TerritoryWars.IncomeCaseState")
		net.WriteBool(true)
	net.Send(player)
	self:Remove()
end