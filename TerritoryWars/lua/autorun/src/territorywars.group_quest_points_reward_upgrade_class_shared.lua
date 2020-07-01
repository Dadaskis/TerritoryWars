local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupQuestPointsRewardUpgradePrice
upgrade.Name 				 	= "QuestPointsReward"
upgrade.FirstCoolDownSeconds 	= TW.GroupQuestPointsRewardUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupQuestPointsRewardUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupQuestPointsRewardUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupQuestPointsRewardUpgradeUpgradedCount
upgrade.Icon 					= "icon16/coins_add.png"

TW.GroupUpgradeTemplates.QuestPointsReward = upgrade