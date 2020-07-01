SWEP.PrintName = "Shop computer parts"
SWEP.Purpose = "Computer parts to create shop computer."
SWEP.Instructions = "Left mouse button to place shop computer."
SWEP.ViewModelFOV = 90
SWEP.Base = "territorywars.swep_base"
SWEP.Category = "TerritoryWars"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["Slam_base"] = { scale = Vector(1, 1, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Detonator"] = { scale = Vector(1, 1, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["Right hand thing"] = { type = "Model", model = "models/weapons/w_toolgun.mdl", bone = "ValveBiped.Bip01_R_Forearm", rel = "Left hand thing", pos = Vector(-6.753, 8.831, 4.675), angle = Angle(-155.456, -90, -5.844), size = Vector(0.95, 0.95, 0.95), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["Left hand thing"] = { type = "Model", model = "models/combine_helicopter/helicopter_bomb01.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "", pos = Vector(16.104, 0.518, -1.558), angle = Angle(134.416, 0, 0), size = Vector(0.107, 0.107, 0.107), color = Color(0, 0, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
}

function SWEP:PrimaryAttack() 
	if SERVER then
		if self.Owner:TWGetGroup() == nil then
			return
		end
		local eyeTrace = self.Owner:GetEyeTrace()
		if self.Owner:GetPos():DistToSqr(eyeTrace.HitPos) < 40000 then
			local entity = ents.Create("territorywars.shop")
			entity:Spawn()
			entity:SetGroupOwner(self.Owner:TWGetGroup())
			local min, max = entity:GetPhysicsObject():GetAABB()
			local pos = eyeTrace.HitPos
			entity:SetPos(pos)
			self.Owner:TWGetGroup():OnShopComputerCreated()
			self.Owner:StripWeapon("territorywars.shop_computer_parts")
		end
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end
