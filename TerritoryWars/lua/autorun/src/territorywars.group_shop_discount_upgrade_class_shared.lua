local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupShopDiscountUpgradePrice
upgrade.Name 				 	= "ShopDiscount"
upgrade.FirstCoolDownSeconds 	= TW.GroupShopDiscountUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupShopDiscountUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupShopDiscountUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupShopDiscountUpgradeUpgradedCount
upgrade.Icon 					= "icon16/coins_delete.png"

TW.GroupUpgradeTemplates.ShopDiscount = upgrade