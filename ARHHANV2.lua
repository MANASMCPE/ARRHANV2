--[[ SUPERMONKXSCRIPTS | ARHHAN V2 | Custom GUI Edition ]]

local Players            = game:GetService("Players")
local CoreGui            = game:GetService("CoreGui")
local TweenService       = game:GetService("TweenService")
local RunService         = game:GetService("RunService")
local UserInputService   = game:GetService("UserInputService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local TextChatService    = game:GetService("TextChatService")

-- ================= CLEANUP =================
for _, n in ipairs({"MonkLoadingScreen","MonkHeaderOverlay","MonkTouchFx","MonkMainGui"}) do
    local o = CoreGui:FindFirstChild(n); if o then o:Destroy() end
end
pcall(function()
    for _, n in ipairs({"ToxicChocoSpammer","AlphaDaddySpammer"}) do
        local o = CoreGui:FindFirstChild(n); if o then o:Destroy() end
    end
end)

-- ================= TOUCH RIPPLE =================
do
    local fxGui = Instance.new("ScreenGui")
    fxGui.Name = "MonkTouchFx"
    fxGui.IgnoreGuiInset = true
    fxGui.ResetOnSpawn = false
    fxGui.DisplayOrder = 2147483646
    fxGui.Parent = CoreGui

    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
           and input.UserInputType ~= Enum.UserInputType.Touch then return end
        local x, y = input.Position.X, input.Position.Y
        local r = Instance.new("Frame")
        r.Size = UDim2.new(0, 20, 0, 20)
        r.Position = UDim2.new(0, x - 10, 0, y - 10)
        r.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
        r.BackgroundTransparency = 0.5
        r.BorderSizePixel = 0
        r.Parent = fxGui
        Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
        local s = Instance.new("UIStroke", r)
        s.Color = Color3.fromRGB(255, 255, 255); s.Thickness = 2; s.Transparency = 0.3
        TweenService:Create(r, TweenInfo.new(0.65, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 140, 0, 140),
            Position = UDim2.new(0, x - 70, 0, y - 70),
            BackgroundTransparency = 1,
        }):Play()
        TweenService:Create(s, TweenInfo.new(0.65), {Transparency = 1}):Play()
        task.delay(0.7, function() r:Destroy() end)
    end)
end

-- ================= INTRO CHAT =================
task.spawn(function()
    task.wait(1)
    local msg = "✌ SUPERMONKXSCRIPTS | ARHHAN V2 LOADED ⚠️ (OWNER: SUPERMONKXSCRIPTS ✅)"
    local b = "(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)"
    local full = b .. "\n" .. msg .. "\n" .. b
    local ev = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if ev and ev:FindFirstChild("SayMessageRequest") then
        ev.SayMessageRequest:FireServer(full, "All")
    else
        local tc = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
        if tc then tc:SendAsync(full) end
    end
end)

------------------------------------------------------------
-- LOADING SCREEN (ARHHAN V2 + Black Hole)
------------------------------------------------------------
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "MonkLoadingScreen"
loadingGui.IgnoreGuiInset = true
loadingGui.ResetOnSpawn = false
loadingGui.DisplayOrder = 999999
loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
loadingGui.Parent = CoreGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

-- Stars
for _ = 1, 70 do
    local s = Instance.new("Frame")
    local sz = math.random(1, 3)
    s.Size = UDim2.new(0, sz, 0, sz)
    s.Position = UDim2.new(math.random(), 0, math.random(), 0)
    s.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    s.BackgroundTransparency = math.random(30, 85) / 100
    s.BorderSizePixel = 0
    s.Parent = bg
    Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
end

-- Black hole
local bhC = Instance.new("Frame")
bhC.Size = UDim2.new(0, 320, 0, 320)
bhC.Position = UDim2.new(0.5, 0, 0.5, 0)
bhC.AnchorPoint = Vector2.new(0.5, 0.5)
bhC.BackgroundTransparency = 1
bhC.Parent = bg

local glowImg = Instance.new("ImageLabel")
glowImg.Size = UDim2.new(0.7, 0, 0.7, 0)
glowImg.Position = UDim2.new(0.5, 0, 0.5, 0)
glowImg.AnchorPoint = Vector2.new(0.5, 0.5)
glowImg.BackgroundTransparency = 1
glowImg.Image = "rbxassetid://5028857084"
glowImg.ImageColor3 = Color3.fromRGB(150, 60, 255)
glowImg.ImageTransparency = 0.3
glowImg.Parent = bhC

local rings = {}
for i = 1, 4 do
    local ring = Instance.new("Frame")
    ring.Size = UDim2.new(0.55 + i * 0.14, 0, 0.55 + i * 0.14, 0)
    ring.Position = UDim2.new(0.5, 0, 0.5, 0)
    ring.AnchorPoint = Vector2.new(0.5, 0.5)
    ring.BackgroundTransparency = 1
    ring.Parent = bhC
    local stroke = Instance.new("UIStroke", ring)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(180 - i * 20, 80, 255 - i * 15)
    stroke.Transparency = 0.15 + i * 0.15
    Instance.new("UICorner", ring).CornerRadius = UDim.new(1, 0)
    table.insert(rings, {frame = ring, speed = 0.25 + i * 0.15, dir = (i % 2 == 0) and 1 or -1})
end

local eh = Instance.new("Frame")
eh.Size = UDim2.new(0.48, 0, 0.48, 0)
eh.Position = UDim2.new(0.5, 0, 0.5, 0)
eh.AnchorPoint = Vector2.new(0.5, 0.5)
eh.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
eh.BorderSizePixel = 0
eh.Parent = bhC
Instance.new("UICorner", eh).CornerRadius = UDim.new(1, 0)

-- Title
local tC = Instance.new("Frame")
tC.Size = UDim2.new(0, 560, 0, 90)
tC.Position = UDim2.new(0.5, 0, 0.32, 0)
tC.AnchorPoint = Vector2.new(0.5, 0.5)
tC.BackgroundTransparency = 1
tC.Parent = bg

