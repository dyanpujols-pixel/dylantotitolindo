-- dylantotitolindo
-- Made by Daniel

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local predictionEnabled = true
local homeRunEnabled = false

local gui = Instance.new("ScreenGui")
gui.Name = "dylantotitolindo"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(260, 190)
frame.Position = UDim2.new(.5, -130, .5, -95)
frame.BackgroundColor3 = Color3.fromRGB(190, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 40)
title.BackgroundTransparency = 1
title.Text = "dylantotitolindo"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Parent = frame

local credit = Instance.new("TextLabel")
credit.Size = UDim2.new(1, 0, 0, 22)
credit.Position = UDim2.fromOffset(0, 35)
credit.BackgroundTransparency = 1
credit.Text = "Made by Daniel"
credit.TextColor3 = Color3.new(1,1,1)
credit.TextScaled = true
credit.Parent = frame

local function button(text, y)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(.8, 0, 0, 40)
    b.Position = UDim2.new(.1, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    b.TextColor3 = Color3.new(1,1,1)
    b.TextScaled = true
    b.Text = text
    b.Parent = frame
    return b
end

local predictionButton = button("Prediction: ON", 65)
local homerunButton = button("Home Run: OFF", 112)

predictionButton.MouseButton1Click:Connect(function()
    predictionEnabled = not predictionEnabled
    predictionButton.Text =
        predictionEnabled and "Prediction: ON" or "Prediction: OFF"
end)

homerunButton.MouseButton1Click:Connect(function()
    homeRunEnabled = not homeRunEnabled
    homerunButton.Text =
        homeRunEnabled and "Home Run: ON" or "Home Run: OFF"
end)

-- Prediction marker
local marker = Instance.new("Part")
marker.Name = "BallPrediction"
marker.Shape = Enum.PartType.Ball
marker.Size = Vector3.new(1,1,1)
marker.Anchored = true
marker.CanCollide = false
marker.CanQuery = false
marker.CanTouch = false
marker.Transparency = 0.25
marker.Color = Color3.fromRGB(255,0,0)
marker.Parent = workspace

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

    marker.Transparency = 0

    -- Predict position using the ball's current velocity.
    local velocity = ball.AssemblyLinearVelocity
    local predictionTime = 0.35

    marker.Position =
        ball.Position + velocity * predictionTime
end)