local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/cross.png"
upgrade.Name = "Crits"
upgrade.StartPrice = TW.CritsUpgradePrice
upgrade.AddUpgradedCount = TW.CritsAddPrice
upgrade.Maximum = TW.CritsMaximum
upgrade.CoolDownSeconds = TW.CritsCoolDown
upgrade.FirstCoolDownSeconds = TW.CritsFirstCoolDown

hook.Add("TerritoryWars.BulletDamageByPlayer", "TerritoryWars.CritsUpgrade", function(player, target, damageInfo) 
	local upgradeTier = player:TWGetGroupRole().Upgrades["Crits"]
	if upgradeTier > 0 then
		math.randomseed(RealTime())
		local procent = math.random(0, 100)
		if procent < upgradeTier * TW.CritsPerTier then
			damageInfo:ScaleDamage(TW.CriticalDamage)
		end
	end
end)

TW.UpgradeTemplates.Crits = upgrade