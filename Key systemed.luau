-- ============================================================
-- KEY SYSTEM — SUPREME ULTIMATE EDITION (Any valid key works)
-- ============================================================
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService   = game:GetService("RunService")
local Lighting     = game:GetService("Lighting")
local UIS          = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local player       = Players.LocalPlayer

local function playSound(id, vol)
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://" .. id
        s.Volume = vol or 0.5
        s.Parent = SoundService
        s:Play()
        task.delay(3, function() if s then s:Destroy() end end)
    end)
end

local function getParent()
    if gethui then local ok, h = pcall(gethui); if ok and h then return h end end
    local ok, cg = pcall(function() return game:GetService("CoreGui") end)
    if ok and cg then return cg end
    return player:WaitForChild("PlayerGui")
end

-- ========== ROOT ==========
local gui = Instance.new("ScreenGui")
gui.Name = "KeySystemSupreme"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 2147483647
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = getParent()

-- ========== BLUR ==========
local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting
TweenService:Create(blur, TweenInfo.new(0.8), { Size = 32 }):Play()

-- ========== BACKGROUND ==========
local bg = Instance.new("Frame")
bg.Size = UDim2.fromScale(1, 1)
bg.BackgroundColor3 = Color3.fromRGB(3, 3, 6)
bg.BorderSizePixel = 0
bg.ZIndex = 0
bg.Parent = gui

local bgGrad = Instance.new("UIGradient")
bgGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(20, 20, 30)),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0, 0, 0))
}
bgGrad.Rotation = 45
bgGrad.Parent = bg

-- ========== AURORA ==========
local auroraHolder = Instance.new("Frame")
auroraHolder.Size = UDim2.fromScale(1, 1)
auroraHolder.BackgroundTransparency = 1
auroraHolder.ZIndex = 1
auroraHolder.ClipsDescendants = true
auroraHolder.Parent = gui

local auroraColors = {
    Color3.fromRGB(80, 100, 255),
    Color3.fromRGB(180, 60, 200),
    Color3.fromRGB(50, 200, 220),
    Color3.fromRGB(120, 80, 255)
}
for i, col in ipairs(auroraColors) do
    local orb = Instance.new("ImageLabel", auroraHolder)
    orb.Size = UDim2.fromOffset(500, 500)
    orb.Position = UDim2.fromScale(math.random(), math.random())
    orb.BackgroundTransparency = 1
    orb.Image = "rbxassetid://1316045217"
    orb.ImageColor3 = col
    orb.ImageTransparency = 0.92
    orb.ZIndex = 1
    task.spawn(function()
        while gui.Parent do
            local x, y = math.random(), math.random()
            TweenService:Create(orb, TweenInfo.new(math.random(8, 14), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = UDim2.fromScale(x, y)
            }):Play()
            task.wait(math.random(8, 14))
        end
    end)
end

-- ========== GRID ==========
local gridHolder = Instance.new("Frame")
gridHolder.Size = UDim2.fromScale(1, 1)
gridHolder.BackgroundTransparency = 1
gridHolder.ZIndex = 2
gridHolder.Parent = gui

for i = 0, 60 do
    local line = Instance.new("Frame", gridHolder)
    line.Size = UDim2.new(0, 1, 1, 0)
    line.Position = UDim2.fromScale(i / 60, 0)
    line.BackgroundColor3 = Color3.new(1,1,1)
    line.BackgroundTransparency = 0.96
    line.BorderSizePixel = 0
end
for i = 0, 35 do
    local line = Instance.new("Frame", gridHolder)
    line.Size = UDim2.new(1, 0, 0, 1)
    line.Position = UDim2.fromScale(0, i / 35)
    line.BackgroundColor3 = Color3.new(1,1,1)
    line.BackgroundTransparency = 0.96
    line.BorderSizePixel = 0
end

-- ========== RADAR ==========
local radar = Instance.new("ImageLabel", gui)
radar.Size = UDim2.fromOffset(900, 900)
radar.Position = UDim2.fromScale(0.5, 0.5)
radar.AnchorPoint = Vector2.new(0.5, 0.5)
radar.BackgroundTransparency = 1
radar.Image = "rbxassetid://9968344311"
radar.ImageTransparency = 0.96
radar.ImageColor3 = Color3.fromRGB(180, 180, 220)
radar.ZIndex = 2
task.spawn(function()
    while gui.Parent do
        radar.Rotation = (radar.Rotation + 0.15) % 360
        task.wait(0.02)
    end
end)

