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

-- Tab-Erstellung (geht weiter von Block 1)
    function Window:MakeTab(tabConfig)
        tabConfig = tabConfig or {}
        tabConfig.Name = tabConfig.Name or "Tab"

        local Tab = {}
        Tab.Button = Instance.new("TextButton")
        Tab.Button.Parent = Window.TabHolder
        Tab.Button.Size = UDim2.new(1, 0, 0, 30)
        Tab.Button.BackgroundColor3 = OrionLib.Theme.Secondary
        Tab.Button.TextColor3 = OrionLib.Theme.Text
        Tab.Button.Font = Enum.Font.GothamBold
        Tab.Button.TextSize = 14
        Tab.Button.Text = tabConfig.Name

        local Page = Instance.new("ScrollingFrame")
        Page.Name = tabConfig.Name .. "_Page"
        Page.Parent = Window.PageHolder
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.BackgroundTransparency = 1
        Page.Visible = false
        Page.ScrollBarThickness = 5

        -- Tab-Switch
        Tab.Button.MouseButton1Click:Connect(function()
            for _, p in ipairs(Window.PageHolder:GetChildren()) do
                if p:IsA("ScrollingFrame") then
                    p.Visible = false
                end
            end
            Page.Visible = true
        end)

        -- Default erstes Tab sichtbar
        if #Window.Tabs == 0 then
            Page.Visible = true
        end

        -- Elemente
        function Tab:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = Page
            Label.Size = UDim2.new(1, -10, 0, 25)
            Label.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 30)
            Label.BackgroundTransparency = 1
            Label.Text = text
            Label.TextColor3 = OrionLib.Theme.Text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            return Label
        end

        function Tab:AddButton(cfg)
            local Button = Instance.new("TextButton")
            Button.Parent = Page
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 35)
            Button.BackgroundColor3 = OrionLib.Theme.Accent
            Button.TextColor3 = OrionLib.Theme.Text
            Button.Font = Enum.Font.GothamBold
            Button.TextSize = 14
            Button.Text = cfg.Name or "Button"

            Button.MouseButton1Click:Connect(function()
                if cfg.Callback then
                    cfg.Callback()
                end
            end)

            return Button
        end

        function Tab:AddToggle(cfg)
            local Button = Instance.new("TextButton")
            Button.Parent = Page
            Button.Size = UDim2.new(1, -10, 0, 30)
            Button.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 35)
            Button.BackgroundColor3 = OrionLib.Theme.Secondary
            Button.TextColor3 = OrionLib.Theme.Text
            Button.Font = Enum.Font.GothamBold
            Button.TextSize = 14

            local state = cfg.Default or false
            local function update()
                Button.Text = cfg.Name .. (state and " [ON]" or " [OFF]")
            end
            update()

            Button.MouseButton1Click:Connect(function()
                state = not state
                update()
                if cfg.Callback then
                    cfg.Callback(state)
                end
            end)

            return Button
        end

        function Tab:AddSlider(cfg)
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Parent = Page
            SliderFrame.Size = UDim2.new(1, -10, 0, 40)
            SliderFrame.Position = UDim2.new(0, 5, 0, #Page:GetChildren() * 45)
            SliderFrame.BackgroundTransparency = 1

            local Label = Instance.new("TextLabel")
            Label.Parent = SliderFrame
            Label.Size = UDim2.new(1, 0, 0, 20)
            Label.BackgroundTransparency = 1
            Label.TextColor3 = OrionLib.Theme.Text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Text = cfg.Name .. ": " .. tostring(cfg.Default or cfg.Min)

            local SliderBar = Instance.new("Frame")
            SliderBar.Parent = SliderFrame
            SliderBar.Position = UDim2.new(0, 0, 0, 25)
            SliderBar.Size = UDim2.new(1, 0, 0, 10)
            SliderBar.BackgroundColor3 = OrionLib.Theme.Secondary

            local Fill = Instance.new("Frame")
            Fill.Parent = SliderBar
            Fill.Size = UDim2.new(0, 0, 1, 0)
            Fill.BackgroundColor3 = OrionLib.Theme.Accent

            local val = cfg.Default or cfg.Min

            local function setValue(x)
                local percent = math.clamp((x - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                val = math.floor((cfg.Min + (cfg.Max - cfg.Min) * percent) / (cfg.Increment or 1)) * (cfg.Increment or 1)
                Fill.Size = UDim2.new(percent, 0, 1, 0)
                Label.Text = cfg.Name .. ": " .. tostring(val)
                if cfg.Callback then
                    cfg.Callback(val)
                end
            end

            SliderBar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    setValue(input.Position.X)
                end
            end)

            SliderBar.InputChanged:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseMovement and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                    setValue(input.Position.X)
                end
            end)

            return SliderFrame
        end

        table.insert(Window.Tabs, Tab)
        return Tab
    end  

-- Init Funktion
function OrionLib:Init()
    print("✅ OrionLib gestartet (volle Version)")
end

return OrionLib
