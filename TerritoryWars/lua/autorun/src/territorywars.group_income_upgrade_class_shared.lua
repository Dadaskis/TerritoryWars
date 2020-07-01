local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupIncomeUpgradePrice
upgrade.Name 				 	= "Income"
upgrade.FirstCoolDownSeconds 	= TW.GroupIncomeUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupIncomeUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupIncomeUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupIncomeUpgradeUpgradedCount
upgrade.Icon 					= "icon16/coins_add.png"

TW.GroupUpgradeTemplates.Income = upgrade