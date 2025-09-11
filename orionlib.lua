-- Orion Library (local version)
-- Source: shlexware/Orion (angepasst für lokalen Gebrauch)

local OrionLib = {}
OrionLib.Flags = {}
OrionLib.Elements = {}

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Orion = Instance.new("ScreenGui")
Orion.Name = "Orion"
Orion.Parent = CoreGui
Orion.ResetOnSpawn = false

-- Theme
OrionLib.Theme = {
    Main = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(32, 32, 32),
    Accent = Color3.fromRGB(0, 170, 255),
    Text = Color3.fromRGB(255, 255, 255)
}

-- Dragging function
local function makeDraggable(frame, object)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            object.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Window creation
function OrionLib:MakeWindow(config)
    local Window = {}
    config = config or {}
    config.Name = config.Name or "Orion Window"
    config.ConfigFolder = config.ConfigFolder or "Orion"

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Orion
    Main.BackgroundColor3 = OrionLib.Theme.Main
    Main.Size = UDim2.new(0, 500, 0, 350)
    Main.Position = UDim2.new(0.5, -250, 0.5, -175)

    makeDraggable(Main, Main)

    local Title = Instance.new("TextLabel")
    Title.Parent = Main
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.Text = config.Name
    Title.TextColor3 = OrionLib.Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20

    Window.Main = Main
    Window.Tabs = {}

    function Window:MakeTab(tabConfig)
        local Tab = {}
        tabConfig = tabConfig or {}
        tabConfig.Name = tabConfig.Name or "Tab"

        local Page = Instance.new("ScrollingFrame")
        Page.Name = tabConfig.Name
        Page.Parent = Main
        Page.Size = UDim2.new(1, 0, 1, -40)
        Page.Position = UDim2.new(0, 0, 0, 40)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.BackgroundColor3 = OrionLib.Theme.Secondary
        Page.ScrollBarThickness = 5

        Tab.Page = Page
        Tab.Elements = {}

        function Tab:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = Page
            Label.Size = UDim2.new(1, -10, 0, 30)
            Label.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 35)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = OrionLib.Theme.Text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 16
            return Label
        end

        function Tab:AddButton(cfg)
            local Button = Instance.new("TextButton")
            Button.Parent = Page
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 35)
            Button.BackgroundColor3 = OrionLib.Theme.Accent
            Button.Text = cfg.Name or "Button"
            Button.TextColor3 = OrionLib.Theme.Text
            Button.Font = Enum.Font.GothamBold
            Button.TextSize = 16

            Button.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    cfg.Callback()
                end
            end)

            return Button
        end

        function Tab:AddToggle(cfg)
            local Toggle = {}
            local Button = Instance.new("TextButton")
            Button.Parent = Page
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 35)
            Button.BackgroundColor3 = OrionLib.Theme.Secondary
            Button.Text = cfg.Name .. " [OFF]"
            Button.TextColor3 = OrionLib.Theme.Text
            Button.Font = Enum.Font.GothamBold
            Button.TextSize = 16

            local state = cfg.Default or false

            local function update()
                Button.Text = cfg.Name .. (state and " [ON]" or " [OFF]")
            end

            Button.MouseButton1Click:Connect(function()
                state = not state
                update()
                if cfg.Callback then
                    cfg.Callback(state)
                end
            end)

            update()
            return Toggle
        end

        table.insert(Window.Tabs, Tab)
        return Tab
    end

    return Window
end

function OrionLib:Init()
    print("✅ OrionLib gestartet (lokal)")
end

return OrionLib  

