local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupRoleUpgradeCooldownDiscountUpgradePrice
upgrade.Name 				 	= "RoleUpgradeCooldownDiscount"
upgrade.FirstCoolDownSeconds 	= TW.GroupRoleUpgradeCooldownDiscountUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupRoleUpgradeCooldownDiscountUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupRoleUpgradeCooldownDiscountUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupRoleUpgradeCooldownDiscountUpgradeUpgradedCount
upgrade.Icon 					= "icon16/time_delete.png"

TW.GroupUpgradeTemplates.RoleUpgradeCooldownDiscount = upgrade