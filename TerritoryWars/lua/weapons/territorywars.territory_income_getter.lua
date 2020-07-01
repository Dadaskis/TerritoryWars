local TW = TerritoryWars
SWEP.PrintName = "Income getter"

SWEP.Purpose = "Created for getting income from territories."
SWEP.Instructions = "Left mouse button to get income."

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
	["ValveBiped.Bip01_L_Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(-30, 0, 0), angle = Angle(-5.557, 0, 0) },
	["Slam_base"] = { scale = Vector(1, 1, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Detonator"] = { scale = Vector(1, 1, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["Right hand thing"] = { type = "Model", model = "models/props_c17/briefcase001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.714, 5.714, 1.557), angle = Angle(-180, -24.546, -3.507), size = Vector(0.56, 0.56, 0.56), color = Color(255, 236, 213, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
}

function SWEP:PrimaryAttack() 
	if SERVER then
		local pos = self.Owner:GetPos()
		local X = math.Round((pos.x / TW.TerritoryChunkSize) - 0.5)
		local Z = math.Round((pos.y / TW.TerritoryChunkSize) - 0.5)
		if (TW.Territories[X] or {})[Z] then
			if TW.Territories[X][Z].Parent then 
				X, Z = TW.Territories[X][Z].Parent[1], TW.Territories[X][Z].Parent[2]
			end
			if TW.Territories[X][Z].GroupName ~= self.Owner:TWGetGroup().Name then
				return
			end
			if not TW.TerritoryIncomeStatus[X .. " " .. Z] then
				TW.TerritoryIncomeStatus[X .. " " .. Z] = true 
				net.Start("TerritoryWars.TerritoryIncomeStatus")
					net.WriteString(X .. " " .. Z)
					net.WriteBool(true)
				net.Broadcast()
				local time = math.huge - 1
				for _, data in pairs(TW.TerritoryBonusMap[X .. " " .. Z]) do 
					if data.Name == "Income" then
						time = math.min(data.Properties.Delay, time)
					end
				end
				timer.Simple(time, function() 
					TW.TerritoryIncomeStatus[X .. " " .. Z] = false
					net.Start("TerritoryWars.TerritoryIncomeStatus")
						net.WriteString(X .. " " .. Z)
						net.WriteBool(false)
					net.Broadcast()
				end)
				local incomeGetted = false
				for _, bonus in pairs(TW.TerritoryBonusMap[X .. " " .. Z] or {}) do 
					if bonus.Name == "Income" then
						bonus:TakePlayerPoints(self.Owner)
						if TW:GetPlayerData(self.Owner).IncomePoints > 0 then
							incomeGetted = true
						end
					end
				end
				if incomeGetted then
					net.Start("TerritoryWars.YouGetIncome")
					net.Send(self.Owner)
				end
			end
		end
	end
end

function SWEP:SecondaryAttack() end

function SWEP:Reload() end
