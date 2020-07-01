local TW = TerritoryWars

function TW.Member(group, player) 
	local member = {}
	member.Player = player
	member.Nick = player:Nick()
	member.Role = group.NoviceRole
	member.Points = 0
	member.TerritoriesCaptured = 0
	member.Quests = {}
	member.SteamID = player:SteamID()
	return member
end