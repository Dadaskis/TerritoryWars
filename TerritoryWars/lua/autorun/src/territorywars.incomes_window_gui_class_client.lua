local TW = TerritoryWars

local IncomesWindow = {}

function IncomesWindow:Init() 
	self:SetSize(ScrW() * 0.5, ScrH() * 0.7)
	self:Center()
	self:MakePopup()

	local group = TW.Group

	if LocalPlayer():SteamID() == group.LeaderSteamID then
		local salarySettings = vgui.Create("TerritoryWars.ButtonBase", self)
		salarySettings:SetFont("TW.SFont" .. ScrH())
		salarySettings:SetText(TW.Labels.SalarySettings)
		salarySettings:Dock(TOP)
		function salarySettings:DoClick() 
			local frame = vgui.Create("TerritoryWars.WindowBase")
			frame:SetSize(ScrW() * 0.5, ScrH() * 0.2)
			frame:Center()
			frame:MakePopup()
			local text = vgui.Create("TerritoryWars.LabelBase", frame)
			text:SetFont("TW.SFont" .. ScrH())
			text:SetText(TW.Labels.SalarySettingsText1 .. group.SalaryDelay .. TW.Labels.SalarySettingsText2)
			text:SizeToContents()
			text:SetContentAlignment(5)
			text:Dock(TOP)

			local panel = vgui.Create("TerritoryWars.PanelBase", frame)
			panel:Dock(TOP)
			panel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)

			local name = vgui.Create("TerritoryWars.LabelBase", panel)
			name:SetFont("TW.SFont" .. ScrH())
			name:SetText(TW.Labels.Delay .. ": ")
			name:SizeToContents()
			name:Dock(LEFT)
			name:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)

			local valueInput = vgui.Create("DTextEntry", panel)
			valueInput:SetFont("TW.SFont" .. ScrH())
			valueInput:SetText(tostring(group.SalaryDelay))
			valueInput:Dock(LEFT)
			valueInput:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
			valueInput:InvalidateParent()
			valueInput:SetSize(ScrW() * 0.4, select(2, valueInput:GetSize()))

			local apply = vgui.Create("TerritoryWars.ButtonBase", frame)
			apply:SetFontInternal("TW.SFont" .. ScrH())
			apply:SetText(TW.Labels.Apply)
			apply:Dock(BOTTOM)
			function apply.DoClick() 
				text:SetText(TW.Labels.SalarySettingsText1 .. valueInput:GetText() .. TW.Labels.SalarySettingsText2)
				text:SizeToContents()
				group.SalaryDelay = math.abs(tonumber(valueInput:GetText()))
				net.Start("TerritoryWars.SetSalaryDelay")
					net.WriteInt(tonumber(valueInput:GetText()), 32)
				net.SendToServer()
			end
		end
	end

	self.DescriptionLabel = vgui.Create("DTextEntry", self)
	self.DescriptionLabel:SetKeyBoardInputEnabled(false)
	self.DescriptionLabel:SetMultiline(true)
	self.DescriptionLabel:SetVerticalScrollbarEnabled(true)
	self.DescriptionLabel:SetTextColor(TW.TextColor)
	self.DescriptionLabel:SetDrawBackground(false)
	self.DescriptionLabel:SetFont("TW.SFont" .. ScrH())
	self.DescriptionLabel:Dock(FILL)
	self.DescriptionLabel:SetText(TW.Labels.Incomes .. ":\n")

	if TW.TerritoryBonusMap ~= nil then
		local checked = {}
		for coord, data in pairs(TW.TerritoryBonusMap) do 
			local coord = string.Split(coord, " ")
			local X, Z = tonumber(coord[1]), tonumber(coord[2])
			local groupName 
			if TW.Territories[X] and TW.Territories[X][Z] then
				groupName = TW.Territories[X][Z].GroupName
			end
			if not checked[X] then
				checked[X] = {}
			end
			local data = TW.TerritoryBonusMap[X .. " " .. Z]
			if (checked[X] and not checked[X][Z]) and (groupName == group.Name) then
				checked[X][Z] = true
				for _, bonus in pairs(data or {}) do 
					if bonus.Name == "Income" then
						self.DescriptionLabel:SetText(
							self.DescriptionLabel:GetText() 
							.. bonus.Properties.Points .. " " .. TW.Labels.Points2 .. " "
							.. TW.Labels.Per .. " " .. bonus.Properties.Delay .. " " .. TW.Labels.Seconds .. "."
							.. "\n"
						)
					end
				end
			end
		end
	end
	for flagID, data in pairs(TW.FlagBonusMap) do 
		if data.Owner == TW.Group.Name then
			for _, bonus in pairs(data.Bonuses or {}) do 
				if bonus.Name == "Income" then
					self.DescriptionLabel:SetText(
						self.DescriptionLabel:GetText() 
						.. bonus.Properties.Points .. " " .. TW.Labels.Points2 .. " "
						.. TW.Labels.Per .. " " .. bonus.Properties.Delay .. " " .. TW.Labels.Seconds .. "."
						.. "\n"
					)
				end
			end
		end
	end
	self.DescriptionLabel:SetText(
		self.DescriptionLabel:GetText() .. "\n" 
		.. TW.Labels.Salaries .. ":\n")
	local roles = {}
	for _, role in pairs(group.Roles) do 
		roles[role.Name] = 0
	end
	for _, member in pairs(group.Members) do 
		roles[member.Role] = roles[member.Role] + group.Roles[member.Role].Salary
	end
	for name, salary in pairs(roles) do 
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. 
			name .. ": " .. salary .. ".\n"
		)
	end
end

vgui.Register("TerritoryWars.IncomesWindow", IncomesWindow, "TerritoryWars.WindowBase")