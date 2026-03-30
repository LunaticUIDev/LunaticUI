-- 🌙 Lunatic UI | Toggle.lua

local TweenService = game:GetService("TweenService")

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Toggle)
    config = config or {}
    self.Value = config.Default or false

    -- Row frame
    local row = Instance.new("Frame")
    row.Name = "LunaticToggle"
    row.Size = UDim2.new(1, 0, 0, 36)
    row.BackgroundTransparency = 1
    row.LayoutOrder = config.LayoutOrder or 0
    row.Parent = parent
    self.Instance = row

    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Toggle"
    label.TextColor3 = Tokens.Colors.Text
    label.Font = Tokens.Font.Medium
    label.TextSize = Tokens.Font.LabelSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    -- Track
    local track = Instance.new("Frame")
    track.Size = UDim2.new(0, Tokens.Size.ToggleWidth, 0, Tokens.Size.ToggleHeight)
    track.Position = UDim2.new(1, -Tokens.Size.ToggleWidth, 0.5, -Tokens.Size.ToggleHeight / 2)
    track.BackgroundColor3 = Tokens.Colors.Surface
    track.BackgroundTransparency = 0.2
    track.BorderSizePixel = 0
    track.Parent = row

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    -- Knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 3, 0.5, -10)
    knob.BackgroundColor3 = Tokens.Colors.Text
    knob.BorderSizePixel = 0
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    local function updateVisual(val)
        local targetX = val and (Tokens.Size.ToggleWidth - 23) or 3
        local targetColor = val and Tokens.Colors.Primary or Tokens.Colors.Surface
        TweenService:Create(knob, Tokens.Tween.Fast, {
            Position = UDim2.new(0, targetX, 0.5, -10)
        }):Play()
        TweenService:Create(track, Tokens.Tween.Fast, {
            BackgroundColor3 = targetColor,
            BackgroundTransparency = val and Tokens.Transparency.Button or 0.2
        }):Play()
    end

    updateVisual(self.Value)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = row

    button.MouseButton1Click:Connect(function()
        self.Value = not self.Value
        updateVisual(self.Value)
        if config.Callback then
            config.Callback(self.Value)
        end
    end)

    return self
end

return Toggle
