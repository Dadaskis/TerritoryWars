local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/shield_add.png"
upgrade.Name = "Armor"
upgrade.StartPrice = TW.ArmorUpgradePrice
upgrade.AddUpgradedCount = TW.ArmorAddPrice
upgrade.Maximum = TW.ArmorMaximum
upgrade.CoolDownSeconds = TW.ArmorCoolDown
upgrade.FirstCoolDownSeconds = TW.ArmorFirstCoolDown

function upgrade:Apply(player, onSpawn) 
	local role = player:TWGetGroupRole()
	if onSpawn then
		timer.Simple(0.05, function()
			player:SetArmor(player:Armor() + (TW.ArmorPerTier * role.Upgrades[self.Name]))
		end)
	end
end

TW.UpgradeTemplates.Armor = upgrade