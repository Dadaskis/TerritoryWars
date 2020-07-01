local TW = TerritoryWars

TW.PassCasesCreatedIn = {}

hook.Add("TerritoryWars.GroupDeleted", "TerritoryWars.PassCaseGroupQuest", function(group) 
    TW.PassCasesCreatedIn[group.Name] = nil
end)

function TW.PassCasesGroupQuest(group, player)
    local groupHaveEnemies = false
	local enemiesList = {}
	for name, group2 in pairs(TW.Groups) do 
		local points = 0 or group.Diplomacy[name]
		if points <= 5000 and group.Name ~= name then
			enemiesList[name] = true
			groupHaveEnemies = true
		end
	end
	if groupHaveEnemies and not TW.PassCasesCreatedIn[group.Name] then
	    TW.PassCasesCreatedIn[group.Name] = true
        local quest = TW.GroupQuest(group)[1]
        quest.Available = true
        quest.Type = "PASS_CASE" 
        quest.PointsReward = TW.PassCasesGroupQuestPointsReward
        quest.LifeTimeReward = TW.PassCasesGroupQuestLifeTimeReward
        quest.HaveTime = true
         
        function quest:Activate(player) 
            quest.OverTime = os.time() + TW.GroupQuestPositiveTimeLength(group, TW.PassCasesGroupQuestTimeLength)
            self.Active = true
            local casesOnBegin = group.CasesPassed
            local counter = 0
            timer.Create("TerritoryWars." .. group.Name .. "PassCases", 
            TW.GroupQuestPositiveTimeLength(group, TW.PassCasesGroupQuestTimeLength) / 1000, 1000, 
            function()
                counter = counter + 1
                if group.CasesPassed - casesOnBegin >= TW.PassCasesGroupQuestCount then
                    self:Complete(group)
                    TW.PassCasesCreatedIn[group.Name] = nil
                    timer.Remove("TerritoryWars." .. group.Name .. "PassCases")
                    return
                end
                if counter == 1000 then
                    TW.PassCasesCreatedIn[group.Name] = nil
                    self:Fail(group)
                end
            end)
        end
         
        return { quest }
    else
        return
    end
end

TW.GroupQuestTypes.PassCase = TW.PassCasesGroupQuest