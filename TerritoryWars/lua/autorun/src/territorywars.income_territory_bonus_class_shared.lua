local TW = TerritoryWars

function TW.IncomeTerritoryBonus()
	local bonus = TW.TerritoryBonus()

	bonus.Name = "Income"
	bonus.Icon = "icon16/time_add.png"

	bonus.Properties.Delay = 1
	bonus.Properties.Points = 1

	bonus.Points = 0

	function bonus:OnCaptured(group, X, Z, index, flagID) 
		timer.Create("TerritoryWars.Income" .. group.Name .. " " .. X .. " " .. Z .. " " 
			.. bonus.Properties.Delay .. " " .. bonus.Properties.Points .. " " .. index .. flagID or 0, bonus.Properties.Delay, 0, function()
			local points = self.Properties.Points 
			if TW.GroupUpgrading and TW.GroupIncomeUpgradeEnabled then
				points = points * (1.0 + ((TW.GroupIncomeUpgradeProcents / 100) * group.Upgrades["Income"]))
			end
			if TW.HandGetIncome then
				self.Points = self.Points + points
			else
				group.Points = group.Points + points
			end
		end)
	end

	function bonus:TakePlayerPoints(player) 
		TW:GetPlayerData(player).IncomePoints = (TW:GetPlayerData(player).IncomePoints or 0) + self.Points
		net.Start("TerritoryWars.IncomeCaseState")
			net.WriteBool(true)
		net.Send(player)
		self.Points = 0
	end

	function bonus:OnUncaptured(group, X, Z, index, flagID) 
		timer.Remove("TerritoryWars.Income" .. group.Name .. " " .. X .. " " .. Z .. " " 
			.. bonus.Properties.Delay .. " " .. bonus.Properties.Points .. " " .. index .. flagID or 0)
	end

	return bonus
end

TW.TerritoryBonuses.Income = TW.IncomeTerritoryBonus 