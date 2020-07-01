print("[TerritoryWarsExperimental] Shared header")
local files, directories = file.Find("autorun/territorywarsexperimental_source/*.shared.lua", "LUA")
for _, file in pairs(files) do 
    if file ~= "header.shared.lua" then
        print(file)
        include(file)
    end
end

print("[TerritoryWarsExperimental] Client-Side Lua")
local files, directories = file.Find("autorun/territorywarsexperimental_source/*.shared.lua", "LUA")
for _, file in pairs(files) do 
    print(file)
    AddCSLuaFile(file)
end