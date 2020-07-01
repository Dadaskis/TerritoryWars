local TW = TerritoryWars 
TW.TerritoryRetainers = {}

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("TerritoryWars.OutFromTerritoryRetainerWindow")

function ENT:Initialize() 
	TW.TerritoryRetainers[#TW.TerritoryRetainers + 1] = self
	self.TWHealth = 200
	self.TWIndex = #TW.TerritoryRetainers
	self.TWActivated = false
	self:SetModel("models/territorywarsmodels/territorywars_retainer.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 
end

function ENT:OnTakeDamage(damage) 
	self.TWHealth = self.TWHealth - damage:GetDamage()
	local player = damage:GetAttacker()
	if player:IsPlayer() then
		local eyeTrace = player:GetEyeTrace()
		if self.TWHealth < 0 then
			local explode = ents.Create("env_explosion") 
			explode:SetPos(self:GetPos())
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "0")
			explode:Fire("Explode", 0, 0)
			explode:EmitSound("weapon_AWP.Single", 400, 400)
			TW.TerritoryRetainers[self.TWIndex] = nil
			self:Remove()
		end
	end
end

function ENT:PhysgunPickup() end

function ENT:Use(player) 
	if not TW:GetPlayerData(player).InTerritoryRetainerWindow then
		TW:GetPlayerData(player).InTerritoryRetainerWindow = true
		net.Start("TerritoryWars.OpenTerritoryRetainerWindow")
			net.WriteBool(self.TWActivated)
			net.WriteInt(self.TWIndex, 32)
		net.Send(player)
	end
end

net.Receive("TerritoryWars.OutFromTerritoryRetainerWindow", function(byteLength, player) 
	TW:GetPlayerData(player).InTerritoryRetainerWindow = false
end)