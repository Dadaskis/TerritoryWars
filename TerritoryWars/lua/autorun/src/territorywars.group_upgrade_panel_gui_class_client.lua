local UpgradePanel = {}
local TW = TerritoryWars
local TWUtil = TW.Utilities

function UpgradePanel:SetUpgrade(upgrade) 
	local lastUpgradesReceived = 0
	self.Upgrade = upgrade
	self.UpgradeIcon:SetImage(upgrade.Icon)

	self.UpgradeName:SetFontInternal("TW.SFont" .. ScrH())
	self.UpgradeName:SetText(TW.Labels.GroupUpgrades[upgrade.Name])
	self.UpgradeName:SizeToContents()
	self.UpgradeName:SetMouseInputEnabled(true)
	
	local toolTip
	function self.UpgradeName.OnCursorEntered() 
		self.ToolTip = vgui.Create("TerritoryWars.ToolTip", self.UpgradeName)
		self.ToolTip:SetText(TW.Labels.GroupUpgradesDescription[upgrade.Name])
		self.ToolTip:SetText(self.ToolTip:GetText() .. "\n" .. TW.Labels.OriginalPrice .. upgrade.Price)
		if TW.GroupUpgradeCoolDown then
			if self.Upgrade.Maximum > 1 then
				self.ToolTip:SetText(
					self.ToolTip:GetText() .. "\n"
					.. TW.Labels.FirstBuy .. self.Upgrade.FirstCoolDownSeconds .. " " .. TW.Labels.Seconds .. "\n"
					.. TW.Labels.AnotherBuy .. self.Upgrade.CoolDownSeconds .. " " .. TW.Labels.Seconds .. "\n"
				)
			else
				self.ToolTip:SetText(
					self.ToolTip:GetText() .. "\n"
					.. TW.Labels.BuyLength .. self.Upgrade.FirstCoolDownSeconds .. " " .. TW.Labels.Seconds .. "\n"
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
	self.UpgradeTier:SetText(TW.Labels.Tier .. ": " .. tostring(TW.GroupUpgrades[upgrade.Name] or 0))
	self.UpgradeTier:SizeToContents()

	self.UpgradePrice:SetFontInternal("TW.SFont" .. ScrH())
	self.UpgradePrice:SetText(TW.Labels.Price .. ": " .. tostring(upgrade.Price * TW.GroupUpgradedCount))
	self.UpgradePrice:SizeToContents()

	function self:Think() 
		if not TW.MainWindowFromTablet or TW.GroupUpgradeInteractionFromTablet then
			self.UpgradeButton:SetVisible(os.time() > TW.GroupUpgradeCoolDownEnd)
		end
		if lastUpgradesReceived < TW.GroupUpgradesReceived then
			lastUpgradesReceived = TW.GroupUpgradesReceived
			local upgradeTier = TW.GroupUpgrades[self.Upgrade.Name]

			if upgradeTier <= self.Upgrade.Maximum then
				self.UpgradeTier:SetText(TW.Labels.Tier .. ": " .. tostring(TW.GroupUpgrades[self.Upgrade.Name] or 0))
			else
				self.UpgradeTier:SetText(TW.Labels.Tier .. ": " .. "MAX")
			end
			self.UpgradeTier:SizeToContents()

			if upgradeTier <= self.Upgrade.Maximum then
				self.UpgradePrice:SetText(TW.Labels.Price .. ": " .. tostring(self.Upgrade.Price * TW.GroupUpgradedCount))
			else
				self.UpgradePrice:SetText(TW.Labels.Price .. ": " .. "---")
			end
			self.UpgradePrice:SizeToContents()
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

	if not TW.MainWindowFromTablet or TW.GroupUpgradeInteractionFromTablet then
		self.UpgradeButton = vgui.Create("DImageButton", self)
		self.UpgradeButton:SetImage("icon16/arrow_up.png")
		self.UpgradeButton:SetStretchToFit(false)
		self.UpgradeButton:Dock(RIGHT)
		self.UpgradeButton:DockMargin(ScrW() * 0.005, ScrH() * 0.005, ScrW() * 0.005, ScrH() * 0.005)	
		self.UpgradeButton:InvalidateParent()
		TWUtil:SetPanelSize(0.02, 0.02, self.UpgradeButton)

		function self.UpgradeButton.DoClick() 
			if os.time() >= TW.GroupUpgradeCoolDownEnd then
				net.Start("TerritoryWars.GroupUpgrade")
					net.WriteString(self.Upgrade.Name)
				net.SendToServer()
			end
		end
	end
end

vgui.Register("TerritoryWars.GroupUpgradePanel", UpgradePanel, "TerritoryWars.PanelBase")