local TW = TerritoryWars

function TW.Role(group, name, color, permisions, salary) 
	local role = {}
	role.GroupName = group.Name
	role.Permisions = permisions or TW.Permisions()
	role.Salary = salary or 0
	role.Name = name or TW.Labels.Novice
	role.Color = color or Color(55, 55, 55)
	role.MaxSlots = 1
	role.CurrentSlots = 0
	role.SlotPrice = TW.SlotPrice
	role.UpgradedCount = 1

	if TW.RoleUpgrading then
		role.Upgrades = {}
		for name, upgrade in pairs(TW.UpgradeTemplates) do 
			role.Upgrades[upgrade.Name] = 0
		end
	end

	return role
end  