local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local BuyTimeButton = {}

AccessorFunc(BuyTimeButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(BuyTimeButton, "ChoosedPanel", "ChoosedPanel")

function BuyTimeButton:Init() 
	group = TW.Group
	self.ID = 20
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.BuyTime)
	self:SetIcon("icon16/clock_add.png")
end

local function TWFormatTime(time) 
	local result = ""
	if time.h < 10 then
		result = result .. "0"
	end
	result = result .. time.h .. ":"
	if time.m < 10 then
		result = result .. "0"
	end
	result = result .. time.m .. ":"
	if time.s < 10 then
		result = result .. "0"
	end
	result = result .. time.s
	return result
end

function BuyTimeButton:DoClick() 
	local frame = vgui.Create("TerritoryWars.WindowBase")
	TWUtil:SetPanelSize(0.5, 0.2, frame)
	frame:Center()
	frame:MakePopup()

	local lifeTime = vgui.Create("TerritoryWars.LabelBase", frame)
	local time = string.FormattedTime(TW.Group.LifeTime - os.time())
	lifeTime:SetText(TWFormatTime(time))
	lifeTime:SetFont("TW.SFont" .. ScrH())
	lifeTime:SizeToContents()
	lifeTime:SetContentAlignment(5)
	lifeTime:Dock(TOP)
	hook.Add("Think", "TerritoryWars.BuyTimeLifeTimeUpdate", function()
		if IsValid(lifeTime) and TW.Group then
			local time = string.FormattedTime(TW.Group.LifeTime - os.time())
			lifeTime:SetText(TWFormatTime(time))
			lifeTime:SizeToContents()
		end
	end)

	local pointsLabel = vgui.Create("TerritoryWars.LabelBase", frame)
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
	
	local description = vgui.Create("TerritoryWars.LabelBase", frame)
	description:SetText(TW.BuyTimeSeconds .. " " .. TW.Labels.Seconds .. ": " .. TW.BuyTimePoints .. " " .. TW.Labels.Points2 .. ".")
	description:SetFont("TW.SFont" .. ScrH())
	description:SizeToContents()
	description:SetContentAlignment(5)
	description:Dock(TOP)

	local buy = vgui.Create("TerritoryWars.ButtonBase", frame)
	buy:SetText(TW.Labels.Buy)
	buy:SetFont("TW.SFont" .. ScrH())
	buy:Dock(TOP)
	function buy:DoClick() 
		net.Start("TerritoryWars.BuyTime")
		net.SendToServer()
	end
end

vgui.Register("TerritoryWars.BuyTimeButton", BuyTimeButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddBuyTimeButton", function(groupWindow) 
	group = TW.Group
	local buyTime = vgui.Create("TerritoryWars.BuyTimeButton")
	groupWindow:AddToChoosePanel(buyTime)
	buyTime:SetChoosePanel(groupWindow:GetChoosePanel())
	buyTime:SetChoosedPanel(groupWindow:GetChoosedPanel())
end)