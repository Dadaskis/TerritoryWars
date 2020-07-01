local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.KillerCreatedIn = {}

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.KillerQuest", function(group) 
	TW.KillerCreatedIn[group.Name] = nil
end)

function TW.KillerQuest(group, ply)
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
	
	local result = {}
	for name, _ in pairs(enemiesList) do 
		local quest = TW.Quest(group)[1]
		quest.Type = "KILL_THE_MEMBER"
		quest.Available = true
		quest.PointsReward = TW.KillerQuestPointsReward

		local member = table.Random(TW.Groups[name].Members)

		if not member then
			continue
		end

		quest.Data[1] = member.SteamID

		if not TW.KillerCreatedIn[group.Name] then
			TW.KillerCreatedIn[group.Name] = {}
		end
		if TW.KillerCreatedIn[group.Name .. member.SteamID .. ply:SteamID()] then
			continue
		end
		TW.KillerCreatedIn[group.Name .. member.SteamID .. ply:SteamID()] = true

		local created = false
		local groupName = group.Name
		local steamID = ply:SteamID()
		timer.Create("TerritoryWars.KillerQuest" .. group.Name .. member.SteamID .. steamID, 60, 1, function() 
			if not created then
				quest.Available = false
				TW.KillerCreatedIn[groupName .. member.SteamID .. steamID] = false
			end
		end)

		quest.HaveTime = true

		function quest:Activate(ply) 
			quest.OverTime = os.time() + TW.QuestPositiveTimeLength(group, TW.KillerQuestTimeLength)
			created = true
			self.Active = true
			local repeated = 1
			math.randomseed(RealTime())
			if math.random(1, 100) <= TW.KillerQuestInfoOnActivateChance then
				for _, ply in pairs(player.GetAll()) do
					net.Start("TerritoryWars.KillerQuestInfo")
						net.WriteBool(true)
						net.WriteString(player.GetBySteamID(self.Data[1]):Nick())
					net.Send(ply)
				end
			end
			local steamID = ply:SteamID()
			local nick = player.GetBySteamID(self.Data[1]):Nick()
			hook.Add("PlayerDeath", "TerritoryWars." .. steamID .. ":" .. self.Data[1] .. "KillerQuestHook", 
			function(killedply, _, killer) 
				if killedply:SteamID() == self.Data[1] and killer == ply then
					for _, ply in pairs(player.GetAll()) do
						net.Start("TerritoryWars.KillerQuestInfo")
							net.WriteBool(false)
							net.WriteString(nick)
						net.Send(ply)
					end
					self:Complete(ply)
					TW.KillerCreatedIn[groupName .. member.SteamID .. steamID] = false
					timer.Remove("TerritoryWars." .. steamID .. ":" .. self.Data[1] .. "KillerQuest")
					hook.Remove("PlayerDeath", "TerritoryWars." .. steamID .. ":" .. self.Data[1] .. "KillerQuestHook")
				end
			end)
			timer.Create("TerritoryWars." .. steamID .. ":" .. self.Data[1] .. "KillerQuest", 
			TW.QuestPositiveTimeLength(group, TW.KillerQuestTimeLength), 1, 
			function() 
				hook.Remove("PlayerDeath", "TerritoryWars." .. steamID .. ":" .. self.Data[1] .. "KillerQuestHook")
				self:Fail()
				TW.KillerCreatedIn[groupName .. member.SteamID .. steamID] = false
			end)
		end

		table.Add(result, { quest })
	end

	return result
end

TW.QuestTypes.Killer = TW.KillerQuest