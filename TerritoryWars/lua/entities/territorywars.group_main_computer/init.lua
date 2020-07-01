local TW = TerritoryWars

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

util.AddNetworkString("TerritoryWars.OutFromMainGroupWindow")

function ENT:Initialize() 
	self:SetModel("models/territorywarsmodels/territorywars_maingroupcomputer.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.TWTimer = 0

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 
end

function ENT:SetupDataTables() 
	self:NetworkVar("Int", 0, "ComputerHealth")

	self:SetComputerHealth(TW.ComputerHealth)
end

function ENT:SetGroupOwner(group) 
	self.TWGroupOwner = group

	hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.MainGroupComputerExplode" .. self:GetCreationID(), function(group) 
		if self.TWGroupOwner == group then
			self:Remove()
			local explode = ents.Create("env_explosion") 
			explode:SetPos(self:GetPos())
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "20")
			explode:Fire("Explode", 0, 0)
			explode:EmitSound("weapon_AWP.Single", 400, 400)
		end
	end)
end

function ENT:Think() 
	if self.TWTimer < os.time() then
		self:SetComputerHealth(TW.ComputerHealth)
	end
end

function ENT:OnRemove() 
	if self.TWGroupOwner and TW.Groups[self.TWGroupOwner.Name] then
		self.TWGroupOwner.Leader:Give("territorywars.leader_computer_parts")
	end
end

function ENT:OnTakeDamage(damage) 
	self:SetComputerHealth(self:GetComputerHealth() - damage:GetDamage())
	self.TWTimer = os.time() + TW.ComputerHealthRegenerationTime
	local player = damage:GetAttacker()
	if player:IsPlayer() then
		local eyeTrace = player:GetEyeTrace()
		if self:GetComputerHealth() < 0 then
			if self.TWGroupOwner and TW.Groups[self.TWGroupOwner.Name] then
				if player:TWGetGroup() ~= self.TWGroupOwner then
					local points = self.TWGroupOwner.Points
					for _, member in pairs(self.TWGroupOwner.Members) do 
						points = points + member.Points
					end
					player:TWGetGroup().Points = player:TWGetGroup().Points + points
					player:TWGetGroup().LifeTime = player:TWGetGroup().LifeTime 
						+ (self.TWGroupOwner.LifeTime - os.time())
				end
				self.TWGroupOwner:DeleteGroup()
			end
			self:Remove()
			local explode = ents.Create("env_explosion") 
			explode:SetPos(self:GetPos())
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "100")
			explode:Fire("Explode", 0, 0)
			explode:EmitSound("weapon_AWP.Single", 400, 400)
		end
	end
end

function ENT:Use(player) 
	if self.TWGroupOwner == player:TWGetGroup() then
		if not TW:GetPlayerData(player).InMainGroupWindow then
			TW:GetPlayerData(player).InMainGroupWindow = true
			net.Start("TerritoryWars.OpenGroupWindow")
			net.Send(player)
		end
	end
end

net.Receive("TerritoryWars.OutFromMainGroupWindow", function(byteLength, player) 
	TW:GetPlayerData(player).InMainGroupWindow = false
end)