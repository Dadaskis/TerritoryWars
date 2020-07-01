local TW = TerritoryWars

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("TerritoryWars.OutFromFlagWindow")

function ENT:Initialize()
	self.CreationID = self:GetCreationID()
	TW.FlagBonusMap[self.CreationID] = TW.FlagBonusMap[self.CreationID] or {}
	TW.FlagBonusMap[self.CreationID].EntIndex = self:EntIndex()
	TW.FlagBonusMap[self.CreationID].Position = self:GetPos()
	TW.FlagBonusMap[self.CreationID].Angles = self:GetAngles()
	net.Start("TerritoryWars.SetFlagBonusMap")
		net.WriteInt(self.CreationID, 32)
		net.WriteTable(TW.Utilities:GetTableData(TW.FlagBonusMap[self.CreationID]))
	net.Broadcast()

	self:SetModel("models/territorywarsmodels/territorywars_flag.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(math.huge - 1)
	end 

	TW:Save()
end

function ENT:Think()
	if self.PrevPos ~= self:GetPos() then
		if not TW.FlagBonusMap[self.CreationID] then
			TW.FlagBonusMap[self.CreationID] = {}
		end
		TW.FlagBonusMap[self.CreationID].Position = self:GetPos()
		TW.FlagBonusMap[self.CreationID].Angles = self:GetAngles()
	end
end

function ENT:Use(player) 
	if not TW:GetPlayerData(player).InFlagWindow then
		TW:GetPlayerData(player).InFlagWindow = true
		net.Start("TerritoryWars.OpenFlagWindow")
			net.WriteInt(self.CreationID, 32)
		net.Send(player)
	end
end

net.Receive("TerritoryWars.OutFromFlagWindow", function(byteLength, player) 
	TW:GetPlayerData(player).InFlagWindow = false
end)