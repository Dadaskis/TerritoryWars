local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.UpgradeTemplates = {}
TW.GroupGetUpgrade = {}

function TW.RoleUpgrade() 
	local upgrade = {}
	upgrade.Icon = "icon16/arrow_up.png"
	upgrade.Name = "NULL_UPGRADE"
	upgrade.StartPrice = 0
	upgrade.Maximum = math.huge - 1
	upgrade.AddUpgradedCount = 1
	upgrade.CoolDownSeconds = 0
	upgrade.FirstCoolDownSeconds = 0

	function upgrade:Apply(player, onSpawn) end

	return upgrade
end

function TW:UpgradeRole(group, roleName, upgrade) 
	if not TW.GroupGetUpgrade[group.Name] then
		TW.GroupGetUpgrade[group.Name] = {}
	end
	local role = group.Roles[roleName]
	local upgradeName = upgrade.Name
	if role.Upgrades[upgradeName] >= upgrade.Maximum then
		return false
	end
	if TW.RoleUpgradeCoolDown then
		group.UpgradeCoolDownEnd[roleName] = group.UpgradeCoolDownEnd[roleName] or 0
		if group.UpgradeCoolDownEnd[roleName] <= os.time() then
			local coolDownSeconds = 0
			if role.Upgrades[upgradeName] == 0 and not TW.GroupGetUpgrade[group.Name][upgradeName] then
				coolDownSeconds = upgrade.FirstCoolDownSeconds
			else
				coolDownSeconds = upgrade.CoolDownSeconds
			end
			if TW.GroupUpgrading and TW.GroupRoleUpgradeDiscountUpgradeEnabled then 
				coolDownSeconds = TW.GroupRoleTimeDiscount(group, coolDownSeconds)
			end
			local price = upgrade.StartPrice * role.UpgradedCount
			if TW.GroupUpgrading and TW.GroupRoleUpgradeDiscountUpgradeEnabled then
				price = TW.GroupRoleDiscount(group, price)
			end
			if not timer.Exists("TerritoryWars." .. group.Name .. "RoleUpgradeCoolDown" .. roleName) and group.Points >= price then
				group.Points = group.Points - price
				group.UpgradeCoolDownEnd[roleName] = os.time() + coolDownSeconds
				TW.SendGroupRoleUpgradeEnd(group)
				timer.Create("TerritoryWars." .. group.Name .. "RoleUpgradeCoolDown" .. roleName, coolDownSeconds, 1, function()
					TW.GroupGetUpgrade[group.Name][upgradeName] = true
					role.Upgrades[upgradeName] = role.Upgrades[upgradeName] + 1
					role.UpgradedCount = role.UpgradedCount + upgrade.AddUpgradedCount
					for _, member in pairs(group.Members) do 
						if IsValid(member.Player) then
							upgrade:Apply(member.Player, false)
						end
					end
					TWUtil:SetGroupRoleToEveryone(group, roleName)
				end)
				return false
			end
		else
			return false
		end
	else
		local price = upgrade.StartPrice * role.UpgradedCount
		if TW.GroupUpgrading and TW.GroupRoleUpgradeDiscountUpgradeEnabled then
			price = TW.GroupRoleDiscount(group, price)
		end
		if group.Points >= price then
			group.Points = group.Points - price
			role.Upgrades[upgradeName] = role.Upgrades[upgradeName] + 1
			role.UpgradedCount = role.UpgradedCount + upgrade.AddUpgradedCount
			return true
		end
	end
end

hook.Add("EntityTakeDamage", "TerritoryWars.OnDamageCallback", function(target, damageInfo) 
	local player = damageInfo:GetAttacker()
	if damageInfo:IsBulletDamage() then
		if player:IsPlayer() then
			if player:TWGetGroup() then
				hook.Run("TerritoryWars.BulletDamageByPlayer", player, target, damageInfo)
			end
		end
		if target:IsPlayer() then
			if target:TWGetGroup() then
				hook.Run("TerritoryWars.BulletDamagedPlayer", target, player, damageInfo)
			end
		end
	end
end)

--TW.UpgradeTemplates.NULL_TYPE = TW.RoleUpgrade()