local TW = TerritoryWars

TW.TerritoryBonuses = {}

function TW.TerritoryBonus()
	local bonus = {}

	bonus.Name = "NULL_BONUS"
	bonus.Icon = "icon16/world.png"
	bonus.Properties = {}
	bonus.Deleted = false

	function bonus:OnCaptured(group, X, Z) end

	function bonus:OnUncaptured(group, X, Z) end

	return bonus
end

-- TW.TerritoryBonuses.NULL_BONUS = TW.TerritoryBonus