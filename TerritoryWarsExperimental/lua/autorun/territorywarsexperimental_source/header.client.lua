print("[TerritoryWarsExperimental] Client header")
local files, directories = file.Find("autorun/territorywarsexperimental_source/*.client.lua", "LUA")
for _, file in pairs(files) do 
    if file ~= "header.client.lua" then
        print(file)
        include(file)
    end
end