for off = 6, 1, -1 do
    local sh = Instance.new("TextLabel")
    sh.Size = UDim2.new(1, 0, 1, 0)
    sh.Position = UDim2.new(0, off, 0, off)
    sh.BackgroundTransparency = 1
    sh.Font = Enum.Font.GothamBlack
    sh.Text = "ARHHAN V2"
    sh.TextColor3 = Color3.fromRGB(45, 15, 75)
    sh.TextSize = 54
    sh.Parent = tC
end
local mainT = Instance.new("TextLabel")
mainT.Size = UDim2.new(1, 0, 1, 0)
mainT.BackgroundTransparency = 1
mainT.Font = Enum.Font.GothamBlack
mainT.Text = "ARHHAN V2"
mainT.TextColor3 = Color3.fromRGB(255, 255, 255)
mainT.TextSize = 54
mainT.Parent = tC

local mStroke = Instance.new("UIStroke", mainT)
mStroke.Color = Color3.fromRGB(190, 120, 255)
mStroke.Thickness = 2.5
mStroke.Transparency = 0.2

local function makeWing(parent, side)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(0, 130, 0, 80)
    holder.BackgroundTransparency = 1
    holder.Parent = parent
    holder.Position = (side == "left") and UDim2.new(0, -135, 0.5, -40) or UDim2.new(1, 5, 0.5, -40)
    for i = 1, 4 do
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0, 65 - i * 7, 0, 8)
        f.Position = UDim2.new(0, 40, 0, 18 + i * 12)
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.Rotation = (side == "left") and (22 + i * 8) or (-22 - i * 8)
        f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        f.BackgroundTransparency = 0.25
        f.BorderSizePixel = 0
        f.Parent = holder
        Instance.new("UICorner", f).CornerRadius = UDim.new(1, 0)
        local g = Instance.new("UIGradient", f)
        g.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 100, 255)),
        }
    end
end
makeWing(tC, "left"); makeWing(tC, "right")

-- Subtitle
local subLbl = Instance.new("TextLabel")
subLbl.Size = UDim2.new(0, 500, 0, 30)
subLbl.Position = UDim2.new(0.5, 0, 0.42, 0)
subLbl.AnchorPoint = Vector2.new(0.5, 0.5)
subLbl.BackgroundTransparency = 1
subLbl.Font = Enum.Font.GothamBold
subLbl.Text = "SUPERMONKXSCRIPTS  •  OWNER  •  VERIFIED ✅"
subLbl.TextColor3 = Color3.fromRGB(200, 170, 255)
subLbl.TextSize = 16
subLbl.Parent = bg

-- Loading text + progress bar
local loadLbl = Instance.new("TextLabel")
loadLbl.Size = UDim2.new(0, 400, 0, 30)
loadLbl.Position = UDim2.new(0.5, 0, 0.66, 0)
loadLbl.AnchorPoint = Vector2.new(0.5, 0.5)
loadLbl.BackgroundTransparency = 1
loadLbl.Font = Enum.Font.GothamBold
loadLbl.Text = "LOADING..."
loadLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
loadLbl.TextSize = 20
loadLbl.Parent = bg

local pBg = Instance.new("Frame")
pBg.Size = UDim2.new(0, 420, 0, 8)
pBg.Position = UDim2.new(0.5, 0, 0.73, 0)
pBg.AnchorPoint = Vector2.new(0.5, 0.5)
pBg.BackgroundColor3 = Color3.fromRGB(30, 20, 55)
pBg.BorderSizePixel = 0
pBg.Parent = bg
Instance.new("UICorner", pBg).CornerRadius = UDim.new(1, 0)

local pFill = Instance.new("Frame")
pFill.Size = UDim2.new(0, 0, 1, 0)
pFill.BackgroundColor3 = Color3.fromRGB(180, 100, 255)
pFill.BorderSizePixel = 0
pFill.Parent = pBg
Instance.new("UICorner", pFill).CornerRadius = UDim.new(1, 0)
local pGrad = Instance.new("UIGradient", pFill)
pGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200)),
}

local pct = Instance.new("TextLabel")
pct.Size = UDim2.new(0, 400, 0, 20)
pct.Position = UDim2.new(0.5, 0, 0.78, 0)
pct.AnchorPoint = Vector2.new(0.5, 0.5)
pct.BackgroundTransparency = 1
pct.Font = Enum.Font.Gotham
pct.Text = "0%"
pct.TextColor3 = Color3.fromRGB(200, 180, 255)
pct.TextSize = 14
pct.Parent = bg

local spin, pulse = 0, 0
RunService.RenderStepped:Connect(function(dt)
    if not loadingGui.Parent then return end
    spin = spin + dt; pulse = pulse + dt * 2
    for _, r in ipairs(rings) do
        r.frame.Rotation = spin * r.speed * 60 * r.dir
    end
    bhC.Position = UDim2.new(0.5, math.sin(spin * 2) * 10, 0.5, math.cos(spin * 1.5) * 10)
    glowImg.ImageTransparency = 0.3 + math.sin(spin * 2) * 0.15
    mStroke.Transparency = 0.15 + math.sin(pulse) * 0.2
end)

local loadingDone = false
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.03)
        TweenService:Create(pFill, TweenInfo.new(0.1), {Size = UDim2.new(i / 100, 0, 1, 0)}):Play()
        pct.Text = i .. "%"
    end
    loadLbl.Text = "ARHHAN V2 LOADED ✔"
    task.wait(0.6)
    loadLbl.Text = "CLICK ANYWHERE TO CONTINUE"
    loadLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    TweenService:Create(loadLbl, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {TextTransparency = 0.5}):Play()
    loadingDone = true
end)

