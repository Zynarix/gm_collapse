local meta = FindMetaTable("Player")

function meta:SetRank(rank)
    self.rank = rank
    return self:SetNWString("PlRank", rank)
end

hook.Add( "PlayerNoClip", "BlockNoclip", function( ply, state )
	if !state then
		return true
    elseif state && ply:HasPermission("noclip") then
        return true
	else
		return false
	end
end )