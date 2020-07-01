TerritoryWars.Utilities = {}

local TW = TerritoryWars
local TWUtil = TerritoryWars.Utilities

function TWUtil:GetPositionOnDisplayFromProcents(XProcents, YProcents) 
	local X = ScrW() * XProcents
	local Y = ScrH() * YProcents
	return X, Y
end

function TWUtil:GetSizeOnDisplayFromProcents(x1, y1, x2, y2) 
	return x2 - x1, y2 - y1
end

function TWUtil:SetPanelPos(XProcents, YProcents, panel) 
	panel:SetPos(self:GetPositionOnDisplayFromProcents(XProcents, YProcents))
end

function TWUtil:SetPanelSize(XProcents, YProcents, panel) 
	panel:SetSize(self:GetPositionOnDisplayFromProcents(XProcents, YProcents))
end

function TWUtil:SetSizeOfPanelToReachPosition(XProcents, YProcents, panel) 
	local panelX, panelY = panel:GetPos()
	panelX = panelX / ScrW()
	panelY = panelY / ScrH()
	panel:SetSize(self:GetSizeOnDisplayFromProcents(panelX, panelY, XProcents, YProcents))
end

local typesBlacklist = {
	"function",
	"userdata",
	"CSoundPatch"
}

local function IsTypeBlacklisted(type) 
	for index, typeName in ipairs(typesBlacklist) do 
		if type == typeName then
			return true
		end
	end
	return false
end

function TWUtil:GetTableData(tbl, level) 
	local level = level or 0
	if level == 0 and not istable(tbl) then
		return {}
	end
	local data = {}	
	for key, value in pairs(tbl) do
		if not IsTypeBlacklisted(type(value)) then
			if type(value) == "table" then
				data[key] = self:GetTableData(value, level + 1)
			else
				data[key] = value
			end
		end
	end
	return data
end

function TWUtil:SendGroupToPlayer(player) 
	net.Start("TerritoryWars.GetGroup")
		net.WriteString(player:SteamID())
		net.WriteTable(TWUtil:GetTableData(player:TWGetGroup()))
	net.Send(player)
end

function TWUtil:SendGroupMembersToPlayer(player) 
	net.Start("TerritoryWars.GetMembers")
		net.WriteTable(TWUtil:GetTableData(player:TWGetGroup().Members))
	net.Send(player)
end

function TWUtil:SendGroupRolesToPlayer(player) 
	net.Start("TerritoryWars.GetRoles")
		net.WriteTable(TWUtil:GetTableData(player:TWGetGroup().Roles))
	net.Send(player)
end

function TWUtil:SendGroupDiplomacyToPlayer(player) 
	net.Start("TerritoryWars.GetDiplomacy")
		net.WriteTable(TWUtil:GetTableData(player:TWGetGroup().Diplomacy))
	net.Send(player)
end

function TWUtil:SendGroupToEveryone(group) 
	local data = TWUtil:GetTableData(group)
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GetGroup")
				net.WriteString(member.Player:SteamID())
				net.WriteTable(data)
			net.Send(member.Player)
		end
	end
end

function TWUtil:SendGroupMembersToEveryone(group) 
	local data = TWUtil:GetTableData(group.Members)
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GetMembers")
				net.WriteTable(data)
			net.Send(member.Player)
		end
	end
end

function TWUtil:SetGroupMemberToEveryone(group, steamID) 
	local data = TWUtil:GetTableData(group.Members[steamID])
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GetMember")
				net.WriteString(steamID)
				net.WriteTable(data)
			net.Send(member.Player)
		end
	end
end

function TWUtil:SendGroupRolesToEveryone(group) 
	local data = TWUtil:GetTableData(group.Roles)
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GetRoles")
				net.WriteTable(data)
			net.Send(member.Player)
		end
	end
end

function TWUtil:SendGroupDiplomacyToEveryone(group) 
	local data = TWUtil:GetTableData(group.Diplomacy or {})
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.GetDiplomacy")
				net.WriteTable(data)
			net.Send(member.Player)
		end
	end
end

function TWUtil:SetGroupRoleToEveryone(group, roleName) 
	for _, member in pairs(group.Members) do 
		if IsValid(member.Player) then
			net.Start("TerritoryWars.SetRole")
				net.WriteString(roleName)
				net.WriteTable(TWUtil:GetTableData(group.Roles[roleName]))
			net.Send(member.Player)
		end
	end
end