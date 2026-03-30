-- 🌙 Lunatic UI | Button.lua

local TweenService = game:GetService("TweenService")

local Button = {}
Button.__index = Button

function Button.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Button)
    config = config or {}

    local btn = Instance.new("TextButton")
    btn.Name = "LunaticButton"
    btn.Size = config.Size or UDim2.new(1, 0, 0, 36)
    btn.BackgroundColor3 = Tokens.Colors.Primary
    btn.BackgroundTransparency = Tokens.Transparency.Button
    btn.BorderSizePixel = 0
    btn.Text = config.Text or "Button"
    btn.TextColor3 = Tokens.Colors.Text
    btn.Font = Tokens.Font.Bold
    btn.TextSize = Tokens.Font.LabelSize
    btn.LayoutOrder = config.LayoutOrder or 0
    btn.Parent = parent
    self.Instance = btn

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Tokens.Size.CornerRadius
    corner.Parent = btn

    local stroke = Instance.new("UIStroke")
    stroke.Color = Tokens.Colors.Border
    stroke.Transparency = 0.5
    stroke.Thickness = 1
    stroke.Parent = btn

    Animations.ButtonHover(btn)

    if config.Callback then
        btn.MouseButton1Click:Connect(config.Callback)
    end

    return self
end

return Button
