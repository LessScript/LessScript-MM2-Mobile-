-- LessScript MM2 v0.1.2 - Mobile Only, No Mouse/Keyboard
-- Murder Mystery 2 Script with Key System
-- Key format: LSMM2-XXXXXX-X-XX
-- Improved: Role Detection, Silent Aim, Knife Aimbot, Throw ESP, Map ESP, Auto Collect Coins

if getgenv().LessScriptMM2Loaded then return end
getgenv().LessScriptMM2Loaded = true

-- ===== VALID KEYS =====
local ValidKeys = {
    "LSMM2-A1B2C3-D-EF", "LSMM2-X9Y8Z7-W-QR", "LSMM2-M4N3B2-V-ST", "LSMM2-Q2W3E4-R-UV",
    "LSMM2-L7K8J9-H-WX", "LSMM2-P0O9I8-U-YZ", "LSMM2-Z1X2C3-V-AB", "LSMM2-K9J8H7-G-CD",
    "LSMM2-W3E4R5-T-EF", "LSMM2-S8D9F0-G-HI", "LSMM2-R1T2Y3-U-JK", "LSMM2-F6G7H8-J-LM",
    "LSMM2-V5B6N7-M-NO", "LSMM2-D3E4R5-F-PQ", "LSMM2-U8I9O0-P-RS", "LSMM2-J4K5L6-M-TU",
    "LSMM2-C1X2Z3-A-VW", "LSMM2-G6H7J8-K-XY", "LSMM2-B5V6C7-X-ZA", "LSMM2-Q1W2E3-R-BC"
}

local EnteredKey = nil
local KeyValid = false

-- ===== KEY GUI =====
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "LessScriptMM2_KeyGui"
KeyGui.ResetOnSpawn = false
KeyGui.DisplayOrder = 999
KeyGui.IgnoreGuiInset = true

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 300, 0, 240)
KeyFrame.Position = UDim2.new(0.5, -150, 0.5, -120)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true
KeyFrame.Parent = KeyGui

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(255, 100, 0)
keyStroke.Thickness = 2.5
keyStroke.Parent = KeyFrame

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 0))
})
KeyGradient.Rotation = 45
KeyGradient.Parent = keyStroke

