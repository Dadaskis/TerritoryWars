local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.PassCaseCreatedIn = {}

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.PassCaseQuest", function(group) 
	TW.PassCaseCreatedIn[group.Name] = nil
end)

function TW.PassCaseQuest(group, player)
	math.randomseed(RealTime())
	if math.random(0, 100) > TW.PassCaseQuestCreateChance then
		return { } 
	end
	local groupHaveEnemies = false
	local enemiesList = {}

	for name, _ in pairs(TW.Groups) do 
		local points = group.Diplomacy[name]
		if (points == nil or points <= 5000) and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end

	if not groupHaveEnemies then
		return
	end

	if not TW.PassCaseCreatedIn[group.Name] then
		TW.PassCaseCreatedIn[group.Name] = {}
	end
	if TW.PassCaseCreatedIn[group.Name][player:SteamID()] then
		return
	end
	TW.PassCaseCreatedIn[group.Name][player:SteamID()] = true

	local quest = TW.Quest(group)[1]
	quest.Available = true
	quest.Type = "PASS_CASE"
	quest.PointsReward = TW.PassCaseQuestPointsReward

	local created = false
	local groupName = group.Name
	local steamID = player:SteamID()
	timer.Create("TerritoryWars.PassCaseQuest" .. group.Name .. steamID, 60, 1, function() 
		if not created then
			quest.Available = false
			(TW.PassCaseCreatedIn[groupName] or {})[steamID] = false
		end
	end)

	local steamID = player:SteamID()
	quest.HaveTime = true

	function quest:Activate(player) 
		quest.OverTime = os.time() + TW.QuestPositiveTimeLength(group, TW.PassCaseQuestTimeLength)
		self.Active = true
		created = true
		hook.Add("TerritoryWars.CasePassed", "TerritoryWars.CasePassQuest" .. steamID, function(player2) 
			if player == player2 then
				self:Complete(player)
				TW.PassCaseCreatedIn[group.Name][steamID] = false
				hook.Remove("TerritoryWars.CasePassed", "TerritoryWars.CasePassQuest" .. steamID)
			end
		end)
		timer.Simple(TW.QuestPositiveTimeLength(group, TW.PassCaseQuestTimeLength), function() 
			self:Fail()
			TW.PassCaseCreatedIn[group.Name][steamID] = false
			hook.Remove("TerritoryWars.CasePassed", "TerritoryWars.CasePassQuest" .. steamID)
		end)
	end

	return { quest }
end

TW.QuestTypes.PassCase = TW.PassCaseQuest