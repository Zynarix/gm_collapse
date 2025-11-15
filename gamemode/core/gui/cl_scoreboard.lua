local frameWidth = ScrW() / 2
local frameHeight = ScrH() / 1
local margin = 30
local bgColor = Color(0,0,0,255)
local textColor = Color(255, 255, 255)

surface.CreateFont( "TitleFont", {
	font = "Orbitron",
	weight = 400,
    size = 44,
    antialias = true,
	outline = 0,
} )

local function DrawVerticalText(text, font, x, y, color)
    surface.SetFont(font)
    surface.SetTextColor(color)
    
    local textHeight = select(2, surface.GetTextSize("A"))
    for i = 1, #text do
        local char = text[i]
        surface.SetTextPos(x, y + (i - 1) * textHeight)
        surface.DrawText(char)
    end
end

local function CreateScoreboard()
    if IsValid(scoreboardFrame) then
        scoreboardFrame:Remove()
    end

    scoreboardFrame = vgui.Create("DFrame")
    scoreboardFrame:SetTitle("")
    scoreboardFrame:SetSize(frameWidth, frameHeight)
    scoreboardFrame:Center()
    scoreboardFrame:SetDraggable(false)
    scoreboardFrame:ShowCloseButton(false)
    scoreboardFrame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, bgColor)
        DrawVerticalText("COLLAPSE RP", "TitleFont", w / 13, margin * 2, textColor)
    end

    local playerList = vgui.Create("DScrollPanel", scoreboardFrame)
    playerList:SetPos(margin * 4, margin * 2)
    playerList:SetSize(frameWidth - margin * 10, frameHeight - margin * 4)
    playerList.Paint = function(self, w, h)
        draw.RoundedBox(16, 0, 0, w , h , Color(30, 30, 30, 0))
    end


    for _, ply in pairs(player.GetAll()) do
        local playerPanel = playerList:Add("DPanel")
        playerPanel:SetSize(playerList:GetWide(), 60)
        playerPanel:Dock(TOP)
        playerPanel:DockMargin(0, 0, 0, 5)
        playerPanel.Paint = function(self, w, h)
            draw.RoundedBox(5, 0, 0, w, h, Color(100, 105, 120, 255))
        end

        local avatar = vgui.Create("AvatarImage", playerPanel)
        avatar:SetSize(28, 28)
        avatar:SetPos(margin - 20, 6)
        avatar:SetPlayer(ply, 48)

        local nameLabel = vgui.Create("DLabel", playerPanel)
        nameLabel:SetPos(10, 40)
        nameLabel:SetSize(100, 10)
        nameLabel:SetText(">> " .. ply:Nick())
        nameLabel:SetFont("Trebuchet18")
        nameLabel:SetTextColor(textColor)

        local killsLabel = vgui.Create("DLabel", playerPanel)
        killsLabel:SetPos(playerPanel:GetWide() - 150, 20)
        killsLabel:SetSize(50, 20)
        killsLabel:SetText(ply:Frags())
        killsLabel:SetFont("Trebuchet24")
        killsLabel:SetTextColor(textColor)

        local deathsLabel = vgui.Create("DLabel", playerPanel)
        deathsLabel:SetPos(playerPanel:GetWide() - 80, 20)
        deathsLabel:SetSize(50, 20)
        deathsLabel:SetText(ply:Deaths())
        deathsLabel:SetFont("Trebuchet24")
        deathsLabel:SetTextColor(textColor)

        playerPanel.OnMousePressed = function(self, code)
            if code == MOUSE_RIGHT then
                local menu = DermaMenu()
                menu:AddOption("Copy Steam ID", function()
                    SetClipboardText(ply:SteamID())
                    notification.AddLegacy("Steam ID copied to clipboard!", NOTIFY_HINT, 3)
                    surface.PlaySound("buttons/button15.wav")
                end):SetIcon("icon16/page_copy.png")
                menu:Open()
            end
        end
    end
end

hook.Add("ScoreboardShow", "CustomScoreboardShow", function()
    CreateScoreboard()
    scoreboardFrame:Show()
    return false
end)

hook.Add("ScoreboardHide", "CustomScoreboardHide", function()
    if IsValid(scoreboardFrame) then
        scoreboardFrame:Hide()
    end
end)
