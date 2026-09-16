--// CARLITOS FLY
--// iPhone Joystick Fly
--// Created by Dylan
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Fly = false
local Speed = 50

local gui = Instance.new("ScreenGui")
gui.Name = "CarlitosFly"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Open / Close
local open = Instance.new("TextButton")
open.Size = UDim2.new(0, 55, 0, 55)
open.Position = UDim2.new(0, 15, 0.5, -28)
open.Text = "✈️"
open.TextSize = 28
open.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
open.TextColor3 = Color3.new(1, 1, 1)
open.Parent = gui
Instance.new("UICorner", open).CornerRadius = UDim.new(1, 0)

-- Menu
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 270, 0, 190)
menu.Position = UDim2.new(0.5, -135, 0.5, -95)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
menu.Parent = gui
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "✈️ CARLITOS FLY"
title.TextSize = 21
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1, 1, 1)
title.Parent = menu

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 230, 0, 45)
toggle.Position = UDim2.new(0.5, -115, 0, 55)
toggle.Text = "FLY: OFF"
toggle.TextSize = 17
toggle.Font = Enum.Font.GothamBold
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
toggle.Parent = menu
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0, 230, 0, 40)
speedBox.Position = UDim2.new(0.5, -115, 0, 110)
speedBox.Text = "50"
speedBox.PlaceholderText = "Speed"
speedBox.TextSize = 16
speedBox.Font = Enum.Font.Gotham
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
speedBox.ClearTextOnFocus = false
speedBox.Parent = menu
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 10)

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, 0, 0, 25)
info.Position = UDim2.new(0, 0, 0, 155)
info.BackgroundTransparency = 1
info.Text = "Use your Roblox joystick to fly"
info.TextSize = 12
info.Font = Enum.Font.Gotham
info.TextColor3 = Color3.fromRGB(170, 170, 175)
info.Parent = menu

local bodyVelocity
local bodyGyro
local connection

local function stopFly()
    Fly = false

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end

    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end

    toggle.Text = "FLY: OFF"
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
end

local function startFly()
    local char = Player.Character
    if not char then return end

    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    Fly = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = root

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 10000
    bodyGyro.Parent = root

    toggle.Text = "FLY: ON"
    toggle.BackgroundColor3 = Color3.fromRGB(40, 170, 80)

    connection = RunService.RenderStepped:Connect(function()
        if not Fly or not root.Parent then
            stopFly()
            return
        end

        local move = humanoid.MoveDirection

        if move.Magnitude > 0 then
            bodyVelocity.Velocity = move.Unit * Speed
            bodyGyro.CFrame = CFrame.lookAt(root.Position, root.Position + move)
        else
            bodyVelocity.Velocity = Vector3.zero
        end
    end)
end

toggle.MouseButton1Click:Connect(function()
    if Fly then
        stopFly()
    else
        startFly()
    end
end)

open.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

speedBox.FocusLost:Connect(function()
    local value = tonumber(speedBox.Text)

    if value then
        Speed = math.clamp(value, 10, 100)
        speedBox.Text = tostring(Speed)
    else
        speedBox.Text = tostring(Speed)
    end
end)

Player.CharacterAdded:Connect(function()
    stopFly()
end)

print("Carlitos Fly loaded")