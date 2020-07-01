local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local RolesPanel = {}

function RolesPanel:Init() 
	local lastRolesReceived = 0
	group = TW.Group
	local role = LocalPlayer():TWGetGroupRole()

	local rolePanel = vgui.Create("TerritoryWars.PanelBase", self)
	rolePanel:Dock(TOP)

	local rolesLabel = vgui.Create("TerritoryWars.LabelBase", rolePanel) 
	rolesLabel:SetFont("TW.Font" .. ScrH())
	rolesLabel:SetText(TW.Labels.Roles .. ":")
	rolesLabel:SizeToContents()
	rolesLabel:Dock(LEFT)

	if not TW.MainWindowFromTablet or TW.RoleInteractionFromTablet then
		local addRoleButton = vgui.Create("TerritoryWars.ButtonBase", rolePanel)
		addRoleButton:SetFontInternal("TW.SFont" .. ScrH())
		addRoleButton:SetText(TW.Labels.AddRole)
		addRoleButton:SizeToContents()
		addRoleButton:Dock(RIGHT)
		addRoleButton:DockMargin(ScrW() * 0.005, 0, ScrW() * 0.005, 0)
		function addRoleButton.DoClick() 
			local roleDataWindow = vgui.Create("TerritoryWars.RoleDataWindow", self)
			local priceLabel = vgui.Create("TerritoryWars.LabelBase", roleDataWindow)
			priceLabel:SetFont("TW.Font" .. ScrH())
			priceLabel:SetText(TW.Labels.Price .. ": " .. TW.RoleCreatePrice)
			priceLabel:SizeToContents()
			priceLabel:SetContentAlignment(5)
			priceLabel:Dock(BOTTOM)
			priceLabel:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
			function roleDataWindow.ApplyButton.DoClick() 
				local permisions = {}
				for key, checkBox in pairs(roleDataWindow.CheckBoxes) do 
					permisions[key] = checkBox:GetChecked()
				end
				net.Start("TerritoryWars.CreateRole")
					net.WriteString(roleDataWindow.NameInput:GetText())
					net.WriteInt(tonumber(roleDataWindow.SalaryInput:GetText()), 32)
					net.WriteTable(permisions)
					net.WriteTable(roleDataWindow.ChoosedColor)
				net.SendToServer()
				roleDataWindow:Close()
			end
		end

		local incomesButton = vgui.Create("TerritoryWars.ButtonBase", rolePanel)
		incomesButton:SetFontInternal("TW.SFont" .. ScrH())
		incomesButton:SetText(TW.Labels.Incomes)
		incomesButton:SizeToContents()
		incomesButton:Dock(RIGHT)
		incomesButton:DockMargin(ScrW() * 0.005, 0, ScrW() * 0.005, 0)
		function incomesButton.DoClick() 
			vgui.Create("TerritoryWars.IncomesWindow")
		end

		if TW.RoleUpgrading then
			local upgradesButton = vgui.Create("TerritoryWars.ButtonBase", rolePanel)
			upgradesButton:SetFontInternal("TW.SFont" .. ScrH())
			upgradesButton:SetText(TW.Labels.RoleUpgrades)
			upgradesButton:SizeToContents()
			upgradesButton:Dock(RIGHT)
			upgradesButton:DockMargin(ScrW() * 0.005, 0, ScrW() * 0.005, 0)
			function upgradesButton.DoClick() 
				local upgrade = vgui.Create("TerritoryWars.UpgradeRoleWindow")
				upgrade:SetRole(TW.Group.Roles[TW.Group.NoviceRole])
			end
		end
	end

	local scrollPanel = vgui.Create("TerritoryWars.ScrollPanelBase", self)
	scrollPanel:Dock(FILL)

	local rolesGrid = scrollPanel:GetCanvas()
	local function fillGrid() 
		for name, role in pairs(group.Roles) do
			local rolePanel = vgui.Create("TerritoryWars.RolePanel", rolesGrid)
			rolePanel:SetRole(role)
			rolePanel:Dock(TOP)
			rolePanel:DockMargin(0, ScrH() * 0.005, 0, ScrH() * 0.005)
		end
	end
	fillGrid()
	function rolesGrid:Think() 
		if lastRolesReceived < TW.RolesReceived then
			lastRolesReceived = TW.RolesReceived
			group = TW.Group
			self:Clear()
			fillGrid()
		end
	end
end

vgui.Register("TerritoryWars.RolesListPanel", RolesPanel, "TerritoryWars.PanelBase")