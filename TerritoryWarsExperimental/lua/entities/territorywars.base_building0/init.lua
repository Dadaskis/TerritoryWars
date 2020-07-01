local TW = TerritoryWars

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function TW.Callbacks.BuildingMeshInit(args, ply) 
    local entity = Entity(args[1])
    if entity.PhysicsInitialized == false then
        local meshTable = args[2]
        entity:EnableCustomCollisions(true)
        print("RESULT OF PHYSICSFROMMESH:", entity:PhysicsFromMesh(meshTable))
        entity.PhysicsInitialized = true
    end
end

function ENT:Initialize() 
    --local meshTable = util.GetModelMeshes("models/territorywarsmodels/territorywars_base_0.mdl")

	self:SetModel("models/territorywarsmodels/territorywars_base_0.mdl")
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)  

    self.PhysicsInitialized = false

    --self.TWHealth = TerritoryWars.SpecialDoorHealth
    --self.TWTimer = 0
    --self.TWNextTimeCheck = 0

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(200)
	end 
end