-- ========== PARTICLES ==========
local particleHolder = Instance.new("Frame")
particleHolder.Size = UDim2.fromScale(1, 1)
particleHolder.BackgroundTransparency = 1
particleHolder.ZIndex = 3
particleHolder.Parent = gui
task.spawn(function()
    while gui.Parent do
        local p = Instance.new("Frame")
        p.Size = UDim2.fromOffset(math.random(1, 4), math.random(1, 4))
        p.BackgroundColor3 = Color3.new(1, 1, 1)
        p.BackgroundTransparency = math.random(30, 80) / 100
        p.BorderSizePixel = 0
        p.Position = UDim2.fromScale(math.random(), 1.05)
        p.ZIndex = 3
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        p.Parent = particleHolder
        local dur = math.random(6, 14)
        TweenService:Create(p, TweenInfo.new(dur, Enum.EasingStyle.Linear), {
            Position = UDim2.fromScale(p.Position.X.Scale + math.random(-15, 15)/100, -0.1),
            BackgroundTransparency = 1
        }):Play()
        task.delay(dur, function() p:Destroy() end)
        task.wait(0.12)
    end
end)

-- ========== CURSOR GLOW ==========
local cursorGlow = Instance.new("ImageLabel", gui)
cursorGlow.Size = UDim2.fromOffset(300, 300)
cursorGlow.AnchorPoint = Vector2.new(0.5, 0.5)
cursorGlow.BackgroundTransparency = 1
cursorGlow.Image = "rbxassetid://1316045217"
cursorGlow.ImageColor3 = Color3.fromRGB(200, 200, 255)
cursorGlow.ImageTransparency = 0.9
cursorGlow.ZIndex = 4
UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        TweenService:Create(cursorGlow, TweenInfo.new(0.15), {
            Position = UDim2.fromOffset(input.Position.X, input.Position.Y)
        }):Play()
    end
end)

-- ========== CARD ==========
local card = Instance.new("Frame")
card.Size = UDim2.fromOffset(0, 0)
card.Position = UDim2.fromScale(0.5, 0.5)
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
card.BackgroundTransparency = 0.05
card.BorderSizePixel = 0
card.ZIndex = 10
card.Parent = gui
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 20)

local neonColors = {Color3.fromRGB(255,255,255), Color3.fromRGB(150,180,255), Color3.fromRGB(200,150,255)}
for i, col in ipairs(neonColors) do
    local s = Instance.new("UIStroke", card)
    s.Color = col
    s.Thickness = i == 1 and 2 or 1
    s.Transparency = 0.7
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    task.spawn(function()
        while card.Parent do
            TweenService:Create(s, TweenInfo.new(math.random(2,4), Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                { Transparency = math.random(30, 80)/100 }):Play()
            task.wait(math.random(2,4))
        end
    end)
end

local function bracket(pos, isTR, isBL, isBR)
    local c = Instance.new("Frame", card)
    c.Size = UDim2.fromOffset(24, 24)
    c.Position = pos
    c.BackgroundTransparency = 1
    c.ZIndex = 12
    local h = Instance.new("Frame", c)
    h.Size = UDim2.new(1, 0, 0, 2)
    h.BackgroundColor3 = Color3.new(1,1,1)
    h.BorderSizePixel = 0
    if isBL or isBR then h.Position = UDim2.new(0, 0, 1, -2) end
    local v = Instance.new("Frame", c)
    v.Size = UDim2.new(0, 2, 1, 0)
    v.BackgroundColor3 = Color3.new(1,1,1)
    v.BorderSizePixel = 0
    if isTR or isBR then v.Position = UDim2.new(1, -2, 0, 0) end
end
bracket(UDim2.new(0, 10, 0, 10))
bracket(UDim2.new(1, -34, 0, 10), true)
bracket(UDim2.new(0, 10, 1, -34), false, true)
bracket(UDim2.new(1, -34, 1, -34), false, false, true)

TweenService:Create(card,
    TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    { Size = UDim2.fromOffset(470, 400) }
):Play()

-- ========== TITLE ==========
local title = Instance.new("TextLabel", card)
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 25)
title.BackgroundTransparency = 1
title.Text = "KEY SYSTEM"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBlack
title.TextSize = 36
title.ZIndex = 12