local KeyTitleBar = Instance.new("Frame")
KeyTitleBar.Size = UDim2.new(1, 0, 0, 36)
KeyTitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyTitleBar.BorderSizePixel = 0
KeyTitleBar.Parent = KeyFrame
Instance.new("UICorner", KeyTitleBar).CornerRadius = UDim.new(0, 12)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -40, 1, 0)
KeyTitle.Position = UDim2.new(0, 20, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "LessScript MM2 • Key System"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.TextSize = 14
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyTitleBar

local KeyCloseBtn = Instance.new("TextButton")
KeyCloseBtn.Size = UDim2.new(0, 24, 0, 24)
KeyCloseBtn.Position = UDim2.new(1, -28, 0, 6)
KeyCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
KeyCloseBtn.Text = "X"
KeyCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyCloseBtn.TextSize = 12
KeyCloseBtn.Font = Enum.Font.GothamBold
KeyCloseBtn.BorderSizePixel = 0
KeyCloseBtn.AutoButtonColor = false
KeyCloseBtn.Parent = KeyTitleBar
Instance.new("UICorner", KeyCloseBtn).CornerRadius = UDim.new(0, 5)
KeyCloseBtn.Activated:Connect(function() KeyFrame.Visible = false end)

local KeyInputFrame = Instance.new("Frame")
KeyInputFrame.Size = UDim2.new(1, -30, 0, 40)
KeyInputFrame.Position = UDim2.new(0, 15, 0, 55)
KeyInputFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyInputFrame.BorderSizePixel = 0
KeyInputFrame.Parent = KeyFrame
Instance.new("UICorner", KeyInputFrame).CornerRadius = UDim.new(0, 8)

local KeyInputStroke = Instance.new("UIStroke")
KeyInputStroke.Color = Color3.fromRGB(60, 60, 60)
KeyInputStroke.Thickness = 1.5
KeyInputStroke.Parent = KeyInputFrame

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -16, 1, 0)
KeyInput.Position = UDim2.new(0, 8, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.PlaceholderText = "LSMM2-XXXXXX-X-XX"
KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 16
KeyInput.Font = Enum.Font.GothamBold
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = KeyInputFrame

local KeyStatus = Instance.new("TextLabel")
KeyStatus.Size = UDim2.new(1, -30, 0, 20)
KeyStatus.Position = UDim2.new(0, 15, 0, 105)
KeyStatus.BackgroundTransparency = 1
KeyStatus.Text = "Enter your key to continue..."
KeyStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
KeyStatus.TextSize = 11
KeyStatus.Font = Enum.Font.Gotham
KeyStatus.TextXAlignment = Enum.TextXAlignment.Center
KeyStatus.Parent = KeyFrame

local KeyButtonsFrame = Instance.new("Frame")
KeyButtonsFrame.Size = UDim2.new(1, -30, 0, 36)
KeyButtonsFrame.Position = UDim2.new(0, 15, 0, 135)
KeyButtonsFrame.BackgroundTransparency = 1
KeyButtonsFrame.Parent = KeyFrame

local KeySubmitBtn = Instance.new("TextButton")
KeySubmitBtn.Size = UDim2.new(0.6, -4, 1, 0)
KeySubmitBtn.Position = UDim2.new(0, 0, 0, 0)
KeySubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
KeySubmitBtn.Text = "SUBMIT"
KeySubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeySubmitBtn.TextSize = 13
KeySubmitBtn.Font = Enum.Font.GothamBlack
KeySubmitBtn.BorderSizePixel = 0
KeySubmitBtn.AutoButtonColor = false
KeySubmitBtn.Parent = KeyButtonsFrame
Instance.new("UICorner", KeySubmitBtn).CornerRadius = UDim.new(0, 6)

local KeyPasteBtn = Instance.new("TextButton")
KeyPasteBtn.Size = UDim2.new(0.4, -4, 1, 0)
KeyPasteBtn.Position = UDim2.new(0.6, 4, 0, 0)
KeyPasteBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyPasteBtn.Text = "PASTE"
KeyPasteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyPasteBtn.TextSize = 12
KeyPasteBtn.Font = Enum.Font.GothamBold
KeyPasteBtn.BorderSizePixel = 0
KeyPasteBtn.AutoButtonColor = false
KeyPasteBtn.Parent = KeyButtonsFrame
Instance.new("UICorner", KeyPasteBtn).CornerRadius = UDim.new(0, 6)

local KeyInfo = Instance.new("TextLabel")
KeyInfo.Size = UDim2.new(1, -30, 0, 16)
KeyInfo.Position = UDim2.new(0, 15, 0, 185)
KeyInfo.BackgroundTransparency = 1
KeyInfo.Text = "Format: LSMM2-XXXXXX-X-XX"
KeyInfo.TextColor3 = Color3.fromRGB(140, 140, 140)
KeyInfo.TextSize = 10
KeyInfo.Font = Enum.Font.Gotham
KeyInfo.TextXAlignment = Enum.TextXAlignment.Center
KeyInfo.Parent = KeyFrame

local KeyInfo2 = Instance.new("TextLabel")
KeyInfo2.Size = UDim2.new(1, -30, 0, 16)
KeyInfo2.Position = UDim2.new(0, 15, 0, 203)
KeyInfo2.BackgroundTransparency = 1
KeyInfo2.Text = "Get keys: @LessScriptArsenal-Bot"
KeyInfo2.TextColor3 = Color3.fromRGB(255, 150, 50)
KeyInfo2.TextSize = 10
KeyInfo2.Font = Enum.Font.Gotham
KeyInfo2.TextXAlignment = Enum.TextXAlignment.Center
KeyInfo2.Parent = KeyFrame

local function ValidateKey(key)
    local trimmedKey = key:gsub("%s+", ""):upper()
    for _, validKey in pairs(ValidKeys) do
        if trimmedKey == validKey then return true end
    end
    return false
end

local function SubmitKey()
    local inputText = KeyInput.Text
    if ValidateKey(inputText) then
        KeyValid = true
        EnteredKey = inputText:gsub("%s+", ""):upper()
        KeyStatus.Text = "✓ Key accepted! Loading LessScript MM2..."
        KeyStatus.TextColor3 = Color3.fromRGB(0, 255, 100)
        KeyInputStroke.Color = Color3.fromRGB(0, 255, 100)
        wait(0.5)
        KeyGui:Destroy()
    else
        KeyStatus.Text = "✗ Invalid key! Try again..."
        KeyStatus.TextColor3 = Color3.fromRGB(255, 100, 0)
        KeyInputStroke.Color = Color3.fromRGB(255, 100, 0)
        KeyInput.Text = ""
        wait(1)
        KeyStatus.Text = "Enter your key to continue..."
        KeyStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
        KeyInputStroke.Color = Color3.fromRGB(60, 60, 60)
    end
end

KeySubmitBtn.Activated:Connect(SubmitKey)
KeyPasteBtn.Activated:Connect(function() KeyInput.Text = ""; KeyInput:CaptureFocus() end)
KeyInput.FocusLost:Connect(function() if KeyInput.Text ~= "" then SubmitKey() end end)

local function injectKeyGui(gui)
    local s = pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not s then
        local pg = game:GetService("Players").LocalPlayer
        if pg then
            local plrGui = pg:FindFirstChildOfClass("PlayerGui")
            if plrGui then gui.Parent = plrGui else pcall(function() gui.Parent = pg:WaitForChild("PlayerGui", 10) end) end
        end
    end
end
injectKeyGui(KeyGui)

repeat wait(0.1) until KeyValid

-- ===== MAIN SCRIPT =====
local LessScriptMM2 = {
    Version = "v0.1.2",
    UserKey = EnteredKey,
    Settings = {
        SheriffESP = {Enabled = false},
        MurdererESP = {Enabled = false},
        PlayerESP = {Enabled = false, Names = true, Distance = true, Health = true},
        Aimbot = {Enabled = false, FOV = 120, AimPart = "Head", ShowFOV = true, AutoFire = false},
        SilentAim = {Enabled = false, FOV = 120},
        KnifeAimbot = {Enabled = false, FOV = 60, AutoStab = false},
        GunESP = {Enabled = false},
        CoinESP = {Enabled = false},
        ThrowESP = {Enabled = false},
        MapESP = {Enabled = false},
        TeleportToSheriff = {Enabled = false},
        TeleportToMurderer = {Enabled = false},
        TeleportToGun = {Enabled = false},
        TeleportToCoin = {Enabled = false},
        Fly = {Enabled = false, Speed = 50},
        SpeedHack = {Enabled = false, Speed = 50},
        NoClip = {Enabled = false},
        InfiniteJump = {Enabled = false},
        SpinBot = {Enabled = false, Speed = 10},
        AntiAfk = {Enabled = false},
        Crosshair = {Enabled = false, Size = 20},
        ThirdPerson = {Enabled = false, Distance = 10},
        RevealRoles = {Enabled = false},
        AutoPickupGun = {Enabled = false},
        AutoCollectCoins = {Enabled = false, Range = 30},
        AutoShoot = {Enabled = false, Delay = 0.1},
        ChatSpy = {Enabled = false},
        NukeAll = {Enabled = false},
        GodMode = {Enabled = false}
    },
    Connections = {},
    ESPObjects = {},
    MapMarkers = {},
    FOVCircle = nil,
    KnifeFOVCircle = nil,
    CrosshairObj = nil,
    SheriffCache = nil,
    MurdererCache = nil
}

if not game:IsLoaded() then game.Loaded:Wait() end

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")

if not LocalPlayer then LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait() end
if not Camera then repeat Camera = Workspace.CurrentCamera wait() until Camera end

-- CLEAN OLD INSTANCES
for _, parent in pairs({
    pcall(function() return game:GetService("CoreGui") end) and game:GetService("CoreGui"),
    pcall(function() return LocalPlayer:FindFirstChildOfClass("PlayerGui") end) and LocalPlayer:FindFirstChildOfClass("PlayerGui")
}) do
    if parent then for _, obj in pairs(parent:GetChildren()) do
        if obj.Name:find("LessScriptMM2") then pcall(function() obj:Destroy() end) end
    end end
end

local function injectGui(gui)
    local s = pcall(function() gui.Parent = game:GetService("CoreGui") end)
    if not s then
        local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
        if pg then gui.Parent = pg else pcall(function() gui.Parent = LocalPlayer:WaitForChild("PlayerGui", 10) end) end
    end
end

-- ===== LOADING SCREEN =====
local Loader = Instance.new("ScreenGui"); Loader.Name = "LessScriptMM2_Loader"; Loader.ResetOnSpawn = false
local LoadFrame = Instance.new("Frame"); LoadFrame.Size = UDim2.new(0, 260, 0, 100); LoadFrame.Position = UDim2.new(0.5, -130, 0.5, -50); LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); LoadFrame.BorderSizePixel = 0; LoadFrame.Parent = Loader
Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 10)
local lds = Instance.new("UIStroke"); lds.Color = Color3.fromRGB(255, 100, 0); lds.Thickness = 2; lds.Parent = LoadFrame
local ldt = Instance.new("TextLabel"); ldt.Size = UDim2.new(1, -20, 0, 28); ldt.Position = UDim2.new(0, 10, 0, 12); ldt.BackgroundTransparency = 1; ldt.Text = "LessScript MM2 " .. LessScriptMM2.Version; ldt.TextColor3 = Color3.fromRGB(255, 255, 255); ldt.TextSize = 18; ldt.Font = Enum.Font.GothamBlack; ldt.Parent = LoadFrame
local ldst = Instance.new("TextLabel"); ldst.Size = UDim2.new(1, -20, 0, 16); ldst.Position = UDim2.new(0, 10, 0, 42); ldst.BackgroundTransparency = 1; ldst.Text = "Initializing..."; ldst.TextColor3 = Color3.fromRGB(180, 180, 180); ldst.TextSize = 11; ldst.Font = Enum.Font.Gotham; ldst.Parent = LoadFrame
local ldbg = Instance.new("Frame"); ldbg.Size = UDim2.new(1, -20, 0, 5); ldbg.Position = UDim2.new(0, 10, 0, 65); ldbg.BackgroundColor3 = Color3.fromRGB(40, 40, 40); ldbg.BorderSizePixel = 0; ldbg.Parent = LoadFrame; Instance.new("UICorner", ldbg).CornerRadius = UDim.new(1, 0)
local ldb = Instance.new("Frame"); ldb.Size = UDim2.new(0, 0, 1, 0); ldb.BackgroundColor3 = Color3.fromRGB(255, 100, 0); ldb.BorderSizePixel = 0; ldb.Parent = ldbg; Instance.new("UICorner", ldb).CornerRadius = UDim.new(1, 0)
injectGui(Loader)

spawn(function()
    for i = 1, 100 do
        ldb.Size = UDim2.new(i/100, 0, 1, 0)
        if i == 25 then ldst.Text = "Loading modules..."
        elseif i == 50 then ldst.Text = "Building interface..."
        elseif i == 75 then ldst.Text = "Almost ready..."
        elseif i == 95 then ldst.Text = "Complete!" end
        wait(0.01)
    end
    wait(0.3)
    LoadFrame:TweenPosition(UDim2.new(0.5, -130, -0.5, -50), "In", "Back", 0.4, true)
    wait(0.4)
    Loader:Destroy()
end)

wait(1.6)

-- ===== WATERMARK =====
local Watermark = Instance.new("ScreenGui"); Watermark.Name = "LessScriptMM2_Watermark"; Watermark.ResetOnSpawn = false; Watermark.DisplayOrder = 998

local WatermarkFrame = Instance.new("Frame")
WatermarkFrame.Name = "WatermarkFrame"
WatermarkFrame.Size = UDim2.new(0, 48, 0, 48)
WatermarkFrame.Position = UDim2.new(0, 15, 0, 15)
WatermarkFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
WatermarkFrame.BorderSizePixel = 0
WatermarkFrame.Active = true
WatermarkFrame.Draggable = true
WatermarkFrame.Parent = Watermark

local WatermarkCorner = Instance.new("UICorner")
WatermarkCorner.CornerRadius = UDim.new(0, 12)
WatermarkCorner.Parent = WatermarkFrame

local WatermarkStroke = Instance.new("UIStroke")
WatermarkStroke.Color = Color3.fromRGB(255, 100, 0)
WatermarkStroke.Thickness = 2
WatermarkStroke.Parent = WatermarkFrame

