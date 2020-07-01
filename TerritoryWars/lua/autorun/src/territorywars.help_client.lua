local TW = TerritoryWars

net.Receive("TerritoryWars.help", function() 
	chat.AddText(
		Color(205, 177, 31),
		TW.Labels.HelpHeader,
		"\n",
		Color(255, 50, 50),
		TW.Labels.CaptureCommand,
		Color(255, 255, 255),
		" - ",
		TW.Labels.CaptureCommandHelpDescription,
		"\n"
	)
end)