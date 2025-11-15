hook.Add( "PlayerInitialSpawn", "PlyInit", function(ply)
    local exp = ply:GetPData("exp", nil)
    local lvl = ply:GetPData("lvl", nil)
    local money = ply:GetPData("money", nil)
    local pos = ply:GetPData("pos", nil)
    local inv = ply:GetPData("inv", "[]")
    local rank = ply:GetPData("rank", "user")
    local faction = ply:GetPData("team", 1001)
    
    if exp then
        ply:SetExp(exp)
        if tostring(ply:GetExp()) == tostring(exp) then
            print("Loaded exp for: " .. ply:Nick() .. "\n")
        end
    end
    
    if lvl then
        ply:SetLvl(lvl)
        if tostring(ply:GetLvl()) == tostring(lvl) then
            print("Loaded lvl for: " .. ply:Nick() .. "\n")
        end
    end
    
    if money then
        ply:SetMoney(money)
        if tostring(ply:GetMoney()) == tostring(money) then
            print("Loaded money for: " .. ply:Nick() .. "\n")
        end
    end
    
    if pos then
        local posVec = Vector(pos)
        ply:SetPos(posVec + Vector(0, 5, 0))
    end
    
    if inv then
        ply:SetInv(util.JSONToTable(inv))
        if ply:GetInv() == util.JSONToTable(inv) then
            print("Loaded inv for: " .. ply:Nick() .. "\n")
        end
    end
    
    ply:SetRank(rank)
    if tostring(ply:GetRank()) == tostring(rank) then
        print("Loaded rank: " .. ply:GetRank() .. " for: " .. ply:Nick() .. "\n")
    end
    if Ranks[ply:GetRank()].name == Ranks["superadmin"].name then
        ply:SetUserGroup( "superadmin" )
    end
    
    hook.Run("PlayerReady", ply)
end)

hook.Add("PlayerDisconnected", "SavePlayerData", function(ply)
    local exp = ply:GetExp()
    local lvl = ply:GetLvl()
    local money = ply:GetMoney()
    local pos = ply:GetPos()
    local inv = ply:GetInv()
    local rank = ply:GetRank()
    local faction = ply:Team()

    ply:SetPData("money", money)
    ply:SetPData("pos", tostring(pos))
    ply:SetPData("lvl", lvl)
    ply:SetPData("exp", exp)
    ply:SetPData("inv", util.TableToJSON(inv))
    ply:SetPData("rank", rank)
end)
