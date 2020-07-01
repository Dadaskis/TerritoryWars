SWEP.PrintName = "Special door parts"
SWEP.Purpose = "Parts for special door"
SWEP.Instructions = "Left mouse button to place special door."
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
	["Left hand thing"] = { type = "Model", model = "models/combine_helicopter/helicopter_bomb01.mdl", bone = "ValveBiped.Bip01_L_Forearm", rel = "", pos = Vector(16.104, 0.518, -1.558), angle = Angle(134.416, 0, 0), size = Vector(0.107, 0.107, 0.107), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
}

SWEP.Primary.Ammo = "Special door parts"
SWEP.Primary.ClipSize = 100000000
SWEP.Primary.DefaultClip = 1

game.AddAmmoType( {
	name = "Special door parts",
	dmgtype = DMG_BULLET,
	tracer = TRACER_LINE,
	plydmg = 0,
	npcdmg = 0,
	force = 2000,
	minsplash = 1,
	maxsplash = 1
} )

function SWEP:PrimaryAttack() 
	if SERVER then
		if self.Owner:GetAmmoCount("Special door parts") <= 0 then
			return
		end
		if self.Owner:TWGetGroup() == nil then
			return
		end
		local eyeTrace = self.Owner:GetEyeTrace()
		if self.Owner:GetPos():DistToSqr(eyeTrace.HitPos) < 40000 then
			self:TakePrimaryAmmo(1)
			local entity = ents.Create("territorywars.special_door")
			entity:SetMaterial("phoenix_storms/metalset_1-2")
			entity:Spawn()
			entity:SetGroupOwner(self.Owner:TWGetGroup())
			local min, max = entity:GetPhysicsObject():GetAABB()
			local pos = eyeTrace.HitPos
			pos = pos + (max * eyeTrace.HitNormal)
			entity:SetPos(pos)
		end
	end
end

if CLIENT then
	local TWRenderModel

	hook.Add("Think", "TerritoryWars.SetSpecialDoorWireframePosition", function() 
		local activeWeapon = LocalPlayer():GetActiveWeapon()
		if IsValid(activeWeapon) and activeWeapon:GetClass() == "territorywars.special_door_parts" then
			if not TWRenderModel then
				util.PrecacheModel("models/hunter/blocks/cube2x2x2.mdl")
				TWRenderModel = ents.CreateClientProp("models/hunter/blocks/cube2x2x2.mdl")
				TWRenderModel:SetMaterial("models/wireframe")
				TWRenderModel:Spawn()
			end
			local trace = LocalPlayer():GetEyeTrace()
			local pos = trace.HitPos
			pos = pos + (Vector(47.450005, 47.450005, 47.450005) * trace.HitNormal)
			if IsValid(TWRenderModel) then
				TWRenderModel:SetPos(pos)
			end
		else
			if IsValid(TWRenderModel) then
				TWRenderModel:Remove()
			end
			TWRenderModel = nil
		end
	end)
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = LocalPlayer():GetAmmoCount("Special door parts")

	return self.AmmoDisplay

end
