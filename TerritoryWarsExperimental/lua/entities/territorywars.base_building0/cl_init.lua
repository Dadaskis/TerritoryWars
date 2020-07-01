include("shared.lua")

local TW = TerritoryWars

function ENT:Initialize() 
    local meshTable = util.GetModelMeshes("models/territorywarsmodels/territorywars_base_0.mdl")
    local vertices = {}
    for key, mesh in pairs(meshTable) do 
        for key, vertex in pairs(mesh.verticies) do 
            table.Add(vertices, { { pos = vertex.pos } })
        end
    end
    PrintTable(vertices)
    TW:RunCallback("BuildingMeshInit", { self:EntIndex(), vertices })
end

function ENT:Draw() 
	self:DrawModel()
end