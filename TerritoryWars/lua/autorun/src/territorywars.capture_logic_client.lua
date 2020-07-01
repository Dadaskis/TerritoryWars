local TW = TerritoryWars

net.Receive("TerritoryWars.Capturing", function() 
	local X = net.ReadInt(32)
	local Z = net.ReadInt(32)
	chat.AddText(Color(255, 255, 255), TW.Labels.Capturing .. " " .. TW.Labels.TerritoryAt .. " " .. X .. " " .. Z .. ".")
end)

net.Receive("TerritoryWars.CaptureDone", function() 
	local X = net.ReadInt(32)
	local Z = net.ReadInt(32)
	chat.AddText(Color(255, 255, 255), TW.Labels.Capture2 .. " " .. TW.Labels.TerritoryAt2 .. " " .. X .. " " .. Z .. " " .. TW.Labels.IsOver .. ".")
end)

net.Receive("TerritoryWars.YouAreNotInGroup", function() 
	chat.AddText(Color(255, 0, 0), TW.Labels.YouAreNotInGroup)
end)

net.Receive("TerritoryWars.SendTerritories", function() 
	TW.Territories = net.ReadTable()
	TW.TerritoriesMinX = net.ReadInt(32)
	TW.TerritoriesMaxX = net.ReadInt(32)
	TW.TerritoriesMinZ = net.ReadInt(32)
	TW.TerritoriesMaxZ = net.ReadInt(32)
end)

net.Receive("TerritoryWars.SetTerritory", function() 
	local X, Y = net.ReadInt(32), net.ReadInt(32)
	if not TW.Territories[X] then
		TW.Territories[X] = {}
	end
	TW.Territories[X][Y] = net.ReadTable()
end)