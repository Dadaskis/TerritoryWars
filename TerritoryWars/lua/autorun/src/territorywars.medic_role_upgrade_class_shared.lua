local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/heart.png"
upgrade.Name = "Medic"
upgrade.StartPrice = TW.MedicUpgradePrice
upgrade.Maximum = 1
upgrade.AddUpgradedCount = TW.MedicAddPrice
upgrade.CoolDownSeconds = TW.MedicCoolDown
upgrade.FirstCoolDownSeconds = TW.MedicCoolDown

function upgrade:Apply(player, onSpawn) 
	local SteamID = player:SteamID()
	timer.Remove("TerritoryWars.MedicUpgrade" .. SteamID)
	local role = player:TWGetGroupRole()
	if role.Upgrades["Medic"] > 0 then
		timer.Create("TerritoryWars.MedicUpgrade" .. SteamID, TW.MedicDelay, 0,
		function() 
			if IsValid(player) and player:TWGetGroup() then
				if player:GetVelocity() == Vector(0, 0, 0) then
					for _, member in pairs(player:TWGetGroup().Members) do 
						local player2 = member.Player
						if IsValid(player2) then
							if player2:GetVelocity() == Vector(0, 0, 0) then
								if player:GetPos():Distance(player2:GetPos()) <= TW.MedicDistance then
									if player2:Health() < player2:GetMaxHealth() + 
										    10 * player2:TWGetGroupRole().Upgrades["Health"] then
										player2:SetHealth(player2:Health() + TW.MedicPower)
									end
								end
							end
						end
					end
				end
			else
				timer.Remove("TerritoryWars.MedicUpgrade" .. SteamID)
				return
			end
		end)
	end
end

TW.UpgradeTemplates.Medic = upgrade