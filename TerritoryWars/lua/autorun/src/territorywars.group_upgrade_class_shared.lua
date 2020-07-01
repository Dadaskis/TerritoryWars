local TW = TerritoryWars

TW.GroupUpgradeTemplates = {}

function TW.GroupUpgrade() 
	local upgrade = {}
	upgrade.Price = 0
	upgrade.CoolDownSeconds = 0
	upgrade.FirstCoolDownSeconds = 0
	upgrade.Maximum = 0
	upgrade.AddUpgradedCount = 0
	upgrade.Name = "NULL_GROUP_UPGRADE"
	upgrade.Icon = "icon16/add.png"
	return upgrade
end

function TW:UpgradeGroup(group, upgrade) 
	if not TW.GroupGetUpgrade[group.Name] then
		TW.GroupGetUpgrade[group.Name] = {}
	end
	local upgradeName = upgrade.Name
	if group.Upgrades[upgradeName] >= upgrade.Maximum then
		return false
	end
	if TW.GroupUpgradeCoolDown then
		if group.GroupUpgradeCoolDownEnd <= os.time() then
			local coolDownSeconds = 0
			if group.Upgrades[upgradeName] == 0 and not TW.GroupGetUpgrade[group.Name]["GroupUpgrade_" .. upgradeName] then
				coolDownSeconds = upgrade.FirstCoolDownSeconds
			else
				coolDownSeconds = upgrade.CoolDownSeconds
			end
			local price = upgrade.Price * group.UpgradedCount
			if not timer.Exists("TerritoryWars." .. group.Name .. "UpgradeCoolDown") and group.Points >= price then
				group.Points = group.Points - price
				group.GroupUpgradeCoolDownEnd = os.time() + coolDownSeconds
				TW.SendGroupUpgradeData(group)
				timer.Create("TerritoryWars." .. group.Name .. "UpgradeCoolDown", coolDownSeconds, 1, function()
					TW.GroupGetUpgrade[group.Name]["GroupUpgrade_" .. upgradeName] = true
					group.Upgrades[upgradeName] = group.Upgrades[upgradeName] + 1
					group.UpgradedCount = group.UpgradedCount + upgrade.AddUpgradedCount
					TW.SendGroupUpgradeData(group)
				end)
			end
		end
	else
		local price = upgrade.Price * group.UpgradedCount
		if group.Points >= price then
			group.Points = group.Points - price
			group.Upgrades[upgradeName] = group.Upgrades[upgradeName] + 1
			group.UpgradedCount = group.UpgradedCount + upgrade.AddUpgradedCount
			TW.SendGroupUpgradeData(group)
		end
	end
end

--TW.GroupUpgradeTemplates.NULL = TW.GroupUpgrade()