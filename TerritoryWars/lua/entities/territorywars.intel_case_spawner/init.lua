local TW = TerritoryWars 

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize() 
	self:SetModel("models/props_c17/SuitCase001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self.TWPickuped = false
	self:SetColor(Color(255, 100, 100, 255))

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(math.huge - 1)
	end 
end

function ENT:OnTakeDamage(damageInfo) 
	print(damageInfo:GetDamage())
end

function ENT:Use(player) 
	if not self.TWPickuped and not TW:GetPlayerData(player).HaveIntel then
		net.Start("TerritoryWars.CaseState")
			net.WriteBool(true)
		net.Send(player)
		self.TWPickuped = true
		self:SetColor(Color(0, 0, 0, 0))
		self:SetSolid(SOLID_NONE)
		self:SetRenderMode(RENDERMODE_TRANSALPHA)
		TW:GetPlayerData(player).HaveIntel = true
		timer.Simple(TW.IntelRespawnTime, function() 
			if IsValid(self) then
				self.TWPickuped = false
				self:SetColor(Color(255, 100, 100, 255))
				self:SetSolid(SOLID_VPHYSICS)
				self:SetRenderMode(RENDERMODE_NORMAL)
			end
		end)
	end
end