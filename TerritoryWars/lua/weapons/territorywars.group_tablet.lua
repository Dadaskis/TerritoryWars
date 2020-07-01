SWEP.PrintName = "Group tablet"
SWEP.Purpose = "Created for showing group menu."
SWEP.Instructions = "Left mouse button to see group menu."
SWEP.Base = "territorywars.swep_base"
SWEP.Category = "TerritoryWars"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 90
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(-5.557, 0, 0) },
	["Slam_base"] = { scale = Vector(1, 1, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Detonator"] = { scale = Vector(1, 1, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["Right hand thing"] = { type = "Model", model = "models/props_phx/sp_screen.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.831, 5.714, 1.557), angle = Angle(-167.144, 52.597, -3.507), size = Vector(0.237, 0.237, 0.237), color = Color(255, 40, 40, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
}

function SWEP:PrimaryAttack() 
	if CLIENT then
		TerritoryWars.MainWindowFromTablet = true
		vgui.Create("TerritoryWars.GroupWindow")
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end
