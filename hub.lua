-- Hub Testscript
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MrCatMemes/test/main/orionlib.lua"))()

-- Erstelle Fenster
local Window = OrionLib:MakeWindow({
    Name = "🚀 Test Hub | by MrCatMemes 😎"
})

-- Erstelle Tab
local Tab = Window:MakeTab({
    Name = "Main"
})

-- Test Label
Tab:AddLabel("✅ OrionLib geladen!")

-- Init
OrionLib:Init()