local tGrad = Instance.new("UIGradient", title)
tGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180,180,200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255,255,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(180,180,200))
}
task.spawn(function()
    while title.Parent do
        tGrad.Offset = Vector2.new(-1, 0)
        TweenService:Create(tGrad, TweenInfo.new(2.5, Enum.EasingStyle.Linear), { Offset = Vector2.new(1, 0) }):Play()
        task.wait(2.5)
    end
end)

local divider = Instance.new("Frame", card)
divider.Size = UDim2.new(1, -60, 0, 1)
divider.Position = UDim2.new(0, 30, 0, 90)
divider.BackgroundColor3 = Color3.new(1,1,1)
divider.BackgroundTransparency = 0.7
divider.BorderSizePixel = 0
divider.ZIndex = 12

-- ========== KEY INPUT ==========
local inputFrame = Instance.new("Frame", card)
inputFrame.Size = UDim2.new(1, -60, 0, 54)
inputFrame.Position = UDim2.new(0, 30, 0, 120)
inputFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
inputFrame.BorderSizePixel = 0
inputFrame.ZIndex = 12
Instance.new("UICorner", inputFrame).CornerRadius = UDim.new(0, 12)

local inputStroke = Instance.new("UIStroke", inputFrame)
inputStroke.Color = Color3.fromRGB(60, 60, 75)
inputStroke.Thickness = 1.5

local textBox = Instance.new("TextBox", inputFrame)
textBox.Size = UDim2.new(1, -100, 1, 0)
textBox.Position = UDim2.new(0, 16, 0, 0)
textBox.BackgroundTransparency = 1
textBox.PlaceholderText = "Paste your key here..."
textBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 105)
textBox.Text = ""
textBox.TextColor3 = Color3.new(1,1,1)
textBox.Font = Enum.Font.Gotham
textBox.TextSize = 14
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.ClearTextOnFocus = false
textBox.ZIndex = 13

local maskOverlay = Instance.new("TextLabel", inputFrame)
maskOverlay.Size = textBox.Size
maskOverlay.Position = textBox.Position
maskOverlay.BackgroundTransparency = 1
maskOverlay.Text = ""
maskOverlay.TextColor3 = Color3.new(1,1,1)
maskOverlay.Font = Enum.Font.Gotham
maskOverlay.TextSize = 14
maskOverlay.TextXAlignment = Enum.TextXAlignment.Left
maskOverlay.ZIndex = 14
maskOverlay.Active = false
maskOverlay.Visible = false

