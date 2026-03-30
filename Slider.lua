-- 🌙 Lunatic UI | Slider.lua

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Slider = {}
Slider.__index = Slider

function Slider.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Slider)
    config = config or {}
    self.Min = config.Min or 0
    self.Max = config.Max or 100
    self.Value = config.Default or 50

    local frame = Instance.new("Frame")
    frame.Name = "LunaticSlider"
    frame.Size = UDim2.new(1, 0, 0, 52)
    frame.BackgroundTransparency = 1
    frame.LayoutOrder = config.LayoutOrder or 0
    frame.Parent = parent
    self.Instance = frame

    -- Label row
    local labelRow = Instance.new("Frame")
    labelRow.Size = UDim2.new(1, 0, 0, 20)
    labelRow.BackgroundTransparency = 1
    labelRow.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Slider"
    label.TextColor3 = Tokens.Colors.Text
    label.Font = Tokens.Font.Medium
    label.TextSize = Tokens.Font.LabelSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = labelRow

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.3, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.7, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(self.Value)
    valueLabel.TextColor3 = Tokens.Colors.Primary
    valueLabel.Font = Tokens.Font.Bold
    valueLabel.TextSize = Tokens.Font.LabelSize
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = labelRow

    -- Track
    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, Tokens.Size.SliderHeight)
    track.Position = UDim2.new(0, 0, 0, 28)
    track.BackgroundColor3 = Tokens.Colors.Surface
    track.BackgroundTransparency = 0.3
    track.BorderSizePixel = 0
    track.Parent = frame

    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = track

    -- Fill
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), 0, 1, 0)
    fill.BackgroundColor3 = Tokens.Colors.Primary
    fill.BackgroundTransparency = 0.2
    fill.BorderSizePixel = 0
    fill.Parent = track

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    -- Knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new((self.Value - self.Min) / (self.Max - self.Min), 0, 0.5, 0)
    knob.BackgroundColor3 = Tokens.Colors.Text
    knob.BorderSizePixel = 0
    knob.Parent = track

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = knob

    -- Drag logic
    local dragging = false

    local function updateSlider(inputX)
        local trackPos = track.AbsolutePosition.X
        local trackWidth = track.AbsoluteSize.X
        local relative = math.clamp((inputX - trackPos) / trackWidth, 0, 1)
        local rounded = math.round(self.Min + relative * (self.Max - self.Min))
        self.Value = rounded
        valueLabel.Text = tostring(rounded)
        TweenService:Create(fill, Tokens.Tween.Fast, { Size = UDim2.new(relative, 0, 1, 0) }):Play()
        TweenService:Create(knob, Tokens.Tween.Fast, { Position = UDim2.new(relative, 0, 0.5, 0) }):Play()
        if config.Callback then config.Callback(rounded) end
    end

    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input.Position.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input.Position.X)
        end
    end)

    return self
end

return Slider
