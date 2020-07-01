local TW = TerritoryWars
local TWUtil = TW.Utilities

TW.FlagBonusMap = {}

net.Receive("TerritoryWars.CaptureFlag", function() 
	local X = net.ReadInt(32)
	local Z = net.ReadInt(32)
	chat.AddText(Color(255, 255, 255), TW.Labels.Capturing .. " " .. TW.Labels.FlagAt .. " " .. X .. " " .. Z .. ".")
end)

net.Receive("TerritoryWars.CaptureFlagDone", function() 
	local X = net.ReadInt(32)
	local Z = net.ReadInt(32)
	chat.AddText(Color(255, 255, 255), TW.Labels.Capture2 .. " " .. TW.Labels.FlagAt2 .. " " .. X .. " " .. Z .. " " .. TW.Labels.IsOver .. ".")
end)

net.Receive("TerritoryWars.SetFlagBonusMap", function()
	local ID = net.ReadInt(32)
	TW.FlagBonusMap[ID] = net.ReadTable()
end)

TW.FlagIncomeStatus = {}
net.Receive("TerritoryWars.FlagIncomeStatus", function() 
	TW.FlagIncomeStatus[net.ReadInt(32)] = net.ReadBool()
end)

net.Receive("TerritoryWars.YouGetIncome", function() 
	chat.AddText(Color(0, 150, 0), TW.Labels.YouGetIncome)
end)

net.Receive("TerritoryWars.OpenFlagWindow", function()
	local flagID = net.ReadInt(32)
	local info = vgui.Create("TerritoryWars.TerritoryInfoWindow")
	if TW.FlagBonusMap[flagID] then
		info:SetBonuses(TW.FlagBonusMap[flagID].Bonuses or {})
		info:SetOwner(TW.FlagBonusMap[flagID].Owner or nil)
		info:SetName(TW.FlagBonusMap[flagID].Name or nil)
		info:SetAdditionalInfo(TW.FlagBonusMap[flagID].AdditionalInfo or nil)
	else
		info:SetBonuses({})
	end

	info:UpdateDescription()

	function info:BonusSettingsOnApply(window) 
		net.Start("TerritoryWars.FlagBonusMapBonuses")
			net.WriteInt(flagID, 32)
			net.WriteTable(TWUtil:GetTableData(window:GetBonuses()))
		net.SendToServer()
		info:UpdateDescription()
	end

	function info.SettingsOnApply(_, name, additionalInfo) 
		info:SetName(name)
		info:SetAdditionalInfo(additionalInfo)
		TW.FlagBonusMap[flagID].Name = name
		TW.FlagBonusMap[flagID].AdditionalInfo = additionalInfo
		net.Start("TerritoryWars.SetFlagBonusMap")
			net.WriteInt(flagID, 32)
			net.WriteTable(TWUtil:GetTableData(TW.FlagBonusMap[flagID]))
		net.SendToServer()
		info:UpdateDescription()
	end

	function info:OnClose() 
		net.Start("TerritoryWars.OutFromFlagWindow")
		net.SendToServer()
	end

	if TW.Group and TW.FlagBonusMap[flagID]
			and TW.Group.Name ~= TW.FlagBonusMap[flagID].Owner
			and not TW.FlagBonusMap[flagID].Capture then
		local capture = vgui.Create("TerritoryWars.ButtonBase", info)
		capture:SetFontInternal("TW.SFont" .. ScrH())
		capture:SetText(TW.Labels.Capture)
		capture:SetImage("icon16/flag_red.png")
		capture:Dock(TOP)
		function capture:DoClick() 
			net.Start("TerritoryWars.CaptureFlag")
				net.WriteInt(flagID, 32)
			net.SendToServer()
		end
		local lastGroupReceived = TW.GroupReceived
		function capture:Think() 
			if lastGroupReceived < TW.GroupReceived then
				lastGroupReceived = TW.GroupReceived
				if not TW.Group then
					self:Remove()
				end
			end
		end
	end

	if TW.HandGetIncome and TW.Group and TW.FlagBonusMap[flagID].Owner == TW.Group.Name then
		createButton = false
		for _, data in pairs(TW.FlagBonusMap[flagID].Bonuses) do 
			if data.Name == "Income" then
				createButton = true
				return
			end
		end
		if not createButton then 
			return
		end
		local income = vgui.Create("TerritoryWars.ButtonBase", info)
		income:SetFontInternal("TW.SFont" .. ScrH())
		income:SetText(TW.Labels.GetIncome)
		income:SetImage("icon16/flag_green.png")
		income:Dock(TOP)
		function income.DoClick() 
			if not TW.FlagIncomeStatus[flagID] then
				net.Start("TerritoryWars.GetFlagIncome")
					net.WriteInt(flagID, 32)
				net.SendToServer()
			end
		end

		function income.Think() 
			income:SetVisible(not TW.FlagIncomeStatus[flagID])
		end
	end

	if LocalPlayer():IsSuperAdmin() and TW.Changeable then
		local remove = vgui.Create("TerritoryWars.ButtonBase", info)
		remove:SetFontInternal("TW.SFont" .. ScrH())
		remove:SetText(TW.Labels.Remove)
		remove:SetImage("icon16/cross.png")
		remove:Dock(TOP)
		function remove:DoClick() 
			net.Start("TerritoryWars.RemoveFlag")
				net.WriteInt(flagID, 32)
			net.SendToServer()
		end
		local lastGroupReceived = TW.GroupReceived
		function remove:Think() 
			if lastGroupReceived < TW.GroupReceived then
				lastGroupReceived = TW.GroupReceived
				if not TW.Group then
					self:Remove()
				end
			end
		end
	end
end)