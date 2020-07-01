local TW = TerritoryWars

TW.Groups = TW.Groups or {}

local ply = FindMetaTable("Player")

function TW.QuestPositiveTimeLength(group, timeLength) 
	if TW.GroupUpgrading then
		local upgrades = group.Upgrades
		if CLIENT then
			upgrades = TW.GroupUpgrades
		end
		return timeLength * (1 + ((TW.GroupQuestPositiveTimeLengthUpgradeProcents / 100) * upgrades["QuestPositiveTimeLength"]))
	end
	return timeLength
end

function TW.QuestNegativeTimeLength(group, timeLength) 
	if TW.GroupUpgrading then
		local upgrades = group.Upgrades
		if CLIENT then
			upgrades = TW.GroupUpgrades
		end
		return math.max(timeLength * (1 - ((TW.GroupQuestNegativeTimeLengthUpgradeProcents / 100) * upgrades["QuestNegativeTimeLength"])), 0)
	end
	return timeLength
end

function TW.GroupQuestPositiveTimeLength(group, timeLength) 
	if TW.GroupUpgrading then
		local upgrades = group.Upgrades
		if CLIENT then
			upgrades = TW.GroupUpgrades
		end
		return timeLength * (1 + ((TW.GroupGroupQuestPositiveTimeLengthUpgradeProcents / 100) * upgrades["GroupQuestPositiveTimeLength"]))
	end
	return timeLength
end

function TW.GroupQuestNegativeTimeLength(group, timeLength) 
	if TW.GroupUpgrading then
		local upgrades = group.Upgrades
		if CLIENT then
			upgrades = TW.GroupUpgrades
		end
		return math.max(timeLength * (1 - ((TW.GroupGroupQuestNegativeTimeLengthUpgradeProcents / 100) * upgrades["GroupQuestNegativeTimeLength"])), 0)
	end
	return timeLength
end

function TW.GroupRoleTimeDiscount(group, coolDownSeconds) 
	return math.max(coolDownSeconds * (1 - ((TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents / 100) 
						* group.Upgrades["RoleUpgradeCooldownDiscount"])), 0)
end

function TW.GroupRoleDiscount(group, price) 
	return math.max(price * (1 - ((TW.GroupRoleUpgradeDiscountUpgradeProcents / 100) * group.Upgrades["RoleUpgradeDiscount"])), 0)
end

if SERVER then

	function ply:TWGetGroup() 
		return TW.Groups[TW:GetPlayerData(self).Group]
	end

	function ply:TWSetGroup(group) 
		TW:GetPlayerData(self).Group = (group or {}).Name 
	end

	function ply:TWGetGroupMember() 
		return self:TWGetGroup().Members[self:SteamID()]
	end

	function ply:TWGetGroupRole() 
		return self:TWGetGroup().Roles[self:TWGetGroupMember().Role]
	end

elseif CLIENT then

	function ply:TWGetGroup() 
		return TW.Group
	end

	function ply:TWSetGroup(group) 
		TW.Group = group
	end

	function ply:TWGetGroupMember() 
		return TW.Group.Members[self:SteamID()]
	end

	function ply:TWGetGroupRole() 
		return TW.Group.Roles[self:TWGetGroupMember().Role]
	end

end