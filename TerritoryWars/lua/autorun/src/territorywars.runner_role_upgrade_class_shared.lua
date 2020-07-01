local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/user_go.png"
upgrade.Name = "Runner"
upgrade.StartPrice = TW.RunnerUpgradePrice
upgrade.Maximum = 1
upgrade.AddUpgradedCount = TW.RunnerAddPrice
upgrade.CoolDownSeconds = TW.RunnerCoolDown
upgrade.FirstCoolDownSeconds = TW.RunnerCoolDown

function upgrade:Apply(player, onSpawn) 
	if onSpawn then
		timer.Simple(0.5, function()
			TW:GetPlayerData(player).NormalRunSpeed = player:GetRunSpeed()
			TW:GetPlayerData(player).NormalWalkSpeed = player:GetWalkSpeed()
			TW:GetPlayerData(player).NormalCrouchedSpeed = player:GetCrouchedWalkSpeed()
		end)
	end
end

hook.Add("TerritoryWars.BulletDamagedPlayer", "TerritoryWars.RunnerUpgrade", function(player, attacker, damageInfo) 
	local upgradeTier = player:TWGetGroupRole().Upgrades["Runner"]
	if upgradeTier > 0 and player:Health() < TW.RunnerHealthLimit then
		player:SetRunSpeed(TW:GetPlayerData(player).NormalRunSpeed * (1.0 + (TW.RunnerPower / 100)))
		player:SetWalkSpeed(TW:GetPlayerData(player).NormalWalkSpeed * (1.0 + (TW.RunnerPower / 100)))
		player:SetCrouchedWalkSpeed(TW:GetPlayerData(player).NormalCrouchedSpeed * (1.0 + (TW.RunnerPower / 100)))
		timer.Simple(TW.RunnerTime, function() 
			player:SetRunSpeed(TW:GetPlayerData(player).NormalRunSpeed)
			player:SetWalkSpeed(TW:GetPlayerData(player).NormalWalkSpeed)
			player:SetCrouchedWalkSpeed(TW:GetPlayerData(player).NormalCrouchedSpeed)
		end)
		math.randomseed(RealTime())
		local procent = math.random(0, 100)
		if procent < TW.RunnerDodgeProcent then
			damageInfo:ScaleDamage(0)
		end
	end
end)

TW.UpgradeTemplates.Runner = upgrade