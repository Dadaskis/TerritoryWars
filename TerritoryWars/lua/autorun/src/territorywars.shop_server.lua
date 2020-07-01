local TW = TerritoryWars
local TWUtil = TW.Utilities

util.AddNetworkString("TerritoryWars.GetShopItem")
util.AddNetworkString("TerritoryWars.ChangeShopData")
util.AddNetworkString("TerritoryWars.Buy")
util.AddNetworkString("TerritoryWars.OpenShopWindow")
util.AddNetworkString("TerritoryWars.ShopBuyedCount")
util.AddNetworkString("TerritoryWars.ShopSwap")
util.AddNetworkString("TerritoryWars.SendShopQueue")
util.AddNetworkString("TerritoryWars.ReturnShopEntity")
util.AddNetworkString("TerritoryWars.AddToShopEntityClass")

TW.Shop = TW.Shop or {}
TW.ShopList = TW.ShopList or {}
TW.ShopList.Counter = TW.ShopList.Counter or 1

function TW.Shop:ShopQueueSpawn(player) 
	local maxAccumulate = Vector(1, 1, 1)
	for _, index in pairs(TW:GetPlayerData(player).ShopQueue) do
		if TW.ShopList[index] then
			local owner = nil
			if TW.ShopList[index].PlayerIsOwner then
				owner = player
			end
			local entities = duplicator.Paste(
				owner, TW.ShopList[index].Entity.Entities, TW.ShopList[index].Entity.Constraints)
			local min, max
			if entities then
				if IsValid(entities[table.GetKeys(entities)[1]]) then
					if IsValid(entities[table.GetKeys(entities)[1]]:GetPhysicsObject()) then
						min, max = entities[table.GetKeys(entities)[1]]:GetPhysicsObject():GetAABB()
					else
						local entity = entities[table.GetKeys(entities)[1]]
						if IsValid(entity) then
							entity:SetModel(entity:GetModel())
							entity:PhysicsInit(SOLID_VPHYSICS)
							entity:SetMoveType(MOVETYPE_VPHYSICS)
							entity:SetSolid(SOLID_VPHYSICS)
                            if IsValid(entity:GetPhysicsObject()) then
    							entity:GetPhysicsObject():Wake()
    							min, max = entity:GetPhysicsObject():GetAABB()
                            else
                                min, max = Vector(0, 0, 0), Vector(0, 0, 100)
                            end
						end
					end
					entities[table.GetKeys(entities)[1]]:SetPos(
						player:GetEyeTrace().HitPos + (
							(player:GetEyeTrace().HitNormal * (maxAccumulate + max))
						)
					)
                    if IsValid(entities[table.GetKeys(entities)[1]]:GetPhysicsObject()) then
    					entities[table.GetKeys(entities)[1]]:GetPhysicsObject():Wake()
                    end
					maxAccumulate = maxAccumulate + max
				end
			end
		end
	end
	TW:GetPlayerData(player).ShopQueue = {}
	net.Start("TerritoryWars.ShopBuyedCount")
		net.WriteInt(0, 8)
	net.Send(player)
end

hook.Add("PlayerInitialSpawn", "TerritoryWars.ShopListSend", function(player) 
	for index = 1, TW.ShopList.Counter do
		net.Start("TerritoryWars.GetShopItem")
			net.WriteInt(index, 32)
			net.WriteTable(TWUtil:GetTableData(TW.ShopList[index]))
		net.Send(player)
	end
end)

hook.Add("PlayerSpawn", "TerritoryWars.GiveShopPocket", function(player) 
	if not TW:GetPlayerData(player).ShopQueue then
		TW:GetPlayerData(player).ShopQueue = {}	
	end
	if #TW:GetPlayerData(player).ShopQueue > 0 then
		player:Give("territorywars.shop_pocket")
	end
end)

