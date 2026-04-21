local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local StarterGui = game:GetService("StarterGui")
local LP = Players.LocalPlayer

local function Notify(msg)
    StarterGui:SetCore("SendNotification", {Title = "Script4You", Text = msg, Duration = 5})
end

if CoreGui:FindFirstChild("Script4You_Main") then CoreGui.Script4You_Main:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "Script4You_Main"
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 360, 0, 300)
Main.Position = UDim2.new(0.5, -180, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness = 2
Stroke.Color = Color3.fromRGB(0, 120, 255)
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundTransparency = 1
Title.Text = "  SCRIPT4YOU | ANTI-AFK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 50)
Status.BackgroundTransparency = 1
Status.Text = "STATUS: ENTER KEY"
Status.TextColor3 = Color3.fromRGB(0, 120, 255)
Status.Font = Enum.Font.GothamBold

local KeyElements = Instance.new("Frame", Main)
KeyElements.Size = UDim2.new(1, 0, 1, -50)
KeyElements.Position = UDim2.new(0, 0, 0, 50)
KeyElements.BackgroundTransparency = 1

local KeyBox = Instance.new("TextBox", KeyElements)
KeyBox.Size = UDim2.new(0, 320, 0, 40)
KeyBox.Position = UDim2.new(0.5, -160, 0, 40)
KeyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyBox.PlaceholderText = "PASTE KEY HERE..."
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyBox)

local function CreateBtn(parent, text, pos, color, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 320, 0, 38)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    if callback then btn.MouseButton1Click:Connect(callback) end
    return btn
end

_G.AntiAFK = false

CreateBtn(KeyElements, "SUBMIT KEY", UDim2.new(0.5, -160, 0, 90), Color3.fromRGB(0, 120, 255), function()
    if KeyBox.Text == "FREE_KEY_2026" or KeyBox.Text == "VIP_LIFETIME" then
        KeyElements:Destroy()
        Status.Text = "STATUS: IDLE"
        Notify("Script Unlocked!")
        local ToggleBtn = CreateBtn(Main, "ENABLE ANTI-AFK", UDim2.new(0.5, -160, 0, 130), Color3.fromRGB(0, 120, 255), nil)
        ToggleBtn.MouseButton1Click:Connect(function()
            _G.AntiAFK = not _G.AntiAFK
            ToggleBtn.Text = _G.AntiAFK and "DISABLE ANTI-AFK" or "ENABLE ANTI-AFK"
            ToggleBtn.BackgroundColor3 = _G.AntiAFK and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(0, 120, 255)
            Status.Text = _G.AntiAFK and "STATUS: ACTIVE" or "STATUS: IDLE"
        end)
    else
        Status.Text = "INVALID KEY"
    end
end)

CreateBtn(KeyElements, "GET TRIAL (1 HR)", UDim2.new(0.5, -160, 0, 140), Color3.fromRGB(25, 25, 25), function() 
    setclipboard("FREE_KEY_2026")
    Notify("Trial Key copied!")
end)

CreateBtn(KeyElements, "BUY LIFETIME ($2)", UDim2.new(0.5, -160, 0, 185), Color3.fromRGB(25, 25, 25), function() 
    setclipboard("[https://scripts4you23.mysellauth.com](https://scripts4you23.mysellauth.com)")
    Notify("Link Copied! Paste in browser.")
end)

task.spawn(function()
    LP.Idled:Connect(function()
        if _G.AntiAFK then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end
    end)
end)

local UIS = game:GetService("UserInputService")
local drag, dStart, sPos
Main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true dStart = i.Position sPos = Main.Position end end)
UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then local d = i.Position - dStart Main.Position = UDim2.new(sPos.X.Scale, sPos.X.Offset + d.X, sPos.Y.Scale, sPos.Y.Offset + d.Y) end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
