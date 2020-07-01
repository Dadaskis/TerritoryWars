local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/heart_add.png"
upgrade.Name = "Health"
upgrade.StartPrice = TW.HealthUpgradePrice
upgrade.Maximum = TW.HealthMaximum
upgrade.AddUpgradedCount = TW.HealthAddPrice
upgrade.CoolDownSeconds = TW.HealthCoolDown
upgrade.FirstCoolDownSeconds = TW.HealthFirstCoolDown

function upgrade:Apply(player, onSpawn) 
	local role = player:TWGetGroupRole()
	if onSpawn then
		timer.Simple(0.05, function()
			player:SetHealth(player:Health() + (TW.HealthPerTier * role.Upgrades["Health"]))
		end)
	end
end

TW.UpgradeTemplates.Health = upgrade