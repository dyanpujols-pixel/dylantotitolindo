--// FLY SCRIPT
--// Open / Close + Fly ON / OFF
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local flying = false
local speed = 50

local gui = Instance.new("ScreenGui")
gui.Name = "FlyUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Open / Close button
local open = Instance.new("TextButton")
open.Size = UDim2.new(0, 55, 0, 55)
open.Position = UDim2.new(0, 15, 0.5, -25)
open.Text = "✈️"
open.TextSize = 27
open.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
open.TextColor3 = Color3.new(1, 1, 1)
open.Parent = gui
Instance.new("UICorner", open).CornerRadius = UDim.new(1, 0)

-- Main menu
local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 260, 0, 150)
menu.Position = UDim2.new(0.5, -130, 0.5, -75)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
menu.Parent = gui
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "✈️ FLY"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.Parent = menu

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 220, 0, 45)
toggle.Position = UDim2.new(0.5, -110, 0, 60)
toggle.Text = "FLY: OFF"
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.TextSize = 17
toggle.Font = Enum.Font.GothamBold
toggle.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
toggle.Parent = menu
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 10)

local bv
local bg
local connection

local function stopFly()
    flying = false

    if connection then
        connection:Disconnect()
        connection = nil
    end

    if bv then
        bv:Destroy()
        bv = nil
    end

    if bg then
        bg:Destroy()
        bg = nil
    end

    toggle.Text = "FLY: OFF"
    toggle.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
end

local function startFly()
    local character = player.Character
    if not character then return end

    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    flying = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.Velocity = Vector3.zero
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bg.P = 9000
    bg.Parent = root

    toggle.Text = "FLY: ON"
    toggle.BackgroundColor3 = Color3.fromRGB(40, 170, 80)

    connection = RunService.RenderStepped:Connect(function()
        if not flying or not root.Parent then
            stopFly()
            return
        end

        local camera = workspace.CurrentCamera
        local move = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            move += camera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            move -= camera.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            move -= camera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            move += camera.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            move += Vector3.new(0, 1, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
            move -= Vector3.new(0, 1, 0)
        end

        bv.Velocity = move * speed
        bg.CFrame = camera.CFrame
    end)
end

toggle.MouseButton1Click:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

open.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
end)

player.CharacterAdded:Connect(function()
    stopFly()
end)

print("Fly UI loaded")