local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupGroupQuestPositiveTimeLengthUpgradePrice
upgrade.Name 				 	= "GroupQuestPositiveTimeLength"
upgrade.FirstCoolDownSeconds 	= TW.GroupGroupQuestPositiveTimeLengthUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupGroupQuestPositiveTimeLengthUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupGroupQuestPositiveTimeLengthUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupGroupQuestPositiveTimeLengthUpgradeUpgradedCount
upgrade.Icon 					= "icon16/time_add.png"

TW.GroupUpgradeTemplates.GroupQuestPositiveTimeLength = upgrade