GM.Name = "Collapse HL2:RPG"
GM.Author = "conn.gez"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("sandbox")
--include("fmenu.lua")
--include("menu.lua")

local excludedFiles = {
    ["init.lua"] = true,
    ["shared.lua"] = true,
    ["cl_init.lua"] = true
}

local includedFiles = {
    sv = {},
    cl = {},
    shared = {}
}


function InitializeLuaFiles(directory)
    local files, directories = file.Find(directory .. "/*", "LUA")

    for _, dir in ipairs(directories) do
        InitializeLuaFiles(directory .. "/" .. dir)
    end

    for _, luaFile in ipairs(files) do
        if excludedFiles[luaFile] then
            continue
        end

        local filePath = directory .. "/" .. luaFile

        if string.EndsWith(luaFile, ".lua") then
            if string.StartWith(luaFile, "sv_") then
                if not includedFiles.sv[filePath] then
                    if SERVER then
                        include(filePath)
                        print("Included (SV): " .. filePath)
                    end
                    includedFiles.sv[filePath] = true
                end
            elseif string.StartWith(luaFile, "cl_") then
                if not includedFiles.cl[filePath] then
                    if SERVER then
                        AddCSLuaFile(filePath)
                    end
                    if CLIENT then
                        include(filePath)
                        print("Included (CL): " .. filePath)
                        --svprint(" Included: " .. filePath)
                    end
                    includedFiles.cl[filePath] = true
                end
            else
                if not includedFiles.shared[filePath] then
                    if SERVER then
                        AddCSLuaFile(filePath)
                        include(filePath)
                        print("Included (SHARED): " .. filePath)
                    elseif CLIENT then
                        include(filePath)
                        print("Included (SHARED): " .. filePath)
                    end
                    includedFiles.shared[filePath] = true
                end
            end
        end
    end
end


hook.Add("CreateTeams", "TeamsInit", function()
    team.SetUp(2, "Rebels", Color(204, 102, 0, 255), false)
    team.SetUp(3, "Combine", Color(51, 51, 255, 255), false)
end)

se = se or {}