local WatermarkGradient = Instance.new("UIGradient")
WatermarkGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 160, 0))
})
WatermarkGradient.Rotation = 45
WatermarkGradient.Parent = WatermarkStroke

local WatermarkLabel = Instance.new("TextLabel")
WatermarkLabel.Size = UDim2.new(1, 0, 1, 0)
WatermarkLabel.BackgroundTransparency = 1
WatermarkLabel.Text = "LS"
WatermarkLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WatermarkLabel.TextSize = 22
WatermarkLabel.Font = Enum.Font.GothamBlack
WatermarkLabel.Parent = WatermarkFrame

local WatermarkVersion = Instance.new("TextLabel")
WatermarkVersion.Size = UDim2.new(1, 0, 0, 12)
WatermarkVersion.Position = UDim2.new(0, 0, 1, -12)
WatermarkVersion.BackgroundTransparency = 1
WatermarkVersion.Text = "v0.1.2"
WatermarkVersion.TextColor3 = Color3.fromRGB(200, 200, 200)
WatermarkVersion.TextSize = 8
WatermarkVersion.Font = Enum.Font.Gotham
WatermarkVersion.Parent = WatermarkFrame

injectGui(Watermark)

-- ===== MAIN GUI =====
local ScreenGui = Instance.new("ScreenGui"); ScreenGui.Name = "LessScriptMM2_Main"; ScreenGui.ResetOnSpawn = false; ScreenGui.DisplayOrder = 1000

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 420)
MainFrame.Position = UDim2.new(0, 10, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
local uis = Instance.new("UIStroke"); uis.Color = Color3.fromRGB(255, 100, 0); uis.Thickness = 1.5; uis.Parent = MainFrame

local ResizeHandle = Instance.new("Frame"); ResizeHandle.Size = UDim2.new(0, 18, 0, 18); ResizeHandle.Position = UDim2.new(1, -9, 1, -9); ResizeHandle.BackgroundColor3 = Color3.fromRGB(255, 100, 0); ResizeHandle.BorderSizePixel = 0; ResizeHandle.ZIndex = 10; ResizeHandle.Parent = MainFrame; Instance.new("UICorner", ResizeHandle).CornerRadius = UDim.new(0, 5)
local ResizeLabel = Instance.new("TextLabel"); ResizeLabel.Size = UDim2.new(1, 0, 1, 0); ResizeLabel.BackgroundTransparency = 1; ResizeLabel.Text = "o"; ResizeLabel.TextColor3 = Color3.fromRGB(255, 255, 255); ResizeLabel.TextSize = 10; ResizeLabel.Font = Enum.Font.GothamBold; ResizeLabel.Parent = ResizeHandle

local resizing = false; local startSize, startPos, startTouchPos
ResizeHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        resizing = true; startSize = MainFrame.AbsoluteSize; startPos = MainFrame.AbsolutePosition; startTouchPos = input.Position
    end
end)
UserInputService.TouchMoved:Connect(function(input)
    if resizing then
        local delta = input.Position - startTouchPos
        MainFrame.Size = UDim2.new(0, math.clamp(startSize.X + delta.X, 250, 500), 0, math.clamp(startSize.Y + delta.Y, 350, 700))
    end
end)
UserInputService.TouchEnded:Connect(function(input) resizing = false end)

local TitleBar = Instance.new("Frame"); TitleBar.Size = UDim2.new(1, 0, 0, 30); TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); TitleBar.BorderSizePixel = 0; TitleBar.Parent = MainFrame; Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)
local TitleText = Instance.new("TextLabel"); TitleText.Size = UDim2.new(1, -45, 1, 0); TitleText.Position = UDim2.new(0, 12, 0, 0); TitleText.BackgroundTransparency = 1; TitleText.Text = "LessScript MM2 " .. LessScriptMM2.Version; TitleText.TextColor3 = Color3.fromRGB(255, 255, 255); TitleText.TextSize = 13; TitleText.Font = Enum.Font.GothamBold; TitleText.TextXAlignment = Enum.TextXAlignment.Left; TitleText.Parent = TitleBar
local CloseButton = Instance.new("TextButton"); CloseButton.Size = UDim2.new(0, 24, 0, 24); CloseButton.Position = UDim2.new(1, -28, 0, 3); CloseButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0); CloseButton.Text = "X"; CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255); CloseButton.TextSize = 12; CloseButton.Font = Enum.Font.GothamBold; CloseButton.BorderSizePixel = 0; CloseButton.AutoButtonColor = false; CloseButton.Parent = TitleBar; Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 5)
CloseButton.Activated:Connect(function() MainFrame.Visible = false end)

local TabButtons = {}; local TabContents = {}
local TabRow = Instance.new("Frame"); TabRow.Size = UDim2.new(1, -8, 0, 26); TabRow.Position = UDim2.new(0, 4, 0, 34); TabRow.BackgroundColor3 = Color3.fromRGB(22, 22, 22); TabRow.BorderSizePixel = 0; TabRow.Parent = MainFrame; Instance.new("UICorner", TabRow).CornerRadius = UDim.new(0, 5)
local ContentArea = Instance.new("Frame"); ContentArea.Size = UDim2.new(1, -8, 1, -64); ContentArea.Position = UDim2.new(0, 4, 0, 64); ContentArea.BackgroundColor3 = Color3.fromRGB(20, 20, 20); ContentArea.BorderSizePixel = 0; ContentArea.ClipsDescendants = true; ContentArea.Parent = MainFrame

local tabNames = {"Info", "ESP", "Combat", "Move", "Misc"}
local tabIcons = {"[i]", "[o]", "[>]", "[>>]", "[*]"}

local function SwitchTab(tabName)
    for name, content in pairs(TabContents) do content.Visible = (name == tabName) end
    for name, button in pairs(TabButtons) do
        button.BackgroundColor3 = (name == tabName) and Color3.fromRGB(255, 100, 0) or Color3.fromRGB(30, 30, 30)
        button.TextColor3 = (name == tabName) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
    end
end

for i, tabName in ipairs(tabNames) do
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1/5, -2, 1, -2)
    tabBtn.Position = UDim2.new((i-1)*(1/5), 1, 0, 1)
    tabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabBtn.Text = tabIcons[i]
    tabBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    tabBtn.TextSize = 12
    tabBtn.Font = Enum.Font.Gotham
    tabBtn.BorderSizePixel = 0
    tabBtn.AutoButtonColor = false
    tabBtn.Parent = TabRow
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 4)
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -4, 1, -4)
    content.Position = UDim2.new(0, 2, 0, 2)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 2
    content.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
    content.CanvasSize = UDim2.new(0, 0, 4, 0)
    content.Visible = (i == 1)
    content.ScrollingEnabled = true
    content.ElasticBehavior = Enum.ElasticBehavior.Never
    content.Parent = ContentArea
    
    local list = Instance.new("UIListLayout"); list.Padding = UDim.new(0, 4); list.Parent = content
    
    TabButtons[tabName] = tabBtn; TabContents[tabName] = content
    tabBtn.Activated:Connect(function() SwitchTab(tabName) end)
end
if TabButtons["Info"] then TabButtons["Info"].BackgroundColor3 = Color3.fromRGB(255, 100, 0); TabButtons["Info"].TextColor3 = Color3.fromRGB(255, 255, 255) end

-- ===== INFO TAB =====
local infoContent = TabContents["Info"]

local infoTitle = Instance.new("TextLabel")
infoTitle.Size = UDim2.new(1, -8, 0, 36)
infoTitle.Position = UDim2.new(0, 4, 0, 10)
infoTitle.BackgroundTransparency = 1
infoTitle.Text = "LessScript MM2"
infoTitle.TextColor3 = Color3.fromRGB(255, 100, 0)
infoTitle.TextSize = 26
infoTitle.Font = Enum.Font.GothamBlack
infoTitle.TextXAlignment = Enum.TextXAlignment.Center
infoTitle.Parent = infoContent

local infoLines = {
    "Telegram bot: @LessScriptArsenal-Bot",
    "Version: " .. LessScriptMM2.Version,
    "Murder Mystery 2 Script",
    "Key: " .. (LessScriptMM2.UserKey or "N/A")
}

for i, line in ipairs(infoLines) do
    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(1, -8, 0, 22)
    infoLabel.Position = UDim2.new(0, 4, 0, 55 + (i - 1) * 26)
    infoLabel.BackgroundTransparency = 1
    infoLabel.Text = line
    infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    infoLabel.TextSize = 12
    infoLabel.Font = Enum.Font.Gotham
    infoLabel.TextXAlignment = Enum.TextXAlignment.Center
    infoLabel.Parent = infoContent
