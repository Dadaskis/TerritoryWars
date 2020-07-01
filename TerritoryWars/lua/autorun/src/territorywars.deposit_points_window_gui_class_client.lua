local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local DepositPointsWindow = {}

function DepositPointsWindow:Init() 
	group = TW.Group
	TWUtil:SetPanelSize(0.4, 0.25, self)
	self:Center()
	self:MakePopup()

	if LocalPlayer():SteamID() == TW.Group.LeaderSteamID 
			or LocalPlayer():TWGetGroupRole().Permisions["Group points managing"] then
		local groupPoints = vgui.Create("TerritoryWars.GroupPointsLabel", self)
		groupPoints:Dock(TOP)
		groupPoints:SetContentAlignment(5)
	end

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

	local depositButton = vgui.Create("TerritoryWars.ButtonBase", self)
	depositButton:SetText(TW.Labels.Deposit)
	depositButton:Dock(BOTTOM)

	local textInput = vgui.Create("DTextEntry", self)
	textInput:SetFont("TW.SFont" .. ScrH())
	textInput:SetText("0")
	textInput:Dock(BOTTOM)

	function depositButton.DoClick() 
		local count = tonumber(textInput:GetText())
		if count == nil then
			count = 0
		end
		if count then
			net.Start("TerritoryWars.DepositGroupPoints")
				net.WriteInt(count, 32)
			net.SendToServer()
		end
	end
end

vgui.Register("TerritoryWars.DepositPointsWindow", DepositPointsWindow, "TerritoryWars.WindowBase")