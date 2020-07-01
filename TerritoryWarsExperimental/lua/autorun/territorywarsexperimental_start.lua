TerritoryWars = TerritoryWars or {}

include("territorywarsexperimental_source/header.shared.lua")
if CLIENT then
    include("territorywarsexperimental_source/header.client.lua")
elseif SERVER then
    AddCSLuaFile("territorywarsexperimental_source/header.shared.lua")
    AddCSLuaFile("territorywarsexperimental_source/header.client.lua")
    include("territorywarsexperimental_source/header.server.lua")
end