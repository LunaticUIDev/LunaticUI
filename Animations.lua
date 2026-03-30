-- 🌙 Lunatic UI | Animations.lua
-- Reusable tween animations

local TweenService = game:GetService("TweenService")
local Tokens = require(script.Parent.Tokens)

local Animations = {}

function Animations.Tween(instance, properties, tweenInfo)
    local tween = TweenService:Create(instance, tweenInfo or Tokens.Tween.Normal, properties)
    tween:Play()
    return tween
end

function Animations.FadeIn(instance, duration)
    instance.BackgroundTransparency = 1
    Animations.Tween(instance, {
        BackgroundTransparency = Tokens.Transparency.Window
    }, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
end

function Animations.FadeOut(instance, duration, callback)
    local tween = Animations.Tween(instance, {
        BackgroundTransparency = 1
    }, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
    if callback then
        tween.Completed:Connect(callback)
    end
end

function Animations.SlideIn(instance, direction, duration)
    direction = direction or "Bottom"
    local originalPos = instance.Position
    if direction == "Bottom" then
        instance.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale + 0.1, originalPos.Y.Offset)
    elseif direction == "Top" then
        instance.Position = UDim2.new(originalPos.X.Scale, originalPos.X.Offset, originalPos.Y.Scale - 0.1, originalPos.Y.Offset)
    elseif direction == "Left" then
        instance.Position = UDim2.new(originalPos.X.Scale - 0.1, originalPos.X.Offset, originalPos.Y.Scale, originalPos.Y.Offset)
    elseif direction == "Right" then
        instance.Position = UDim2.new(originalPos.X.Scale + 0.1, originalPos.X.Offset, originalPos.Y.Scale, originalPos.Y.Offset)
    end
    instance.BackgroundTransparency = 1
    Animations.Tween(instance, {
        Position = originalPos,
        BackgroundTransparency = Tokens.Transparency.Window
    }, TweenInfo.new(duration or 0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
end

function Animations.ButtonHover(button)
    button.MouseEnter:Connect(function()
        Animations.Tween(button, {
            BackgroundTransparency = Tokens.Transparency.Button - 0.15,
            BackgroundColor3 = Tokens.Colors.PrimaryLight
        }, Tokens.Tween.Fast)
    end)
    button.MouseLeave:Connect(function()
        Animations.Tween(button, {
            BackgroundTransparency = Tokens.Transparency.Button,
            BackgroundColor3 = Tokens.Colors.Primary
        }, Tokens.Tween.Fast)
    end)
    button.MouseButton1Down:Connect(function()
        Animations.Tween(button, {
            BackgroundColor3 = Tokens.Colors.PrimaryDark
        }, Tokens.Tween.Fast)
    end)
    button.MouseButton1Up:Connect(function()
        Animations.Tween(button, {
            BackgroundColor3 = Tokens.Colors.PrimaryLight
        }, Tokens.Tween.Fast)
    end)
end

function Animations.Pulse(instance)
    local function doPulse()
        Animations.Tween(instance, { BackgroundTransparency = Tokens.Transparency.Window - 0.1 }, Tokens.Tween.Normal)
        task.delay(0.3, function()
            Animations.Tween(instance, { BackgroundTransparency = Tokens.Transparency.Window }, Tokens.Tween.Normal)
        end)
    end
    return doPulse
end

return Animations
