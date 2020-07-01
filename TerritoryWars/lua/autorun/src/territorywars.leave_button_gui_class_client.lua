local TW = TerritoryWars
local leaveButton = {}

function leaveButton:Init() 
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.Leave)
	self:SetIcon("icon16/door_open.png")
	self.ID = 5000
end

function leaveButton:DoClick() 
	local frame = vgui.Create("TerritoryWars.WindowBase")
	frame:SetSize(ScrW() * 0.4, ScrH() * 0.2)
	frame:Center()
	frame:MakePopup()

	local label = vgui.Create("TerritoryWars.LabelBase", frame)
	label:Dock(TOP)
	label:SetContentAlignment(5)
	label:SetFontInternal("TW.SFont" .. ScrH())
	label:SetText(TW.Labels.AcceptOrNotLeave)
	label:SizeToContents()

	local answerPanel = vgui.Create("TerritoryWars.PanelBase", frame)
	answerPanel:Dock(BOTTOM)

	local yesButton = vgui.Create("TerritoryWars.ButtonBase", answerPanel)
	yesButton:SetFontInternal("TW.SFont" .. ScrH())
	yesButton:SetText(TW.Labels.Yes)
	yesButton:Dock(LEFT)
	function yesButton.DoClick() 
		net.Start("TerritoryWars.Leave")
		net.SendToServer()
		self.GroupWindow:Close()
		frame:Close()
	end

	local noButton = vgui.Create("TerritoryWars.ButtonBase", answerPanel)
	noButton:SetFontInternal("TW.SFont" .. ScrH())
	noButton:SetText(TW.Labels.No)
	noButton:Dock(RIGHT)
	function noButton.DoClick() 
		frame:Close()
	end
end

function leaveButton:SetGroupWindow(groupWindow) 
	self.GroupWindow = groupWindow
end

vgui.Register("TerritoryWars.LeaveButton", leaveButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.LeaveButton", function(groupWindow) 
	local leaveButton = vgui.Create("TerritoryWars.LeaveButton")
	leaveButton:SetGroupWindow(groupWindow)
	groupWindow:AddToChoosePanel(leaveButton)
end)