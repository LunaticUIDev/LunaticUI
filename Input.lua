-- 🌙 Lunatic UI | Input.lua

local Input = {}
Input.__index = Input

function Input.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Input)
    config = config or {}

    local frame = Instance.new("Frame")
    frame.Name = "LunaticInput"
    frame.Size = UDim2.new(1, 0, 0, 52)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = config.LayoutOrder or 0
    frame.Parent = parent
    self.Instance = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 18)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Input"
    label.TextColor3 = Tokens.Colors.TextMuted
    label.Font = Tokens.Font.Medium
    label.TextSize = Tokens.Font.SmallSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, 0, 0, 34)
    inputFrame.Position = UDim2.new(0, 0, 0, 20)
    inputFrame.BackgroundColor3 = Tokens.Colors.Surface
    inputFrame.BackgroundTransparency = Tokens.Transparency.Input
    inputFrame.BorderSizePixel = 0
    inputFrame.Parent = frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Tokens.Size.CornerRadius
    corner.Parent = inputFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Tokens.Colors.Border
    stroke.Transparency = 0.5
    stroke.Thickness = 1
    stroke.Parent = inputFrame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -16, 1, 0)
    textBox.Position = UDim2.new(0, 8, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.PlaceholderText = config.Placeholder or "Type here..."
    textBox.PlaceholderColor3 = Tokens.Colors.TextMuted
    textBox.Text = config.Default or ""
    textBox.TextColor3 = Tokens.Colors.Text
    textBox.Font = Tokens.Font.Regular
    textBox.TextSize = Tokens.Font.LabelSize
    textBox.ClearTextOnFocus = false
    textBox.Parent = inputFrame
    self.TextBox = textBox

    -- Glow on focus
    textBox.Focused:Connect(function()
        stroke.Transparency = 0.2
        stroke.Color = Tokens.Colors.Primary
    end)
    textBox.FocusLost:Connect(function(entered)
        stroke.Transparency = 0.5
        stroke.Color = Tokens.Colors.Border
        if config.Callback then
            config.Callback(textBox.Text, entered)
        end
    end)

    return self
end

return Input
