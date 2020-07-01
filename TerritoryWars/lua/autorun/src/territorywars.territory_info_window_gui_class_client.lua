local TW = TerritoryWars
local TWUtil = TW.Utilities

local InfoWindow = {}

AccessorFunc(InfoWindow, "TerritoryCoord", "TerritoryCoord")
AccessorFunc(InfoWindow, "Owner", "Owner")
AccessorFunc(InfoWindow, "Bonuses", "Bonuses")
AccessorFunc(InfoWindow, "AdditionalInfo", "AdditionalInfo")
AccessorFunc(InfoWindow, "Name", "Name")

function InfoWindow:SettingsOnApply(name, additionalInfo) end

function InfoWindow:BonusSettingsOnApply(settingsWindow) end

function InfoWindow:UpdateDescription() 
	self.DescriptionLabel:SetText("")
	if self.Owner then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. "\n" ..
			TW.Labels.Owner .. ": " .. self.Owner
		)
	end

	if self.Name then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. "\n" .. self.Name
		)
	end

	if self.TerritoryCoord then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. " (" .. self.TerritoryCoord .. ")"
		)
	end

	if table.Count(self.Bonuses) > 0 then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. "\n" ..
			TW.Labels.CaptureBonuses .. ":"
		)
		for _, bonus in pairs(self.Bonuses) do 
			if not bonus.Deleted then
				self.DescriptionLabel:SetText(
					self.DescriptionLabel:GetText() .. "\n" ..
					TW.Labels.BonusText[bonus.Name](bonus)
				)
			end
		end
	end

	if self.AdditionalInfo then
		self.DescriptionLabel:SetText(
			self.DescriptionLabel:GetText() .. "\n\n" ..
			self.AdditionalInfo
		)
	end

	self.DescriptionLabel:InvalidateParent()
	self.DescriptionLabel:SizeToContents()
end

function InfoWindow:Init()
	self:SetSize(ScrW() * 0.5, ScrH() * 0.6)
	self:Center()
	self:MakePopup()

	if LocalPlayer():IsSuperAdmin() and TW.Changeable then
		local settingsButton = vgui.Create("TerritoryWars.ButtonBase", self)
		settingsButton:SetImage("icon16/cog.png")
		settingsButton:SetText(TW.Labels.BonusSettings)
		settingsButton:SetFontInternal("TW.SFont" .. ScrH())
		settingsButton:Dock(TOP)
		function settingsButton.DoClick() 
			local window = vgui.Create("TerritoryWars.TerritoryBonusesWindow")
			window:SetBonuses(self.Bonuses)
			window:MakePopup()
			window:Center()

			function window.OnApply() 
				self:BonusSettingsOnApply(window)
			end
		end
		
		local settings2Button = vgui.Create("TerritoryWars.ButtonBase", self)
		settings2Button:SetImage("icon16/cog.png")
		settings2Button:SetText(TW.Labels.Settings)
		settings2Button:SetFontInternal("TW.SFont" .. ScrH())
		settings2Button:Dock(TOP)
		function settings2Button.DoClick() 
			local window = vgui.Create("TerritoryWars.TerritorySettingsWindow")
			window:SetAdditionalInfo(self.AdditionalInfo)
			window:SetName(self.Name)
			window:Center()
			window:MakePopup()

			function window.OnApply(_, name, additionalInfo) 
				self:SettingsOnApply(name, additionalInfo)
			end
		end
	end

	self.DescriptionLabel = vgui.Create("DTextEntry", self)
	--self.DescriptionLabel:SetEditable(false)
	self.DescriptionLabel:SetKeyBoardInputEnabled(false)
	self.DescriptionLabel:SetMultiline(true)
	self.DescriptionLabel:SetTextColor(TW.TextColor)
	self.DescriptionLabel:SetDrawBackground(false)
	self.DescriptionLabel:SetFont("TW.SFont" .. ScrH())
	self.DescriptionLabel:Dock(FILL)
	self.DescriptionLabel:SetVerticalScrollbarEnabled(true)
end

vgui.Register("TerritoryWars.TerritoryInfoWindow", InfoWindow, "TerritoryWars.WindowBase")