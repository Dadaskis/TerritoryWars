local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GiveSWEPsButton = {}

function GiveSWEPsButton:Init() 
	self.ID = 1000
	self:SetText("SWEPs")
	self:SetFont("TW.SFont" .. ScrH())
	self:SetIcon("icon16/basket_add.png")
	self:SizeToContents()
	self.Sended = false
end

function GiveSWEPsButton:DoClick() 
	if not self.Sended then
		self.Sended = true
		net.Start("TerritoryWars.GiveSWEPs")
		net.SendToServer()
		timer.Simple(1, function() 
			self.Sended = false
		end)
	end
end

vgui.Register("TerritoryWars.GiveSWEPsButton", GiveSWEPsButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddGiveSWEPsButton", function(groupWindow) 
	local giveSWEPsButton = vgui.Create("TerritoryWars.GiveSWEPsButton")
	groupWindow:AddToChoosePanel(giveSWEPsButton)
end)