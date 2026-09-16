-- DILAN TOTITOLINDO ✈️
-- Fly para iPhone
-- Joystick = moverte | ⬆️ = subir | ⬇️ = bajar

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "DilanTotitolindo"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local flying = false
local upHeld = false
local downHeld = false
local speed = 75
local bv, bg, flyConnection

local function getCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    return char, char:WaitForChild("Humanoid"), char:WaitForChild("HumanoidRootPart")
end

local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 55, 0, 55)
openButton.Position = UDim2.new(0, 15, 0.5, -30)
openButton.Text = "✈️"
openButton.TextSize = 25
openButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
openButton.TextColor3 = Color3.new(1, 1, 1)
openButton.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = openButton

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 230, 0, 170)
menu.Position = UDim2.new(0.5, -115, 0.5, -85)
menu.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
menu.Parent = gui

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 15)
menuCorner.Parent = menu

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "DILAN TOTITOLINDO"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = menu

local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 190, 0, 45)
flyButton.Position = UDim2.new(0.5, -95, 0, 55)
flyButton.Text = "FLY: OFF"
flyButton.TextSize = 18
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
flyButton.Parent = menu

local flyCorner = Instance.new("UICorner")
flyCorner.CornerRadius = UDim.new(0, 10)
flyCorner.Parent = flyButton

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 35)
speedLabel.Position = UDim2.new(0, 0, 0, 110)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Speed: 75"
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.TextSize = 16
speedLabel.Parent = menu

local speedDown = Instance.new("TextButton")
speedDown.Size = UDim2.new(0, 45, 0, 35)
speedDown.Position = UDim2.new(0, 20, 0, 125)
speedDown.Text = "−"
speedDown.TextSize = 25
speedDown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedDown.TextColor3 = Color3.new(1, 1, 1)
speedDown.Parent = menu

local speedUp = Instance.new("TextButton")
speedUp.Size = UDim2.new(0, 45, 0, 35)
speedUp.Position = UDim2.new(1, -65, 0, 125)
speedUp.Text = "+"
speedUp.TextSize = 25
speedUp.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
speedUp.TextColor3 = Color3.new(1, 1, 1)
speedUp.Parent = menu

local upButton = Instance.new("TextButton")
upButton.Size = UDim2.new(0, 65, 0, 65)
upButton.Position = UDim2.new(1, -85, 0.5, -75)
upButton.Text = "⬆️"
upButton.TextSize = 30
upButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
upButton.TextColor3 = Color3.new(1, 1, 1)
upButton.Visible = false
upButton.Parent = gui

local upCorner = Instance.new("UICorner")
upCorner.CornerRadius = UDim.new(1, 0)
upCorner.Parent = upButton

local downButton = Instance.new("TextButton")
downButton.Size = UDim2.new(0, 65, 0, 65)
downButton.Position = UDim2.new(1, -85, 0.5, 10)
downButton.Text = "⬇️"
downButton.TextSize = 30
downButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
downButton.TextColor3 = Color3.new(1, 1, 1)
downButton.Visible = false
downButton.Parent = gui

local downCorner = Instance.new("UICorner")
downCorner.CornerRadius = UDim.new(1, 0)
downCorner.Parent = downButton

local function stopFly()
    flying = false
    upHeld = false
    downHeld = false

    flyButton.Text = "FLY: OFF"
    flyButton.BackgroundColor3 = Color3.fromRGB(170, 40, 40)
    upButton.Visible = false
    downButton.Visible = false

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

    if bv then
        bv:Destroy()
        bv = nil
    end

    if bg then
        bg:Destroy()
        bg = nil
    end
end

local function startFly()
    local char, humanoid, root = getCharacter()

    flying = true
    flyButton.Text = "FLY: ON"
    flyButton.BackgroundColor3 = Color3.fromRGB(40, 170, 70)
    upButton.Visible = true
    downButton.Visible = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.P = 10000
    bv.Velocity = Vector3.zero
    bv.Parent = root

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bg.P = 10000
    bg.CFrame = root.CFrame
    bg.Parent = root

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flying or not root.Parent then
            return
        end

        local move = humanoid.MoveDirection
        local vertical = 0

        if upHeld then
            vertical += 1
        end

        if downHeld then
            vertical -= 1
        end

        bv.Velocity = (move * speed) + Vector3.new(0, vertical * speed, 0)

        local horizontal = Vector3.new(move.X, 0, move.Z)
        if horizontal.Magnitude > 0.05 then
            bg.CFrame = CFrame.lookAt(root.Position, root.Position + horizontal)
        end
    end)
end

flyButton.Activated:Connect(function()
    if flying then
        stopFly()
    else
        startFly()
    end
end)

openButton.Activated:Connect(function()
    menu.Visible = not menu.Visible
end)

speedUp.Activated:Connect(function()
    speed = math.clamp(speed + 5, 50, 100)
    speedLabel.Text = "Speed: " .. speed
end)

speedDown.Activated:Connect(function()
    speed = math.clamp(speed - 5, 50, 100)
    speedLabel.Text = "Speed: " .. speed
end)

local function setHeld(state, input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        return state
    end
    return nil
end

upButton.InputBegan:Connect(function(input)
    local state = setHeld(true, input)
    if state ~= nil then upHeld = state end
end)

upButton.InputEnded:Connect(function(input)
    local state = setHeld(false, input)
    if state ~= nil then upHeld = state end
end)

downButton.InputBegan:Connect(function(input)
    local state = setHeld(true, input)
    if state ~= nil then downHeld = state end
end)

downButton.InputEnded:Connect(function(input)
    local state = setHeld(false, input)
    if state ~= nil then downHeld = state end
end)

player.CharacterAdded:Connect(function()
    if flying then
        task.wait(1)
        stopFly()
    end
end)