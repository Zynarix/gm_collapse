hook.Add("DrawDeathNotice", "HideDeaths", function()
    return false
end)

hook.Add("HUDPaint", "DeathEffect", function()
    if !IsValid(LocalPlayer()) then return end
    local pl = LocalPlayer()
    if !pl:Alive() then
        surface.SetDrawColor(0,0,0,255)
        surface.DrawRect(0, 0, ScrW(), ScrH())
    else
        hook.Remove("HUDPaint", "FadeInEffect")
    end
end)