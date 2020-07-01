local TW = TerritoryWars

util.AddNetworkString("TerritoryWars.help")

hook.Add("PlayerSay", "TerritoryWars.HelpCommandHandle", function(player, text) 
	if string.lower(text) == string.lower(TW.Labels.HelpCommand) then
		net.Start("TerritoryWars.help")
		net.Send(player)
	end
end)