-- OrionLib laden
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MrCatMemes/test/main/orionlib.lua"))()

-- Fenster erstellen
local Window = OrionLib:MakeWindow({
    Name = "🚀 H+ub V1 | by MrCatMemes 😎",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HplusHub"
})

-- ===== MAIN TAB =====
local MainTab = Window:MakeTab({
    Name = "Main",
})

MainTab:AddLabel("🔥 Willkommen zu H+ub V1")
MainTab:AddButton({
    Name = "Sag Hallo",
    Callback = function()
        print("👋 Hallo von MrCatMemes!")
    end
})
MainTab:AddToggle({
    Name = "Test Toggle",
    Default = false,
    Callback = function(state)
        print("Toggle ist jetzt: ", state)
    end
})
MainTab:AddSlider({
    Name = "Speed",
    Min = 16,
    Max = 200,
    Default = 16,
    Increment = 1,
    Callback = function(value)
        print("Speed gesetzt auf: ", value)
    end
})

-- ===== INFO TAB =====
local InfoTab = Window:MakeTab({
    Name = "Info",
})

InfoTab:AddLabel("📝 Version: V1")
InfoTab:AddLabel("👑 Created by MrCatMemes")

-- Orion starten
OrionLib:Init()
