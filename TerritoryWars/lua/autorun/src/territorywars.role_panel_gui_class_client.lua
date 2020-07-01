local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local RolePanel = {}

AccessorFunc(RolePanel, "Role", "Role")

function RolePanel:SetRole(role) 
	group = TW.Group
	self.Role = role
	self.RoleLabel:SetText(role.Name)
	self.RoleLabel:SetColor(role.Color)
	self.RoleLabel:SizeToContents()

	self.SalaryLabel:SetText(TW.Labels.Salary .. ": " .. role.Salary)
	self.SalaryLabel:SizeToContents()

	function self.SalaryLabel.Think() 
		if RealTime() >= self.TWNextTime then
			self.TWNextTime = self.TWNextTime + 1
			self.SalaryLabel:SetText(TW.Labels.Salary .. ": " .. role.Salary)
			self.SalaryLabel:SizeToContents()
		end
	end

	if self.Role.Name ~= group.NoviceRole then
		local deleteButton = vgui.Create("DImageButton", self)
		deleteButton:SetImage("icon16/cross.png")
		deleteButton:SetStretchToFit(false)
		deleteButton:Dock(RIGHT)
		deleteButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, deleteButton)
		deleteButton:SetMouseInputEnabled(true)
		function deleteButton.DoClick() 
			net.Start("TerritoryWars.DeleteRole")
				net.WriteString(self.Role.Name)
			net.SendToServer()
		end
	end
end

function RolePanel:Paint(width, height) 
	draw.RoundedBox(0, 0, 0, width, height, Color(35, 35, 35))
end

function RolePanel:Init()
	group = TW.Group
	local lastGroupReceived = 0
	self:SetSize(width, ScrH() * 0.05)
	self.TWNextTime = 0

	self.RoleLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.RoleLabel:SetFontInternal("TW.Font" .. ScrH())
	self.RoleLabel:SizeToContents()
	self.RoleLabel:Dock(LEFT)

	self.SalaryLabel = vgui.Create("TerritoryWars.LabelBase", self)
	self.SalaryLabel:SetFontInternal("TW.Font" .. ScrH())
	self.SalaryLabel:SizeToContents()
	self.SalaryLabel:Dock(RIGHT)
	self.SalaryLabel.TWNextTime = RealTime()
	
	if not TW.MainWindowFromTablet or TW.RoleInteractionFromTablet then
		local settingsButton = vgui.Create("DImageButton", self)
		settingsButton:SetImage("icon16/cog.png")
		settingsButton:SetStretchToFit(false)
		settingsButton:Dock(RIGHT)
		settingsButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, settingsButton)
		function settingsButton:Think() 
			if lastGroupReceived < TW.GroupReceived then
				lastGroupReceived = TW.GroupReceived
				group = TW.Group
				local role = group.Roles[name]

				if not role then 
					return
				end

				local toolTipText = TW.Labels.ThisRoleCan

				local havePermisions = false

				for name, value in pairs(role.Permisions) do 
					havePermisions = havePermisions or value
					toolTipText = toolTipText .. "\n" .. TW.PermisionsList[name]
				end

				if havePermisions then
					settingsButton:SetTooltip(toolTipText)
				else
					settingsButton:SetTooltip(TW.Labels.AnySpecial)
				end
			end
		end

		settingsButton:SetMouseInputEnabled(true)
		function settingsButton.DoClick() 
			local roleDataWindow = vgui.Create("TerritoryWars.RoleDataWindow")
			roleDataWindow.Role = self.Role
			roleDataWindow.NameInput:SetText(self.Role.Name)
			roleDataWindow.SalaryInput:SetText(self.Role.Salary)
			roleDataWindow.ChoosedColor = self.Role.Color
			for key, _ in pairs(self.Role.Permisions) do 
				if self.Role.Permisions[key] == true then
					roleDataWindow.CheckBoxes[key]:SetChecked(true)
				end
			end
			function roleDataWindow.ApplyButton.DoClick() 
				local permisions = {}
				for key, checkBox in pairs(roleDataWindow.CheckBoxes) do 
					permisions[key] = checkBox:GetChecked()
				end
				net.Start("TerritoryWars.ChangeRole")
					net.WriteString(roleDataWindow.Role.Name)
					net.WriteString(roleDataWindow.NameInput:GetText())
					net.WriteInt(tonumber(roleDataWindow.SalaryInput:GetText()), 32)
					net.WriteTable(permisions)
					net.WriteTable(roleDataWindow.ChoosedColor)
				net.SendToServer()
				LocalPlayer():TWGetGroupMember().Role = roleDataWindow.NameInput:GetText()
				if IsValid(self) then
					self.RoleLabel:SetText(roleDataWindow.NameInput:GetText())
					self.RoleLabel:SetColor(roleDataWindow.ChoosedColor)
					self.RoleLabel:SizeToContents()
					self.SalaryLabel:SetText(roleDataWindow.SalaryInput:GetText())
					self.SalaryLabel:SizeToContents()
				end
				roleDataWindow:Close()
			end
		end

		local slotsButton = vgui.Create("DImageButton", self)
		slotsButton:SetImage("icon16/table_multiple.png")
		slotsButton:SetStretchToFit(false)
		slotsButton:Dock(RIGHT)
		slotsButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, slotsButton)

		function slotsButton.DoClick() 
			local slots = vgui.Create("TerritoryWars.RoleSlotsWindow")
			slots:SetRoleName(self.Role.Name)
		end
	end

	if TW.RoleUpgrading then
		local upgradeButton = vgui.Create("DImageButton", self)
		upgradeButton:SetImage("icon16/arrow_up.png")
		upgradeButton:SetStretchToFit(false)
		upgradeButton:Dock(RIGHT)
		upgradeButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, upgradeButton)

		function upgradeButton.DoClick() 
			local upgrade = vgui.Create("TerritoryWars.UpgradeRoleWindow")
			upgrade:SetRole(self.Role)
		end
	end
end

vgui.Register("TerritoryWars.RolePanel", RolePanel, "TerritoryWars.PanelBase")