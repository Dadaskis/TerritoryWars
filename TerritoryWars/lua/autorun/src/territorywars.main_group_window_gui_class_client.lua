local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local GroupWindow = {}

function GroupWindow:AddToChoosePanel(panel) 
	if TW.MainWindowFromTablet and panel.NotInTablet then
		panel:Remove()
		return
	end
	local ID = panel.ID
	while self.ToAdd[ID] do 
		ID = ID + 1
	end
	
	self.ToAdd[ID] = panel
end

function GroupWindow:Init() 
	group = TW.Group
	self.ToAdd = {}
	self:SetTitle("")
	self.TWNextTime = RealTime()

	self.ChoosePanel = vgui.Create("TerritoryWars.ScrollPanelBase", self)
	self.ChoosedPanel = vgui.Create("TerritoryWars.PanelBase", self)

	TWUtil:SetPanelSize(0.7, 0.82, self)

	TWUtil:SetPanelSize(0.2, 0.77, self.ChoosePanel)
	TWUtil:SetPanelSize(0.499, 0.77, self.ChoosedPanel)

	TWUtil:SetPanelPos(0.0, 0.05, self.ChoosePanel)
	TWUtil:SetPanelPos(0.201, 0.05, self.ChoosedPanel)

	hook.Run("TerritoryWars.MainGroupWindowOpened", self)

	for _, panel in SortedPairs(self.ToAdd) do
		panel:SetParent(self.ChoosePanel)
		panel:Dock(TOP)
		panel:DockMargin(ScrW() * 0.004, ScrH() * 0.004, ScrW() * 0.004, ScrH() * 0.004)
		panel:InvalidateParent()
		local X, Y = panel:GetSize()
		panel:SetSize(X, ScrH() * 0.035)
	end

	self:MakePopup()
	self:Center()
end

function GroupWindow:GetChoosePanel()
	return self.ChoosePanel:GetCanvas()
end

function GroupWindow:GetChoosedPanel() 
	return self.ChoosedPanel
end

function GroupWindow:OnClose() 
	net.Start("TerritoryWars.OutFromMainGroupWindow")
	net.SendToServer()
	TW.MainWindowFromTablet = false	
	self:Remove()
end

vgui.Register("TerritoryWars.GroupWindow", GroupWindow, "TerritoryWars.WindowBase")