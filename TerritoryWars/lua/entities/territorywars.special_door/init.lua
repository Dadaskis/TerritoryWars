AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize() 
	self:SetModel("models/hunter/blocks/cube2x2x2.mdl")
	self:PhysicsInitStatic(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

    self.TWHealth = TerritoryWars.SpecialDoorHealth
    self.TWTimer = 0
    self.TWNextTimeCheck = 0

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 

	hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.GroupDoorExplode" .. self:GetCreationID(), function(group) 
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
    self.TWTimer = os.time() + TerritoryWars.SpecialDoorHealthRegenerationTime
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

function ENT:SetGroupOwner(group) 
	self.TWGroupOwner = group
end

function ENT:Think() 
    if self.TWTimer < os.time() then
        self.TWHealth = TerritoryWars.SpecialDoorHealth
    end

    if self.TWNextTimeCheck < os.time() then
        local haveMembersNear = false
        for key, member in pairs(self.TWGroupOwner.Members) do 
            local player = member.Player
            if IsValid(player) then
                if player:GetPos():Distance(self:GetPos()) < 100 then
                    self:SetRenderMode(RENDERMODE_TRANSALPHA)
                    self:SetColor(Color(0, 255, 0, 10))
                    self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
                    haveMembersNear = true
                end
            end
        end

        if not haveMembersNear then
            self:SetCollisionGroup(COLLISION_GROUP_NONE)
            self:SetRenderMode(RENDERMODE_NORMAL)
            self:SetColor(Color(255, 255, 255, 255))
        end

        self.TWNextTimeCheck = os.time() + 2
    end
end

--[[function ENT:Use(player) 
	if self.TWGroupOwner == player:TWGetGroup() then
		if not TerritoryWars:GetPlayerData(player).InShopWindow then
			TerritoryWars:GetPlayerData(player).InShopWindow = true
			net.Start("TerritoryWars.OpenShopWindow")
			net.Send(player)
		end
	end
end]]