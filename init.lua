-- 🌙 Lunatic UI | init.lua
-- Main loader — require this in your LocalScript

local Lunatic = {}

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Core modules
local Tokens = require(script.Core.Tokens)
local Animations = require(script.Core.Animations)

-- Components
local Components = {
    Window       = require(script.Components.Window),
    Button       = require(script.Components.Button),
    Input        = require(script.Components.Input),
    Toggle       = require(script.Components.Toggle),
    Slider       = require(script.Components.Slider),
    Dropdown     = require(script.Components.Dropdown),
    Label        = require(script.Components.Label),
    Divider      = require(script.Components.Divider),
    Notification = require(script.Components.Notification),
    KeySystem    = require(script.Components.KeySystem),
}

-- Expose tokens & animations
Lunatic.Tokens = Tokens
Lunatic.Animations = Animations

-- Create main ScreenGui
local function createScreenGui()
    local gui = Instance.new("ScreenGui")
    gui.Name = "LunaticUI"
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = PlayerGui
    return gui
end

Lunatic.ScreenGui = createScreenGui()

-- Component constructors
function Lunatic.Window(config)
    return Components.Window.new(Lunatic.ScreenGui, config, Tokens, Animations)
end

function Lunatic.KeySystem(config)
    return Components.KeySystem.new(Lunatic.ScreenGui, config, Tokens, Animations)
end

function Lunatic.Notification(config)
    return Components.Notification.new(Lunatic.ScreenGui, config, Tokens, Animations)
end

-- Version
Lunatic.Version = "1.0.0"

print("🌙 Lunatic UI v" .. Lunatic.Version .. " loaded!")

return Lunatic