end

local separator = Instance.new("Frame")
separator.Size = UDim2.new(0.8, 0, 0, 1)
separator.Position = UDim2.new(0.1, 0, 0, 160)
separator.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
separator.BorderSizePixel = 0
separator.Parent = infoContent

local featuresLabels = {
    "Features: Sheriff/Murderer ESP,",
    "Gun/Coin/Throw ESP, Map ESP,",
    "Silent Aim, Knife Aimbot,",
    "Auto Collect Coins, Auto Pickup Gun,",
    "Nuke All, God Mode, Teleports,",
    "and many more..."
}

for i, text in ipairs(featuresLabels) do
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -8, 0, 18)
    lbl.Position = UDim2.new(0, 4, 0, 170 + (i - 1) * 17)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = i == #featuresLabels and Color3.fromRGB(255, 150, 50) or Color3.fromRGB(180, 180, 180)
    lbl.TextSize = 10
    lbl.Font = i == #featuresLabels and Enum.Font.GothamBold or Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Center
    lbl.Parent = infoContent
end

-- Helpers
local function CreateSection(parent, name)
    local sec = Instance.new("Frame"); sec.Size = UDim2.new(1, -4, 0, 22); sec.BackgroundColor3 = Color3.fromRGB(28, 28, 28); sec.BorderSizePixel = 0; sec.Parent = parent; Instance.new("UICorner", sec).CornerRadius = UDim.new(0, 4)
    local line = Instance.new("Frame"); line.Size = UDim2.new(0, 2, 1, -6); line.Position = UDim2.new(0, 5, 0, 3); line.BackgroundColor3 = Color3.fromRGB(255, 100, 0); line.BorderSizePixel = 0; line.Parent = sec; Instance.new("UICorner", line).CornerRadius = UDim.new(1, 0)
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, -14, 1, 0); lbl.Position = UDim2.new(0, 10, 0, 0); lbl.BackgroundTransparency = 1; lbl.Text = name; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 10; lbl.Font = Enum.Font.GothamBold; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = sec
end

local function CreateToggle(parent, settings, name, callback)
    local frm = Instance.new("Frame"); frm.Size = UDim2.new(1, -4, 0, 28); frm.BackgroundColor3 = Color3.fromRGB(24, 24, 24); frm.BorderSizePixel = 0; frm.Parent = parent; Instance.new("UICorner", frm).CornerRadius = UDim.new(0, 4)
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(0.55, 0, 1, 0); lbl.Position = UDim2.new(0, 8, 0, 0); lbl.BackgroundTransparency = 1; lbl.Text = name; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 10; lbl.Font = Enum.Font.Gotham; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = frm
    local bg = Instance.new("Frame"); bg.Size = UDim2.new(0, 28, 0, 15); bg.Position = UDim2.new(1, -34, 0.5, -7); bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50); bg.BorderSizePixel = 0; bg.Parent = frm; Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)
    local dot = Instance.new("Frame"); dot.Size = UDim2.new(0, 11, 0, 11); dot.Position = UDim2.new(0, 2, 0.5, -5); dot.BackgroundColor3 = Color3.fromRGB(200, 200, 200); dot.BorderSizePixel = 0; dot.Parent = bg; Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
    local enabled = settings.Enabled or false
    local function update()
        if enabled then bg.BackgroundColor3 = Color3.fromRGB(255, 100, 0); TweenService:Create(dot, TweenInfo.new(0.12), {Position = UDim2.new(0, 15, 0.5, -5)}):Play()
        else bg.BackgroundColor3 = Color3.fromRGB(50, 50, 50); TweenService:Create(dot, TweenInfo.new(0.12), {Position = UDim2.new(0, 2, 0.5, -5)}):Play() end
    end
    update()
    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            enabled = not enabled; settings.Enabled = enabled; update(); if callback then callback(enabled) end
        end
    end)
    dot.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            enabled = not enabled; settings.Enabled = enabled; update(); if callback then callback(enabled) end
        end
    end)
end

local function CreateSlider(parent, settings, name, min, max, default, callback)
    settings.Value = default
    local frm = Instance.new("Frame"); frm.Size = UDim2.new(1, -4, 0, 44); frm.BackgroundColor3 = Color3.fromRGB(24, 24, 24); frm.BorderSizePixel = 0; frm.Parent = parent; Instance.new("UICorner", frm).CornerRadius = UDim.new(0, 4)
    local lbl = Instance.new("TextLabel"); lbl.Size = UDim2.new(1, -12, 0, 16); lbl.Position = UDim2.new(0, 6, 0, 2); lbl.BackgroundTransparency = 1; lbl.Text = name .. ": " .. default; lbl.TextColor3 = Color3.fromRGB(255, 255, 255); lbl.TextSize = 10; lbl.Font = Enum.Font.Gotham; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = frm
    local sbg = Instance.new("Frame"); sbg.Size = UDim2.new(1, -12, 0, 5); sbg.Position = UDim2.new(0, 6, 0, 24); sbg.BackgroundColor3 = Color3.fromRGB(50, 50, 50); sbg.BorderSizePixel = 0; sbg.Parent = frm; Instance.new("UICorner", sbg).CornerRadius = UDim.new(1, 0)
    local fill = Instance.new("Frame"); fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0); fill.BackgroundColor3 = Color3.fromRGB(255, 100, 0); fill.BorderSizePixel = 0; fill.Parent = sbg; Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local dragging = false
    local function updateSlider(input)
        local px = input.Position.X; local sp = sbg.AbsolutePosition; local ss = sbg.AbsoluteSize
        local rx = math.clamp(px - sp.X, 0, ss.X); local pct = rx / ss.X; local val = math.floor(min + (max-min)*pct)
        settings.Value = val; fill.Size = UDim2.new(pct, 0, 1, 0); lbl.Text = name .. ": " .. val
        if callback then callback(val) end
    end
    sbg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then dragging = true; updateSlider(input) end
    end)
    sbg.InputEnded:Connect(function() dragging = false end)
    UserInputService.TouchMoved:Connect(function(input)
        if dragging then updateSlider(input) end
    end)
end

-- Drawing functions
local function CreateFOVCircle()
    if LessScriptMM2.FOVCircle then LessScriptMM2.FOVCircle:Remove() end
    local c = Drawing.new("Circle")
    c.Visible = LessScriptMM2.Settings.Aimbot.ShowFOV
    c.Radius = LessScriptMM2.Settings.Aimbot.FOV
    c.Color = Color3.fromRGB(255, 100, 0)
    c.Thickness = 1.5
    c.Transparency = 0.7
    c.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    LessScriptMM2.FOVCircle = c
    if LessScriptMM2.Connections.FOVUpd then LessScriptMM2.Connections.FOVUpd:Disconnect() end
    LessScriptMM2.Connections.FOVUpd = RunService.RenderStepped:Connect(function()
        if LessScriptMM2.FOVCircle then
            LessScriptMM2.FOVCircle.Visible = LessScriptMM2.Settings.Aimbot.ShowFOV
            LessScriptMM2.FOVCircle.Radius = LessScriptMM2.Settings.Aimbot.FOV
            LessScriptMM2.FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        end
    end)
end
local function RemoveFOVCircle()
    if LessScriptMM2.FOVCircle then LessScriptMM2.FOVCircle:Remove(); LessScriptMM2.FOVCircle = nil end
    if LessScriptMM2.Connections.FOVUpd then LessScriptMM2.Connections.FOVUpd:Disconnect() end
end

local function CreateKnifeFOVCircle()
    if LessScriptMM2.KnifeFOVCircle then LessScriptMM2.KnifeFOVCircle:Remove() end
    local c = Drawing.new("Circle")
    c.Visible = true
    c.Radius = LessScriptMM2.Settings.KnifeAimbot.FOV
    c.Color = Color3.fromRGB(255, 0, 0)
    c.Thickness = 1.5
    c.Transparency = 0.5
    c.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    LessScriptMM2.KnifeFOVCircle = c
    if LessScriptMM2.Connections.KFOVUpd then LessScriptMM2.Connections.KFOVUpd:Disconnect() end
    LessScriptMM2.Connections.KFOVUpd = RunService.RenderStepped:Connect(function()
        if LessScriptMM2.KnifeFOVCircle then
            LessScriptMM2.KnifeFOVCircle.Radius = LessScriptMM2.Settings.KnifeAimbot.FOV
            LessScriptMM2.KnifeFOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        end
    end)
