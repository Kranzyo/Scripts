-- Services
local TweenService = game:GetService("TweenService")

local NotifyLib = {}

do
    function NotifyLib.Notify(data)
        title = data.title or "Title"
        text = data.text or "Text"
        duration = data.duration or 1000000000000000000000000000000000

        -- Instances
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Text = Instance.new("TextLabel")
        local ImageButton = Instance.new("ImageButton")

        -- Properties:

        ScreenGui.Name = "NotificationGUI"
        ScreenGui.Parent = game.CoreGui
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.ResetOnSpawn = false

        Frame.Parent = ScreenGui
        Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(1, 0, 0.891, 0)
        Frame.Size = UDim2.new(0, 137, 0, 74)

        Title.Name = "Title"
        Title.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Title.BorderSizePixel = 0
        Title.Size = UDim2.new(0, 137, 0, 22)
        Title.Font = Enum.Font.SourceSans
        Title.Text = title
        Title.TextColor3 = Color3.fromRGB(179, 179, 179)
        Title.TextSize = 14.000
        Title.TextWrapped = true
        Title.Parent = Frame

        Text.Name = "Text"
        Text.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Text.BorderSizePixel = 0
        Text.Position = UDim2.new(0, 0, 0.287671238, 0)
        Text.Size = UDim2.new(0, 137, 0, 53)
        Text.Font = Enum.Font.SourceSans
        Text.Text = text
        Text.TextColor3 = Color3.fromRGB(179, 179, 179)
        Text.TextSize = 14.000
        Text.TextWrapped = true
        Text.Parent = Frame

        ImageButton.Parent = ScreenGui.Frame
        ImageButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ImageButton.ImageColor3 = Color3.fromRGB(200, 200, 200)
        ImageButton.BorderSizePixel = 0
        ImageButton.Position = UDim2.new(0.92592597, 0, 0.0684931502, 0)
        ImageButton.Size = UDim2.new(0, 10, 0, 10)
        ImageButton.Image = "http://www.roblox.com/asset/?id=1188759461"

        -- Image Button Functions and effects
        ImageButton.MouseEnter:Connect(function()
            TweenService:Create(ImageButton, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end)

        ImageButton.MouseLeave:Connect(function()
            TweenService:Create(ImageButton, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        end)

        ImageButton.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
        end)

        -- Tweening
        Frame:TweenPosition(UDim2.new(0.9, 0, 0.891, 0), "InOut", "Quart", 0.2)
        -- TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Position = UDim2.new(0.9, 0, 0.891, 0)}):Play()
        
        task.wait(duration)
        Frame:TweenPosition(UDim2.new(1, 0, 0.891, 0), "InOut", "Quart", 0.2)
        -- TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut), {Position = UDim2.new(1, 0, 0.891, 0)}):Play()
        task.wait(0.2)
        ScreenGui:Destroy()
    end
end

return NotifyLib

