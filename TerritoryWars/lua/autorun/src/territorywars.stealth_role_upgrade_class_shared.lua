local TW = TerritoryWars
 
local upgrade = TW.RoleUpgrade()
upgrade.Icon = "icon16/eye.png"
upgrade.Name = "Stealth"
upgrade.StartPrice = TW.StealthUpgradePrice
upgrade.AddUpgradedCount = TW.StealthAddPrice
upgrade.Maximum = 1
upgrade.CoolDownSeconds = TW.StealthCoolDown
upgrade.FirstCoolDownSeconds = TW.StealthCoolDown

TW.StealthTimers = {}

if SERVER then

    hook.Add("TerritoryWars.BulletDamageByPlayer", "TerritoryWars.StealthUpgrade", function(player, target, damageInfo) 
    	if not target:IsPlayer() then
    		return
    	end
    	if player:TWGetGroupRole().Upgrades["Stealth"] > 0 then
    		local degrees = math.deg(math.acos((player:GetAimVector():Dot(target:GetAimVector()))))
    		if degrees < TW.StealthFOVNeeded then
    			damageInfo:ScaleDamage(TW.CriticalDamage)
    		end
    	end
        TW.StealthTimers[target:SteamID()] = os.time() + TW.StealthDisableTime
    end)

    if TW.StealthEnableInvisible then
        hook.Add("Think", "TerritoryWars.HandleStealthInvisible", function() 
            for _, ply in pairs(player.GetAll()) do
                if not ply:TWGetGroup() then
                    ply:SetRenderMode(RENDERMODE_NORMAL)
                    ply:SetColor(Color(255, 255, 255, 255))
                    continue
                end
                if (ply:TWGetGroupRole() or {Upgrades = {Stealth = 0}}).Upgrades["Stealth"] > 0 then
                    if ply:Crouching() then
                        if TW.StealthTimers[ply:SteamID()] == nil then
                            TW.StealthTimers[ply:SteamID()] = 0
                        end
                        if TW.StealthTimers[ply:SteamID()] > os.time() then
                            ply:SetRenderMode(RENDERMODE_NORMAL)
                            ply:SetColor(Color(255, 255, 255, 255))
                            continue
                        end
                        ply:SetRenderMode(RENDERMODE_TRANSALPHA)
                        ply:SetColor(Color(0, 0, 0, 8))
                    else
                        ply:SetRenderMode(RENDERMODE_NORMAL)
                        ply:SetColor(Color(255, 255, 255, 255))
                    end
                end
            end
        end)

        hook.Add("EntityFireBullets", "TerritoryWars.MakeNonInvisibleIfShoot", function(entity) 
            print("Fire bullets: ", entity)
            if entity:IsPlayer() then
                TW.StealthTimers[entity:SteamID()] = os.time() + TW.StealthDisableTime
            end
        end)
    end

end

TW.UpgradeTemplates.Stealth = upgrade