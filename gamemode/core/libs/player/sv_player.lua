local meta = FindMetaTable("Player")
--local logs = Logger:New("server_activity")

function meta:AddMoney(ammount)
    local curmoney = self:GetNWInt("money")
    return self:SetNWInt( "money", curmoney + ammount )
end

function meta:SetMoney(ammount)
    return self:SetNWInt( "money", ammount )
end

function meta:AddExp(ammount)
    local curmoney = self:GetNWInt("exp")
    return self:SetNWInt( "exp", curmoney + ammount )
end

function meta:SetExp(ammount)
    return self:SetNWInt( "exp", ammount )
end

function meta:AddLvl(ammount)
    local curmoney = self:GetNWInt("lvl")
    return self:SetNWInt( "lvl", curmoney + ammount )
end

function meta:SetLvl(ammount)
    return self:SetNWInt( "lvl", ammount )
end

function meta:SetInv(tbl)
    local caller = caller or console
    self.inv = tbl or {}  
end

function meta:AddItem(item)
    self.inv = self.inv or {}

    if not istable(item) then
        table.insert(self.inv, item)
        return true
    end

    for _, v in ipairs(item) do
        table.insert(self.inv, v)
    end

    return true
end


concommand.Add( "adduserrank", function( ply, cmd, args, argss )
    if #args ~= 2 then print("Usage: <target> <rank>") return end
    local target, rank = args[1], args[2]
    local pl
    for _, v in ipairs(player.GetAll()) do
        if v:Nick() == tostring(target) then
            pl = v
            break
        end
    end
    if !pl then print("Invalid target: "..target) return end
    if !Ranks[rank] then print("Invalid rank: "..rank) end
    pl:SetRank(rank)

end )

concommand.Add( "addmoney", function( ply, cmd, args )
    if #args ~= 2 then print("Usage: <target> <ammount>") return end
    local target, ammount = args[1], args[2]
    local pl
    for _, v in ipairs(player.GetAll()) do
        if v:Nick() == tostring(target) then
            pl = v
            break
        end
    end
    if !pl then print("Invalid target: "..target) return end
    pl:AddMoney(ammount)
end )