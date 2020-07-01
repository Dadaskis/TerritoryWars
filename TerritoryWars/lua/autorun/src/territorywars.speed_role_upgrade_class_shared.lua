local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/lightning_go.png"
upgrade.Name = "Speed"
upgrade.StartPrice = TW.SpeedUpgradePrice
upgrade.Maximum = TW.SpeedMaximum
upgrade.AddUpgradedPrice = TW.SpeedAddPrice
upgrade.CoolDownSeconds = TW.SpeedCoolDown
upgrade.FirstCoolDownSeconds = TW.SpeedFirstCoolDown

function upgrade:Apply(player, onSpawn) 
	local role = player:TWGetGroupRole()
	local tier = role.Upgrades["Speed"]
	if tier > 0 and onSpawn then
		timer.Simple(0.05, function()
			player:SetRunSpeed(player:GetRunSpeed() + 
				(player:GetRunSpeed() * (tier * (TW.SpeedPerTier / 100))))
			player:SetWalkSpeed(player:GetWalkSpeed() + 
				(player:GetWalkSpeed() * (tier * ((TW.SpeedPerTier / 100) * 0.6))))
			player:SetCrouchedWalkSpeed(player:GetCrouchedWalkSpeed() + 
				(player:GetCrouchedWalkSpeed() * (tier * ((TW.SpeedPerTier / 100) * 0.3))))
		end)
	end
end

TW.UpgradeTemplates.Speed = upgrade