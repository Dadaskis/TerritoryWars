local TW = TerritoryWars

local BonusWindow = {}

function BonusWindow:SetBonuses(bonuses) 
	self.BonusPanel:GetCanvas():Clear()
	self.Bonuses = bonuses

	local applyButton = vgui.Create("TerritoryWars.ButtonBase", self)
	applyButton:SetFontInternal("TW.SFont" .. ScrH())
	applyButton:SetText(TW.Labels.Apply)
	applyButton:Dock(BOTTOM)
	applyButton:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
	function applyButton.DoClick() 
		self:OnApply()
		self:Close()
	end
	
	local addButton = vgui.Create("TerritoryWars.ButtonBase", self)
	addButton:SetFontInternal("TW.SFont" .. ScrH())
	addButton:SetText(TW.Labels.Add)
	addButton:Dock(BOTTOM)
	addButton:DockMargin(ScrW() * 0.01, ScrH() * 0.01, ScrW() * 0.01, ScrH() * 0.01)
	function addButton.DoClick() 
		local menu = DermaMenu()
		for key, bonus in pairs(TW.TerritoryBonuses) do 
			local choice = menu:AddOption(TW.Labels.Bonuses[key])
			function choice.DoClick() 
				local bonusPanel = vgui.Create("TerritoryWars.TerritoryBonus" .. key .. "Panel", self.BonusPanel)
				local bonus = bonus()
				table.Add(bonuses, { bonus })
				bonusPanel:SetBonus(bonus)
				bonusPanel:Dock(TOP)
				bonusPanel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
			end
		end
		menu:Open()
	end

	for key, bonus in pairs(self.Bonuses) do 
		if not bonus.Deleted then
			PrintTable(self.Bonuses)
			local bonusPanel = vgui.Create("TerritoryWars.TerritoryBonus" .. bonus.Name .. "Panel", self.BonusPanel)
			bonusPanel:SetBonus(bonus)
			bonusPanel:Dock(TOP)
			bonusPanel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
		else
			self.Bonuses[key] = nil
		end
	end
end

function BonusWindow:GetBonuses()
	return self.Bonuses
end

function BonusWindow:OnApply() end

function BonusWindow:Init() 
	self:SetSize(ScrW() * 0.5, ScrH() * 0.8)
	self:Center()
	self:MakePopup()

	self.BonusPanel = vgui.Create("TerritoryWars.ScrollPanelBase", self)
	self.BonusPanel:Dock(FILL)
	self.BonusPanel:GetCanvas():Dock(FILL)
end

vgui.Register("TerritoryWars.TerritoryBonusesWindow", BonusWindow, "TerritoryWars.WindowBase")