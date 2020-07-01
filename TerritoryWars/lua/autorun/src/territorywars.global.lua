local TW = TerritoryWars

TW.TerritoriesMinX = 0
TW.TerritoriesMaxX = 0
TW.TerritoriesMinZ = 0
TW.TerritoriesMaxZ = 0

TW.PlayerData = TW.PlayerData or {}
function TW:GetPlayerData(player)
	if not self.PlayerData then
		self.PlayerData = {}
	end
	if not self.PlayerData[player:SteamID()] then
		self.PlayerData[player:SteamID()] = {}
	end
	return self.PlayerData[player:SteamID()]
end
