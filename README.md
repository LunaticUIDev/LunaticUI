# 🌙 Lunatic UI
> A beautiful Glassmorphism Roblox UI Library — water blue aesthetic, smooth animations, and a built-in key system.

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![License](https://img.shields.io/badge/license-MIT-blue)
![Platform](https://img.shields.io/badge/platform-Roblox-blue)

---

## ✨ Features

- 🌙 Moon-themed glassmorphism design
- 💧 Water blue color palette
- 🔑 Built-in Key System
- 🎬 Smooth TweenService animations
- 🧩 Easy-to-use component API
- 📦 Lightweight and modular

---

## 📦 Components

| Component | Description |
|-----------|-------------|
| `Window` | Main glass UI frame |
| `Button` | Styled glass button |
| `Input` | Text input field |
| `Toggle` | On/off toggle switch |
| `Slider` | Value slider |
| `Dropdown` | Selection dropdown |
| `Label` | Styled text label |
| `Divider` | Section divider |
| `Notification` | Toast notifications |
| `KeySystem` | Key gate screen |

---

## 🚀 Installation

1. Get the model from the Roblox library or copy the source
2. Place `LunaticUI` inside `ReplicatedStorage`
3. Require it in your LocalScript:

```lua
local Lunatic = require(game.ReplicatedStorage.LunaticUI)
```

---

## 🔑 Key System Usage

```lua
local Lunatic = require(game.ReplicatedStorage.LunaticUI)

Lunatic.KeySystem({
    Title = "Lunatic UI",
    Key = "LUNA-XXXX-XXXX",
    OnSuccess = function()
        -- Your UI loads here
    end
})
```

---

## 🪟 Window Usage

```lua
local Window = Lunatic.Window({
    Title = "My Script",
    Size = UDim2.new(0, 500, 0, 400),
})
```

## 🔘 Button Usage

```lua
local Button = Window:Button({
    Text = "Click Me",
    Callback = function()
        print("Clicked!")
    end
})
```

## 🎚️ Slider Usage

```lua
local Slider = Window:Slider({
    Text = "Speed",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print(value)
    end
})
```

---

## 🎨 Design Tokens

| Token | Value |
|-------|-------|
| Primary Color | `#0A84FF` |
| Background | `rgba(10, 20, 40, 0.6)` |
| Blur | `12px` |
| Border | `1px solid rgba(255,255,255,0.15)` |
| Font | `GothamBold / GothamMedium` |

---

## 📁 Structure

```
LunaticUI/
├── Core/
│   ├── init.lua
│   ├── Tokens.lua
│   └── Animations.lua
├── Components/
│   ├── Window.lua
│   ├── Button.lua
│   ├── Input.lua
│   ├── Toggle.lua
│   ├── Slider.lua
│   ├── Dropdown.lua
│   ├── Label.lua
│   ├── Divider.lua
│   ├── Notification.lua
│   └── KeySystem.lua
└── Assets/
    └── MoonLogo.png
```

---

## 📜 License

MIT License — free to use, modify and distribute.

---

## 🌙 Credits

Made with 💙 by [LunaticUIDevlop]  
UI Library — Lunatic UI v1.0
