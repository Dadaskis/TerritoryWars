local TW = TerritoryWars
TW.Callbacks = TW.Callbacks or {}

util.AddNetworkString("TerritoryWars.RunCallBack")

net.Receive("TerritoryWars.RunCallback", function(byteLength, player) 
    local functionName = net.ReadString()
    local args = net.ReadTable()
    TW.Callbacks[functionName](args, player)
end) 

function TW:RunCallback(functionName, tbl, player) 
    net.Start("TerritoryWars.RunCallBack")
        net.WriteString(functionName)
        net.WriteTable(tbl)
    if player and IsValid(player) then
        net.Send(player)
    else
        net.Broadcast()
    end
end

