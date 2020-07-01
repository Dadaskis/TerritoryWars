local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GroupPointsLabel = {}

function GroupPointsLabel:Init()
	group = TW.Group
	self:SetFont("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.GroupPoints .. ": " .. group.Points)
	self:SizeToContents()
	self.GroupPointsReceived = 0
end

function GroupPointsLabel:Think() 
	if self.GroupPointsReceived < TW.GroupPointsReceived then
		self.GroupPointsReceived = TW.GroupPointsReceived
		net.Start("TerritoryWars.GetGroupPoints")
		net.SendToServer()
		timer.Simple(LocalPlayer():Ping() / 500, function()
			if IsValid(self) then
				self:SetText(TW.Labels.GroupPoints .. ": " .. (TW.GroupPoints or 0))
				self:SizeToContents()
			end
		end)
	end
end

vgui.Register("TerritoryWars.GroupPointsLabel", GroupPointsLabel, "TerritoryWars.LabelBase")