-- OrionLib laden
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MrCatMemes/test/main/orionlib.lua"))()

-- Fenster erstellen
local Window = OrionLib:MakeWindow({
    Name = "H+ub V1 | by MrCatMemes 😎",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HplusHub"
})

-- Tab Beispiel
local MainTab = Window:MakeTab({
    Name = "Main",
})

MainTab:AddLabel("🚀 Willkommen zu H+ub V1")
MainTab:AddButton({
    Name = "Hallo",
    Callback = function()
        print("👋 Hallo von MrCatMemes")
    end
})