textBox:GetPropertyChangedSignal("Text"):Connect(function()
    if maskOverlay.Visible then
        maskOverlay.Text = string.rep("•", math.min(#textBox.Text, 40))
    end
end)

local eyeBtn = Instance.new("TextButton", inputFrame)
eyeBtn.Size = UDim2.fromOffset(30, 30)
eyeBtn.Position = UDim2.new(1, -76, 0.5, -15)
eyeBtn.BackgroundTransparency = 1
eyeBtn.Text = "👁"
eyeBtn.TextSize = 16
eyeBtn.TextColor3 = Color3.fromRGB(150,150,150)
eyeBtn.ZIndex = 15
eyeBtn.AutoButtonColor = false

eyeBtn.MouseButton1Click:Connect(function()
    maskOverlay.Visible = not maskOverlay.Visible
    textBox.TextTransparency = maskOverlay.Visible and 1 or 0
    eyeBtn.Text = maskOverlay.Visible and "🙈" or "👁"
    eyeBtn.TextColor3 = maskOverlay.Visible and Color3.fromRGB(255,200,80) or Color3.fromRGB(150,150,150)
    if maskOverlay.Visible then
        maskOverlay.Text = string.rep("•", math.min(#textBox.Text, 40))
    end
    playSound("6895079853", 0.3)
end)

local pasteBtn = Instance.new("TextButton", inputFrame)
pasteBtn.Size = UDim2.fromOffset(42, 42)
pasteBtn.Position = UDim2.new(1, -52, 0.5, -21)
pasteBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
pasteBtn.BorderSizePixel = 0
pasteBtn.Text = "📋"
pasteBtn.TextSize = 16
pasteBtn.Font = Enum.Font.GothamBold
pasteBtn.AutoButtonColor = false
pasteBtn.ZIndex = 13
Instance.new("UICorner", pasteBtn).CornerRadius = UDim.new(0, 9)

pasteBtn.MouseButton1Click:Connect(function()
    playSound("6895079853", 0.3)
    local clip = ""
    pcall(function()
        local ok, c = pcall(function() return tostring(getclipboard()) end)
        if ok and c then clip = c end
    end)
    if clip ~= "" then
        textBox.Text = clip
        if maskOverlay.Visible then
            maskOverlay.Text = string.rep("•", math.min(#clip, 40))
        end
        pasteBtn.Text = "✓"
        task.delay(1, function() pasteBtn.Text = "📋" end)
    else
        pasteBtn.Text = "✕"
        task.delay(1, function() pasteBtn.Text = "📋" end)
    end
end)

local function setFocusState(on)
    TweenService:Create(inputStroke, TweenInfo.new(0.25), {
        Color = on and Color3.new(1,1,1) or Color3.fromRGB(60, 60, 75),
        Thickness = on and 2 or 1.5
    }):Play()
end
textBox.Focused:Connect(function() setFocusState(true) end)
textBox.FocusLost:Connect(function() setFocusState(false) end)

-- ========== BUTTON ==========
local btn = Instance.new("TextButton", card)
btn.Size = UDim2.new(1, -60, 0, 54)
btn.Position = UDim2.new(0, 30, 0, 200)
btn.BackgroundColor3 = Color3.new(1,1,1)
btn.BorderSizePixel = 0
btn.Text = ""
btn.AutoButtonColor = false
btn.ClipsDescendants = true
btn.ZIndex = 12
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)

local btnLabel = Instance.new("TextLabel", btn)
btnLabel.Size = UDim2.fromScale(1, 1)
btnLabel.BackgroundTransparency = 1
btnLabel.Text = "VERIFY"
btnLabel.TextColor3 = Color3.fromRGB(10,10,15)
btnLabel.Font = Enum.Font.GothamBlack
btnLabel.TextSize = 15
btnLabel.ZIndex = 13

local shine = Instance.new("Frame", btn)
shine.Size = UDim2.fromOffset(80, 200)
shine.Position = UDim2.new(-0.5, 0, -0.5, 0)
shine.Rotation = 20
shine.BackgroundColor3 = Color3.new(1,1,1)
shine.BorderSizePixel = 0
shine.ZIndex = 14
local shineGrad = Instance.new("UIGradient", shine)
shineGrad.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.5, 0.4),
    NumberSequenceKeypoint.new(1, 1)
}
task.spawn(function()
    while btn.Parent do
        shine.Position = UDim2.new(-0.5, 0, -0.5, 0)
        TweenService:Create(shine, TweenInfo.new(1.4, Enum.EasingStyle.Linear), {
            Position = UDim2.new(1.5, 0, -0.5, 0)
        }):Play()
        task.wait(math.random(3, 5))
    end
end)

btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(235, 235, 240) }):Play()
    TweenService:Create(btnLabel, TweenInfo.new(0.2), { TextSize = 16 }):Play()
    playSound("876939830", 0.15)
end)
btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = Color3.new(1,1,1) }):Play()
    TweenService:Create(btnLabel, TweenInfo.new(0.2), { TextSize = 15 }):Play()
end)

btn.MouseButton1Down:Connect(function()
    local ripple = Instance.new("Frame", btn)
    ripple.Size = UDim2.fromOffset(20, 20)
    ripple.Position = UDim2.new(0.5, -10, 0.5, -10)
    ripple.BackgroundColor3 = Color3.fromRGB(180, 180, 200)
    ripple.BackgroundTransparency = 0.5
    ripple.BorderSizePixel = 0
    ripple.ZIndex = 15
    Instance.new("UICorner", ripple).CornerRadius = UDim.new(1, 0)
    TweenService:Create(ripple, TweenInfo.new(0.6), {
        Size = UDim2.fromOffset(300, 300),
        Position = UDim2.new(0.5, -150, 0.5, -150),
        BackgroundTransparency = 1
    }):Play()
    task.delay(0.6, function() ripple:Destroy() end)
end)

-- ========== LOADING BAR ==========
local loadBg = Instance.new("Frame", card)
loadBg.Size = UDim2.new(1, -60, 0, 4)
loadBg.Position = UDim2.new(0, 30, 0, 265)
loadBg.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
loadBg.BorderSizePixel = 0
loadBg.ZIndex = 12
loadBg.Visible = false
Instance.new("UICorner", loadBg).CornerRadius = UDim.new(1, 0)

local loadFill = Instance.new("Frame", loadBg)
loadFill.Size = UDim2.fromScale(0, 1)
loadFill.BackgroundColor3 = Color3.new(1,1,1)
loadFill.BorderSizePixel = 0
loadFill.ZIndex = 13
Instance.new("UICorner", loadFill).CornerRadius = UDim.new(1, 0)

