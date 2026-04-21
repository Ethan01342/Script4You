-- [[ SCRIPT4YOU - ANTI-AFK ASYLUM EDITION ]]
-- SHOP: https://scripts4you23.mysellauth.com

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LP = Players.LocalPlayer

-- Cleanup old instances
if CoreGui:FindFirstChild("Script4You_Main") then CoreGui.Script4You_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Script4You_Main"
ScreenGui.ResetOnSpawn = false

-- MAIN CONTAINER
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 280)
Main.Position = UDim2.new(0.5, -180, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Pure Black
Main.BorderSizePixel = 0

-- NEON BLUE BORDER
local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 120, 255)

-- ROUNDED CORNERS
local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 8)

-- HEADER TITLE
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "  SCRIPT4YOU | ANTI-AFK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- STATUS
local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 50)
Status.BackgroundTransparency = 1
Status.Text = "STATUS: ENTER KEY"
Status.TextColor3 = Color3.fromRGB(0, 120, 255)
Status.Font = Enum.Font.GothamBold
Status.TextSize = 14

-- KEY INPUT
local KeyBox = Instance.new("TextBox", Main)
KeyBox.Size = UDim2.new(0, 320, 0, 40)
KeyBox.Position = UDim2.new(0.5, -160, 0, 90)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyBox.PlaceholderText = "PASTE KEY HERE..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.Font = Enum.Font.Gotham
local KCorner = Instance.new("UICorner", KeyBox)

-- BUTTON BUILDER
local function S4Y_Button(text, pos, color, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0, 320, 0, 38)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- LOGIC VARIABLES
_G.AntiAFK = false
local SubmitBtn, ToggleBtn

-- BUTTONS
SubmitBtn = S4Y_Button("SUBMIT KEY", UDim2.new(0.5, -160, 0, 140), Color3.fromRGB(0, 120, 255), function()
    if KeyBox.Text == "FREE_KEY_2026" or KeyBox.Text == "VIP_LIFETIME" then
        Status.Text = "STATUS: IDLE"
        Status.TextColor3 = Color3.fromRGB(255, 255, 255)
        KeyBox.Visible = false
        SubmitBtn.Visible = false
        ToggleBtn.Visible = true
    else
        Status.Text = "INVALID KEY"
        task.wait(1.5)
        Status.Text = "STATUS: ENTER KEY"
    end
end)

ToggleBtn = S4Y_Button("ENABLE ANTI-AFK", UDim2.new(0.5, -160, 0, 110), Color3.fromRGB(0, 120, 255), function()
    _G.AntiAFK = not _G.AntiAFK
    ToggleBtn.Text = _G.AntiAFK and "DISABLE ANTI-AFK" or "ENABLE ANTI-AFK"
    ToggleBtn.BackgroundColor3 = _G.AntiAFK and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 120, 255)
    Status.Text = _G.AntiAFK and "STATUS: ACTIVE (PROTECTED)" or "STATUS: IDLE"
    Status.TextColor3 = _G.AntiAFK and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
end)
ToggleBtn.Visible = false

S4Y_Button("GET TRIAL (1 HR)", UDim2.new(0.5, -160, 0, 190), Color3.fromRGB(30, 30, 30), function()
    setclipboard("FREE_KEY_2026")
end)

S4Y_Button("BUY LIFETIME ($2)", UDim2.new(0.5, -160, 0, 235), Color3.fromRGB(30, 30, 30), function()
    setclipboard("https://scripts4you23.mysellauth.com")
end)

-- CORE BYPASS ENGINE
task.spawn(function()
    LP.Idled:Connect(function()
        if _G.AntiAFK then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end
    end)
end)

-- DRAG SYSTEM
local UIS = game:GetService("UserInputService")
local drag, dInput, dStart, sPos
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true dStart = i.Position sPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - dStart Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
