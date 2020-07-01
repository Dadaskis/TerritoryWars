local TW = TerritoryWars

local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/arrow_up.png"
upgrade.Name = "Jump"
upgrade.StartPrice = TW.SpeedUpgradePrice
upgrade.Maximum = TW.JumpMaximum
upgrade.AddUpgradedCount = TW.JumpAddPrice
upgrade.CoolDownSeconds = TW.JumpCoolDown
upgrade.FirstCoolDownSeconds = TW.JumpFirstCoolDown

function upgrade:Apply(player, onSpawn) 
	if onSpawn then
		timer.Simple(0.05, function()
			player:SetJumpPower(player:GetJumpPower() + 
				(player:GetJumpPower() * (player:TWGetGroupRole().Upgrades["Jump"] * (TW.JumpPerTier / 100))))
		end)
	end
end

TW.UpgradeTemplates.Jump = upgrade