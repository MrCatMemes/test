-- Lade deine lokale OrionLib
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MrCatMemes/test/main/orionlib.lua"))()

-- Fenster
local Window = OrionLib:MakeWindow({
    Name = "🚀 H+ub V1 | by MrCatMemes 😎",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HplusHub"
})

-- Tab "Main"
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

MainTab:AddLabel("👑 Hub V1 | Made by MrCatMemes ❤")

MainTab:AddButton({
    Name = "Sag Hallo",
    Callback = function()
        print("Hallo von MrCatMemes 😎")
    end
})

MainTab:AddToggle({
    Name = "Godmode",
    Default = false,
    Callback = function(state)
        print("Godmode ist jetzt: " .. tostring(state))
    end
})

MainTab:AddSlider({
    Name = "Speed",
    Min = 16,
    Max = 200,
    Default = 50,
    Increment = 1,
    Callback = function(value)
        print("Speed gesetzt auf: " .. tostring(value))
    end
})

-- Orion starten
OrionLib:Init()
