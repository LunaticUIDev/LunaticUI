-- 🌙 Lunatic UI | Tokens.lua
-- Design tokens for colors, fonts, sizing

local Tokens = {}

-- Colors
Tokens.Colors = {
    Primary       = Color3.fromRGB(10, 132, 255),   -- Blue
    PrimaryDark   = Color3.fromRGB(0, 80, 180),
    PrimaryLight  = Color3.fromRGB(100, 180, 255),
    Background    = Color3.fromRGB(8, 15, 35),
    Surface       = Color3.fromRGB(15, 25, 55),
    Glass         = Color3.fromRGB(20, 40, 80),
    Border        = Color3.fromRGB(60, 120, 200),
    Text          = Color3.fromRGB(220, 235, 255),
    TextMuted     = Color3.fromRGB(120, 160, 210),
    Success       = Color3.fromRGB(50, 215, 120),
    Error         = Color3.fromRGB(255, 70, 80),
    Warning       = Color3.fromRGB(255, 180, 50),
}

-- Transparency (glass effect)
Tokens.Transparency = {
    Window        = 0.35,
    Button        = 0.45,
    Input         = 0.50,
    Border        = 0.65,
    Overlay       = 0.20,
}

-- Sizing
Tokens.Size = {
    ButtonHeight  = 36,
    InputHeight   = 36,
    ToggleWidth   = 50,
    ToggleHeight  = 26,
    SliderHeight  = 8,
    CornerRadius  = UDim.new(0, 10),
    CornerSmall   = UDim.new(0, 6),
    CornerLarge   = UDim.new(0, 16),
    Padding       = UDim.new(0, 12),
}

-- Fonts
Tokens.Font = {
    Bold          = Enum.Font.GothamBold,
    Medium        = Enum.Font.GothamMedium,
    Regular       = Enum.Font.Gotham,
    TitleSize     = 16,
    LabelSize     = 14,
    SmallSize     = 12,
}

-- Tween info
Tokens.Tween = {
    Fast          = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Normal        = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Slow          = TweenInfo.new(0.4,  Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Bounce        = TweenInfo.new(0.4,  Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
    Spring        = TweenInfo.new(0.5,  Enum.EasingStyle.Back,  Enum.EasingDirection.Out),
}

return Tokens
