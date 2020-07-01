local TW = TerritoryWars

TW.AttackGroupQuestData = {}
TW.AttackGroupQuestCreated = {}
TW.AttackGroupQuestCreatedCounter = 0

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.AttackGroupQuest", function(group) 
	if TW.AttackGroupQuestCreated[group.Name] then
		TW.AttackGroupQuestCreatedCounter = TW.AttackGroupQuestCreatedCounter - 1
	end
	TW.AttackGroupQuestCreated[group.Name] = nil
end)

local function createData() 
	local variants = {}
	for _, group in pairs(TW.Groups) do 
		local territories = group.Territories
		for X, tbl in pairs(territories or {}) do 
			if not variants[X] then
				variants[X] = {}
			end
			for Z, _ in pairs(tbl) do 
				variants[X][Z] = true
			end
		end
	end
	local territoriesX, X = table.Random(variants)
	if not territoriesX then
		return false
	end
	local _, Z = table.Random(territoriesX)
	if not Z then
		return false
	end
	if not TW.AttackGroupQuestCreated[X .. " " .. Z] then
	    TW.AttackGroupQuestCreated[X .. " " .. Z] = true
	    table.Add(TW.AttackGroupQuestData, { { X, Z } })
	end
	return true
end

function TW.AttackGroupQuest(group) 
	local groupHaveEnemies = false
	local enemiesList = {}

	for name, group2 in pairs(TW.Groups) do 
		local points = 0 or group.Diplomacy[name]
		if points <= 5000 and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end
	if groupHaveEnemies then
		if TW.AttackGroupQuestCreatedCounter == 0 then
			TW.AttackGroupQuestCreated = {}
			TW.AttackGroupQuestData = {}
			TW.AttackGroupQuestCanCreate = true
			for counter = 1, TW.AttackGroupQuestTerritoriesLimit do 
				if not createData() then
					return
				end
			end
		end
		if TW.AttackGroupQuestCreatedCounter >= TW.AttackGroupQuestGroupsLimit then
			TW.AttackGroupQuestCanCreate = false
			return
		end
		if not TW.AttackGroupQuestCanCreate then
			return
		end 
		if #TW.AttackGroupQuestData == 0 then
			TW.AttackGroupQuestCreated = {}
			TW.AttackGroupQuestData = {}
			TW.AttackGroupQuestCreatedCounter = 0
			TW.AttackGroupQuestCanCreate = true
			return
		end
		if TW.AttackGroupQuestCreated[group.Name] then
			return
		end

		TW.AttackGroupQuestCreated[group.Name] = true
		local quest = TW.GroupQuest(group)[1]
		quest.Available = true
		quest.Type = "ATTACK_GROUP_QUEST"
		quest.Data = TW.AttackGroupQuestData
		quest.PointsReward = TW.AttackGroupQuestPointsReward
		quest.LifeTimeReward = TW.AttackGroupQuestLifeTimeReward
		quest.HaveTime = true
		TW.AttackGroupQuestCreatedCounter = TW.AttackGroupQuestCreatedCounter + 1
		function quest:Activate() 
			quest.OverTime = os.time() + TW.GroupQuestNegativeTimeLength(group, TW.AttackGroupQuestTimeLength)
			quest.Active = true
			timer.Simple(TW.GroupQuestNegativeTimeLength(group, TW.AttackGroupQuestTimeLength), function() 
				TW.AttackGroupQuestCreated[group.Name] = false
				local count = 0
				for index, data in ipairs(TW.AttackGroupQuestData) do 
					if TW.Territories[data[1]][data[2]].GroupName == group.Name then
						count = count + 1
					end
				end
				if count == #TW.AttackGroupQuestData then
					self:Complete(group)
				elseif count > 0 then
					self.PointsReward = TW.AttackGroupQuestParticalPointsReward * count
					self.LifeTimeReward = TW.AttackGroupQuestParticalLifeTimeReward * count
					self:Complete(group)
				else
					self:Fail(group)
				end
			end)
		end

		return { quest }
	end
end

if TW.TerritoryCapturing then
	TW.GroupQuestTypes.Attack = TW.AttackGroupQuest
end