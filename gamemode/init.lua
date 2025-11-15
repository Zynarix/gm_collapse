include("shared.lua")
AddCSLuaFile("shared.lua")

util.AddNetworkString( "FMENU" )
util.AddNetworkString( "svprint" )
util.AddNetworkString( "teamselect" )
util.AddNetworkString( "DeathNet" )


function GM:ShowSpare2(ply)
    --net.Start( "FMENU" )
    --net.Send( ply )
end


InitializeLuaFiles(GM.FolderName .. "/gamemode")


fonts = file.Find("gamemodes/collapse/content/fonts/*.ttf", "GAME")

for k, v in ipairs(fonts) do
    resource.AddSingleFile("gamemodes/collapse/content/fonts/" .. v)
end

print("Added fonts: ")
PrintTable(fonts)

local logs = Logger:New("server_activity")

logs:Write("Server started.")