local UpgradePanel = {}
local TW = TerritoryWars
local TWUtil = TW.Utilities

function UpgradePanel:SetRole(role) 
	self.Role = role
end

function UpgradePanel:SetUpgrade(upgrade) 
	local lastRoleReceived = 0
	if self.Role then
		self.Upgrade = upgrade
		self.UpgradeIcon:SetImage(upgrade.Icon)

		self.UpgradeName:SetFontInternal("TW.SFont" .. ScrH())
		self.UpgradeName:SetText(TW.Labels.Upgrades[upgrade.Name])
		self.UpgradeName:SizeToContents()
		self.UpgradeName:SetMouseInputEnabled(true)
		
		function self.UpgradeName.OnCursorEntered() 
			self.ToolTip = vgui.Create("TerritoryWars.ToolTip", self.UpgradeName)
			self.ToolTip:SetText(TW.Labels.UpgradesDescription[upgrade.Name])
			self.ToolTip:SetText(self.ToolTip:GetText() .. "\n" .. TW.Labels.OriginalPrice .. upgrade.StartPrice)
			if TW.RoleUpgradeCoolDown then
				if upgrade.Maximum > 1 then
					self.ToolTip:SetText(
						self.ToolTip:GetText() .. "\n"
						.. TW.Labels.FirstBuy .. 
							math.max(self.Upgrade.FirstCoolDownSeconds * (1 - ((TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents / 100) 
								* TW.GroupUpgrades["RoleUpgradeCooldownDiscount"])), 0) .. " " .. TW.Labels.Seconds .. "\n"
						.. TW.Labels.AnotherBuy ..
								math.max(self.Upgrade.CoolDownSeconds * (1 - ((TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents / 100) 
								* TW.GroupUpgrades["RoleUpgradeCooldownDiscount"])), 0) .. " " .. TW.Labels.Seconds .. "\n"
					)
				else
					self.ToolTip:SetText(
						self.ToolTip:GetText() .. "\n"
						.. TW.Labels.BuyLength .. 
							math.max(self.Upgrade.FirstCoolDownSeconds * (1 - ((TW.GroupRoleUpgradeCooldownDiscountUpgradeProcents / 100) 
								* TW.GroupUpgrades["RoleUpgradeCooldownDiscount"])), 0) .. " " .. TW.Labels.Seconds .. "\n"
					)
				end
			end
			self.ToolTip:MakePopup()
		end
		function self.UpgradeName.OnCursorExited() 
			if self.ToolTip and IsValid(self.ToolTip) then
				self.ToolTip:Remove()
			end
		end

		self.UpgradeTier:SetFontInternal("TW.SFont" .. ScrH())
		self.UpgradeTier:SetText(TW.Labels.Tier .. ": " .. tostring(self.Role.Upgrades[upgrade.Name]))
		self.UpgradeTier:SizeToContents()

		local price = upgrade.StartPrice * self.Role.UpgradedCount
		if TW.GroupUpgrading and TW.GroupRoleUpgradeDiscountUpgradeEnabled then
			price = 
				math.max(price * (1 - ((TW.GroupRoleUpgradeDiscountUpgradeProcents / 100) * TW.GroupUpgrades["RoleUpgradeDiscount"])), 0)
		end

		self.UpgradePrice:SetFontInternal("TW.SFont" .. ScrH())
		self.UpgradePrice:SetText(TW.Labels.Price .. ": " .. tostring(price))
		self.UpgradePrice:SizeToContents()

		function self:Think() 
			if not TW.MainWindowFromTablet or TW.RoleInteractionFromTablet then
				self.UpgradeButton:SetVisible(os.time() >= (TW.UpgradeCoolDownEnd[self.Role.Name] or 0))
			end
			if lastRoleReceived < TW.RolesReceived or lastRoleReceived < TW.GroupUpgradesReceived then
				lastRoleReceived = math.max(TW.RolesReceived, TW.GroupUpgradesReceived)
				self.Role = TW.Group.Roles[self.Role.Name]
				local upgradeTier = self.Role.Upgrades[self.Upgrade.Name]
				self.Upgrade = upgrade

				if upgrade ~= upgrade.Maximum then
					self.UpgradeTier:SetText(TW.Labels.Tier .. ": " .. tostring(self.Role.Upgrades[upgrade.Name]))
				else
					self.UpgradeTier:SetText(TW.Labels.Tier .. ": " .. "MAX")
				end
				self.UpgradeTier:SizeToContents()

				if upgradeTier ~= upgrade.Maximum then
					price = upgrade.StartPrice * self.Role.UpgradedCount
					if TW.GroupUpgrading and TW.GroupRoleUpgradeDiscountUpgradeEnabled then
						price = 
							math.max(price * (1 - ((TW.GroupRoleUpgradeDiscountUpgradeProcents / 100) 
								* TW.GroupUpgrades["RoleUpgradeDiscount"])), 0)
					end
					self.UpgradePrice:SetText(TW.Labels.Price .. ": " .. tostring(price))
				else
					self.UpgradePrice:SetText(TW.Labels.Price .. ": " .. "---")
				end
				self.UpgradePrice:SizeToContents()
			end
		end
	end
end

function UpgradePanel:Init() 
	self.UpgradeIcon = vgui.Create("DImage", self)
	self.UpgradeIcon:Dock(LEFT)
	self.UpgradeIcon:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)
	self.UpgradeIcon:InvalidateParent()
	self.UpgradeIcon:SetSize(ScrH() * 0.02, ScrH() * 0.02)

	self.UpgradeName = vgui.Create("TerritoryWars.LabelBase", self)
	self.UpgradeName:Dock(LEFT)
	self.UpgradeName:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)

	self.UpgradePrice = vgui.Create("TerritoryWars.LabelBase", self)
	self.UpgradePrice:Dock(RIGHT)
	self.UpgradePrice:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)	

	self.UpgradeTier = vgui.Create("TerritoryWars.LabelBase", self)
	self.UpgradeTier:Dock(RIGHT)
	self.UpgradeTier:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)	

	if not TW.MainWindowFromTablet or TW.RoleInteractionFromTablet then
		self.UpgradeButton = vgui.Create("DImageButton", self)
		self.UpgradeButton:SetImage("icon16/arrow_up.png")
		self.UpgradeButton:SetStretchToFit(false)
		self.UpgradeButton:Dock(RIGHT)
		self.UpgradeButton:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)	
		self.UpgradeButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, self.UpgradeButton)

		function self.UpgradeButton.DoClick() 
			if os.time() >= (TW.UpgradeCoolDownEnd[self.Role.Name] or 0) then
				net.Start("TerritoryWars.RoleUpgrade")
					net.WriteString(string.Split(self.Upgrade.Name, "Upgrade")[1])
					net.WriteString(self.Role.Name)
				net.SendToServer()
			end
		end
	end
end

vgui.Register("TerritoryWars.RoleUpgradePanel", UpgradePanel, "TerritoryWars.PanelBase")