local TW = TerritoryWars

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("TerritoryWars.OpenRegisterWindow")
util.AddNetworkString("TerritoryWars.OutFromGroupRegisterWindow")

function ENT:Initialize() 
	self:SetModel("models/territorywarsmodels/territorywars_registercomputer.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local physicsObj = self:GetPhysicsObject()

	if physicsObj:IsValid() then
		physicsObj:Wake()
		physicsObj:SetMass(math.huge - 1)
	end 
end

function ENT:Use(player) 
	if not TW:GetPlayerData(player) then
		TW.PlayerData[player:SteamID()] = {}
	end
	if not TW:GetPlayerData(player).InGroupRegisterWindow then
		TW:GetPlayerData(player).InGroupRegisterWindow = true
		net.Start("TerritoryWars.OpenRegisterWindow")
		net.Send(player)
	end
end

net.Receive("TerritoryWars.OutFromGroupRegisterWindow", function(byteLength, player) 
	TW.PlayerData[player:SteamID()].InGroupRegisterWindow = false
end)