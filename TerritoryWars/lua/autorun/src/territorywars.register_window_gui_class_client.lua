local TW = TerritoryWars
local TWUtil = TW.Utilities

local RegisterWindow = {}

function RegisterWindow:Init() 
	self:SetTitle(string.upper(TW.Labels.GroupRegisterWindowTitle))
	TWUtil:SetPanelSize(0.5, 0.4, self)
	self:Center()
	self:MakePopup()

	local panel = vgui.Create("TerritoryWars.PanelBase", self)
	panel:Dock(TOP)

	local label = vgui.Create("TerritoryWars.LabelBase", panel)
	label:SetFontInternal("TW.SFont" .. ScrH())
	label:SetText(TW.Labels.GroupName)
	label:SizeToContents()
	label:Dock(LEFT)

	local inputText = vgui.Create("DTextEntry", panel)
	inputText:SetFont("TW.SFont" .. ScrH())
	TWUtil:SetPanelSize(0.23, 0.05, inputText)
	inputText:Dock(FILL)

	local warning = vgui.Create("TerritoryWars.LabelBase", self)
	warning:SetFont("TW.SFont" .. ScrH())
	warning:SetContentAlignment(5)
	warning:Dock(TOP)
	warning:SetText(TW.Labels.Warning)
	warning:SizeToContents()

	local guide = vgui.Create("TerritoryWars.ButtonBase", self) 
	guide:SetFont("TW.SFont" .. ScrH())
	guide:Dock(TOP)
	guide:SetText(TW.Labels.GuideButton)
	guide:SetIcon("icon16/book_addresses.png")
	function guide.DoClick() 
		local frame = vgui.Create("TerritoryWars.WindowBase")
		frame:SetSize(ScrW() * 0.7, ScrH() * 0.7)
		frame:Center()
		frame:MakePopup()

		local descriptionLabel = vgui.Create("DTextEntry", frame)
		descriptionLabel:SetKeyBoardInputEnabled(false)
		descriptionLabel:SetMultiline(true)
		descriptionLabel:SetVerticalScrollbarEnabled(true)
		descriptionLabel:SetTextColor(TW.TextColor)
		descriptionLabel:SetDrawBackground(false)
		descriptionLabel:SetFont("TW.SFont" .. ScrH())
		descriptionLabel:SetText(TW.Labels.Guide)
		descriptionLabel:Dock(FILL)
	end

	local button = vgui.Create("TerritoryWars.ButtonBase", self)
	button:SetFontInternal("TW.SFont" .. ScrH())
	button:SetText(TW.Labels.CreateGroup)
	button:Dock(BOTTOM)

	local colorButton = vgui.Create("TerritoryWars.ColorChooserOpenWindowButton", self)
	colorButton:SetText(TW.Labels.GroupColor)
	colorButton:Dock(BOTTOM)

	function button.DoClick() 
		net.Start("TerritoryWars.GroupRegisterRequest")
			net.WriteString(inputText:GetText())
			net.WriteTable(colorButton:GetChoosedColor())
		net.SendToServer()
		self:Close()
	end
end

function RegisterWindow:OnScreenSizeChanged() 
	self:Close()
end

function RegisterWindow:OnClose() 
	net.Start("TerritoryWars.OutFromGroupRegisterWindow")
	net.SendToServer()
end

vgui.Register("TerritoryWars.RegisterWindow", RegisterWindow, "TerritoryWars.WindowBase")