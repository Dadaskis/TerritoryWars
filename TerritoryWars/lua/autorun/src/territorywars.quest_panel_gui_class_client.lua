local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local QuestPanel = {}

AccessorFunc(QuestPanel, "ChoosePanel", "ChoosePanel")
AccessorFunc(QuestPanel, "ChoosedPanel", "ChoosedPanel")

QuestPanel.LastQuestsReceived = 0
function QuestPanel:Think() 
	if self.LastQuestsReceived < TW.QuestsReceived then
		self.LastQuestsReceived = TW.QuestsReceived
		self.AvailableQuests:GetCanvas():Clear()
		self.ActiveQuests:GetCanvas():Clear()
		hook.Run("TerritoryWars.QuestPanelOpened", 
			self.AvailableQuests:GetCanvas(), self.ActiveQuests:GetCanvas(), self.QuestChoosedPanel)
	end
end

function QuestPanel:SetChoosedPanel(choosedPanel) 
	self.ChoosedPanel = choosedPanel
	self.QuestChoosePanel = vgui.Create("TerritoryWars.PanelBase", self.ChoosedPanel)
	self.QuestChoosedPanel = vgui.Create("TerritoryWars.PanelBase", self.ChoosedPanel)

	self.QuestChoosePanel:Dock(LEFT)
	self.QuestChoosedPanel:Dock(FILL)

	self.QuestChoosePanel:InvalidateLayout()
	local X, Y = self.QuestChoosePanel:GetSize()
	self.QuestChoosePanel:SetSize(ScrW() * 0.15, Y)

	function self.QuestChoosePanel:Paint(width, height) 
		draw.RoundedBox(0, 0, 0, width, height, Color(28, 28, 28))
	end

	self.AvailableLabel = vgui.Create("TerritoryWars.LabelBase", self.QuestChoosePanel)
	self.AvailableLabel:SetFontInternal("TW.SFont" .. ScrH())
	self.AvailableLabel:SetText(TW.Labels.AvailableQuests)
	self.AvailableLabel:SizeToContents()
	self.AvailableLabel:Dock(TOP)
	self.AvailableQuests = vgui.Create("TerritoryWars.ScrollPanelBase", self.QuestChoosePanel)
	self.AvailableQuests:Dock(TOP)
	self.AvailableQuests:InvalidateLayout()
	local X, Y = self.AvailableQuests:GetSize()
	self.AvailableQuests:SetSize(X, ScrH() * 0.35)
	
	self.ActiveLabel = vgui.Create("TerritoryWars.LabelBase", self.QuestChoosePanel)
	self.ActiveLabel:SetFontInternal("TW.SFont" .. ScrH())
	self.ActiveLabel:SetText(TW.Labels.ActiveQuests)
	self.ActiveLabel:SizeToContents()
	self.ActiveLabel:Dock(TOP)
	self.ActiveQuests = vgui.Create("TerritoryWars.ScrollPanelBase", self.QuestChoosePanel)
	self.ActiveQuests:Dock(TOP)
	self.ActiveQuests:InvalidateLayout()
	local X, Y = self.ActiveQuests:GetSize()
	self.ActiveQuests:SetSize(X, ScrH() * 0.35)
end

vgui.Register("TerritoryWars.QuestPanel", QuestPanel, "TerritoryWars.PanelBase")

