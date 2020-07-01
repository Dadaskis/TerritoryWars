local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local LanguageSwitchButton = {}

function LanguageSwitchButton:Init()
	self.ID = 1000
	self:SetText(TW.Labels.LanguageSwitch)
	self:SetFont("TW.SFont" .. ScrH())
	self:SetIcon("icon16/flag_orange.png")
	self:SizeToContents()
	self.TWGroupWindow = {}
end

function LanguageSwitchButton:SetGroupWindow(window) 
	self.TWGroupWindow = window
end

function LanguageSwitchButton:DoClick() 
	local menu = DermaMenu()
	for language, func in pairs(TW.Languages) do 
		local langMenu = menu:AddOption(language)
		langMenu.DoClick = function() 
			func()
			self.TWGroupWindow:Close()
		end
	end
	menu:Open()
end

vgui.Register("TerritoryWars.LanguageSwitchButton", LanguageSwitchButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddLanguageSwitchButton", function(groupWindow) 
	local languageButton = vgui.Create("TerritoryWars.LanguageSwitchButton")
	groupWindow:AddToChoosePanel(languageButton)
	languageButton:SetGroupWindow(groupWindow)
end)