-- ========== STATUS ==========
local status = Instance.new("TextLabel", card)
status.Size = UDim2.new(1, -60, 0, 40)
status.Position = UDim2.new(0, 30, 0, 275)
status.BackgroundTransparency = 1
status.Text = ""
status.TextColor3 = Color3.fromRGB(180,180,195)
status.Font = Enum.Font.GothamMedium
status.TextSize = 12
status.TextWrapped = true
status.ZIndex = 12

-- ========== GET KEY LINK ==========
local getKeyBtn = Instance.new("TextButton", card)
getKeyBtn.Size = UDim2.new(1, -60, 0, 24)
getKeyBtn.Position = UDim2.new(0, 30, 1, -40)
getKeyBtn.BackgroundTransparency = 1
getKeyBtn.Text = "◆  Don't have a key?  →  Get Key  ◆"
getKeyBtn.TextColor3 = Color3.fromRGB(120, 160, 255)
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 11
getKeyBtn.ZIndex = 12
getKeyBtn.MouseEnter:Connect(function()
    TweenService:Create(getKeyBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(190, 210, 255) }):Play()
end)
getKeyBtn.MouseLeave:Connect(function()
    TweenService:Create(getKeyBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(120, 160, 255) }):Play()
end)

-- ========== CLOSE ==========
local closeBtn = Instance.new("TextButton", card)
closeBtn.Size = UDim2.fromOffset(28, 28)
closeBtn.Position = UDim2.new(1, -38, 0, 12)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(140,140,155)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.ZIndex = 14
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(255, 100, 100) }):Play()
end)
closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(140,140,155) }):Play()
end)

-- ========== CLEANUP ==========
local function cleanup()
    TweenService:Create(blur, TweenInfo.new(0.5), { Size = 0 }):Play()
    TweenService:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.fromOffset(0, 0), BackgroundTransparency = 1
    }):Play()
    task.delay(0.55, function()
        if blur then blur:Destroy() end
        if gui then gui:Destroy() end
    end)
end
closeBtn.MouseButton1Click:Connect(function()
    playSound("6895079853", 0.3)
    cleanup()
end)

-- ========== EFFECTS ==========
local function flash(color, transparency)
    local f = Instance.new("Frame", card)
    f.Size = UDim2.fromScale(1, 1)
    f.BackgroundColor3 = color
    f.BackgroundTransparency = transparency
    f.BorderSizePixel = 0
    f.ZIndex = 20
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 20)
    TweenService:Create(f, TweenInfo.new(0.5), { BackgroundTransparency = 1 }):Play()
    task.delay(0.6, function() f:Destroy() end)
end

local function shake(intensity, times)
    local orig = UDim2.new(0.5, 0, 0.5, 0)
    for i = 1, times do
        card.Position = UDim2.new(0.5, (i % 2 == 0 and -intensity or intensity), 0.5, math.random(-3, 3))
        task.wait(0.02)
    end
    card.Position = orig
end

local function confettiBurst()
    for i = 1, 40 do
        local c = Instance.new("Frame", gui)
        c.Size = UDim2.fromOffset(math.random(4, 10), math.random(4, 10))
        c.Position = UDim2.fromScale(0.5, 0.5)
        c.BackgroundColor3 = Color3.fromRGB(math.random(150, 255), math.random(150, 255), math.random(150, 255))
        c.BorderSizePixel = 0
        c.ZIndex = 30
        Instance.new("UICorner", c).CornerRadius = UDim.new(1, 0)
        local angle = math.random() * math.pi * 2
        local dist = math.random(200, 600)
        local tX = 0.5 + (math.cos(angle) * dist / 1200)
        local tY = 0.5 + (math.sin(angle) * dist / 1200)
        TweenService:Create(c, TweenInfo.new(math.random(8, 14)/10, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromScale(tX, tY),
            Rotation = math.random(-720, 720),
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(2, 2)
        }):Play()
        task.delay(1.5, function() c:Destroy() end)
    end
end

