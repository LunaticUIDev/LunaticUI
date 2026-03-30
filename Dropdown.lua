-- 🌙 Lunatic UI | Dropdown.lua

local TweenService = game:GetService("TweenService")

local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(parent, config, Tokens, Animations)
    local self = setmetatable({}, Dropdown)
    config = config or {}
    self.Options = config.Options or {}
    self.Value = config.Default or self.Options[1] or "Select..."
    self.Open = false

    local frame = Instance.new("Frame")
    frame.Name = "LunaticDropdown"
    frame.Size = UDim2.new(1, 0, 0, 54)
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = false
    frame.LayoutOrder = config.LayoutOrder or 0
    frame.Parent = parent
    self.Instance = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 18)
    label.BackgroundTransparency = 1
    label.Text = config.Text or "Dropdown"
    label.TextColor3 = Tokens.Colors.TextMuted
    label.Font = Tokens.Font.Medium
    label.TextSize = Tokens.Font.SmallSize
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    -- Header button
    local header = Instance.new("TextButton")
    header.Size = UDim2.new(1, 0, 0, 34)
    header.Position = UDim2.new(0, 0, 0, 20)
    header.BackgroundColor3 = Tokens.Colors.Surface
    header.BackgroundTransparency = Tokens.Transparency.Input
    header.BorderSizePixel = 0
    header.Text = ""
    header.Parent = frame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = Tokens.Size.CornerRadius
    headerCorner.Parent = header

    local headerStroke = Instance.new("UIStroke")
    headerStroke.Color = Tokens.Colors.Border
    headerStroke.Transparency = 0.5
    headerStroke.Thickness = 1
    headerStroke.Parent = header

    local selectedLabel = Instance.new("TextLabel")
    selectedLabel.Size = UDim2.new(1, -36, 1, 0)
    selectedLabel.Position = UDim2.new(0, 10, 0, 0)
    selectedLabel.BackgroundTransparency = 1
    selectedLabel.Text = self.Value
    selectedLabel.TextColor3 = Tokens.Colors.Text
    selectedLabel.Font = Tokens.Font.Regular
    selectedLabel.TextSize = Tokens.Font.LabelSize
    selectedLabel.TextXAlignment = Enum.TextXAlignment.Left
    selectedLabel.Parent = header

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 24, 1, 0)
    arrow.Position = UDim2.new(1, -28, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▾"
    arrow.TextColor3 = Tokens.Colors.Primary
    arrow.Font = Tokens.Font.Bold
    arrow.TextSize = 14
    arrow.Parent = header

    -- Options list
    local optList = Instance.new("Frame")
    optList.Size = UDim2.new(1, 0, 0, 0)
    optList.Position = UDim2.new(0, 0, 0, 56)
    optList.BackgroundColor3 = Tokens.Colors.Glass
    optList.BackgroundTransparency = 0.2
    optList.BorderSizePixel = 0
    optList.ClipsDescendants = true
    optList.ZIndex = 20
    optList.Visible = false
    optList.Parent = frame

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = Tokens.Size.CornerRadius
    listCorner.Parent = optList

    local listStroke = Instance.new("UIStroke")
    listStroke.Color = Tokens.Colors.Border
    listStroke.Transparency = 0.4
    listStroke.Thickness = 1
    listStroke.Parent = optList

    local listLayout = Instance.new("UIListLayout")
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = optList

    -- Build options
    for i, opt in ipairs(self.Options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 32)
        optBtn.BackgroundTransparency = 1
        optBtn.Text = opt
        optBtn.TextColor3 = Tokens.Colors.Text
        optBtn.Font = Tokens.Font.Regular
        optBtn.TextSize = Tokens.Font.LabelSize
        optBtn.ZIndex = 21
        optBtn.LayoutOrder = i
        optBtn.Parent = optList

        optBtn.MouseEnter:Connect(function()
            TweenService:Create(optBtn, Tokens.Tween.Fast, {
                BackgroundTransparency = 0.7,
                BackgroundColor3 = Tokens.Colors.Primary
            }):Play()
        end)
        optBtn.MouseLeave:Connect(function()
            TweenService:Create(optBtn, Tokens.Tween.Fast, {
                BackgroundTransparency = 1
            }):Play()
        end)
        optBtn.MouseButton1Click:Connect(function()
            self.Value = opt
            selectedLabel.Text = opt
            self.Open = false
            TweenService:Create(optList, Tokens.Tween.Normal, { Size = UDim2.new(1, 0, 0, 0) }):Play()
            task.delay(0.25, function() optList.Visible = false end)
            arrow.Text = "▾"
            if config.Callback then config.Callback(opt) end
        end)
    end

    local totalHeight = #self.Options * 32

    -- Toggle dropdown
    header.MouseButton1Click:Connect(function()
        self.Open = not self.Open
        if self.Open then
            optList.Visible = true
            TweenService:Create(optList, Tokens.Tween.Normal, {
                Size = UDim2.new(1, 0, 0, totalHeight)
            }):Play()
            arrow.Text = "▴"
        else
            TweenService:Create(optList, Tokens.Tween.Normal, {
                Size = UDim2.new(1, 0, 0, 0)
            }):Play()
            task.delay(0.25, function() optList.Visible = false end)
            arrow.Text = "▾"
        end
    end)

    return self
end

return Dropdown
