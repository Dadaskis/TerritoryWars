AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("TerritoryWars.OutFromShopWindow")

function ENT:Initialize() 
	self:SetModel("models/territorywarsmodels/territorywars_shopcomputer.mdl")
	self:PhysicsInitStatic(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	self.TWHealth = TerritoryWars.ShopHealth

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 

	hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.GroupShopExplode" .. self:GetCreationID(), function(group) 
		if self.TWGroupOwner == group then
			local explode = ents.Create("env_explosion") 
			explode:SetPos(self:GetPos())
			explode:Spawn()
			explode:SetKeyValue("iMagnitude", "5")
			explode:Fire("Explode", 0, 0)
			explode:EmitSound("weapon_AWP.Single", 400, 400)
			self:Remove()
		end
	end)
end

function ENT:OnTakeDamage(damage) 
    self.TWHealth = self.TWHealth - damage:GetDamage()
    self.TWTimer = os.time() + TerritoryWars.ShopHealthRegenerationTime
    local player = damage:GetAttacker()
    if player:IsPlayer() then
        local eyeTrace = player:GetEyeTrace()
        if self.TWHealth < 0 then
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

function ENT:OnRemove() 
	if self.TWGroupOwner and TerritoryWars.Groups[self.TWGroupOwner.Name] and IsValid(self.TWGroupOwner.Leader) then
		self.TWGroupOwner.Leader:Give("territorywars.shop_computer_parts")
	end
end

function ENT:SetGroupOwner(group) 
	self.TWGroupOwner = group
end

function ENT:Use(player) 
	if self.TWGroupOwner == player:TWGetGroup() then
		if not TerritoryWars:GetPlayerData(player).InShopWindow then
			TerritoryWars:GetPlayerData(player).InShopWindow = true
			net.Start("TerritoryWars.OpenShopWindow")
			net.Send(player)
		end
	end
end

net.Receive("TerritoryWars.OutFromShopWindow", function(byteLength, player) 
	TerritoryWars:GetPlayerData(player).InShopWindow = false
end)