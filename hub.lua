-- Lade OrionLib von deinem Repo
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MrCatMemes/test/main/orionlib.lua"))()

-- Erstelle dein Hauptfenster
local Window = OrionLib:MakeWindow({
    Name = "H+ub V1 | by MrCatMemes 😎",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HplusHub"
})

-- ===== MAIN TAB =====
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998", -- kannst du ändern
    PremiumOnly = false
})

-- Label
Tab:AddLabel("Willkommen im H+ub 🚀")

-- Button
Tab:AddButton({
    Name = "Sag Hallo",
    Callback = function()
        print("👋 Hallo von MrCatMemes 😘")
    end
})

-- Toggle
Tab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(state)
        print("Noclip ist jetzt: ", state and "AN ✅" or "AUS ❌")
        -- hier später dein Noclip Code
    end
})

-- Slider Beispiel
Tab:AddSlider({
    Name = "Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        print("Speed gesetzt auf: " .. value)
        -- hier kannst du den Wert ins Script übernehmen
    end
})

-- ===== EXTRA TAB =====
local InfoTab = Window:MakeTab({
    Name = "Info",
    Icon = "rbxassetid://6034509993",
    PremiumOnly = false
})

InfoTab:AddLabel("Made with ❤ by MrCatMemes")
InfoTab:AddButton({
    Name = "Discord öffnen",
    Callback = function()
        print("Hier könnte dein Discord-Link stehen 😎")
    end
})

-- Init OrionLib
OrionLib:Init()
