local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupQuestPositiveTimeLengthUpgradePrice
upgrade.Name 				 	= "QuestPositiveTimeLength"
upgrade.FirstCoolDownSeconds 	= TW.GroupQuestPositiveTimeLengthUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupQuestPositiveTimeLengthUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupQuestPositiveTimeLengthUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupQuestPositiveTimeLengthUpgradeUpgradedCount
upgrade.Icon 					= "icon16/time_add.png"

TW.GroupUpgradeTemplates.QuestPositiveTimeLength = upgrade