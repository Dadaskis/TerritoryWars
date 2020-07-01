local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupGroupQuestNegativeTimeLengthUpgradePrice
upgrade.Name 				 	= "GroupQuestNegativeTimeLength"
upgrade.FirstCoolDownSeconds 	= TW.GroupGroupQuestNegativeTimeLengthUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupGroupQuestNegativeTimeLengthUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupGroupQuestNegativeTimeLengthUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupGroupQuestNegativeTimeLengthUpgradeUpgradedCount
upgrade.Icon 					= "icon16/time_delete.png"

TW.GroupUpgradeTemplates.GroupQuestNegativeTimeLength = upgrade