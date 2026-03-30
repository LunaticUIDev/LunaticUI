-- 🌙 Lunatic UI | Window.lua
-- Main glass window frame

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Window = {}
Window.__index = Window

function Window.new(screenGui, config, Tokens, Animations)
    local self = setmetatable({}, Window)

    config = config or {}
    self.Title = config.Title or "Lunatic UI"
    self.Size = config.Size or UDim2.new(0, 520, 0, 420)
    self.Position = config.Position or UDim2.new(0.5, -260, 0.5, -210)
    self.Tokens = Tokens
    self.Animations = Animations
    self.Tabs = {}
    self.CurrentTab = nil

    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Name = "LunaticWindow"
    frame.Size = self.Size
    frame.Position = self.Position
    frame.BackgroundColor3 = Tokens.Colors.Glass
    frame.BackgroundTransparency = Tokens.Transparency.Window
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    self.Frame = frame

    -- Corner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = Tokens.Size.CornerLarge
    corner.Parent = frame

    -- Border glow
    local stroke = Instance.new("UIStroke")
    stroke.Color = Tokens.Colors.Border
    stroke.Transparency = Tokens.Transparency.Border
    stroke.Thickness = 1.5
    stroke.Parent = frame

    -- Blur effect
    local blur = Instance.new("BlurEffect")
    blur.Size = 16
    blur.Parent = game:GetService("Lighting")
    self.Blur = blur

    -- Titlebar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 44)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Tokens.Colors.Primary
    titleBar.BackgroundTransparency = 0.6
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame

    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = Tokens.Size.CornerLarge
    titleCorner.Parent = titleBar

    -- Moon logo
    local moonLabel = Instance.new("TextLabel")
    moonLabel.Size = UDim2.new(0, 30, 0, 30)
    moonLabel.Position = UDim2.new(0, 10, 0.5, -15)
    moonLabel.BackgroundTransparency = 1
    moonLabel.Text = "🌙"
    moonLabel.TextSize = 20
    moonLabel.Parent = titleBar

    -- Title text
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -90, 1, 0)
    titleLabel.Position = UDim2.new(0, 45, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.Title
    titleLabel.TextColor3 = Tokens.Colors.Text
    titleLabel.Font = Tokens.Font.Bold
    titleLabel.TextSize = Tokens.Font.TitleSize
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar

    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -36, 0.5, -14)
    closeBtn.BackgroundColor3 = Tokens.Colors.Error
    closeBtn.BackgroundTransparency = 0.4
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Tokens.Colors.Text
    closeBtn.Font = Tokens.Font.Bold
    closeBtn.TextSize = 12
    closeBtn.Parent = titleBar

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        Animations.FadeOut(frame, 0.25, function()
            frame.Visible = false
            blur.Size = 0
        end)
    end)

    -- Minimize button
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 28, 0, 28)
    minBtn.Position = UDim2.new(1, -70, 0.5, -14)
    minBtn.BackgroundColor3 = Tokens.Colors.Warning
    minBtn.BackgroundTransparency = 0.4
    minBtn.BorderSizePixel = 0
    minBtn.Text = "−"
    minBtn.TextColor3 = Tokens.Colors.Text
    minBtn.Font = Tokens.Font.Bold
    minBtn.TextSize = 14
    minBtn.Parent = titleBar

    local minCorner = Instance.new("UICorner")
    minCorner.CornerRadius = UDim.new(1, 0)
    minCorner.Parent = minBtn

    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            TweenService:Create(frame, Tokens.Tween.Normal, {
                Size = UDim2.new(0, self.Size.X.Offset, 0, 44)
            }):Play()
        else
            TweenService:Create(frame, Tokens.Tween.Normal, {
                Size = self.Size
            }):Play()
        end
    end)

    -- Content area
    local content = Instance.new("ScrollingFrame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -60)
    content.Position = UDim2.new(0, 10, 0, 52)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = Tokens.Colors.Primary
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = frame
    self.Content = content

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 8)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = content

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 6)
    padding.PaddingBottom = UDim.new(0, 6)
    padding.Parent = content

    -- Dragging
    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    titleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Slide in on open
    Animations.SlideIn(frame, "Bottom", 0.4)

    return self
end

-- Add a component to window
function Window:AddComponent(component)
    if component and component.Instance then
        component.Instance.Parent = self.Content
    end
end

return Window
