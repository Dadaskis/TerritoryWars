SWEP.PrintName = "Territory capturer"
SWEP.Purpose = "Created for capturing territories."
SWEP.Instructions = "Left mouse button for capture."
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

SWEP.Base = "territorywars.swep_base"

SWEP.ViewModelBoneMods = {
	["Detonator"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Slam_panel"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Slam_base"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_L_UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(1.667, 0, -30), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["Lamp"] = { type = "Sprite", sprite = "sprites/blueglow1", bone = "ValveBiped.Bip01_L_Finger41", rel = "Slam", pos = Vector(-1.558, 1.557, 0.518), size = { x = 1.145, y = 1.145 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
	["Slam"] = { type = "Model", model = "models/weapons/w_slam.mdl", bone = "ValveBiped.Bip01_R_Finger41", rel = "", pos = Vector(3.635, 2.596, -1.558), angle = Angle(-19.871, 57.272, 80.649), size = Vector(0.755, 0.755, 0.755), color = Color(255, 213, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Lamp+"] = { type = "Sprite", sprite = "sprites/blueglow1", bone = "ValveBiped.Bip01_L_Finger41", rel = "Slam", pos = Vector(-0.519, -1.558, 0.518), size = { x = 1.145, y = 1.145 }, color = Color(255, 255, 0, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.WElements = {
}

SWEP.IronSightsPos = Vector(-0.16, 0, -0.201)
SWEP.IronSightsAng = Vector(0, 0, 0)

function SWEP:PrimaryAttack() 
	print(123123)
	if SERVER then
		TerritoryWars:Capture(self.Owner)
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end
