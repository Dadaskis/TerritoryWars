local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/shield.png"
upgrade.Name = "Armorer"
upgrade.StartPrice = TW.ArmorerUpgradePrice
upgrade.Maximum = 1
upgrade.AddUpgradedCount = TW.ArmorerAddPrice
upgrade.FirstCoolDownSeconds = TW.ArmorerCoolDown
upgrade.CoolDownSeconds = TW.ArmorerCoolDown

function upgrade:Apply(player, onSpawn) 
	local SteamID = player:SteamID()
	timer.Remove("TerritoryWars.ArmorerUpgrade" .. SteamID) 
	local role = player:TWGetGroupRole()
	if role.Upgrades["Armorer"] > 0 then
		timer.Create("TerritoryWars.ArmorerUpgrade" .. SteamID, TW.ArmorerDelay, 0,
		function() 
			if IsValid(player) and player:TWGetGroup() then
				local group = player:TWGetGroup()
				if player:GetVelocity() == Vector(0, 0, 0) then
					for _, member in pairs(group.Members) do 
						local player2 = member.Player
						if IsValid(player2) then
							if player2:GetVelocity() == Vector(0, 0, 0) then
								if player:GetPos():Distance(player2:GetPos()) <= TW.ArmorerDistance then
									if player2:Armor() < 100 + 
										  TW.ArmorPerTier * player2:TWGetGroupRole().Upgrades["Armor"] then
										player2:SetArmor(player2:Armor() + TW.ArmorerPower)
									end
								end
							end
						end
					end
				end
			else
				timer.Remove("TerritoryWars.ArmorerUpgrade" .. SteamID)
				return
			end
		end)
	end
end


TW.UpgradeTemplates.Armorer = upgrade