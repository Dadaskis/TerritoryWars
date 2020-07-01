local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GivePointsWindow = {}

function GivePointsWindow:Init() 
	group = TW.Group
	TWUtil:SetPanelSize(0.4, 0.23, self)
	self:Center()
	self:MakePopup()

	local playerToGive = nil

	local pointsLabel = vgui.Create("TerritoryWars.LabelBase", self)
	pointsLabel:SetFontInternal("TW.SFont" .. ScrH())
	pointsLabel:SetContentAlignment(5)
	pointsLabel:SetText(TW.Labels.Points .. ": " .. 0)
	pointsLabel:SizeToContents()
	local lastPointsReceived = 0
	function pointsLabel:Think() 
		if lastPointsReceived < TW.PointsReceived then
			lastPointsReceived = TW.PointsReceived
			pointsLabel:SetText(TW.Labels.Points .. ": " .. TW.Points)
			pointsLabel:SizeToContents()
			pointsLabel:SetContentAlignment(5)
		end
	end
	pointsLabel:Dock(TOP)

	local playerChooser = vgui.Create("DComboBox", self)
	playerChooser:SetFont("TW.SFont" .. ScrH())
	playerChooser:SetColor(TW.TextColor)
	playerChooser:SetValue(TW.Labels.ChoosePlayer)
	for SteamID, member in pairs(group.Members) do 
		playerChooser:AddChoice(member.Nick, SteamID)
	end
	playerChooser:Dock(TOP)

	local giveButton = vgui.Create("TerritoryWars.ButtonBase", self)
	giveButton:SetText(TW.Labels.Give)
	giveButton:Dock(BOTTOM)

	local textInput = vgui.Create("DTextEntry", self)
	textInput:SetFont("TW.SFont" .. ScrH())
	textInput:SetText("0")
	textInput:Dock(BOTTOM)

	function playerChooser:OnSelect(_, _, value) 
		playerToGive = value
	end

	function giveButton.DoClick() 
		local count = tonumber(textInput:GetText())
		if count == nil then
			count = 0
		end
		if count and playerToGive then
			net.Start("TerritoryWars.GivePointsToPlayerFromGroup")
				net.WriteString(playerToGive)
				net.WriteInt(count, 32)
			net.SendToServer()
		end
	end
end

vgui.Register("TerritoryWars.GivePointsWindow", GivePointsWindow, "TerritoryWars.WindowBase")