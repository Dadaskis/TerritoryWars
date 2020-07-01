print("[TerritoryWarsExperimental] Server header")
local files, directories = file.Find("autorun/territorywarsexperimental_source/*.server.lua", "LUA")
for _, file in pairs(files) do 
    if file ~= "header.server.lua" then
        print(file)
        include(file)
    end
end

print("[TerritoryWarsExperimental] Client-Side Lua")
local files, directories = file.Find("autorun/territorywarsexperimental_source/*.client.lua", "LUA")
for _, file in pairs(files) do 
    print(file)
    AddCSLuaFile(file)
end