if TW.Changeable then
    net.Receive("TerritoryWars.AddToShopEntityClass", function(byteLength, ply) 
        if not ply:IsSuperAdmin() then
            return
        end

        local entityClass = net.ReadString()

        local entity = ents.Create(entityClass)
        if not IsValid(entity) then
            print("[TerritoryWars] Added entity class to shop was invalid")
            return
        end

        entity:Spawn()
        local model = entity:GetModel()
        entity:Remove()

        local ShopData = {}
        ShopData.EntityClass = entityClass
        ShopData.Model = model
        ShopData.Name = tostring(TW.ShopList.Counter)
        ShopData.Price = 0
        ShopData.AlwaysUnlocked = true
        ShopData.PlayerIsOwner = false
        TW.ShopList.Counter = TW.ShopList.Counter + 1
        TW.ShopList[TW.ShopList.Counter] = ShopData
        TW:Save()
        net.Start("TerritoryWars.GetShopItem")
            net.WriteInt(TW.ShopList.Counter, 32)
            net.WriteTable(TerritoryWars.Utilities:GetTableData(TW.ShopList[TW.ShopList.Counter]))
        net.Broadcast()
    end)

	net.Receive("TerritoryWars.ShopSwap", function(byteLength, ply) 
		local direction = net.ReadBool()
		local index = net.ReadInt(32)
		if direction == true then
			if index < TW.ShopList.Counter and TW.ShopList[index + 1] then
				TW.ShopList[index], TW.ShopList[index + 1] = TW.ShopList[index + 1], TW.ShopList[index]
			else 
				return
			end
		else
			if index > 0 and TW.ShopList[index - 1] then
				TW.ShopList[index], TW.ShopList[index - 1] = TW.ShopList[index - 1], TW.ShopList[index]
			else
				return
			end
		end
		local players = player.GetAll()
		for index, ply2 in pairs(players) do 
			if ply == ply2 then
				players[index] = nil
				players[index], players[#players] = players[#players], players[index]
				break
			end
		end
		net.Start("TerritoryWars.GetShopItem")
			net.WriteInt(index, 32)
			net.WriteTable(TWUtil:GetTableData(TW.ShopList[index]))
		net.Send(players)
		net.Start("TerritoryWars.GetShopItem")
			net.WriteInt(index, 32)
			if direction then
				net.WriteTable(TWUtil:GetTableData(TW.ShopList[index + 1]))
			else
				net.WriteTable(TWUtil:GetTableData(TW.ShopList[index - 1]))
			end
		net.Send(players)
	end)

	net.Receive("TerritoryWars.ChangeShopData", function(byteLength, player) 
		if player:IsSuperAdmin() then
			local index = net.ReadInt(32)
			local delete = net.ReadBool()
			if delete then
				table.remove(TW.ShopList, index)
				TW.ShopList.Counter = TW.ShopList.Counter - 1
				TW:Save()
				local beginIndex = index
				for index = beginIndex, TW.ShopList.Counter + 1 do
					net.Start("TerritoryWars.GetShopItem")
						net.WriteInt(index, 32)
						if TW.ShopList[index] then
							net.WriteTable(TWUtil:GetTableData(TW.ShopList[index]))
						end
					net.Broadcast()
				end
				return
			end
			TW.ShopList[index].Name = net.ReadString()
			TW.ShopList[index].Price = net.ReadInt(32)
			TW.ShopList[index].AlwaysUnlocked = net.ReadBool()
			TW.ShopList[index].PlayerIsOwner = net.ReadBool()
			TW.ShopList[index].Category = net.ReadString()
			TW:Save()

			net.Start("TerritoryWars.GetShopItem")
				net.WriteInt(index, 32)
				net.WriteTable(TWUtil:GetTableData(TW.ShopList[index]))
			net.Broadcast()
		end
	end)

	hook.Add("PlayerSpawn", "TerritoryWars.AddToShop", function(player, text) 
		if IsValid(player) and player:IsSuperAdmin() then
			player:Give("territorywars.add_to_shop")
		end
	end)
end

net.Receive("TerritoryWars.ReturnShopEntity", function(byteLength, player) 
    if player:TWGetGroup() then
        local index = net.ReadInt(32)
        local shopQueue = TW:GetPlayerData(player).ShopQueue
        local price = TW.ShopList[index].Price
        if TW.GroupUpgrading and TW.GroupShopDiscountUpgradeEnabled then
            price = 
                math.max(
                    math.Round(price * (1 - ((TW.GroupShopDiscountUpgradeProcents / 100) * player:TWGetGroup().Upgrades["ShopDiscount"]))), 0)
        end
        table.remove(shopQueue, index)
        player:TWGetGroupMember().Points = player:TWGetGroupMember().Points + price
        net.Start("TerritoryWars.ShopBuyedCount")
            net.WriteInt(#shopQueue, 32)
        net.Send(player)
        net.Start("TerritoryWars.SendShopQueue")
            net.WriteTable(shopQueue)
        net.Send(player)
        if #shopQueue == 0 then
            player:StripWeapon("territorywars.shop_pocket")
        end
    end
end)

net.Receive("TerritoryWars.Buy", function(byteLength, player) 
	local index = net.ReadInt(32)
	if not TW:GetPlayerData(player).ShopQueue then
		TW:GetPlayerData(player).ShopQueue = {}
	end
	local shopQueue = TW:GetPlayerData(player).ShopQueue
	if (player:TWGetGroup().ShopList[index] or 0) > 0 or TW.ShopList[index].AlwaysUnlocked then
		local price = TW.ShopList[index].Price
		if TW.GroupUpgrading and TW.GroupShopDiscountUpgradeEnabled then
			price = 
				math.max(
					math.Round(price * (1 - ((TW.GroupShopDiscountUpgradeProcents / 100) * player:TWGetGroup().Upgrades["ShopDiscount"]))), 0)
		end
		if (player:TWGetGroupMember().Points or 0) >= price
				and #shopQueue < TW.ShopPocketLimit then
			shopQueue[#shopQueue + 1] = index
			player:TWGetGroupMember().Points = player:TWGetGroupMember().Points - price
			net.Start("TerritoryWars.ShopBuyedCount")
				net.WriteInt(#shopQueue, 32)
			net.Send(player)
			player:Give("territorywars.shop_pocket")
            net.Start("TerritoryWars.SendShopQueue")
                net.WriteTable(shopQueue)
            net.Send(player)
		end
	end
	net.Start("TerritoryWars.GetMyPoints")
		net.WriteInt(player:TWGetGroupMember().Points, 32)
	net.Send(player)
end)