end
local function RemoveKnifeFOVCircle()
    if LessScriptMM2.KnifeFOVCircle then LessScriptMM2.KnifeFOVCircle:Remove(); LessScriptMM2.KnifeFOVCircle = nil end
    if LessScriptMM2.Connections.KFOVUpd then LessScriptMM2.Connections.KFOVUpd:Disconnect() end
end

local function CreateCrosshair()
    if LessScriptMM2.CrosshairObj then for _, o in pairs(LessScriptMM2.CrosshairObj) do o:Remove() end end
    local s = LessScriptMM2.Settings.Crosshair.Size
    local c = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local h = Drawing.new("Line"); h.Visible = true; h.From = Vector2.new(c.X - s, c.Y); h.To = Vector2.new(c.X + s, c.Y); h.Color = Color3.fromRGB(255, 100, 0); h.Thickness = 1.5
    local v = Drawing.new("Line"); v.Visible = true; v.From = Vector2.new(c.X, c.Y - s); v.To = Vector2.new(c.X, c.Y + s); v.Color = Color3.fromRGB(255, 100, 0); v.Thickness = 1.5
    LessScriptMM2.CrosshairObj = {h, v}
    if LessScriptMM2.Connections.ChUpd then LessScriptMM2.Connections.ChUpd:Disconnect() end
    LessScriptMM2.Connections.ChUpd = RunService.RenderStepped:Connect(function()
        if LessScriptMM2.Settings.Crosshair.Enabled and LessScriptMM2.CrosshairObj then
            local nc = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            local sz = LessScriptMM2.Settings.Crosshair.Size
            LessScriptMM2.CrosshairObj[1].From = Vector2.new(nc.X - sz, nc.Y); LessScriptMM2.CrosshairObj[1].To = Vector2.new(nc.X + sz, nc.Y)
            LessScriptMM2.CrosshairObj[2].From = Vector2.new(nc.X, nc.Y - sz); LessScriptMM2.CrosshairObj[2].To = Vector2.new(nc.X, nc.Y + sz)
        end
    end)
end
local function RemoveCrosshair()
    if LessScriptMM2.CrosshairObj then for _, o in pairs(LessScriptMM2.CrosshairObj) do o:Remove() end; LessScriptMM2.CrosshairObj = nil end
    if LessScriptMM2.Connections.ChUpd then LessScriptMM2.Connections.ChUpd:Disconnect() end
end

-- Role Detection (IMPROVED)
local function FindSheriff()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            -- Check for name tags
            local head = char:FindFirstChild("Head")
            if head then
                local billboard = head:FindFirstChildOfClass("BillboardGui")
                if billboard then
                    for _, child in pairs(billboard:GetDescendants()) do
                        if child:IsA("TextLabel") and (child.Text:lower():find("sheriff") or child.Text:lower():find("шериф")) then
                            return plr
                        end
                    end
                end
            end
            -- Check for gun in character
            for _, child in pairs(char:GetChildren()) do
                if child:IsA("Tool") then
                    local name = child.Name:lower()
                    if name:find("gun") or name:find("revolver") or name:find("pistol") or name:find("deagle") then
                        return plr
                    end
                end
            end
        end
    end
    -- Check backpacks
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Backpack then
            for _, tool in pairs(plr.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = tool.Name:lower()
                    if name:find("gun") or name:find("revolver") or name:find("pistol") then
                        return plr
                    end
                end
            end
        end
    end
    return nil
end

local function FindMurderer()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local char = plr.Character
            -- Check for name tags
            local head = char:FindFirstChild("Head")
            if head then
                local billboard = head:FindFirstChildOfClass("BillboardGui")
                if billboard then
                    for _, child in pairs(billboard:GetDescendants()) do
                        if child:IsA("TextLabel") and (child.Text:lower():find("murder") or child.Text:lower():find("убийца")) then
                            return plr
                        end
                    end
                end
            end
            -- Check for knife
            for _, child in pairs(char:GetChildren()) do
                if child:IsA("Tool") then
                    local name = child.Name:lower()
                    if name:find("knife") or name:find("blade") or name:find("dagger") or name:find("stab") then
                        return plr
                    end
                end
            end
        end
    end
    -- Check backpacks
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Backpack then
            for _, tool in pairs(plr.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    local name = tool.Name:lower()
                    if name:find("knife") or name:find("blade") or name:find("dagger") then
                        return plr
                    end
                end
            end
        end
    end
    return nil
end

local function GetSheriff() return FindSheriff() end
local function GetMurderer() return FindMurderer() end

-- ESP Functions
local function HighlightRole(player, color)
    if player and player.Character then
        local char = player.Character
        local existing = char:FindFirstChild("LessScriptMM2_RoleHL")
        if existing then existing:Destroy() end
        local hl = Instance.new("Highlight")
        hl.Name = "LessScriptMM2_RoleHL"
        hl.FillColor = color
        hl.FillTransparency = 0.3
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        hl.OutlineTransparency = 0
        hl.Parent = char
        table.insert(LessScriptMM2.ESPObjects, hl)
    end
end

local function CreateRoleESP()
    for _, obj in pairs(LessScriptMM2.ESPObjects) do
        if typeof(obj) == "Instance" and obj.Name == "LessScriptMM2_RoleHL" then
            pcall(function() obj:Destroy() end)
        end
    end
    
    if LessScriptMM2.Settings.SheriffESP.Enabled then
        local sheriff = GetSheriff()
        if sheriff then
            HighlightRole(sheriff, Color3.fromRGB(0, 100, 255))
            LessScriptMM2.SheriffCache = sheriff
        end
    end
    
    if LessScriptMM2.Settings.MurdererESP.Enabled then
        local murderer = GetMurderer()
        if murderer then
            HighlightRole(murderer, Color3.fromRGB(255, 0, 0))
            LessScriptMM2.MurdererCache = murderer
        end
    end
end

-- Map ESP
local function CreateMapESP()
    for _, marker in pairs(LessScriptMM2.MapMarkers) do
        pcall(function() marker:Remove() end)
    end
    LessScriptMM2.MapMarkers = {}
    
    if not LessScriptMM2.Settings.MapESP.Enabled then return end
    
    local mapCenter = Vector2.new(Camera.ViewportSize.X - 120, 100)
    
    local function addDot(position, color, label)
        local dot = Drawing.new("Circle")
        dot.Position = position
        dot.Radius = 4
        dot.Color = color
        dot.Filled = true
        dot.Transparency = 0.8
        table.insert(LessScriptMM2.MapMarkers, dot)
    end
    
    -- Draw map background
    local mapBg = Drawing.new("Square")
    mapBg.Position = mapCenter - Vector2.new(80, 80)
    mapBg.Size = Vector2.new(160, 160)
    mapBg.Color = Color3.fromRGB(0, 0, 0)
    mapBg.Thickness = 2
    mapBg.Filled = true
    mapBg.Transparency = 0.5
    table.insert(LessScriptMM2.MapMarkers, mapBg)
    
    -- Draw dots for players
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local rootPos = plr.Character.HumanoidRootPart.Position
            local myPos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Position or Vector3.new(0,0,0)
            local relative = rootPos - myPos
            local dotX = math.clamp(relative.X / 2, -75, 75)
            local dotZ = math.clamp(relative.Z / 2, -75, 75)
            
            local color = Color3.fromRGB(255, 255, 255)
            local sheriff = GetSheriff()
            local murderer = GetMurderer()
            if plr == sheriff then color = Color3.fromRGB(0, 100, 255)
            elseif plr == murderer then color = Color3.fromRGB(255, 0, 0) end
            
            addDot(mapCenter + Vector2.new(dotX, dotZ), color, plr.Name)
        end
    end
end

-- Combat functions
local function GetClosestEnemyInFOV(fov)
    local best, bestDist = nil, fov or 9999
    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            local hum = player.Character:FindFirstChild("Humanoid")
            if head and hum and hum.Health > 0 then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if dist < bestDist then bestDist = dist; best = player end
                end
            end
        end
    end
    return best
end

local function GetClosestMurdererInFOV(fov)
    local murderer = GetMurderer()
    if not murderer or not murderer.Character then return nil end
    local head = murderer.Character:FindFirstChild("Head")
    if not head then return nil end
    local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
    if onScreen then
        local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
        local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
        if dist < (fov or 9999) then return murderer end
    end
    return nil
end

local function FireWeapon()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton1(Vector2.new())
    end)
end

-- ===== BUILD CONTENT =====

-- ESP Tab
CreateSection(TabContents["ESP"], "Role ESP")
CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.SheriffESP, "Sheriff ESP (Blue)", function(on)
    CreateRoleESP()
end)
CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.MurdererESP, "Murderer ESP (Red)", function(on)
    CreateRoleESP()