------------------------------------------------------------
-- FULL CUSTOM GUI BUILDER
------------------------------------------------------------
local function buildMainGui()
    local mainGui = Instance.new("ScreenGui")
    mainGui.Name = "MonkMainGui"
    mainGui.IgnoreGuiInset = true
    mainGui.ResetOnSpawn = false
    mainGui.DisplayOrder = 500
    mainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    mainGui.Parent = CoreGui

    -- Dim
    local dim = Instance.new("Frame")
    dim.Size = UDim2.new(1, 0, 1, 0)
    dim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dim.BackgroundTransparency = 0.55
    dim.BorderSizePixel = 0
    dim.Parent = mainGui

    -- ================= WINDOW =================
    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 580, 0, 500)
    window.Position = UDim2.new(0.5, -290, 0.5, -250)
    window.BackgroundColor3 = Color3.fromRGB(12, 8, 22)
    window.BackgroundTransparency = 0.05
    window.BorderSizePixel = 0
    window.ClipsDescendants = true
    window.Parent = mainGui
    Instance.new("UICorner", window).CornerRadius = UDim.new(0, 16)
    local wStroke = Instance.new("UIStroke", window)
    wStroke.Color = Color3.fromRGB(140, 80, 220)
    wStroke.Thickness = 2
    wStroke.Transparency = 0.2

    -- Floating black hole behind everything in window
    local bhHolder = Instance.new("Frame")
    bhHolder.Size = UDim2.new(0, 260, 0, 260)
    bhHolder.Position = UDim2.new(0.75, -130, 0.55, -130)
    bhHolder.BackgroundTransparency = 1
    bhHolder.ZIndex = 1
    bhHolder.Parent = window

    local bhGlow = Instance.new("ImageLabel")
    bhGlow.Size = UDim2.new(2, 0, 2, 0)
    bhGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    bhGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    bhGlow.BackgroundTransparency = 1
    bhGlow.Image = "rbxassetid://5028857084"
    bhGlow.ImageColor3 = Color3.fromRGB(120, 50, 200)
    bhGlow.ImageTransparency = 0.55
    bhGlow.ZIndex = 1
    bhGlow.Parent = bhHolder

    local bhCore = Instance.new("Frame")
    bhCore.Size = UDim2.new(0.55, 0, 0.55, 0)
    bhCore.Position = UDim2.new(0.5, 0, 0.5, 0)
    bhCore.AnchorPoint = Vector2.new(0.5, 0.5)
    bhCore.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bhCore.BorderSizePixel = 0
    bhCore.ZIndex = 1
    bhCore.Parent = bhHolder
    Instance.new("UICorner", bhCore).CornerRadius = UDim.new(1, 0)
    local bhRing2 = Instance.new("Frame", bhHolder)
    bhRing2.Size = UDim2.new(1, 0, 1, 0)
    bhRing2.Position = UDim2.new(0.5, 0, 0.5, 0)
    bhRing2.AnchorPoint = Vector2.new(0.5, 0.5)
    bhRing2.BackgroundTransparency = 1
    bhRing2.ZIndex = 1
    local rs = Instance.new("UIStroke", bhRing2)
    rs.Color = Color3.fromRGB(160, 90, 240); rs.Thickness = 1.5; rs.Transparency = 0.4
    Instance.new("UICorner", bhRing2).CornerRadius = UDim.new(1, 0)

    -- ================= HEADER =================
    local header = Instance.new("Frame")
    header.Size = UDim2.new(1, 0, 0, 78)
    header.BackgroundColor3 = Color3.fromRGB(22, 14, 40)
    header.BackgroundTransparency = 0.05
    header.BorderSizePixel = 0
    header.ZIndex = 10
    header.Parent = window
    local hCorner = Instance.new("UICorner", header)
    hCorner.CornerRadius = UDim.new(0, 16)
    -- bottom mask
    local hMask = Instance.new("Frame", header)
    hMask.Size = UDim2.new(1, 0, 0, 20)
    hMask.Position = UDim2.new(0, 0, 1, -20)
    hMask.BackgroundColor3 = Color3.fromRGB(22, 14, 40)
    hMask.BackgroundTransparency = 0.05
    hMask.BorderSizePixel = 0
    hMask.ZIndex = 10

    -- Mini black hole in header
    local hBH = Instance.new("Frame")
    hBH.Size = UDim2.new(0, 46, 0, 46)
    hBH.Position = UDim2.new(0, 12, 0.5, -23)
    hBH.BackgroundColor3 = Color3.fromRGB(5, 0, 15)
    hBH.BorderSizePixel = 0
    hBH.ZIndex = 12
    hBH.Parent = header
    Instance.new("UICorner", hBH).CornerRadius = UDim.new(1, 0)
    local hBHGlow = Instance.new("ImageLabel", hBH)
    hBHGlow.Size = UDim2.new(2, 0, 2, 0)
    hBHGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    hBHGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    hBHGlow.BackgroundTransparency = 1
    hBHGlow.Image = "rbxassetid://5028857084"
    hBHGlow.ImageColor3 = Color3.fromRGB(150, 60, 255)
    hBHGlow.ImageTransparency = 0.35

    -- Title
    local titleLbl = Instance.new("TextLabel")
    titleLbl.Size = UDim2.new(1, -180, 0, 26)
    titleLbl.Position = UDim2.new(0, 68, 0, 12)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBlack
    titleLbl.Text = "SUPERMONKXSCRIPTS"
    titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLbl.TextSize = 22
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 12
    titleLbl.Parent = header
    local tSt = Instance.new("UIStroke", titleLbl)
    tSt.Color = Color3.fromRGB(200, 130, 255)
    tSt.Thickness = 1.5
    tSt.Transparency = 0.3

    -- Badges
    local bRow = Instance.new("Frame")
    bRow.Size = UDim2.new(1, -180, 0, 22)
    bRow.Position = UDim2.new(0, 68, 0, 42)
    bRow.BackgroundTransparency = 1
    bRow.ZIndex = 12
    bRow.Parent = header
    local bLayout = Instance.new("UIListLayout", bRow)
    bLayout.FillDirection = Enum.FillDirection.Horizontal
    bLayout.Padding = UDim.new(0, 8)

    local function makeBadge(text, bg, fg, width)
        local b = Instance.new("Frame")
        b.Size = UDim2.new(0, width, 1, 0)
        b.BackgroundColor3 = bg
        b.BackgroundTransparency = 0.15
        b.BorderSizePixel = 0
        b.ZIndex = 12
        b.Parent = bRow
        Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
        local s = Instance.new("UIStroke", b)
        s.Color = fg; s.Thickness = 1; s.Transparency = 0.3
        local l = Instance.new("TextLabel", b)
        l.Size = UDim2.new(1, 0, 1, 0)
        l.BackgroundTransparency = 1
        l.Font = Enum.Font.GothamBold
        l.Text = text
        l.TextColor3 = fg
        l.TextSize = 11
        l.ZIndex = 13
    end
    makeBadge("👑 OWNER", Color3.fromRGB(60, 45, 10), Color3.fromRGB(255, 215, 0), 90)
    makeBadge("✅ VERIFIED", Color3.fromRGB(10, 40, 60), Color3.fromRGB(100, 220, 255), 100)

    -- Close / Minimize
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -42, 0, 12)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 80)
    closeBtn.BackgroundTransparency = 0.15
    closeBtn.Text = "✕"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextSize = 16
    closeBtn.BorderSizePixel = 0
    closeBtn.ZIndex = 14
    closeBtn.Parent = header
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

    -- ================= TABS BAR =================
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, -24, 0, 42)
    tabBar.Position = UDim2.new(0, 12, 0, 88)
    tabBar.BackgroundColor3 = Color3.fromRGB(20, 12, 36)
    tabBar.BackgroundTransparency = 0.1
    tabBar.BorderSizePixel = 0
    tabBar.ZIndex = 10
    tabBar.Parent = window
    Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 10)
    local tabLayout = Instance.new("UIListLayout", tabBar)
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 6)
    tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

    -- Content area
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -24, 1, -148)
    content.Position = UDim2.new(0, 12, 0, 138)
    content.BackgroundColor3 = Color3.fromRGB(18, 10, 32)
    content.BackgroundTransparency = 0.1
    content.BorderSizePixel = 0
    content.ZIndex = 10
    content.Parent = window
    Instance.new("UICorner", content).CornerRadius = UDim.new(0, 12)

    -- ================= TABS =================
    local pages = {}
    local tabs = {}
    local currentTab

    local function makePage(name)
        local p = Instance.new("ScrollingFrame")
        p.Size = UDim2.new(1, -20, 1, -20)
        p.Position = UDim2.new(0, 10, 0, 10)
        p.BackgroundTransparency = 1
        p.BorderSizePixel = 0
        p.ScrollBarThickness = 4
        p.ScrollBarImageColor3 = Color3.fromRGB(140, 80, 220)
        p.CanvasSize = UDim2.new(0, 0, 0, 0)
        p.ZIndex = 11
        p.Visible = false
        p.Parent = content
        local list = Instance.new("UIListLayout", p)
        list.Padding = UDim.new(0, 8)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            p.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 10)
        end)
        pages[name] = p
        return p
    end

    local function switchTab(name)
        for n, p in pairs(pages) do p.Visible = (n == name) end
        for n, b in pairs(tabs) do
            if n == name then
                TweenService:Create(b, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(120, 70, 200),
                    BackgroundTransparency = 0.15
                }):Play()
                b.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                TweenService:Create(b, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(35, 20, 55),
                    BackgroundTransparency = 0.2
                }):Play()
                b.TextColor3 = Color3.fromRGB(180, 170, 210)
            end
        end
    end

    local function addTab(name, label)
        local b = Instance.new("TextButton")
        b.Size = UDim2.new(0, 110, 0, 32)
        b.BackgroundColor3 = Color3.fromRGB(35, 20, 55)
        b.BackgroundTransparency = 0.2
        b.Text = label or name
        b.Font = Enum.Font.GothamBold
        b.TextColor3 = Color3.fromRGB(180, 170, 210)
        b.TextSize = 13
        b.BorderSizePixel = 0
        b.ZIndex = 11
        b.Parent = tabBar
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
        tabs[name] = b
        makePage(name)
        b.MouseButton1Click:Connect(function() switchTab(name) end)
    end

    addTab("main", "MAIN")
    addTab("targets", "TARGETS")
    addTab("info", "INFO")

    -- ================= UI HELPERS =================
    local function makeCard(parent, height)
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, -4, 0, height)
        card.BackgroundColor3 = Color3.fromRGB(28, 18, 48)
        card.BackgroundTransparency = 0.1
        card.BorderSizePixel = 0
        card.ZIndex = 11
        card.Parent = parent
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        local st = Instance.new("UIStroke", card)
        st.Color = Color3.fromRGB(90, 60, 140); st.Thickness = 1; st.Transparency = 0.5
        return card
    end

    -- ================= MAIN PAGE =================
    local mainPage = pages["main"]

    -- Custom message input
    local msgCard = makeCard(mainPage, 70)
    local msgLbl = Instance.new("TextLabel", msgCard)
    msgLbl.Size = UDim2.new(1, -20, 0, 20)
    msgLbl.Position = UDim2.new(0, 10, 0, 8)
    msgLbl.BackgroundTransparency = 1
    msgLbl.Font = Enum.Font.GothamBold
    msgLbl.Text = "CUSTOM MESSAGE PREFIX"
    msgLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    msgLbl.TextSize = 11
    msgLbl.TextXAlignment = Enum.TextXAlignment.Left
    msgLbl.ZIndex = 12

    local msgBox = Instance.new("TextBox")
    msgBox.Size = UDim2.new(1, -20, 0, 30)
    msgBox.Position = UDim2.new(0, 10, 0, 32)
    msgBox.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
    msgBox.BorderSizePixel = 0
    msgBox.Font = Enum.Font.Gotham
    msgBox.Text = ""
    msgBox.PlaceholderText = "Type prefix..."
    msgBox.PlaceholderColor3 = Color3.fromRGB(100, 90, 130)
    msgBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    msgBox.TextSize = 13
    msgBox.TextXAlignment = Enum.TextXAlignment.Left
    msgBox.ClearTextOnFocus = false
    msgBox.ZIndex = 12
    msgBox.Parent = msgCard
    Instance.new("UICorner", msgBox).CornerRadius = UDim.new(0, 6)
    local msgPad = Instance.new("UIPadding", msgBox)
    msgPad.PaddingLeft = UDim.new(0, 8)

    -- Slider
    local sliderCard = makeCard(mainPage, 70)
    local sliderLbl = Instance.new("TextLabel", sliderCard)
    sliderLbl.Size = UDim2.new(1, -20, 0, 20)
    sliderLbl.Position = UDim2.new(0, 10, 0, 8)
    sliderLbl.BackgroundTransparency = 1
    sliderLbl.Font = Enum.Font.GothamBold
    sliderLbl.Text = "DELAY: 2.4s"
    sliderLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    sliderLbl.TextSize = 11
    sliderLbl.TextXAlignment = Enum.TextXAlignment.Left
    sliderLbl.ZIndex = 12

    local sliderTrack = Instance.new("Frame", sliderCard)
    sliderTrack.Size = UDim2.new(1, -30, 0, 8)
    sliderTrack.Position = UDim2.new(0, 15, 0, 45)
    sliderTrack.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
    sliderTrack.BorderSizePixel = 0
    sliderTrack.ZIndex = 12
    Instance.new("UICorner", sliderTrack).CornerRadius = UDim.new(1, 0)

    local sliderFill = Instance.new("Frame", sliderTrack)
    sliderFill.Size = UDim2.new(0.24, 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(160, 90, 240)
    sliderFill.BorderSizePixel = 0
    sliderFill.ZIndex = 12
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)
    local sFillGrad = Instance.new("UIGradient", sliderFill)
    sFillGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 200)),
    }

    local sliderKnob = Instance.new("Frame", sliderTrack)
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.Position = UDim2.new(0.24, -8, 0.5, -8)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.BorderSizePixel = 0
    sliderKnob.ZIndex = 13
    Instance.new("UICorner", sliderKnob).CornerRadius = UDim.new(1, 0)
    local kStroke = Instance.new("UIStroke", sliderKnob)
    kStroke.Color = Color3.fromRGB(160, 90, 240); kStroke.Thickness = 2

    -- Slider value
    local delayValue = 2.4
    local minDelay, maxDelay = 0.1, 10

    local dragging = false
    local function updateSlider(relX)
        local abs = sliderTrack.AbsoluteSize.X
        local p = math.clamp(relX / abs, 0, 1)
        sliderFill.Size = UDim2.new(p, 0, 1, 0)
        sliderKnob.Position = UDim2.new(p, -8, 0.5, -8)
        delayValue = minDelay + (maxDelay - minDelay) * p
        sliderLbl.Text = string.format("DELAY: %.1fs", delayValue)
    end

    sliderTrack.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(i.Position.X - sliderTrack.AbsolutePosition.X)
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement
           or i.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(i.Position.X - sliderTrack.AbsolutePosition.X)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    -- Burst mode toggle
    local burstCard = makeCard(mainPage, 55)
    local burstLbl = Instance.new("TextLabel", burstCard)
    burstLbl.Size = UDim2.new(1, -90, 1, 0)
    burstLbl.Position = UDim2.new(0, 12, 0, 0)
    burstLbl.BackgroundTransparency = 1
    burstLbl.Font = Enum.Font.GothamBold
    burstLbl.Text = "BURST MODE (FAST)"
    burstLbl.TextColor3 = Color3.fromRGB(200, 180, 255)
    burstLbl.TextSize = 12
    burstLbl.TextXAlignment = Enum.TextXAlignment.Left
    burstLbl.ZIndex = 12

    local burstOn = false
    local burstToggle = Instance.new("Frame", burstCard)
    burstToggle.Size = UDim2.new(0, 50, 0, 26)
    burstToggle.Position = UDim2.new(1, -62, 0.5, -13)
    burstToggle.BackgroundColor3 = Color3.fromRGB(60, 40, 90)
    burstToggle.BorderSizePixel = 0
    burstToggle.ZIndex = 12
    Instance.new("UICorner", burstToggle).CornerRadius = UDim.new(1, 0)
    local burstKnob = Instance.new("Frame", burstToggle)
    burstKnob.Size = UDim2.new(0, 20, 0, 20)
    burstKnob.Position = UDim2.new(0, 3, 0.5, -10)
    burstKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    burstKnob.BorderSizePixel = 0
    burstKnob.ZIndex = 13
    Instance.new("UICorner", burstKnob).CornerRadius = UDim.new(1, 0)

    burstToggle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            burstOn = not burstOn
            if burstOn then
                TweenService:Create(burstToggle, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(160, 90, 240)
                }):Play()
                TweenService:Create(burstKnob, TweenInfo.new(0.25), {
                    Position = UDim2.new(1, -23, 0.5, -10)
                }):Play()
                delayValue = 0.2
                sliderFill.Size = UDim2.new(0.01, 0, 1, 0)
                sliderKnob.Position = UDim2.new(0.01, -8, 0.5, -8)
                sliderLbl.Text = "DELAY: 0.2s"
            else
                TweenService:Create(burstToggle, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(60, 40, 90)
                }):Play()
                TweenService:Create(burstKnob, TweenInfo.new(0.25), {
                    Position = UDim2.new(0, 3, 0.5, -10)
                }):Play()
                delayValue = 2.4
                sliderFill.Size = UDim2.new(0.24, 0, 1, 0)
                sliderKnob.Position = UDim2.new(0.24, -8, 0.5, -8)
                sliderLbl.Text = "DELAY: 2.4s"
            end
        end
    end)

    -- Status label
    local statusCard = makeCard(mainPage, 44)
    local statusDot = Instance.new("Frame", statusCard)
    statusDot.Size = UDim2.new(0, 10, 0, 10)
    statusDot.Position = UDim2.new(0, 14, 0.5, -5)
    statusDot.BackgroundColor3 = Color3.fromRGB(239, 68, 68)
    statusDot.BorderSizePixel = 0
    statusDot.ZIndex = 12
    Instance.new("UICorner", statusDot).CornerRadius = UDim.new(1, 0)

    local statusLbl = Instance.new("TextLabel", statusCard)
    statusLbl.Size = UDim2.new(1, -40, 1, 0)
    statusLbl.Position = UDim2.new(0, 32, 0, 0)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Font = Enum.Font.GothamBold
    statusLbl.Text = "STATUS: STOPPED"
    statusLbl.TextColor3 = Color3.fromRGB(255, 150, 150)
    statusLbl.TextSize = 12
    statusLbl.TextXAlignment = Enum.TextXAlignment.Left
    statusLbl.ZIndex = 12

    local function setStatus(text, color)
        statusLbl.Text = "STATUS: " .. text
        statusLbl.TextColor3 = color
        statusDot.BackgroundColor3 = color
    end

    -- Start/Stop button
    local startBtn = Instance.new("TextButton")
    startBtn.Size = UDim2.new(1, -4, 0, 50)
    startBtn.BackgroundColor3 = Color3.fromRGB(120, 70, 200)
    startBtn.BackgroundTransparency = 0
    startBtn.Text = "▶ START SPAM"
    startBtn.Font = Enum.Font.GothamBlack
    startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    startBtn.TextSize = 16
    startBtn.BorderSizePixel = 0
    startBtn.ZIndex = 11
    startBtn.Parent = mainPage
    Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 10)
    local sBtnGrad = Instance.new("UIGradient", startBtn)
    sBtnGrad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 240)),
    }

    -- ================= TARGETS PAGE =================
    local targetPage = pages["targets"]
    local targetBoxes = {}

    for i = 1, 10 do
        local tCard = makeCard(targetPage, 40)
        local numL = Instance.new("TextLabel", tCard)
        numL.Size = UDim2.new(0, 30, 1, 0)
        numL.BackgroundTransparency = 1
        numL.Font = Enum.Font.GothamBlack
        numL.Text = "#" .. i
        numL.TextColor3 = Color3.fromRGB(160, 120, 230)
        numL.TextSize = 12
        numL.ZIndex = 12

        local tb = Instance.new("TextBox", tCard)
        tb.Size = UDim2.new(1, -40, 0, 26)
        tb.Position = UDim2.new(0, 35, 0.5, -13)
        tb.BackgroundColor3 = Color3.fromRGB(15, 8, 28)
        tb.BorderSizePixel = 0
        tb.Font = Enum.Font.Gotham
        tb.Text = ""
        tb.PlaceholderText = "Enter target username..."
        tb.PlaceholderColor3 = Color3.fromRGB(100, 90, 130)
        tb.TextColor3 = Color3.fromRGB(255, 255, 255)
        tb.TextSize = 12
        tb.TextXAlignment = Enum.TextXAlignment.Left
        tb.ClearTextOnFocus = false
        tb.ZIndex = 12
        Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 6)
        local pad = Instance.new("UIPadding", tb)
        pad.PaddingLeft = UDim.new(0, 8)

        table.insert(targetBoxes, tb)
    end

    -- ================= INFO PAGE =================
    local infoPage = pages["info"]
    local infoCard = makeCard(infoPage, 220)
    local infoTxt = Instance.new("TextLabel", infoCard)
    infoTxt.Size = UDim2.new(1, -20, 1, -20)
    infoTxt.Position = UDim2.new(0, 10, 0, 10)
    infoTxt.BackgroundTransparency = 1
    infoTxt.Font = Enum.Font.Gotham
    infoTxt.Text = "SUPERMONKXSCRIPTS | ARHHAN V2\n\n👑 OWNER: SUPERMONKXSCRIPTS\n✅ VERIFIED BUILD\n\n• Press K to toggle GUI\n• Targets are paired automatically\n• Burst mode = 7 msgs then 5s rest\n• Custom prefix prepended to every msg\n\nMade with ❤️ by Monk"
    infoTxt.TextColor3 = Color3.fromRGB(200, 180, 255)
    infoTxt.TextSize = 13
    infoTxt.TextWrapped = true
    infoTxt.TextYAlignment = Enum.TextYAlignment.Top
    infoTxt.TextXAlignment = Enum.TextXAlignment.Left
    infoTxt.ZIndex = 12

    -- ================= SPAM LOGIC =================
    local isSpamming = false
    local sentCount, burstCount = 0, 0
    local tIdx = 1

    local patterns = {
        "(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)(!)",
        "o_O|o_O|o_O|o_O|o_O|o_O|o_O|o_O|",
        "- _ - _ - _ - _ - _ - _ - _ - _ - _ - _",
        "______________________________________",
        "--------------------------------------",
        "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",
    }
    local toxicMsg = "☄️ tmx MAI TOXIC KA MONKTAP KARKE BOL TOXIC PAPA OP✌ ☄️"
    local messages = {
        toxicMsg,
        "✨ tmx GODZILA POWER SONIC BEEM UNLEASHED 100% MAXIMUM DESTRUCTION OVERLOAD ✨",
        "☄️ tmx SUPER ULTRA BRAZIL TIGER GORILLA PUNCH COMING THROUGH WITH UNSTOPPABLE JUNGLE FURY RAGE ☄️",
        "✨☀️ tmx SUPER MEGA POWER WAVE TSUNAMI BLAST ACTIVATED ACROSS THE ENTIRE SERVER DIMENSION ✨☀️",
        " tmx ULTIMATE BEAST MODE ACTIVATED: GODZILA ROAR COMBINED WITH TIGER SPEED AND GORILLA SMASH ",
        "☀️☄️ tmx ULTIMATE SONIC BEEM DESTRUCTION RAY BURNING DOWN EVERYTHING IN SIGHT ☀️☄️",
        " tmx BRAZIL TIGER HYPER DRIFT KICK MEETS GORILLA EARTHQUAKE SMASH COMBO OF DOOM ",
        "✨ tmx MEGA POWER WAVE IS OVERWHELMING THE ENTIRE SERVER WITH TIDAL WAVE TSUNAMI ENERGY ✨",
        " tmx WARNING: GODZILA POWER IS COMPLETELY UNSTOPPABLE IN THE CHAT ROOM RIGHT NOW ",
        toxicMsg,
        " tmx GORILLA PUNCH EARTHQUAKE SHAKE CAUSING MASSIVE DAMAGE EVERYWHERE ",
        "✨ tmx SONIC BEEM CHARGING UP TO MAXIMUM OVERDRIVE POWER LEVEL INFINITE LIGHTNING SPEED ✨",
        "☀️ tmx BRAZIL TIGER JUNGLE FURY SAVAGE ATTACK SWEEPING AWAY ALL OPPONENTS IN THE ARENA ☀️",
        "☄️ tmx MEGA POWER WAVE WASHING AWAY EVERY SINGLE PLAYER WITH AN OCEANIC TSUNAMI STORM ☄️",
        "✨ tmx GODZILA ATOMIC BREATH READY TO FIRE ACROSS THE SKIES BRINGING TOTAL ANNIHILATION ✨",
        "☀️ tmx ULTRA SUPER SAIYAN GORILLA RAGE UNLEASHED WITH PRIMAL INSTINCT ☀️",
        " tmx SONIC BEEM SPEED OF LIGHT BEATDOWN LEAVING ONLY ELECTRIC SPARKS IN THE AIR ",
        "☄️ tmx BRAZIL TIGER CLAW SLASH OF DOOM CUTTING THROUGH DIMENSIONS WITH HYPER PRECISION ☄️",
        "✨ tmx SUPER MEGA POWER WAVE TSUNAMI STORM CRASHING INTO THE MAIN GATES WITH FORCE ✨",
        toxicMsg,
        " tmx GODZILA VS GORILLA ULTIMATE CLASH OF THE TITANS BATTLE OF THE CENTURY ",
        " tmx SONIC BEEM THUNDERSTORM STRIKE SHATTERING THE SOUND BARRIER ",
        "✨ tmx BRAZIL TIGER HYPER DRIFT KICK DRIFTING ACROSS THE MAP AT LIGHTNING SPEED ✨",
        "☀️☄️ tmx MEGA POWER WAVE MAXIMUM OVERDRIVE TIDAL WAVE ENERGY SURGE ACTIVATED ☀️☄️",
        " tmx ULTIMATE GODZILA TAIL WHIP DESTRUCTION LEVEL 9999 ACTIVATED IN THE SECTOR ",
        "✨ tmx GORILLA CHEST BEAT SOUNDWAVE BLAST ",
        "☄️ tmx BRAZIL TIGER POUNCE FROM THE CANOPY WITH UNSTOPPABLE PREDATOR INSTINCT ☄️",
        "✨ tmx SONIC BEEM HYPERSPACE LIGHTSPEED DASH LEAVING A TRAIL OF PURE ENERGY ✨",
        "☀️ tmx MEGA POWER WAVE SOLAR FLARE TSUNAMI SCORCHING THE ENTIRE BATTLEFIELD ☀️",
        " tmx GODZILA NUCLEAR PULSE DESTROYING EVERYTHING IN A 10 KILOMETER RADIUS ",
        "✨ tmx BRAZIL TIGER STEALTH AMBUSH FROM THE SHADOWS WITH DEADLY PRECISION ✨",
        "☄️ tmx GORILLA SEISMIC SLAM CREATING VOLCANIC ERUPTIONS EVERYWHERE ☄️",
        toxicMsg,
    }

    startBtn.MouseButton1Click:Connect(function()
        isSpamming = not isSpamming
        if isSpamming then
            sentCount, burstCount = 0, 0
            setStatus("RUNNING", Color3.fromRGB(74, 222, 128))
            startBtn.Text = "⏹ STOP SPAM"
            TweenService:Create(sBtnGrad, TweenInfo.new(0.2), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 80)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 100)),
                }
            }):Play()
        else
            setStatus("STOPPED", Color3.fromRGB(239, 68, 68))
            startBtn.Text = "▶ START SPAM"
            TweenService:Create(sBtnGrad, TweenInfo.new(0.2), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 150, 255)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 90, 240)),
                }
            }):Play()
        end
    end)

    task.spawn(function()
        while mainGui.Parent do
            if isSpamming then
                local customMsg = msgBox.Text or ""
                local customDelay = delayValue
                local tList = {}
                for _, box in ipairs(targetBoxes) do
                    local txt = string.match(box.Text or "", "^%s*(.-)%s*$")
                    if txt ~= "" then table.insert(tList, txt) end
                end
                local groups = {}
                for i = 1, #tList, 2 do
                    if tList[i + 1] then
                        table.insert(groups, "[" .. tList[i] .. "], [" .. tList[i + 1] .. "]")
                    else
                        table.insert(groups, "[" .. tList[i] .. "]")
                    end
                end
                for _, msg in ipairs(messages) do
                    if not isSpamming or not mainGui.Parent then break end
                    local target = ""
                    if #groups > 0 then
                        if tIdx > #groups then tIdx = 1 end
                        target = groups[tIdx]; tIdx = tIdx + 1
                    end
                    local pat = patterns[math.random(1, #patterns)]
                    local core = customMsg ~= "" and (customMsg .. " " .. msg) or msg
                    if target ~= "" then core = target .. " " .. core end
                    local final = pat .. "\n" .. core .. "\n" .. pat
                    if #final > 195 then
                        local allow = math.floor((190 - #core) / 2)
                        if allow > 2 then
                            local short = string.sub(pat, 1, allow)
                            final = short .. "\n" .. core .. "\n" .. short
                        else
                            final = string.sub(core, 1, 190)
                        end
                    end
                    local ev = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                    local tc = TextChatService.TextChannels:FindFirstChild("RBXGeneral")
                    if ev and ev:FindFirstChild("SayMessageRequest") then
                        ev.SayMessageRequest:FireServer(final, "All")
                    elseif tc then
                        tc:SendAsync(final)
                    end
                    sentCount = sentCount + 1
                    if burstOn then
                        burstCount = burstCount + 1
                        if burstCount >= 7 then
                            setStatus("COOLDOWN ⏳", Color3.fromRGB(250, 204, 21))
                            task.wait(5); burstCount = 0
                            if isSpamming then setStatus("RUNNING (BURST)", Color3.fromRGB(74, 222, 128)) end
                        else
                            task.wait(customDelay)
                        end
                    else
                        task.wait(customDelay)
                    end
                end
            else
                task.wait(0.5)
            end
        end
    end)

    -- ================= DRAG =================
    local dragStart, startPos
    header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            dragStart = i.Position
            startPos = window.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragStart and (i.UserInputType == Enum.UserInputType.MouseMovement
           or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + d.X,
                startPos.Y.Scale, startPos.Y.Offset + d.Y
            )
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
           or i.UserInputType == Enum.UserInputType.Touch then
            dragStart = nil
        end
    end)

    -- ================= CLOSE =================
    closeBtn.MouseButton1Click:Connect(function()
        isSpamming = false
        TweenService:Create(window, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        }):Play()
        TweenService:Create(dim, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        mainGui:Destroy()
    end)

    -- ================= BLACK HOLE ANIMATION =================
    local bhT = 0
    RunService.RenderStepped:Connect(function(dt)
        if not mainGui.Parent then return end
        bhT = bhT + dt
        bhHolder.Position = UDim2.new(0.75, -130 + math.sin(bhT * 0.8) * 20, 0.55, -130 + math.cos(bhT * 0.6) * 20)
        bhRing2.Rotation = bhT * 30
        bhGlow.ImageTransparency = 0.5 + math.sin(bhT * 2) * 0.1
        -- Header black hole
        hBH.Position = UDim2.new(0, 12, 0.5, -23 + math.sin(bhT * 3) * 2)
        hBHGlow.ImageTransparency = 0.3 + math.sin(bhT * 3) * 0.15
        tSt.Transparency = 0.2 + math.sin(bhT * 4) * 0.2
    end)

    -- ================= K TOGGLE =================
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.K then
            if mainGui.Parent then
                window.Visible = not window.Visible
                dim.Visible = window.Visible
            end
        end
    end)

    switchTab("main")
end

------------------------------------------------------------
-- CLICK → AURA MERGE → OPEN GUI
------------------------------------------------------------
local clicked = false
local clickConn
clickConn = UserInputService.InputBegan:Connect(function(input)
    if clicked or not loadingDone then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1
       and input.UserInputType ~= Enum.UserInputType.Touch then return end
    clicked = true
    if clickConn then clickConn:Disconnect() end

    local auraC = Instance.new("Frame")
    auraC.Size = UDim2.new(1, 0, 1, 0)
    auraC.BackgroundTransparency = 1
    auraC.ZIndex = 100
    auraC.Parent = loadingGui

    local function makeAura(color, startX)
        local a = Instance.new("Frame")
        a.Size = UDim2.new(0, 180, 0, 180)
        a.Position = UDim2.new(0, startX, 0.5, -90)
        a.BackgroundColor3 = color
        a.BorderSizePixel = 0
        a.ZIndex = 100
        a.Parent = auraC
        Instance.new("UICorner", a).CornerRadius = UDim.new(1, 0)
        local g = Instance.new("ImageLabel", a)
        g.Size = UDim2.new(2, 0, 2, 0)
        g.Position = UDim2.new(0.5, 0, 0.5, 0)
        g.AnchorPoint = Vector2.new(0.5, 0.5)
        g.BackgroundTransparency = 1
        g.Image = "rbxassetid://5028857084"
        g.ImageColor3 = color
        g.ImageTransparency = 0.35
        return a
    end

    local aura1 = makeAura(Color3.fromRGB(100, 150, 255), -220)
    local aura2 = makeAura(Color3.fromRGB(255, 100, 200), 1800)

    TweenService:Create(aura2, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -90, 0.5, -90)
    }):Play()
    TweenService:Create(aura1, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Position = UDim2.new(0.5, -90, 0.5, -90)
    }):Play()

    task.wait(0.85)

    local flash = Instance.new("Frame", loadingGui)
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    flash.BorderSizePixel = 0
    flash.ZIndex = 200
    TweenService:Create(flash, TweenInfo.new(0.7), {BackgroundTransparency = 1}):Play()

    for _, d in ipairs(bg:GetDescendants()) do
        if d:IsA("TextLabel") then
            TweenService:Create(d, TweenInfo.new(0.6), {TextTransparency = 1}):Play()
        elseif d:IsA("ImageLabel") then
            TweenService:Create(d, TweenInfo.new(0.6), {ImageTransparency = 1}):Play()
        elseif d:IsA("Frame") and d.BackgroundTransparency < 1 then
            TweenService:Create(d, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
        elseif d:IsA("UIStroke") then
            TweenService:Create(d, TweenInfo.new(0.6), {Transparency = 1}):Play()
        end
    end
    task.wait(0.7)
    loadingGui:Destroy()

    buildMainGui()
end)