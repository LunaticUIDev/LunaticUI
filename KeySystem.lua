-- 🌙 Lunatic UI | KeySystem.lua
-- Key gate screen — validates key before showing UI

local KeySystem = {}
KeySystem.__index = KeySystem

function KeySystem.new(screenGui, config, Tokens, Animations)
    local self = setmetatable({}, KeySystem)

    config = config or {}
    self.Title      = config.Title or "Lunatic UI"
    self.Subtitle   = config.Subtitle or "Enter your key to continue"
    self.ValidKeys  = config.Keys or {}
    self.OnSuccess  = config.OnSuccess or function() end
    self.OnFail     = config.OnFail or function() end

    -- Overlay
    local overlay = Instance.new("Frame")
    overlay.Name = "KeySystemOverlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.BackgroundColor3 = Tokens.Colors.Background
    overlay.BackgroundTransparency = 0.2
    overlay.BorderSizePixel = 0
    overlay.ZIndex = 10
    overlay.Parent = screenGui
    self.Overlay = overlay

    -- Main box
    local box = Instance.new("Frame")
    box.Name = "KeyBox"
    box.Size = UDim2.new(0, 400, 0, 320)
    box.Position = UDim2.new(0.5, -200, 0.5, -160)
    box.BackgroundColor3 = Tokens.Colors.Glass
    box.BackgroundTransparency = Tokens.Transparency.Window
    box.BorderSizePixel = 0
    box.ZIndex = 11
    box.Parent = screenGui
    self.Box = box

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Tokens.Size.CornerLarge
    corner.Parent = box

    local stroke = Instance.new("UIStroke")
    stroke.Color = Tokens.Colors.Border
    stroke.Transparency = Tokens.Transparency.Border
    stroke.Thickness = 1.5
    stroke.Parent = box

    -- Moon icon
    local moon = Instance.new("TextLabel")
    moon.Size = UDim2.new(1, 0, 0, 50)
    moon.Position = UDim2.new(0, 0, 0, 20)
    moon.BackgroundTransparency = 1
    moon.Text = "🌙"
    moon.TextSize = 36
    moon.ZIndex = 12
    moon.Parent = box

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 75)
    title.BackgroundTransparency = 1
    title.Text = self.Title
    title.TextColor3 = Tokens.Colors.Text
    title.Font = Tokens.Font.Bold
    title.TextSize = 20
    title.ZIndex = 12
    title.Parent = box

    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, -40, 0, 24)
    subtitle.Position = UDim2.new(0, 20, 0, 108)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = self.Subtitle
    subtitle.TextColor3 = Tokens.Colors.TextMuted
    subtitle.Font = Tokens.Font.Regular
    subtitle.TextSize = 13
    subtitle.ZIndex = 12
    subtitle.Parent = box

    -- Input field
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -40, 0, 40)
    inputFrame.Position = UDim2.new(0, 20, 0, 148)
    inputFrame.BackgroundColor3 = Tokens.Colors.Surface
    inputFrame.BackgroundTransparency = Tokens.Transparency.Input
    inputFrame.BorderSizePixel = 0
    inputFrame.ZIndex = 12
    inputFrame.Parent = box

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = Tokens.Size.CornerRadius
    inputCorner.Parent = inputFrame

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = Tokens.Colors.Border
    inputStroke.Transparency = 0.5
    inputStroke.Thickness = 1
    inputStroke.Parent = inputFrame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -20, 1, 0)
    textBox.Position = UDim2.new(0, 10, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.PlaceholderText = "Enter key..."
    textBox.PlaceholderColor3 = Tokens.Colors.TextMuted
    textBox.Text = ""
    textBox.TextColor3 = Tokens.Colors.Text
    textBox.Font = Tokens.Font.Medium
    textBox.TextSize = 14
    textBox.ClearTextOnFocus = false
    textBox.ZIndex = 13
    textBox.Parent = inputFrame
    self.TextBox = textBox

    -- Status label
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, -40, 0, 20)
    status.Position = UDim2.new(0, 20, 0, 196)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = Tokens.Colors.Error
    status.Font = Tokens.Font.Medium
    status.TextSize = 12
    status.ZIndex = 12
    status.Parent = box
    self.StatusLabel = status

    -- Submit button
    local submitBtn = Instance.new("TextButton")
    submitBtn.Size = UDim2.new(1, -40, 0, 42)
    submitBtn.Position = UDim2.new(0, 20, 0, 224)
    submitBtn.BackgroundColor3 = Tokens.Colors.Primary
    submitBtn.BackgroundTransparency = Tokens.Transparency.Button
    submitBtn.BorderSizePixel = 0
    submitBtn.Text = "Unlock 🌙"
    submitBtn.TextColor3 = Tokens.Colors.Text
    submitBtn.Font = Tokens.Font.Bold
    submitBtn.TextSize = 14
    submitBtn.ZIndex = 12
    submitBtn.Parent = box

    local submitCorner = Instance.new("UICorner")
    submitCorner.CornerRadius = Tokens.Size.CornerRadius
    submitCorner.Parent = submitBtn

    Animations.ButtonHover(submitBtn)

    -- Validate key
    local function validate()
        local entered = textBox.Text
        local valid = false
        for _, key in ipairs(self.ValidKeys) do
            if entered == key then
                valid = true
                break
            end
        end

        if valid then
            status.TextColor3 = Tokens.Colors.Success
            status.Text = "✓ Key accepted! Loading..."
            submitBtn.Active = false
            task.delay(1, function()
                Animations.FadeOut(box, 0.3, function()
                    box:Destroy()
                    overlay:Destroy()
                end)
                self.OnSuccess()
            end)
        else
            status.TextColor3 = Tokens.Colors.Error
            status.Text = "✗ Invalid key. Try again."
            self.OnFail()
            -- Shake animation
            local origPos = inputFrame.Position
            for i = 1, 4 do
                task.delay(i * 0.05, function()
                    inputFrame.Position = UDim2.new(
                        origPos.X.Scale,
                        origPos.X.Offset + (i % 2 == 0 and 6 or -6),
                        origPos.Y.Scale,
                        origPos.Y.Offset
                    )
                end)
            end
            task.delay(0.25, function()
                inputFrame.Position = origPos
            end)
        end
    end

    submitBtn.MouseButton1Click:Connect(validate)
    textBox.FocusLost:Connect(function(entered)
        if entered then validate() end
    end)

    -- Slide in
    Animations.SlideIn(box, "Bottom", 0.4)

    return self
end

return KeySystem
