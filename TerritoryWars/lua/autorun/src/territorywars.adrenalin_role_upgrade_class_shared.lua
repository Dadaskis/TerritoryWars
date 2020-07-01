local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/pill_delete.png"
upgrade.Name = "Adrenaline"
upgrade.StartPrice = TW.AdrenalineUpgradePrice
upgrade.Maximum = 1
upgrade.AddUpgradeCount = TW.AdrenalineAddPrice
upgrade.CoolDownSeconds = TW.AdrenalineCoolDown
upgrade.FirstCoolDownSeconds = TW.AdrenalineCoolDown

function upgrade:Apply(player, onSpawn) 
	local SteamID = player:SteamID()
	timer.Remove("TerritoryWars.AdrenalineUpgrade" .. SteamID)
	local role = player:TWGetGroupRole()
	if role and (role.Upgrades["Adrenaline"] or 0) > 0 then
		timer.Create(
			"TerritoryWars.AdrenalineUpgrade" .. SteamID,
			TW.AdrenalineSpeed, 0,
			function()
			if IsValid(player) and player:TWGetGroup() then
				if player:Health() < TW.AdrenalineHealthLimit then
					player:SetHealth(player:Health() + TW.AdrenalineRegenerationPower)
				end					
			end
		end)
	end
end


TW.UpgradeTemplates.Adrenaline = upgrade