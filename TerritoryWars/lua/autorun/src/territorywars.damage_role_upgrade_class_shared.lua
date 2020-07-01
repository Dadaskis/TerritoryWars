local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/user_red.png"
upgrade.Name = "Damage"
upgrade.StartPrice = TW.DamageUpgradePrice
upgrade.Maximum = TW.DamageMaximum
upgrade.AddUpgradedCount = TW.DamageAddPrice
upgrade.FirstCoolDownSeconds = TW.DamageFirstCoolDown
upgrade.CoolDownSeconds = TW.DamageCoolDown

hook.Add("TerritoryWars.BulletDamageByPlayer", "TerritoryWars.DamageUpgrade", function(player, target, damageInfo) 
	local tier = player:TWGetGroupRole().Upgrades["Damage"]
	damageInfo:ScaleDamage(1.0 + (tier * (TW.DamagePerTier / 100)))
end)

TW.UpgradeTemplates.Damage = upgrade