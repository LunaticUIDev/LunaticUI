-- 🌙 Lunatic UI | Divider.lua

local Divider = {}
Divider.__index = Divider

function Divider.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Divider)
    config = config or {}

    local frame = Instance.new("Frame")
    frame.Name = "LunaticDivider"
    frame.Size = UDim2.new(1, 0, 0, 16)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = config.LayoutOrder or 0
    frame.Parent = parent
    self.Instance = frame

    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.BackgroundColor3 = Tokens.Colors.Border
    line.BackgroundTransparency = 0.5
    line.BorderSizePixel = 0
    line.Parent = frame

    if config.Text then
        line.Size = UDim2.new(0.35, 0, 0, 1)

        local text = Instance.new("TextLabel")
        text.Size = UDim2.new(0.3, 0, 1, 0)
        text.Position = UDim2.new(0.35, 0, 0, 0)
        text.BackgroundTransparency = 1
        text.Text = config.Text
        text.TextColor3 = Tokens.Colors.TextMuted
        text.Font = Tokens.Font.Regular
        text.TextSize = Tokens.Font.SmallSize
        text.Parent = frame

        local line2 = Instance.new("Frame")
        line2.Size = UDim2.new(0.35, 0, 0, 1)
        line2.Position = UDim2.new(0.65, 0, 0.5, 0)
        line2.BackgroundColor3 = Tokens.Colors.Border
        line2.BackgroundTransparency = 0.5
        line2.BorderSizePixel = 0
        line2.Parent = frame
    end

    return self
end

return Divider
