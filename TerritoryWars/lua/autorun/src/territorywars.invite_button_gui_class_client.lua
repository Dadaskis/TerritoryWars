local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local InviteButton = {}

function InviteButton:Init() 
	self.ID = 10
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.Invite)
	self:SetImage("icon16/user_add.png")
end

function InviteButton:DoClick() 
	local frame = vgui.Create("TerritoryWars.WindowBase")
	TWUtil:SetPanelSize(0.4, 0.2, frame)
	frame:Center()
	frame:SetDraggable(false)
	frame:MakePopup()

	local playerToWrite = nil

	local playerChooser = vgui.Create("DComboBox", frame)
	playerChooser:SetValue(TW.Labels.ChoosePlayer)
	for _, ply in pairs(player.GetAll()) do 
		if ply ~= LocalPlayer() then
			playerChooser:AddChoice(ply:Nick(), ply:SteamID())
		end
	end
	playerChooser:Dock(TOP)

	local inviteButton = vgui.Create("TerritoryWars.ButtonBase", frame)
	inviteButton:SetText(TW.Labels.Invite)
	inviteButton:Dock(BOTTOM)

	function playerChooser:OnSelect(_, _, index) 
		playerToWrite = index
	end

	function inviteButton.DoClick() 
		if playerToWrite ~= nil then
			net.Start("TerritoryWars.Invite")
				net.WriteString(playerToWrite)
			net.SendToServer()
		end
	end
end

vgui.Register("TerritoryWars.InviteButton", InviteButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddInviteButton", function(groupWindow) 
	if LocalPlayer():SteamID() == TW.Group.LeaderSteamID 
			or LocalPlayer():TWGetGroupRole().Permisions["Invite"] then
		local invite = vgui.Create("TerritoryWars.InviteButton")
		groupWindow:AddToChoosePanel(invite)
	end
end)