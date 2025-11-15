local meta = FindMetaTable("Player")

function meta:GetMoney()
    return self:GetNWInt("money")
end

function meta:GetExp()
    return self:GetNWInt("exp")
end

function meta:GetLvl()
    return self:GetNWInt("lvl")
end

function meta:CanAfford(price)
    local curmoney = self:GetNWInt("money")
    if curmoney >= price then return true else return false end
end

function meta:GetInv()
    return self.inv or {}
end

function meta:GetRank()
    return self:GetNWString("PlRank") or "user"
end

function meta:HasPermission(permission)
    local rank = self:GetRank()
    
    if not Ranks[rank] then
        print("Invalid rank: " .. tostring(rank))
        return false
    end

    local perms = Ranks[rank].permissions
    if not perms then
        print("Permissions missing for rank: " .. tostring(rank))
        return false
    end

    for k, v in pairs(perms) do
        if permission == v then
            return true
        end
    end
    return false
end
