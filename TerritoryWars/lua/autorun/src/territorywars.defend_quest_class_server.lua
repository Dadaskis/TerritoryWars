local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.DefendCreated = {}

function TW.DefendQuest(group, player) 
	local quest = TW.Quest(group)[1]
	local groupHaveEnemies = false
	local enemiesList = {}

	for name, _ in pairs(TW.Groups) do 
		local points = group.Diplomacy[name]
		if (points == nil or points <= 5000) and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end

	quest.Type = "DEFEND_TERRITORY"

	if groupHaveEnemies then
		if table.Count(group.Territories or {}) > 0 then
			local _, X = table.Random(group.Territories)
			local _, Z = table.Random(group.Territories[X])
			if X and Z then
				quest.Available = true
				quest.Data = { X, Z } 
			else
				return
			end
		else
			return
		end
	else
		return
	end
	
	if not quest.Data then
		return
	end
	if TW.DefendCreated[group.Name .. player:SteamID() .. ":" .. quest.Data[1] .. ":" .. quest.Data[2]] then
		return
	end
	TW.DefendCreated[group.Name .. player:SteamID() .. ":" .. quest.Data[1] .. ":" .. quest.Data[2]] = true

	local created = false
	local groupName = group.Name
	local steamID = player:SteamID()
	timer.Create("TerritoryWars.DefendQuest" .. group.Name .. steamID .. ":" .. quest.Data[1] .. ":" .. quest.Data[2], 60, 1, function() 
		if not created then
			quest.Available = false
			TW.DefendFlagCreated[groupName .. steamID .. ":" .. quest.Data[1] .. ":" .. quest.Data[2]] = false
		end
	end)

	quest.PointsReward = TW.DefendQuestPointsReward
	quest.HaveTime = true
	function quest:Activate(player) 
		quest.OverTime = os.time() + TW.QuestNegativeTimeLength(group, TW.DefendQuestTimeLength)
		self.Active = true
		created = true
		timer.Simple(TW.QuestNegativeTimeLength(group, TW.DefendQuestTimeLength), function() 
			if player:TWGetGroup() 
					and player:TWGetGroup().Territories[self.Data[1]] 
					and player:TWGetGroup().Territories[self.Data[1]][self.Data[2]] then
				self:Complete(player)
				TW.DefendCreated[group.Name .. player:SteamID() .. ":" .. quest.Data[1] .. ":" .. quest.Data[2]] = false
			elseif not player:TWGetGroup() then
				TW.DefendCreated[group.Name .. player:SteamID() .. ":" .. quest.Data[1] .. ":" .. quest.Data[2]] = false
			end
		end)
	end

	return { quest }
end

if TW.TerritoryCapturing then
	TW.QuestTypes.Defend = TW.DefendQuest
end