local function successCheck()
    local chk = Instance.new("TextLabel", card)
    chk.Size = UDim2.fromScale(1, 1)
    chk.BackgroundTransparency = 1
    chk.Text = "✓"
    chk.TextColor3 = Color3.fromRGB(100, 255, 150)
    chk.Font = Enum.Font.GothamBlack
    chk.TextSize = 0
    chk.TextTransparency = 0.3
    chk.ZIndex = 25
    TweenService:Create(chk, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        TextSize = 220, TextTransparency = 0.5
    }):Play()
    task.delay(0.7, function()
        TweenService:Create(chk, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
    end)
    task.delay(1.2, function() chk:Destroy() end)
end

-- ========== AUTH ==========
local processing = false

local function tryValidate()
    if processing then return end
    local key = textBox.Text
    if not key or key == "" then
        status.Text = "⚠  Please enter a key."
        status.TextColor3 = Color3.fromRGB(255, 200, 80)
        playSound("9120386555", 0.4)
        shake(8, 6)
        return
    end

    playSound("6895079853", 0.4)
    processing = true
    btnLabel.Text = "VERIFYING..."
    loadBg.Visible = true
    loadFill.Size = UDim2.fromScale(0, 1)
    TweenService:Create(loadFill, TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(1, 1)
    }):Play()

    for _, child in ipairs(card:GetChildren()) do
        if child:IsA("UIStroke") then
            TweenService:Create(child, TweenInfo.new(0.3), { Color = Color3.new(1,1,1), Transparency = 0.5 }):Play()
        end
    end
    status.Text = "Connecting to server..."
    status.TextColor3 = Color3.fromRGB(180,180,195)

    task.spawn(function()
        local ok, res = pcall(function()
            task.wait(2.0)
            local PUSL = loadstring(game:HttpGet("https://secure.pandauth.com/pv4/lib"))()
            if not PUSL or type(PUSL.configure) ~= "function" then
                error("Library failed to load.")
            end
            PUSL.configure({ serviceId = "oldhacfardshubkey" })
            local r = PUSL.validate(key)
            if not r.success then error("Invalid key.") end
            return r
        end)

        processing = false
        loadBg.Visible = false
        btnLabel.Text = "VERIFY"

        if ok then
            status.Text = "✓  Verified! Loading..."
            status.TextColor3 = Color3.fromRGB(100, 255, 150)
            for _, child in ipairs(card:GetChildren()) do
                if child:IsA("UIStroke") then
                    TweenService:Create(child, TweenInfo.new(0.4), {
                        Color = Color3.fromRGB(100, 255, 150), Transparency = 0
                    }):Play()
                end
            end
            TweenService:Create(btn, TweenInfo.new(0.4), { BackgroundColor3 = Color3.fromRGB(100, 255, 150) }):Play()
            playSound("9120386436", 0.5)
            successCheck()
            confettiBurst()
            task.wait(1.5)
            cleanup()
            print("[KeySystem] Authenticated. Premium:", res.isPremium)
          
loadstring(game:HttpGet("https://raw.githubusercontent.com/oldhacfard/Oldy-libsry/refs/heads/main/Kit.luau"))()
        
        else
            status.Text = "✕  " .. tostring(res)
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            for _, child in ipairs(card:GetChildren()) do
                if child:IsA("UIStroke") then
                    TweenService:Create(child, TweenInfo.new(0.3), {
                        Color = Color3.fromRGB(255, 80, 80), Transparency = 0
                    }):Play()
                end
            end
            playSound("9120386555", 0.5)
            flash(Color3.fromRGB(255, 50, 50), 0.5)
            shake(12, 10)
            task.delay(2, function()
                if card and card.Parent then
                    for _, child in ipairs(card:GetChildren()) do
                        if child:IsA("UIStroke") then
                            TweenService:Create(child, TweenInfo.new(0.5), {
                                Color = Color3.new(1,1,1), Transparency = 0.7
                            }):Play()
                        end
                    end
                end
            end)
        end
    end)
end

btn.MouseButton1Click:Connect(tryValidate)
textBox.FocusLost:Connect(function(enter) if enter then tryValidate() end end)

-- ========== DRAG ==========
do
    local dragging, dragStart, startPos
    card.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = card.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ========== GET KEY (DÜZELTİLDİ) ==========
getKeyBtn.MouseButton1Click:Connect(function()
    playSound("6895079853", 0.3)
    
    -- Sabit link kullanılıyor:
    local url = "https://ads.pandauth.com/getkey/oldhacfardshubkey"
    
    if setclipboard then 
        setclipboard(url) 
    end
    
    status.Text = "🔗 Key link copied to clipboard!"
    status.TextColor3 = Color3.fromRGB(120, 160, 255)
end)

-- Auto focus
task.wait(0.8)
if textBox and textBox.Parent then textBox:CaptureFocus() end
