--// dylantotitolindo 💀
--// Made by Daniel

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local Prediction = true
local HomeRun = false

local RED = Color3.fromRGB(220, 0, 0)
local DARK = Color3.fromRGB(18, 18, 18)
local DARK2 = Color3.fromRGB(28, 28, 28)
local WHITE = Color3.fromRGB(255, 255, 255)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "dylantotitolindo"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- OPEN BUTTON
local open = Instance.new("TextButton")
open.Size = UDim2.fromOffset(58, 58)
open.Position = UDim2.new(0, 20, .5, -29)
open.BackgroundColor3 = RED
open.Text = "💀"
open.TextScaled = true
open.TextColor3 = WHITE
open.BorderSizePixel = 0
open.Visible = false
open.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1, 0)
openCorner.Parent = open

-- MAIN
local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(310, 245)
main.Position = UDim2.new(.5, -155, .5, -122)
main.BackgroundColor3 = DARK
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = RED
stroke.Thickness = 2
stroke.Parent = main

-- HEADER
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 65)
header.BackgroundColor3 = RED
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = header

local skull = Instance.new("TextLabel")
skull.Size = UDim2.fromOffset(55, 55)
skull.Position = UDim2.fromOffset(8, 5)
skull.BackgroundTransparency = 1
skull.Text = "💀"
skull.TextScaled = true
skull.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -110, 0, 32)
title.Position = UDim2.fromOffset(65, 5)
title.BackgroundTransparency = 1
title.Text = "dylantotitolindo"
title.TextColor3 = WHITE
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local made = Instance.new("TextLabel")
made.Size = UDim2.new(1, -110, 0, 22)
made.Position = UDim2.fromOffset(66, 37)
made.BackgroundTransparency = 1
made.Text = "Made by Daniel"
made.TextColor3 = WHITE
made.TextScaled = true
made.TextXAlignment = Enum.TextXAlignment.Left
made.Parent = header

-- CLOSE
local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(38, 38)
close.Position = UDim2.new(1, -47, 0, 13)
close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
close.Text = "×"
close.TextColor3 = WHITE
close.TextScaled = true
close.Font = Enum.Font.GothamBold
close.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 10)
closeCorner.Parent = close

-- STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 25)
status.Position = UDim2.fromOffset(15, 75)
status.BackgroundTransparency = 1
status.Text = "⚡ FEATURES"
status.TextColor3 = RED
status.TextSize = 16
status.Font = Enum.Font.GothamBold
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main

-- BUTTON FUNCTION
local function makeButton(text, y)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -30, 0, 50)
    button.Position = UDim2.fromOffset(15, y)
    button.BackgroundColor3 = DARK2
    button.TextColor3 = WHITE
    button.Text = text
    button.TextSize = 17
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.Parent = main

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = button

    return button
end

local predictionButton = makeButton("🎯  Prediction       ON", 105)
local homerunButton = makeButton("🏠  Home Run       OFF", 165)

-- TOGGLES
predictionButton.MouseButton1Click:Connect(function()
    Prediction = not Prediction

    predictionButton.Text =
        Prediction and "🎯  Prediction       ON"
        or "🎯  Prediction       OFF"

    predictionButton.BackgroundColor3 =
        Prediction and Color3.fromRGB(70, 20, 20)
        or DARK2
end)

homerunButton.MouseButton1Click:Connect(function()
    HomeRun = not HomeRun

    homerunButton.Text =
        HomeRun and "🏠  Home Run       ON"
        or "🏠  Home Run       OFF"

    homerunButton.BackgroundColor3 =
        HomeRun and Color3.fromRGB(70, 20, 20)
        or DARK2
end)

-- CLOSE / OPEN
close.MouseButton1Click:Connect(function()
    main.Visible = false
    open.Visible = true
end)

open.MouseButton1Click:Connect(function()
    main.Visible = true
    open.Visible = false
end)

-- DRAG MENU
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and
        (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- BALL PREDICTION VISUAL
local marker = Instance.new("Part")
marker.Name = "PredictionMarker"
marker.Shape = Enum.PartType.Ball
marker.Size = Vector3.new(1.5, 1.5, 1.5)
marker.Anchored = true
marker.CanCollide = false
marker.CanTouch = false
marker.CanQuery = false
marker.Material = Enum.Material.Neon
marker.Color = RED
marker.Transparency = 1
marker.Parent = workspace

RunService.RenderStepped:Connect(function()
    if not Prediction then
        marker.Transparency = 1
        return
    end

    local ball = workspace:FindFirstChild("Ball")

    if ball and ball:IsA("BasePart") then
        marker.Transparency = 0

        local velocity = ball.AssemblyLinearVelocity
        local predictionTime = 0.35

        marker.Position = ball.Position + velocity * predictionTime
    else
        marker.Transparency = 1
    end
end)

print("dylantotitolindo loaded! 💀")