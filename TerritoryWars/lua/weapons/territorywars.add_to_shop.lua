local TW = TerritoryWars
SWEP.PrintName = "Add to shop"
SWEP.Purpose = "Created to add items to shop."
SWEP.Instructions = "Left mouse button to add entity to shop."
SWEP.Base = "territorywars.swep_base"

SWEP.Base = "territorywars.swep_base"
SWEP.Category = "TerritoryWars"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.AdminOnly = false


SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 81.809045226131
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {}

SWEP.IronSightsPos = Vector(-3.217, 0, 0)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {
	["Lamp"] = { type = "Sprite", sprite = "sprites/blueglow1", bone = "ValveBiped.square", rel = "", pos = Vector(-0.519, 0.518, 10.909), size = { x = 7.697, y = 7.697 }, color = Color(255, 198, 255, 178), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}

SWEP.WElements = {
	["Lamp"] = { type = "Sprite", sprite = "sprites/blueglow1", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.947, -6.753, 0), size = { x = 9.189, y = 9.189 }, color = Color(255, 163, 255, 201), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false}
}



function SWEP:PrimaryAttack() 
	if SERVER then
		if self.Owner:IsSuperAdmin() and TW.Changeable then
			local ShopData = {}
			ShopData.Entity = duplicator.Copy(self.Owner:GetEyeTrace().Entity)
			if table.Count(ShopData.Entity.Entities) == 0 then
				self.Owner:ChatPrint("[TerritoryWars] This entity isn't supported duplicator (or it might be world). You can't add it to shop, sorry.")
				return
			end
			ShopData.Name = tostring(TW.ShopList.Counter)
			ShopData.Price = 0
			ShopData.AlwaysUnlocked = true
			ShopData.PlayerIsOwner = false
			TW.ShopList.Counter = TW.ShopList.Counter + 1
			TW.ShopList[TW.ShopList.Counter] = ShopData
			TW:Save()
			net.Start("TerritoryWars.GetShopItem")
				net.WriteInt(TW.ShopList.Counter, 32)
				net.WriteTable(TerritoryWars.Utilities:GetTableData(TW.ShopList[TW.ShopList.Counter]))
			net.Broadcast()
		end 
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end
