-- 🌙 Lunatic UI | Notification.lua
-- Toast-style notifications

local TweenService = game:GetService("TweenService")

local Notification = {}
Notification.__index = Notification

local activeNotifs = {}
local NOTIF_HEIGHT = 60
local NOTIF_GAP = 8
local PADDING = 16

local function restack(screenGui)
    for i, notif in ipairs(activeNotifs) do
        local targetY = -(NOTIF_HEIGHT + NOTIF_GAP) * i - PADDING
        TweenService:Create(notif, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -320, 1, targetY)
        }):Play()
    end
end

function Notification.new(screenGui, config, Tokens, Animations)
    local self = setmetatable({}, Notification)
    config = config or {}

    local nType = config.Type or "info" -- info, success, error, warning
    local colorMap = {
        info    = Tokens.Colors.Primary,
        success = Tokens.Colors.Success,
        error   = Tokens.Colors.Error,
        warning = Tokens.Colors.Warning,
    }
    local iconMap = {
        info    = "💙",
        success = "✅",
        error   = "❌",
        warning = "⚠️",
    }

    local accentColor = colorMap[nType] or Tokens.Colors.Primary

    local frame = Instance.new("Frame")
    frame.Name = "LunaticNotif"
    frame.Size = UDim2.new(0, 300, 0, NOTIF_HEIGHT)
    frame.Position = UDim2.new(1, 20, 1, -PADDING - NOTIF_HEIGHT)
    frame.BackgroundColor3 = Tokens.Colors.Glass
    frame.BackgroundTransparency = Tokens.Transparency.Window
    frame.BorderSizePixel = 0
    frame.ZIndex = 50
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = Tokens.Size.CornerRadius
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = accentColor
    stroke.Transparency = 0.4
    stroke.Thickness = 1.5
    stroke.Parent = frame

    -- Left accent bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0, 4, 1, -16)
    bar.Position = UDim2.new(0, 8, 0, 8)
    bar.BackgroundColor3 = accentColor
    bar.BackgroundTransparency = 0.1
    bar.BorderSizePixel = 0
    bar.ZIndex = 51
    bar.Parent = frame

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Position = UDim2.new(0, 18, 0.5, -14)
    icon.BackgroundTransparency = 1
    icon.Text = iconMap[nType] or "💙"
    icon.TextSize = 18
    icon.ZIndex = 51
    icon.Parent = frame

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 0, 20)
    title.Position = UDim2.new(0, 50, 0, 10)
    title.BackgroundTransparency = 1
    title.Text = config.Title or "Notification"
    title.TextColor3 = Tokens.Colors.Text
    title.Font = Tokens.Font.Bold
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 51
    title.Parent = frame

    -- Message
    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -60, 0, 18)
    msg.Position = UDim2.new(0, 50, 0, 32)
    msg.BackgroundTransparency = 1
    msg.Text = config.Message or ""
    msg.TextColor3 = Tokens.Colors.TextMuted
    msg.Font = Tokens.Font.Regular
    msg.TextSize = 12
    msg.TextXAlignment = Enum.TextXAlignment.Left
    msg.ZIndex = 51
    msg.Parent = frame

    -- Slide in
    table.insert(activeNotifs, 1, frame)
    restack(screenGui)

    TweenService:Create(frame, Tokens.Tween.Spring, {
        Position = UDim2.new(1, -316, 1, -(NOTIF_HEIGHT + PADDING))
    }):Play()

    -- Auto dismiss
    local duration = config.Duration or 4
    task.delay(duration, function()
        TweenService:Create(frame, Tokens.Tween.Normal, {
            Position = UDim2.new(1, 20, 1, -(NOTIF_HEIGHT + PADDING))
        }):Play()
        task.delay(0.3, function()
            local idx = table.find(activeNotifs, frame)
            if idx then table.remove(activeNotifs, idx) end
            frame:Destroy()
            restack(screenGui)
        end)
    end)

    return self
end

return Notification
