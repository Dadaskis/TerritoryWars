local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/pill_add.png"
upgrade.Name = "Regeneration"
upgrade.StartPrice = TW.RegenerationUpgradePrice
upgrade.Maximum = TW.RegenerationMaximum
upgrade.AddUpgradedCount = TW.RegenerationAddPrice
upgrade.CoolDownSeconds = TW.RegenerationCoolDown
upgrade.FirstCoolDownSeconds = TW.RegenerationFirstCoolDown

function upgrade:Apply(player, onSpawn) 
	local SteamID = player:SteamID()
	timer.Remove("TerritoryWars.RegenerationUpgrade" .. SteamID)
	local role = player:TWGetGroupRole()
	if role.Upgrades["Regeneration"] > 0 then
		timer.Create(
			"TerritoryWars.RegenerationUpgrade" .. SteamID,
			TW.RegenerationSpeedPerTier / role.Upgrades["Regeneration"], 0,
			function()
			if IsValid(player) and player:TWGetGroup() then
				if player:Health() < player:GetMaxHealth() + 
							TW.HealthPerTier * player:TWGetGroupRole().Upgrades["Health"] then
					player:SetHealth(player:Health() + TW.RegenerationPower)
				end
			else
				timer.Remove("TerritoryWars.RegenerationUpgrade" .. SteamID)
			end
		end)
	end
end


TW.UpgradeTemplates.Regeneration = upgrade