local TW = TerritoryWars

TW.AttackFlagGroupQuestData = {}
TW.AttackFlagGroupQuestCreated = {}
TW.AttackFlagGroupQuestCreatedCounter = 0

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.AttackFlagGroupQuest", function(group) 
	if TW.AttackFlagGroupQuestCreated[group.Name] then
		TW.AttackFlagGroupQuestCreatedCounter = TW.AttackFlagGroupQuestCreatedCounter - 1
	end
	TW.AttackFlagGroupQuestCreated[group.Name] = nil
end)

function TW.AttackFlagGroupQuest(group) 
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
		if TW.AttackFlagGroupQuestCreatedCounter < TW.AttackFlagGroupQuestGroupsLimit then
			TW.AttackFlagGroupQuestCreated = {}
			TW.AttackFlagGroupQuestData = {}
			local flagData
			local name = select(2, table.Random(enemiesList))
		    for counter = 1, TW.AttackFlagGroupQuestFlagLimit do 
		    	local data, flagID = table.Random(TW.FlagBonusMap)
		    	if not data or not flagID then
		    		return
		    	end
		    	if #(data.Name or "") == 0 then
		    		return
		    	end
		    	if not flagID then
		    		return
		  		end
		    	flagData = { flagID }
		    	if not TW.AttackFlagGroupQuestCreated[flagData[1]] then
				    TW.AttackFlagGroupQuestCreated[flagData[1]] = true
				    table.Add(TW.AttackFlagGroupQuestData, { flagData })
				end
		    end
		end
		if #TW.AttackFlagGroupQuestData == 0 then
			TW.AttackFlagGroupQuestCreated = {}
			TW.AttackFlagGroupQuestData = {}
			TW.AttackFlagGroupQuestCreatedCounter = 0
			return
		end
		if TW.AttackFlagGroupQuestCreated[group.Name] then
			return
		end
		if TW.AttackFlagGroupQuestCreatedCounter > TW.AttackFlagGroupQuestGroupsLimit then
			return
		end

		TW.AttackFlagGroupQuestCreated[group.Name] = true
		local quest = TW.GroupQuest(group)[1]
		quest.Available = true
		quest.Type = "ATTACK_FLAG_GROUP_QUEST"
		quest.Data = TW.AttackFlagGroupQuestData
		quest.PointsReward = TW.AttackFlagGroupQuestPointsReward
		quest.LifeTimeReward = TW.AttackFlagGroupQuestLifeTimeReward
		quest.HaveTime = true
		TW.AttackFlagGroupQuestCreatedCounter = TW.AttackFlagGroupQuestCreatedCounter + 1
		local acceptedQuest = false
		timer.Simple(60 * 5, function() 
			if not acceptedQuest then
				quest.Available = false
			end
		end)
		function quest:Activate() 
			quest.OverTime = os.time() + TW.GroupQuestNegativeTimeLength(group, TW.AttackFlagGroupQuestTimeLength)
			acceptedQuest = true
			quest.Active = true
			timer.Simple(TW.GroupQuestNegativeTimeLength(group, TW.AttackFlagGroupQuestTimeLength), function() 
				TW.AttackFlagGroupQuestCreated[group.Name] = false
				TW.AttackFlagGroupQuestCreatedCounter = TW.AttackFlagGroupQuestCreatedCounter - 1
				local count = 0
				for index, data in ipairs(TW.AttackGroupQuestData) do 
					if TW.FlagBonusMap[data].Owner == group.Name then
						count = count + 1
					end
				end
				if count == #TW.AttackGroupQuestData then
					self:Complete(group)
				elseif count > 0 then
					self.PointsReward = self.AttackFlagGroupQuestParticalPointsReward * count
					self.LifeTimeReward = self.AttackFlagGroupQuestParticalLifeTimeReward * count
					self:Complete(group)
				else
					self:Fail(group)
				end
			end)
		end

		return { quest }
	end
end

TW.GroupQuestTypes.AttackFlag = TW.AttackFlagGroupQuest