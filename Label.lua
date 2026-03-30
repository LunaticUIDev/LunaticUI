-- 🌙 Lunatic UI | Label.lua

local Label = {}
Label.__index = Label

function Label.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Label)
    config = config or {}

    local label = Instance.new("TextLabel")
    label.Name = "LunaticLabel"
    label.Size = UDim2.new(1, 0, 0, 24)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Label"
    label.TextColor3 = config.Color or Tokens.Colors.Text
    label.Font = config.Bold and Tokens.Font.Bold or Tokens.Font.Regular
    label.TextSize = config.Size or Tokens.Font.LabelSize
    label.TextXAlignment = config.Align or Enum.TextXAlignment.Left
    label.LayoutOrder = config.LayoutOrder or 0
    label.Parent = parent
    self.Instance = label

    return self
end

return Label
