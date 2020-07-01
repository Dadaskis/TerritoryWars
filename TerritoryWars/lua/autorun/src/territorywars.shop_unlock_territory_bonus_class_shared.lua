local TW = TerritoryWars

function TW.ShopUnlockTerritoryBonus()
	local bonus = TW.TerritoryBonus()

	bonus.Name = "ShopUnlock"
	bonus.Icon = "icon16/table_add.png"

	bonus.Properties.Item = -1

	function bonus:OnCaptured(group) 
		if not group or not group.ShopList then 
			return
		end
		if self.Properties.Item >= 0 then
			group.ShopList[self.Properties.Item] = (group.ShopList[self.Properties.Item] or 0) + 1
			for _, member in pairs(group.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.GroupShopList")
						net.WriteTable(group.ShopList)
					net.Send(member.Player)
				end
			end
		end
	end

	function bonus:OnUncaptured(group) 
		if not group or not group.ShopList then 
			return
		end
		if self.Properties.Item >= 0 then
			group.ShopList[self.Properties.Item] = (group.ShopList[self.Properties.Item] or 1) - 1
			for _, member in pairs(group.Members) do 
				if IsValid(member.Player) then
					net.Start("TerritoryWars.GroupShopList")
						net.WriteTable(group.ShopList)
					net.Send(member.Player)
				end
			end
		end
	end

	return bonus
end

TW.TerritoryBonuses.ShopUnlock = TW.ShopUnlockTerritoryBonus