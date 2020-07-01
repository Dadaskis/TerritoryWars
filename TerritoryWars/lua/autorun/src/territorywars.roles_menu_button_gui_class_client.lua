local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local RolesButton = {}

AccessorFunc(RolesButton, "ChoosePanel", "ChoosePanel")
AccessorFunc(RolesButton, "ChoosedPanel", "ChoosedPanel")

function RolesButton:Init() 
	group = TW.Group
	self.NotInTablet = not TW.RoleMenuFromTablet
	self.ID = 1
	self:SetFontInternal("TW.SFont" .. ScrH())
	self:SetText(TW.Labels.Roles)
	self:SetIcon("icon16/user_red.png")
end

function RolesButton:DoClick() 
	self.ChoosedPanel:Clear()

	local leaderPanel = vgui.Create("TerritoryWars.RolesMenuPanel", self.ChoosedPanel)
	leaderPanel:Dock(FILL)
end

vgui.Register("TerritoryWars.RolesButton", RolesButton, "TerritoryWars.ButtonBase")

hook.Add("TerritoryWars.MainGroupWindowOpened", "TerritoryWars.AddRolesButton", function(groupWindow) 
	if LocalPlayer():SteamID() == TW.Group.LeaderSteamID 
			or LocalPlayer():TWGetGroupRole().Permisions["Role creating"] then
		local Roles = vgui.Create("TerritoryWars.RolesButton")
		groupWindow:AddToChoosePanel(Roles)
		Roles:SetChoosePanel(groupWindow:GetChoosePanel())
		Roles:SetChoosedPanel(groupWindow:GetChoosedPanel())
	end
end)