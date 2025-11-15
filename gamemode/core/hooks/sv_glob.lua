local GM = GM or {}

function GM:PlyDataSave(ply, data, key)
    if !data or !key or !ply then return false end
    if istable(data) then
        local jsonData = util.TableToJSON(data)
        ply:SetPData(key, jsonData)
        return true
    end
    ply:SetPData(key, data)

    return true
    
end

function GM:PlyDataSave()

end

hook.Add("PlayerDisconnected", "SaveDataPlayers", function()
    GAMEMODE:PlyDataSave()
    GAMEMODE:OnPlyDataSave()
end)