end)
CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.RevealRoles, "Auto Refresh Roles", function(on)
    if on then
        if LessScriptMM2.Connections.Roles then LessScriptMM2.Connections.Roles:Disconnect() end
        LessScriptMM2.Connections.Roles = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.RevealRoles.Enabled then return end
            CreateRoleESP()
        end)
    else
        if LessScriptMM2.Connections.Roles then LessScriptMM2.Connections.Roles:Disconnect() end
    end
end)

CreateSection(TabContents["ESP"], "Item ESP")
CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.GunESP, "Gun ESP (Yellow)", function(on)
    if on then
        if LessScriptMM2.Connections.GunESP then LessScriptMM2.Connections.GunESP:Disconnect() end
        LessScriptMM2.Connections.GunESP = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.GunESP.Enabled then return end
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Tool") then
                    local name = obj.Name:lower()
                    if (name:find("gun") or name:find("revolver") or name:find("pistol") or name:find("deagle")) and not obj.Parent:IsA("Model") then
                        if not obj:FindFirstChild("LessScriptMM2_Highlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "LessScriptMM2_Highlight"
                            hl.FillColor = Color3.fromRGB(255, 255, 0)
                            hl.FillTransparency = 0.5
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.OutlineTransparency = 0.3
                            hl.Parent = obj
                            table.insert(LessScriptMM2.ESPObjects, hl)
                        end
                    end
                end
            end
        end)
    else
        if LessScriptMM2.Connections.GunESP then LessScriptMM2.Connections.GunESP:Disconnect() end
    end
end)

CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.CoinESP, "Coin ESP (Gold)", function(on)
    if on then
        if LessScriptMM2.Connections.CoinESP then LessScriptMM2.Connections.CoinESP:Disconnect() end
        LessScriptMM2.Connections.CoinESP = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.CoinESP.Enabled then return end
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local name = obj.Name:lower()
                    if name:find("coin") or name:find("crystal") or name:find("gem") or name:find("collect") or name:find("token") then
                        if not obj:FindFirstChild("LessScriptMM2_Highlight") then
                            local hl = Instance.new("Highlight")
                            hl.Name = "LessScriptMM2_Highlight"
                            hl.FillColor = Color3.fromRGB(255, 200, 0)
                            hl.FillTransparency = 0.5
                            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                            hl.OutlineTransparency = 0.3
                            hl.Parent = obj
                            table.insert(LessScriptMM2.ESPObjects, hl)
                        end
                    end
                end
            end
        end)
    else
        if LessScriptMM2.Connections.CoinESP then LessScriptMM2.Connections.CoinESP:Disconnect() end
    end
end)

CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.ThrowESP, "Throw ESP (Knife)", function(on)
    if on then
        if LessScriptMM2.Connections.ThrowESP then LessScriptMM2.Connections.ThrowESP:Disconnect() end
        LessScriptMM2.Connections.ThrowESP = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.ThrowESP.Enabled then return end
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Tool") and not obj.Parent:IsA("Model") then
                    local name = obj.Name:lower()
                    if name:find("throw") or name:find("knife") or name:find("blade") then
                        if obj.Velocity.Magnitude > 5 then
                            if not obj:FindFirstChild("LessScriptMM2_Highlight") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "LessScriptMM2_Highlight"
                                hl.FillColor = Color3.fromRGB(255, 0, 0)
                                hl.FillTransparency = 0.5
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.OutlineTransparency = 0
                                hl.Parent = obj
                                table.insert(LessScriptMM2.ESPObjects, hl)
                            end
                        end
                    end
                end
            end
        end)
    else
        if LessScriptMM2.Connections.ThrowESP then LessScriptMM2.Connections.ThrowESP:Disconnect() end
    end
end)

CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.MapESP, "Map ESP", function(on)
    if on then
        if LessScriptMM2.Connections.MapESP then LessScriptMM2.Connections.MapESP:Disconnect() end
        LessScriptMM2.Connections.MapESP = RunService.RenderStepped:Connect(function()
            CreateMapESP()
        end)
    else
        if LessScriptMM2.Connections.MapESP then LessScriptMM2.Connections.MapESP:Disconnect() end
        for _, marker in pairs(LessScriptMM2.MapMarkers) do
            pcall(function() marker:Remove() end)
        end
        LessScriptMM2.MapMarkers = {}
    end
end)

CreateSection(TabContents["ESP"], "Player ESP")
CreateToggle(TabContents["ESP"], LessScriptMM2.Settings.PlayerESP, "Player ESP", function(on)
    if on then
        for _, obj in pairs(LessScriptMM2.ESPObjects) do
            if typeof(obj) == "Instance" and obj:IsA("BillboardGui") then obj:Destroy() end
        end
        local function addESP(player)
            if player == LocalPlayer then return end
            local function createESP()
                local char = player.Character
                if not char then return end
                local bb = Instance.new("BillboardGui"); bb.Name = "LessScriptMM2_ESP"; bb.Size = UDim2.new(0, 120, 0, 50); bb.StudsOffset = Vector3.new(0, 3, 0)
                bb.AlwaysOnTop = true; bb.Parent = char; table.insert(LessScriptMM2.ESPObjects, bb)
                if LessScriptMM2.Settings.PlayerESP.Names then
                    local nl = Instance.new("TextLabel"); nl.Size = UDim2.new(1, 0, 0, 14); nl.BackgroundTransparency = 1
                    nl.Text = player.Name; nl.TextColor3 = Color3.fromRGB(255, 255, 255); nl.TextSize = 10; nl.Font = Enum.Font.GothamBold; nl.Parent = bb
                end
                if LessScriptMM2.Settings.PlayerESP.Health and char:FindFirstChild("Humanoid") then
                    local hll = Instance.new("TextLabel"); hll.Size = UDim2.new(1, 0, 0, 14); hll.Position = UDim2.new(0, 0, 0, 16); hll.BackgroundTransparency = 1
                    hll.Text = "HP: " .. math.floor(char.Humanoid.Health); hll.TextColor3 = Color3.fromRGB(255, 100, 100); hll.TextSize = 10; hll.Font = Enum.Font.Gotham; hll.Parent = bb
                    table.insert(LessScriptMM2.ESPObjects, char.Humanoid.HealthChanged:Connect(function(hp) hll.Text = "HP: " .. math.floor(hp) end))
                end
                if LessScriptMM2.Settings.PlayerESP.Distance then
                    local dl = Instance.new("TextLabel"); dl.Size = UDim2.new(1, 0, 0, 14); dl.Position = UDim2.new(0, 0, 0, 30); dl.BackgroundTransparency = 1
                    dl.Text = "0m"; dl.TextColor3 = Color3.fromRGB(200, 200, 200); dl.TextSize = 10; dl.Font = Enum.Font.Gotham; dl.Parent = bb
                    table.insert(LessScriptMM2.ESPObjects, RunService.RenderStepped:Connect(function()
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("HumanoidRootPart") then
                            local dist = (LocalPlayer.Character.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                            dl.Text = math.floor(dist) .. "m"
                        end
                    end))
                end
            end
            if player.Character then createESP() end
            player.CharacterAdded:Connect(function() if LessScriptMM2.Settings.PlayerESP.Enabled then wait(0.3); createESP() end end)
        end
        for _, p in pairs(Players:GetPlayers()) do addESP(p) end
        Players.PlayerAdded:Connect(function(player) wait(0.5); addESP(player) end)
    else
        for _, obj in pairs(LessScriptMM2.ESPObjects) do
            if typeof(obj) == "Instance" and obj:IsA("BillboardGui") then obj:Destroy() end
        end
    end
end)

-- Combat Tab
CreateSection(TabContents["Combat"], "Gun Aimbot")
CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.Aimbot, "Aimbot", function(on)
    if on then
        CreateFOVCircle()
        if LessScriptMM2.Connections.Aim then LessScriptMM2.Connections.Aim:Disconnect() end
        LessScriptMM2.Connections.Aim = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.Aimbot.Enabled then return end
            local target = GetClosestEnemyInFOV(LessScriptMM2.Settings.Aimbot.FOV)
            if target and target.Character then
                local aimPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
                if aimPart then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPart.Position)
                    if LessScriptMM2.Settings.Aimbot.AutoFire then
                        FireWeapon()
                    end
                end
            end
        end)
    else
        RemoveFOVCircle()
        if LessScriptMM2.Connections.Aim then LessScriptMM2.Connections.Aim:Disconnect() end
    end
