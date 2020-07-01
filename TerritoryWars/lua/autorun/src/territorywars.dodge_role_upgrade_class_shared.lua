local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/user_gray.png"
upgrade.Name = "Dodge"
upgrade.StartPrice = TW.DodgeUpgradePrice
upgrade.Maximum = TW.DodgeMaximum
upgrade.CoolDownSeconds = TW.DodgeCoolDown
upgrade.FirstCoolDownSeconds = TW.DodgeFirstCoolDown

hook.Add("TerritoryWars.BulletDamagedPlayer", "TerritoryWars.DodgeUpgrade", function(player, attacker, damageInfo) 
	local upgradeTier = player:TWGetGroupRole().Upgrades["Dodge"]
	math.randomseed(RealTime())
	local procent = math.random(0, 100)
	if procent < upgradeTier * TW.DodgePerTier then
		damageInfo:ScaleDamage(0)
	end
end)

TW.UpgradeTemplates.Dodge = upgrade