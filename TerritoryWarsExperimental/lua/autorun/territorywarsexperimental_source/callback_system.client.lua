local TW = TerritoryWars
TW.Callbacks = TW.Callbacks or {}

net.Receive("TerritoryWars.RunCallback", function() 
    local functionName = net.ReadString()
    local args = net.ReadTable()
    TW.Callbacks[functionName](args)
end) 

function TW:RunCallback(functionName, tbl) 
    net.Start("TerritoryWars.RunCallBack")
        net.WriteString(functionName)
        net.WriteTable(tbl)
    net.SendToServer()
end

hook.Add("SpawnMenuOpen", "Server.PreventOpening", function() 
    if not LocalPlayer():IsSuperAdmin() then
        return false
    end
end)