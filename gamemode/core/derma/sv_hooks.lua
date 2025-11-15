hook.Add("PlayerDeath", "DeathNets", function(victim)
    local pl
    if victim:IsPlayer() then pl = victim end
    net.Start( "DeathNet" )
    net.Send(pl)
    
end)