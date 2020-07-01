local TW = TerritoryWars

local function GetRolePrice(group, role) 
    local price = 0

    for name, upgradeLevel in pairs(role.Upgrades) do 
        local roleData = TW.UpgradeTemplates[name]
        if not roleData then
            continue
        end
        local rolePrice = 0
        local multiplier = 0
        for level = 1, upgradeLevel do 
            rolePrice = rolePrice + (roleData.StartPrice * multiplier)
            multiplier = multiplier + roleData.AddUpgradedCount
        end
        price = price + rolePrice
    end

    return price
end

local function GetGroupUpgradePrice(group, name, level) 
    local groupUpgradeData = TW.GroupUpgradeTemplates[name]
    local groupUpgradePrice = 0
    local multiplier = 0
    for levelCounter = 1, level do 
        if not groupUpgradeData then
            return groupUpgradePrice
        end
        groupUpgradePrice = groupUpgradePrice + (groupUpgradeData.Price * multiplier)
        multiplier = multiplier + groupUpgradeData.AddUpgradedCount
    end
    return groupUpgradePrice
end

local function GetGroupPrice(group) 
    local price = 0

    price = price + group.Points

    for _, member in pairs(group.Members) do 
        price = price + member.Points
    end

    for _, role in pairs(group.Roles) do
        price = price + GetRolePrice(group, role)
    end

    for name, level in pairs(group.Upgrades) do 
        price = price + GetGroupUpgradePrice(group, name, level)
    end

    return price
end

hook.Add("TerritoryWars.GroupCreated", "TerritoryWarsExperimental.NewGroupGivePoints", function(group) 
    local maxPrice = 0
    for name, group2 in pairs(TW.Groups) do 
        local price = GetGroupPrice(group2)
        if price > maxPrice then
            maxPrice = price
        end
    end
    group.Points = maxPrice
    TW.SendGroupPoints(group) 
end)