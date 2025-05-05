-- Auto Farm Chest GUI with Animation & Hide Button
local player = game.Players.LocalPlayer

-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "CreateGUI"

-- Main Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true

-- UICorner (bo góc)
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -20, 0, 40)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "Create - Made by Bạn"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(200, 200, 200)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left

-- Script name
local scriptName = Instance.new("TextLabel", frame)
scriptName.Size = UDim2.new(1, -20, 0, 30)
scriptName.Position = UDim2.new(0, 10, 0, 45)
scriptName.Text = "Auto Farm Chest"
scriptName.BackgroundTransparency = 1
scriptName.TextColor3 = Color3.fromRGB(180, 180, 180)
scriptName.Font = Enum.Font.Gotham
scriptName.TextSize = 18
scriptName.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Button
local toggleButton = Instance.new("TextButton", frame)
toggleButton.Size = UDim2.new(0.8, 0, 0, 40)
toggleButton.Position = UDim2.new(0.1, 0, 0.5, -10)
toggleButton.Text = "Auto Farm Chest: OFF"
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Gotham
toggleButton.TextSize = 16

local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(0, 8)

-- Hide Button
local hideButton = Instance.new("TextButton", frame)
hideButton.Size = UDim2.new(0, 30, 0, 30)
hideButton.Position = UDim2.new(1, -40, 0, 10)
hideButton.Text = "X"
hideButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
hideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
hideButton.Font = Enum.Font.Gotham
hideButton.TextSize = 16

local hideCorner = Instance.new("UICorner", hideButton)
hideCorner.CornerRadius = UDim.new(1, 0)

-- Show Button (tròn nhỏ)
local showButton = Instance.new("TextButton", screenGui)
showButton.Size = UDim2.new(0, 40, 0, 40)
showButton.Position = UDim2.new(0, 10, 0.5, -20)
showButton.Text = "O"
showButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.Font = Enum.Font.GothamBold
showButton.TextSize = 18
showButton.Visible = false

local showCorner = Instance.new("UICorner", showButton)
showCorner.CornerRadius = UDim.new(1, 0)

-- Thêm tính năng kéo cho nút hình tròn
local dragging = false
local dragInput, dragStart, startPos

showButton.MouseButton1Down:Connect(function(input)
    dragging = true
    dragStart = input.Position
    startPos = showButton.Position
    input.Changed:Connect(function()
        if dragging then
            local delta = input.Position - dragStart
            showButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
-- Animation Tween
local tween = game:GetService("TweenService")
local farming = false

function teleportTo(pos)
    local tweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Linear)
    local goal = {CFrame = CFrame.new(pos)}
    local tweenCreate = tween:Create(player.Character.HumanoidRootPart, tweenInfo, goal)
    tweenCreate:Play()
    tweenCreate.Completed:Wait()
end

-- Auto Farm Loop
spawn(function()
    while true do
        if farming then
            -- Sửa phần tìm kiếm Chest
            local chestModels = game.Workspace:WaitForChild("ChestModels")
            for i, v in pairs(chestModels:GetChildren()) do
                if v:IsA("Model") and string.find(v.Name, "Chest") then
                    if v:FindFirstChild("HumanoidRootPart") then
                        teleportTo(v.HumanoidRootPart.Position + Vector3.new(0, 3, 0))
                        wait(0.5)
                    end
                end
            end
        end
        wait(3)
    end
end)

-- Toggle Button Event
toggleButton.MouseButton1Click:Connect(function()
    farming = not farming
    if farming then
        toggleButton.Text = "Auto Farm Chest: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)

        -- Hiệu ứng: phóng lớn nút
        local t = tween:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.85, 0, 0, 45)})
        t:Play()
        t.Completed:Wait()
        tween:Create(toggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0.8, 0, 0, 40)}):Play()
    else
        toggleButton.Text = "Auto Farm Chest: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

        -- Hiệu ứng tương tự khi tắt
        local t = tween:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0.85, 0, 0, 45)})
        t:Play()
        t.Completed:Wait()
        tween:Create(toggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0.8, 0, 0, 40)}):Play()
    end
end)

-- Hide Event
hideButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    showButton.Visible = true
end)

-- Show Event
showButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    showButton.Visible = false
end)
