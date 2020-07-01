local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local VoteButton = {}

AccessorFunc(VoteButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(VoteButton, "ChoosedPanel", "ChoosedPanel")

function VoteButton:Init() 
	group = TW.Group
	self.ID = 100
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.Vote)
	self:SetIcon("icon16/star.png")
end

function VoteButton:DoClick() 
	local frame = vgui.Create("TerritoryWars.WindowBase")
	TWUtil:SetPanelSize(0.4, 0.2, frame)
	frame:Center()
	frame:SetDraggable(false)
	frame:MakePopup()

	local playerToWrite = nil

	local playerChooser = vgui.Create("DComboBox", frame)
	playerChooser:SetValue(TW.Labels.ChoosePlayer)
	for SteamID, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			playerChooser:AddChoice(member.Nick, SteamID)
		end
	end
	playerChooser:Dock(TOP)

	local vote2Button = vgui.Create("TerritoryWars.ButtonBase", frame)
	vote2Button:SetText(TW.Labels.Vote)
	vote2Button:Dock(BOTTOM)

	function playerChooser:OnSelect(_, _, value) 
		playerToWrite = value
	end

	function vote2Button.DoClick() 
		net.Start("TerritoryWars.Vote")
			net.WriteString(playerToWrite)
		net.SendToServer()
		frame:Close()
		TW.Voted = true
		self:Remove()
	end
end

vgui.Register("TerritoryWars.VoteButton", VoteButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddVoteButton", function(groupWindow) 
	group = TW.Group
	if group and TW.VoteTime and not TW.Voted then
		local vote = vgui.Create("TerritoryWars.VoteButton")
		groupWindow:AddToChoosePanel(vote)
		vote:SetChoosePanel(groupWindow:GetChoosePanel())
		vote:SetChoosedPanel(groupWindow:GetChoosedPanel())
	end
end)