end)
CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.Aimbot, "AutoFire", function(on)
    LessScriptMM2.Settings.Aimbot.AutoFire = on
end)
CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.Aimbot, "Show FOV Circle", function(on)
    LessScriptMM2.Settings.Aimbot.ShowFOV = on
    if LessScriptMM2.FOVCircle then LessScriptMM2.FOVCircle.Visible = on end
    if on and LessScriptMM2.Settings.Aimbot.Enabled and not LessScriptMM2.FOVCircle then CreateFOVCircle() end
end)
CreateSlider(TabContents["Combat"], LessScriptMM2.Settings.Aimbot, "FOV", 40, 400, 120, function(v) LessScriptMM2.Settings.Aimbot.FOV = v end)

CreateSection(TabContents["Combat"], "Silent Aim")
CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.SilentAim, "Silent Aim", function(on)
    if on then
        local mt = getrawmetatable(game)
        if mt then
            setreadonly(mt, false)
            local oldNamecall = mt.__namecall
            mt.__namecall = newcclosure(function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                if method == "FireServer" and LessScriptMM2.Settings.SilentAim.Enabled then
                    local target = GetClosestEnemyInFOV(LessScriptMM2.Settings.SilentAim.FOV)
                    if target and target.Character then
                        local aimPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("HumanoidRootPart")
                        if aimPart then
                            for i, arg in pairs(args) do
                                if typeof(arg) == "Vector3" then
                                    args[i] = aimPart.Position
                                    return oldNamecall(self, unpack(args))
                                end
                            end
                        end
                    end
                end
                return oldNamecall(self, ...)
            end)
            setreadonly(mt, true)
        end
    end
end)
CreateSlider(TabContents["Combat"], LessScriptMM2.Settings.SilentAim, "Silent FOV", 40, 400, 120, function(v) LessScriptMM2.Settings.SilentAim.FOV = v end)

CreateSection(TabContents["Combat"], "Knife Aimbot")
CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.KnifeAimbot, "Knife Aimbot", function(on)
    if on then
        CreateKnifeFOVCircle()
        if LessScriptMM2.Connections.KnifeAim then LessScriptMM2.Connections.KnifeAim:Disconnect() end
        LessScriptMM2.Connections.KnifeAim = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.KnifeAimbot.Enabled then return end
            local target = GetClosestMurdererInFOV(LessScriptMM2.Settings.KnifeAimbot.FOV)
            if target and target.Character then
                local aimPart = target.Character:FindFirstChild("HumanoidRootPart") or target.Character:FindFirstChild("Head")
                if aimPart then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, aimPart.Position)
                    if LessScriptMM2.Settings.KnifeAimbot.AutoStab then
                        FireWeapon()
                    end
                end
            end
        end)
    else
        RemoveKnifeFOVCircle()
        if LessScriptMM2.Connections.KnifeAim then LessScriptMM2.Connections.KnifeAim:Disconnect() end
    end
end)
CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.KnifeAimbot, "Auto Stab", function(on)
    LessScriptMM2.Settings.KnifeAimbot.AutoStab = on
end)
CreateSlider(TabContents["Combat"], LessScriptMM2.Settings.KnifeAimbot, "Knife FOV", 20, 200, 60, function(v) LessScriptMM2.Settings.KnifeAimbot.FOV = v end)

CreateToggle(TabContents["Combat"], LessScriptMM2.Settings.AutoShoot, "Auto Shoot", function(on)
    if on then
        if LessScriptMM2.Connections.AutoShoot then LessScriptMM2.Connections.AutoShoot:Disconnect() end
        LessScriptMM2.Connections.AutoShoot = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.AutoShoot.Enabled then return end
            local target = GetClosestEnemyInFOV(80)
            if target then FireWeapon(); task.wait(LessScriptMM2.Settings.AutoShoot.Delay) end
        end)
    else
        if LessScriptMM2.Connections.AutoShoot then LessScriptMM2.Connections.AutoShoot:Disconnect() end
    end
end)
CreateSlider(TabContents["Combat"], LessScriptMM2.Settings.AutoShoot, "Shoot Delay", 0.05, 0.5, 0.1, function(v) LessScriptMM2.Settings.AutoShoot.Delay = v end)

-- Movement Tab
CreateSection(TabContents["Move"], "Teleport")
CreateToggle(TabContents["Move"], LessScriptMM2.Settings.TeleportToSheriff, "Teleport to Sheriff", function(on)
    if on then
        local sheriff = GetSheriff()
        if sheriff and sheriff.Character and sheriff.Character:FindFirstChild("HumanoidRootPart") then
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local targetPos = sheriff.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                myChar.HumanoidRootPart.CFrame = CFrame.new(targetPos.Position, sheriff.Character.HumanoidRootPart.Position)
            end
        end
        LessScriptMM2.Settings.TeleportToSheriff.Enabled = false
    end
end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.TeleportToMurderer, "Teleport to Murderer", function(on)
    if on then
        local murderer = GetMurderer()
        if murderer and murderer.Character and murderer.Character:FindFirstChild("HumanoidRootPart") then
            local myChar = LocalPlayer.Character
            if myChar and myChar:FindFirstChild("HumanoidRootPart") then
                local targetPos = murderer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                myChar.HumanoidRootPart.CFrame = CFrame.new(targetPos.Position, murderer.Character.HumanoidRootPart.Position)
            end
        end
        LessScriptMM2.Settings.TeleportToMurderer.Enabled = false
    end
end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.TeleportToGun, "Teleport to Gun", function(on)
    if on then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Tool") and not obj.Parent:IsA("Model") then
                    local name = obj.Name:lower()
                    if name:find("gun") or name:find("revolver") or name:find("pistol") then
                        myChar.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                        break
                    end
                end
            end
        end
        LessScriptMM2.Settings.TeleportToGun.Enabled = false
    end
end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.TeleportToCoin, "Teleport to Coin", function(on)
    if on then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local name = obj.Name:lower()
                    if name:find("coin") or name:find("crystal") or name:find("gem") then
                        myChar.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                        break
                    end
                end
            end
        end
        LessScriptMM2.Settings.TeleportToCoin.Enabled = false
    end
end)

CreateSection(TabContents["Move"], "Movement")
CreateToggle(TabContents["Move"], LessScriptMM2.Settings.Fly, "Fly", function(on)
    if on then
        if LessScriptMM2.Connections.Fly then LessScriptMM2.Connections.Fly:Disconnect() end
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local root = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")
        if root and hum then
            local bg = Instance.new("BodyGyro"); bg.P = 9e4; bg.maxTorque = Vector3.new(9e9, 9e9, 9e9); bg.CFrame = root.CFrame; bg.Parent = root
            local bv = Instance.new("BodyVelocity"); bv.maxForce = Vector3.new(9e9, 9e9, 9e9); bv.Parent = root
            LessScriptMM2.Connections.Fly = RunService.RenderStepped:Connect(function()
                if not LessScriptMM2.Settings.Fly.Enabled then bg:Destroy(); bv:Destroy(); LessScriptMM2.Connections.Fly:Disconnect(); hum.PlatformStand = false; return end
                hum.PlatformStand = true
                bv.Velocity = Camera.CFrame.LookVector * LessScriptMM2.Settings.Fly.Speed
                bg.CFrame = Camera.CFrame
            end)
        end
    else
        if LessScriptMM2.Connections.Fly then LessScriptMM2.Connections.Fly:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.PlatformStand = false end
    end
end)
CreateSlider(TabContents["Move"], LessScriptMM2.Settings.Fly, "Fly Speed", 10, 200, 50, function(v) LessScriptMM2.Settings.Fly.Speed = v end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.SpeedHack, "Speed Hack", function(on)
    if on then
        if LessScriptMM2.Connections.Spd then LessScriptMM2.Connections.Spd:Disconnect() end
        LessScriptMM2.Connections.Spd = RunService.RenderStepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = LessScriptMM2.Settings.SpeedHack.Speed
            end
        end)
    else
        if LessScriptMM2.Connections.Spd then LessScriptMM2.Connections.Spd:Disconnect() end
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = 16 end
    end
