local hidelist = {"CHudAmmo", "CHudSecondaryAmmo", "CHudBattery", "CHudCrosshair", "CHudHealth", "CHudZoom", "CHudSuitPower", "CHUDQuickInfo"}
function HideHud(name)

    for k, v in ipairs(hidelist) do
        if name == v then
            return false
        end
    end

end
hook.Add("HUDShouldDraw", "DisableDefaultHUD", HideHud)

se.gui = {}

se.gui.hud = function() 
    
end


function drawHUD()


end

hook.Add("HUDPaint", "CustomHUD", drawHUD)
