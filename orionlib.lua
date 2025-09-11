-- Orion Library | Local Full Version
-- Source: https://github.com/shlexware/Orion

local OrionLib = {
    Flags = {},
    Elements = {}
}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.Parent = CoreGui
Orion.ZIndexBehavior = Enum.ZIndexBehavior.Global
Orion.ResetOnSpawn = false

-- Theme Colors
OrionLib.Theme = {
    Main = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(32, 32, 32),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(255, 255, 255),
    DarkText = Color3.fromRGB(180, 180, 180)
}

-- Dragging Support
local function makeDraggable(topbar, frame)
    local dragging = false
    local dragInput, dragStart, startPos

    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Window Creation
function OrionLib:MakeWindow(config)
    config = config or {}
    config.Name = config.Name or "Orion Window"
    config.SaveConfig = config.SaveConfig or false
    config.ConfigFolder = config.ConfigFolder or "Orion"

    local Window = {}
    Window.Tabs = {}

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Orion
    Main.BackgroundColor3 = OrionLib.Theme.Main
    Main.Size = UDim2.new(0, 530, 0, 350)
    Main.Position = UDim2.new(0.5, -265, 0.5, -175)

    local Topbar = Instance.new("Frame")
    Topbar.Name = "Topbar"
    Topbar.Parent = Main
    Topbar.BackgroundColor3 = OrionLib.Theme.Secondary
    Topbar.Size = UDim2.new(1, 0, 0, 40)

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Topbar
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = config.Name
    Title.TextColor3 = OrionLib.Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left

    makeDraggable(Topbar, Main)

    local TabHolder = Instance.new("Frame")
    TabHolder.Name = "TabHolder"
    TabHolder.Parent = Main
    TabHolder.BackgroundColor3 = OrionLib.Theme.Secondary
    TabHolder.Position = UDim2.new(0, 0, 0, 40)
    TabHolder.Size = UDim2.new(0, 150, 1, -40)

    local PageHolder = Instance.new("Frame")
    PageHolder.Name = "PageHolder"
    PageHolder.Parent = Main
    PageHolder.BackgroundColor3 = OrionLib.Theme.Main
    PageHolder.Position = UDim2.new(0, 150, 0, 40)
    PageHolder.Size = UDim2.new(1, -150, 1, -40)

    Window.Main = Main
    Window.PageHolder = PageHolder
    Window.TabHolder = TabHolder

    function Window:MakeTab(tabConfig)
        -- Tab Creation (kommt in Block 2)
    end

    return Window
end
