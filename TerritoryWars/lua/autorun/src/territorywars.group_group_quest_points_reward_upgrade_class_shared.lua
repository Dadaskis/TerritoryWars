local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupGroupQuestPointsRewardUpgradePrice
upgrade.Name 				 	= "GroupQuestPointsReward"
upgrade.FirstCoolDownSeconds 	= TW.GroupGroupQuestPointsRewardUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupGroupQuestPointsRewardUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupGroupQuestPointsRewardUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupGroupQuestPointsRewardUpgradeUpgradedCount
upgrade.Icon 					= "icon16/coins_add.png"

TW.GroupUpgradeTemplates.GroupQuestPointsReward = upgrade