local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/heart_delete.png"
upgrade.Name = "Tank"
upgrade.Maximum = 1
upgrade.AddUpgradedCount = TW.TankAddPrice
upgrade.StartPrice = TW.TankUpgradePrice
upgrade.CoolDownSeconds = TW.TankCoolDown
upgrade.FirstCoolDownSeconds = TW.TankCoolDown

hook.Add("TerritoryWars.BulletDamageByPlayer", "TerritoryWars.TankUpgrade", function(player, target, damageInfo) 
	local upgradeTier = player:TWGetGroupRole().Upgrades["Tank"]
	if upgradeTier > 0 then
		if player:Health() < TW.TankHealthLimit 
				and player:Armor() < 100 
						+ (TW.ArmorPerTier * player:TWGetGroupRole().Upgrades["Armor"]) then
			timer.Simple(0.05, function()
				player:SetArmor(player:Armor() + (damageInfo:GetDamage() * (TW.TankPower / 100)))
			end)
		end
	end
end)

TW.UpgradeTemplates.Tank = upgrade