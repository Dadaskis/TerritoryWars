local TW = TerritoryWars

local BonusPanel = {}

function BonusPanel:SetBonus(bonus) 
	self.Bonus = bonus

	self.DescriptionLabel:SetText(TW.Labels.BonusText.Income(bonus))
	self.DescriptionLabel:SizeToContents()

	function self.SettingsButton.DoClick() 
		local window = vgui.Create("TerritoryWars.WindowBase")
		window:SetSize(ScrW() * 0.4, ScrH() * 0.4)
		window:MakePopup()
		window:Center()

		local scrollPanel = vgui.Create("TerritoryWars.ScrollPanelBase", window)
		scrollPanel.Inputs = {}
		scrollPanel:Dock(FILL)
		scrollPanel:GetCanvas():Dock(FILL)

		for key, value in pairs(self.Bonus.Properties) do 
			local panel = vgui.Create("TerritoryWars.PanelBase", scrollPanel:GetCanvas())
			panel:Dock(TOP)
			panel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)

			local name = vgui.Create("TerritoryWars.LabelBase", panel)
			name:SetFont("TW.SFont" .. ScrH())
			name:SetText((TW.Labels[key] or key) .. ": ")
			name:SizeToContents()
			name:Dock(LEFT)
			name:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)

			local valueInput = vgui.Create("DTextEntry", panel)
			valueInput:SetFont("TW.SFont" .. ScrH())
			valueInput:SetText(tostring(value))
			valueInput:Dock(LEFT)
			valueInput:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)

			scrollPanel.Inputs[key] = valueInput
		end

		local apply = vgui.Create("TerritoryWars.ButtonBase", window)
		apply:SetFontInternal("TW.SFont" .. ScrH())
		apply:SetText(TW.Labels.Apply)
		apply:Dock(BOTTOM)
		function apply.DoClick() 
			for key, input in pairs(scrollPanel.Inputs) do 
				self.Bonus.Properties[key] = tonumber(scrollPanel.Inputs[key]:GetText()) or 0
			end
			self.DescriptionLabel:SetText(TW.Labels.BonusText.Income(bonus))
			self.DescriptionLabel:SizeToContents()
			window:Close()
		end
	end
end

vgui.Register("TerritoryWars.TerritoryBonusIncomePanel", BonusPanel, "TerritoryWars.TerritoryBonusPanelBase")