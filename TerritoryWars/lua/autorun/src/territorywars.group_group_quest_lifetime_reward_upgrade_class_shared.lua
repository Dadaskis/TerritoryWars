local TW = TerritoryWars

local upgrade 				 	= TW.GroupUpgrade()
upgrade.Price 				 	= TW.GroupGroupQuestLifeTimeRewardUpgradePrice
upgrade.Name 				 	= "GroupQuestLifeTimeReward"
upgrade.FirstCoolDownSeconds 	= TW.GroupGroupQuestLifeTimeRewardUpgradeFirstCoolDown
upgrade.CoolDownSeconds 	 	= TW.GroupGroupQuestLifeTimeRewardUpgradeCoolDown
upgrade.Maximum				 	= TW.GroupGroupQuestLifeTimeRewardUpgradeMaximum
upgrade.AddUpgradedCount 	 	= TW.GroupGroupQuestLifeTimeRewardUpgradeUpgradedCount
upgrade.Icon 					= "icon16/time_add.png"

TW.GroupUpgradeTemplates.GroupQuestLifeTimeReward = upgrade