hook.Add("PlayerBindPress", "DisableQMenu", function(ply, bind)

    if bind == "+menu" and not ply:HasPermission("qmenu") then
        return true
    end

    if bind == "+menu_context" and not ply:HasPermission("cmenu") then
        return true
    else
        return false
    end
end)