local TW = TerritoryWars
local TWUtil = TW.Utilities
local group

local RolesMenuPanel = {}

function RolesMenuPanel:Init() 
	group = TW.Group
	local currentPlayerPermisions = LocalPlayer():TWGetGroupRole().Permisions

	if LocalPlayer():SteamID() == group.LeaderSteamID or currentPlayerPermisions["Role creating"] then
		vgui.Create("TerritoryWars.RolesListPanel", self):Dock(FILL)
	end
end

vgui.Register("TerritoryWars.RolesMenuPanel", RolesMenuPanel, "TerritoryWars.PanelBase")