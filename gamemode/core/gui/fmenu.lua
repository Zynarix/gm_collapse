local frameWidth = 500
local frameHeight = 600
local margin = 20
local bgColor = Color(45, 45, 48, 220)
local textColor = Color(255, 255, 255)

net.Receive("FMENU", function(len, ply)

    local frame = vgui.Create("DFrame")
    frame:SetTitle("")
    frame:SetSize(frameWidth, frameHeight)
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, bgColor)
    end

    local propertySheet = vgui.Create("DPropertySheet", frame)
    propertySheet:SetPos(margin, margin)
    propertySheet:SetSize(frameWidth - margin * 2, frameHeight - margin * 2)

    local characterPanel = vgui.Create("DPanel", propertySheet)
    characterPanel:SetBackgroundColor(Color(30, 30, 30, 200))
    characterPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(30, 30, 30, 200))
    end

    local moneyLabel = vgui.Create("DLabel", characterPanel)
    moneyLabel:SetPos(margin, margin)
    moneyLabel:SetSize(frameWidth - margin * 4, 20)
    moneyLabel:SetText("Money: $" .. LocalPlayer():GetMoney())
    moneyLabel:SetFont("Trebuchet24")
    moneyLabel:SetTextColor(textColor)

    local expLabel = vgui.Create("DLabel", characterPanel)
    expLabel:SetPos(margin, margin + 40)
    expLabel:SetSize(frameWidth - margin * 4, 20)
    expLabel:SetText("Experience: " .. LocalPlayer():GetExp())
    expLabel:SetFont("Trebuchet24")
    expLabel:SetTextColor(textColor)

    local levelLabel = vgui.Create("DLabel", characterPanel)
    levelLabel:SetPos(margin, margin + 80)
    levelLabel:SetSize(frameWidth - margin * 4, 20)
    levelLabel:SetText("Level: " .. LocalPlayer():GetLvl())
    levelLabel:SetFont("Trebuchet24")
    levelLabel:SetTextColor(textColor)

    propertySheet:AddSheet("Character", characterPanel, "icon16/user.png")

    local inventoryPanel = vgui.Create("DPanel", propertySheet)
    inventoryPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(30, 30, 30, 200))
    end

    local inventoryScrollPanel = vgui.Create("DScrollPanel", inventoryPanel)
    inventoryScrollPanel:SetPos(margin, margin)
    inventoryScrollPanel:SetSize(frameWidth - margin * 4, frameHeight - margin * 4)
    inventoryScrollPanel:SetBackgroundColor(Color(50, 50, 50, 200))
    inventoryScrollPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(30, 30, 30, 200))
    end

    -- Добавление элементов инвентаря в панель прокрутки
    for _, itemName in ipairs(LocalPlayer():GetInv()) do
        local item = GetItem(itemName)
        if item then
            local itemPanel = inventoryScrollPanel:Add("DPanel")
            itemPanel:SetSize(frameWidth - margin * 2, 30)
            itemPanel:Dock(TOP)
            itemPanel:DockMargin(0, 0, 0, 5)
            itemPanel.Paint = function(self, w, h)
                draw.RoundedBox(5, 0, 0, w, h, Color(70, 70, 70, 255))
                draw.SimpleText(item.Name, "DermaDefaultBold", 10, h / 2, textColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end
        end
    end
    
    propertySheet:AddSheet("Inventory", inventoryPanel, "icon16/box.png")

    local settingsPanel = vgui.Create("DPanel", propertySheet)
    settingsPanel.Paint = function(self, w, h)
        draw.RoundedBox(10, 0, 0, w, h, Color(30, 30, 30, 200))
    end

    local soundLabel = vgui.Create("DLabel", settingsPanel)
    soundLabel:SetPos(margin, margin)
    soundLabel:SetSize(frameWidth - margin * 4, 20)
    soundLabel:SetText("Кубические карты(больше ФПС)")
    soundLabel:SetFont("TargetID")
    soundLabel:SetTextColor(textColor)

    local soundSlider = vgui.Create("DCheckBoxLabel", settingsPanel)
    soundSlider:SetPos(margin, margin + 30)
    soundSlider:SetConVar("mat_specular")

    propertySheet:AddSheet("Settings", settingsPanel, "icon16/box.png")

end)
