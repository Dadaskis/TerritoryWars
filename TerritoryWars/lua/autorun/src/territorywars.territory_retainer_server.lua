local TW = TerritoryWars

util.AddNetworkString("TerritoryWars.OpenTerritoryRetainerWindow")
util.AddNetworkString("TerritoryWars.SwitchTerritoryRetainerMode")

TW.TerritoryRetainers = {}

net.Receive("TerritoryWars.SwitchTerritoryRetainerMode", function(byteLength, player)
	local index = net.ReadInt(32)
	local retainer = TW.TerritoryRetainers[index]
	retainer.TWActivated = not retainer.TWActivated
	retainer:GetPhysicsObject():EnableMotion(not retainer.TWActivated)
end)