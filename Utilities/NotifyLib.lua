-- Services
local TweenService = game:GetService("TweenService")

local NotifyLib = {}

do
    NotifyLib.__index = NotifyLib

    function NotifyLib.new(data)
        title = data.title or "Title"
        text = data.text or "Text"
        duration = data.duration or 1

        -- Instances
        local ScreenGui = Instance.new("ScreenGui")
        local Frame = Instance.new("Frame")
        local Title = Instance.new("TextLabel")
        local Text = Instance.new("TextLabel")

        -- Properties:

        ScreenGui.Parent = game.CoreGui
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.ResetOnSpawn = false

        Frame.Parent = ScreenGui
        Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
        Frame.Position = UDim2.new(1, 0, 0.891, 0)
        Frame.Size = UDim2.new(0, 136, 0, 73)

        Title.Name = "Title"
        Title.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        Title.BorderColor3 = Color3.fromRGB(20, 20, 20)
        Title.Size = UDim2.new(0, 136, 0, 21)
        Title.Font = Enum.Font.SourceSans
        Title.Text = title
        Title.TextColor3 = Color3.fromRGB(179, 179, 179)
        Title.TextSize = 14.000
        Title.TextWrapped = true
        Title.Parent = Frame

        Text.Name = "Text"
        Text.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Text.BorderColor3 = Color3.fromRGB(20, 20, 20)
        Text.Position = UDim2.new(0, 0, 0.287671238, 0)
        Text.Size = UDim2.new(0, 136, 0, 52)
        Text.Font = Enum.Font.SourceSans
        Text.Text = text
        Text.TextColor3 = Color3.fromRGB(179, 179, 179)
        Text.TextSize = 14.000
        Text.TextWrapped = true
        Text.Parent = Frame

        TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.9, 0, 0.891, 0)}):Play()

        task.wait(duration)

        TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, 0, 0.891, 0)}):Play()
        task.wait(0.2)
        ScreenGui:Destroy()
    end
end

return NotifyLib

