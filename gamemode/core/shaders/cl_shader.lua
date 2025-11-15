local colorMod = {
    ["$pp_colour_addr"] = 0,
    ["$pp_colour_addg"] = 0,
    ["$pp_colour_addb"] = 0,
    ["$pp_colour_brightness"] = -0.15,
    ["$pp_colour_contrast"] = 1,
    ["$pp_colour_colour"] = 0.95,
    ["$pp_colour_mulr"] = 0.00,
    ["$pp_colour_mulg"] = 0.00,
    ["$pp_colour_mulb"] = 0.00
}

hook.Add("RenderScreenspaceEffects", "DarkAtmosphereCombined", function()
    if 1 then return end
    DrawColorModify(colorMod)
end)
