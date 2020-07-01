local TW = TerritoryWars

net.Receive("TerritoryWars.OpenTerritoryRetainerWindow", function() 
	local isEnabled = net.ReadBool()
	local index = net.ReadInt(32)
	local frame = vgui.Create("TerritoryWars.WindowBase")
	frame:SetTitle(TW.Labels.TerritoryRetainer)
	frame:SetSize(ScrW() * 0.3, ScrH() * 0.15)
	frame:Center()
	frame:MakePopup()

	function frame:OnClose() 
		net.Start("TerritoryWars.OutFromTerritoryRetainerWindow")
		net.SendToServer()
	end

	local button = vgui.Create("TerritoryWars.ButtonBase", frame)
	if not isEnabled then
		button:SetText(TW.Labels.Enable)
	else
		button:SetText(TW.Labels.Disable)
	end

	function button:DoClick() 
		isEnabled = not isEnabled
		if not isEnabled then
			button:SetText(TW.Labels.Enable)
		else
			button:SetText(TW.Labels.Disable)
		end
		net.Start("TerritoryWars.SwitchTerritoryRetainerMode")
			net.WriteInt(index, 32)
		net.SendToServer()
	end

	button:Dock(FILL)
end)