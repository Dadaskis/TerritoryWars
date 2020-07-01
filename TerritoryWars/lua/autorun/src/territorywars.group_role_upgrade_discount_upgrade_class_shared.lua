local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupRoleUpgradeDiscountUpgradePrice
upgrade.Name 				 	= "RoleUpgradeDiscount"
upgrade.FirstCoolDownSeconds 	= TW.GroupRoleUpgradeDiscountUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupRoleUpgradeDiscountUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupRoleUpgradeDiscountUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupRoleUpgradeDiscountUpgradeUpgradedCount
upgrade.Icon 					= "icon16/coins_delete.png"

TW.GroupUpgradeTemplates.RoleUpgradeDiscount = upgrade