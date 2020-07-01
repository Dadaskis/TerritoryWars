local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupQuestNegativeTimeLengthUpgradePrice
upgrade.Name 				 	= "QuestNegativeTimeLength"
upgrade.FirstCoolDownSeconds 	= TW.GroupQuestNegativeTimeLengthUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupQuestNegativeTimeLengthUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupQuestNegativeTimeLengthUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupQuestNegativeTimeLengthUpgradeUpgradedCount
upgrade.Icon 					= "icon16/time_delete.png"

TW.GroupUpgradeTemplates.QuestNegativeTimeLength = upgrade