end)
CreateSlider(TabContents["Move"], LessScriptMM2.Settings.SpeedHack, "Walk Speed", 16, 300, 50, function(v) LessScriptMM2.Settings.SpeedHack.Speed = v end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.NoClip, "NoClip", function(on)
    if on then
        if LessScriptMM2.Connections.NC then LessScriptMM2.Connections.NC:Disconnect() end
        LessScriptMM2.Connections.NC = RunService.Stepped:Connect(function()
            if not LessScriptMM2.Settings.NoClip.Enabled then return end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end)
    else
        if LessScriptMM2.Connections.NC then LessScriptMM2.Connections.NC:Disconnect() end
    end
end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.InfiniteJump, "Infinite Jump", function(on)
    if on then
        if LessScriptMM2.Connections.Jmp then LessScriptMM2.Connections.Jmp:Disconnect() end
        LessScriptMM2.Connections.Jmp = UserInputService.JumpRequest:Connect(function()
            if not LessScriptMM2.Settings.InfiniteJump.Enabled then return end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        if LessScriptMM2.Connections.Jmp then LessScriptMM2.Connections.Jmp:Disconnect() end
    end
end)

CreateToggle(TabContents["Move"], LessScriptMM2.Settings.SpinBot, "SpinBot", function(on)
    if on then
        if LessScriptMM2.Connections.Spn then LessScriptMM2.Connections.Spn:Disconnect() end
        LessScriptMM2.Connections.Spn = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.SpinBot.Enabled then return end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(LessScriptMM2.Settings.SpinBot.Speed), 0)
            end
        end)
    else
        if LessScriptMM2.Connections.Spn then LessScriptMM2.Connections.Spn:Disconnect() end
    end
end)
CreateSlider(TabContents["Move"], LessScriptMM2.Settings.SpinBot, "Spin Speed", 1, 50, 10, function(v) LessScriptMM2.Settings.SpinBot.Speed = v end)

-- Misc Tab
CreateSection(TabContents["Misc"], "Auto Collect")
CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.AutoPickupGun, "Auto Pickup Gun", function(on)
    if on then
        if LessScriptMM2.Connections.APG then LessScriptMM2.Connections.APG:Disconnect() end
        LessScriptMM2.Connections.APG = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.AutoPickupGun.Enabled then return end
            local myChar = LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
            local myRoot = myChar.HumanoidRootPart
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Tool") and not obj.Parent:IsA("Model") then
                    local name = obj.Name:lower()
                    if name:find("gun") or name:find("revolver") or name:find("pistol") then
                        if (myRoot.Position - obj.Position).Magnitude < 10 then
                            firetouchinterest(myRoot, obj, 0)
                            firetouchinterest(myRoot, obj, 1)
                        end
                    end
                end
            end
        end)
    else
        if LessScriptMM2.Connections.APG then LessScriptMM2.Connections.APG:Disconnect() end
    end
end)

CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.AutoCollectCoins, "Auto Collect Coins", function(on)
    if on then
        if LessScriptMM2.Connections.ACC then LessScriptMM2.Connections.ACC:Disconnect() end
        LessScriptMM2.Connections.ACC = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.AutoCollectCoins.Enabled then return end
            local myChar = LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
            local myRoot = myChar.HumanoidRootPart
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local name = obj.Name:lower()
                    if name:find("coin") or name:find("crystal") or name:find("gem") or name:find("token") then
                        if (myRoot.Position - obj.Position).Magnitude < LessScriptMM2.Settings.AutoCollectCoins.Range then
                            myRoot.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                            task.wait(0.05)
                        end
                    end
                end
            end
        end)
    else
        if LessScriptMM2.Connections.ACC then LessScriptMM2.Connections.ACC:Disconnect() end
    end
end)
CreateSlider(TabContents["Misc"], LessScriptMM2.Settings.AutoCollectCoins, "Collect Range", 10, 100, 30, function(v) LessScriptMM2.Settings.AutoCollectCoins.Range = v end)

CreateSection(TabContents["Misc"], "Rage")
CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.NukeAll, "Nuke All", function(on)
    if on then
        spawn(function()
            local myChar = LocalPlayer.Character
            if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return end
            local myRoot = myChar.HumanoidRootPart
            
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                    local targetRoot = plr.Character.HumanoidRootPart
                    myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
                    FireWeapon()
                    task.wait(0.05)
                end
            end
            LessScriptMM2.Settings.NukeAll.Enabled = false
        end)
    end
end)

CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.GodMode, "God Mode", function(on)
    if on then
        if LessScriptMM2.Connections.GM then LessScriptMM2.Connections.GM:Disconnect() end
        LessScriptMM2.Connections.GM = RunService.RenderStepped:Connect(function()
            if not LessScriptMM2.Settings.GodMode.Enabled then return end
            local myChar = LocalPlayer.Character
            if not myChar then return end
            local hum = myChar:FindFirstChild("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
                hum.MaxHealth = 999999
            end
            for _, part in pairs(myChar:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    part.Transparency = 0.5
                end
            end
        end)
    else
        if LessScriptMM2.Connections.GM then LessScriptMM2.Connections.GM:Disconnect() end
    end
end)

CreateSection(TabContents["Misc"], "Visuals")
CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.Crosshair, "Crosshair", function(on)
    if on then CreateCrosshair() else RemoveCrosshair() end
end)
CreateSlider(TabContents["Misc"], LessScriptMM2.Settings.Crosshair, "Size", 5, 40, 20, function(v) LessScriptMM2.Settings.Crosshair.Size = v end)

CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.ThirdPerson, "Third Person", function(on)
    if on then
        LocalPlayer.CameraMaxZoomDistance = LessScriptMM2.Settings.ThirdPerson.Distance
        LocalPlayer.CameraMode = Enum.CameraMode.Classic
    else LocalPlayer.CameraMaxZoomDistance = 10 end
end)
CreateSlider(TabContents["Misc"], LessScriptMM2.Settings.ThirdPerson, "Camera Dist", 5, 30, 10, function(v)
    LessScriptMM2.Settings.ThirdPerson.Distance = v
    if LessScriptMM2.Settings.ThirdPerson.Enabled then LocalPlayer.CameraMaxZoomDistance = v end
end)

CreateSection(TabContents["Misc"], "Other")
CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.AntiAfk, "Anti AFK", function(on)
    if on then
        if LessScriptMM2.Connections.AFK then LessScriptMM2.Connections.AFK:Disconnect() end
        LessScriptMM2.Connections.AFK = LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            wait(1)
            VirtualUser:ClickButton2(Vector2.new())
        end)
    else
        if LessScriptMM2.Connections.AFK then LessScriptMM2.Connections.AFK:Disconnect() end
    end
end)

CreateToggle(TabContents["Misc"], LessScriptMM2.Settings.ChatSpy, "Chat Spy", function(on)
    if on then
        if LessScriptMM2.Connections.Cht then LessScriptMM2.Connections.Cht:Disconnect() end
        LessScriptMM2.Connections.Cht = Players.PlayerChatted:Connect(function(plr, msg)
            if LessScriptMM2.Settings.ChatSpy.Enabled then print("[ChatSpy] " .. plr.Name .. ": " .. msg) end
        end)
    else
        if LessScriptMM2.Connections.Cht then LessScriptMM2.Connections.Cht:Disconnect() end
    end
end)

-- Inject main GUI
injectGui(ScreenGui)

-- ===== TOGGLE GUI =====
local function toggleGUI()
    MainFrame.Visible = not MainFrame.Visible
end

WatermarkFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        toggleGUI()
    end
end)

-- Respawn handler
LocalPlayer.CharacterAdded:Connect(function()
    wait(0.3)
    if LessScriptMM2.Settings.Fly.Enabled then
        LessScriptMM2.Settings.Fly.Enabled = false
        wait()
        LessScriptMM2.Settings.Fly.Enabled = true
    end
end)

print("LessScript MM2 " .. LessScriptMM2.Version .. " Loaded Successfully!")
print("Key used: " .. (LessScriptMM2.UserKey or "N/A"))
print("Tap LS watermark to open menu")
