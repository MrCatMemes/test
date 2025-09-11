local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MrCatMemes/test/main/orionlib.lua"))()

-- Fenster
local Window = OrionLib:MakeWindow({
    Name = "🚀 H+ub V1 | by MrCatMemes 😎",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "HplusHub"
})

-- Tab
local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Label
Tab:AddLabel("👑 Hub V1 | Made by MrCatMemes ❤")

OrionLib:Init()
