-- dylantotitolindo
-- Made by Daniel
-- Enhanced UI Version

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

local predictionEnabled = true
local homeRunEnabled = false
local guiVisible = true

local gui = Instance.new("ScreenGui")
gui.Name = "dylantotitolindo"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main frame with better styling
local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(300, 250)
frame.Position = UDim2.new(.5, -150, .5, -125)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- Add shadow effect
local shadow = Instance.new("Frame")
shadow.Size = UDim2.new(1, 8, 1, 8)
shadow.Position = UDim2.new(0, -4, 0, -4)
shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
shadow.BorderSizePixel = 0
shadow.ZIndex = -1
shadow.Parent = frame
local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(0, 16)
shadowCorner.Parent = shadow

-- Header frame
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(190, 0, 0)
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.BackgroundTransparency = 1
title.Text = "dylantotitolindo"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = header

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(40, 40)
closeButton.Position = UDim2.new(1, -45, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextScaled = true
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "×"
closeButton.Parent = header
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- Content frame
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -50)
content.Position = UDim2.new(0, 0, 0, 50)
content.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
content.BorderSizePixel = 0
content.Parent = frame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = content

-- Credit label
local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 25)
credit.Position = UDim2.fromOffset(0, 10)
credit.BackgroundTransparency = 1
credit.Text = "Made by Daniel"
credit.TextColor3 = Color3.fromRGB(200, 200, 200)
credit.TextScaled = true
credit.Font = Enum.Font.Gotham
credit.Parent = content

-- Utility function to create enhanced buttons
local function createToggleButton(text, y, callback)
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Size = UDim2.new(0.9, 0, 0, 50)
    buttonContainer.Position = UDim2.new(0.05, 0, 0, y)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = content

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextScaled = true
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.Parent = buttonContainer

    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button

    -- Hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end)

    button.MouseButton1Click:Connect(function()
        callback(button)
    end)

    return button
end

local predictionButton = createToggleButton("Prediction: ON", 45, function(btn)
    predictionEnabled = not predictionEnabled
    btn.Text = predictionEnabled and "Prediction: ON" or "Prediction: OFF"
    btn.BackgroundColor3 = predictionEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
end)

local homerunButton = createToggleButton("Home Run: OFF", 105, function(btn)
    homeRunEnabled = not homeRunEnabled
    btn.Text = homeRunEnabled and "Home Run: ON" or "Home Run: OFF"
    btn.BackgroundColor3 = homeRunEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(120, 0, 0)
end)

-- Set initial button colors
predictionButton.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
homerunButton.BackgroundColor3 = Color3.fromRGB(120, 0, 0)

-- Close/Open button functionality
closeButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    frame.Visible = guiVisible
end)

-- Toggle GUI with F6 key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F6 then
        guiVisible = not guiVisible
        frame.Visible = guiVisible
    end
end)

-- Prediction marker
local marker = Instance.new("Part")
marker.Name = "BallPrediction"
marker.Shape = Enum.PartType.Ball
marker.Size = Vector3.new(1, 1, 1)
marker.Anchored = true
marker.CanCollide = false
marker.CanQuery = false
marker.CanTouch = false
marker.Transparency = 0.25
marker.Color = Color3.fromRGB(255, 0, 0)
marker.Parent = workspace

-- Add surface GUI to marker for better visibility
local surfaceGui = Instance.new("SurfaceGui")
surfaceGui.Face = Enum.NormalId.Top
surfaceGui.Parent = marker

local markerLabel = Instance.new("TextLabel")
markerLabel.Size = UDim2.new(1, 0, 1, 0)
markerLabel.BackgroundTransparency = 0.3
markerLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
markerLabel.Text = "BALL"
markerLabel.TextColor3 = Color3.new(1, 1, 1)
markerLabel.TextScaled = true
markerLabel.Font = Enum.Font.GothamBold
markerLabel.Parent = surfaceGui

RunService.RenderStepped:Connect(function()
    if not predictionEnabled then
        marker.Transparency = 1
        return
    end

    local ball = workspace:FindFirstChild("Ball")

    if not ball or not ball:IsA("BasePart") then
        marker.Transparency = 1
        return
    end

    marker.Transparency = 0.25

    -- Predict position using the ball's current velocity.
    local velocity = ball.AssemblyLinearVelocity
    local predictionTime = 0.35

    marker.Position = ball.Position + velocity * predictionTime
end)

print("dylantotitolindo loaded! Press F6 to toggle GUI")