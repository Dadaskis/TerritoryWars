local TW = TerritoryWars

local BonusPanel = {}

function BonusPanel:SetBonus(bonus) 
	self.Bonus = bonus

	self.DescriptionLabel:SetText(TW.Labels.BonusText.ShopUnlock(bonus))
	self.DescriptionLabel:SizeToContents()

	function self.SettingsButton.DoClick() 
		local menu = DermaMenu()

		for index, shopEntity in pairs(TW.Shop.ShopList) do 
			if isnumber(shopEntity) then
				continue
			end
			if not shopEntity.AlwaysUnlocked then
				local bonusChoice = menu:AddOption(shopEntity.Name)
				function bonusChoice.DoClick() 
					self.Bonus.Properties.Item = index
					self.DescriptionLabel:SetText(TW.Labels.BonusText.ShopUnlock(bonus))
					self.DescriptionLabel:SizeToContents()
				end
			end
		end

		menu:Open()
	end
end

vgui.Register("TerritoryWars.TerritoryBonusShopUnlockPanel", BonusPanel, "TerritoryWars.TerritoryBonusPanelBase") 