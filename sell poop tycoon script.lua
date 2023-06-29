-- Game: SELL POOP TYCOON https://web.roblox.com/games/13390606619/SELL-POOP-TYCOON

-- TODO: auto collect and put in storage

-- docs : https://detourious.gitbook.io/project-finity/docs

--// fireproximityprompt(<ProximityPrompt> Object,?<Int> ClickAmount,?<Bool> ExcludeTime)

local function fireproximityprompt(Obj, Amount, Skip)
    if Obj.ClassName == "ProximityPrompt" then 
        Amount = Amount or 1
        local PromptTime = Obj.HoldDuration
        if Skip then 
            Obj.HoldDuration = 0
        end
        for i = 1, Amount do 
            Obj:InputHoldBegin()
            if not Skip then 
                wait(Obj.HoldDuration)
            end
            Obj:InputHoldEnd()
        end
        Obj.HoldDuration = PromptTime
    else 
        error("userdata<ProximityPrompt> expected")
    end
end

local lp = game:GetService("Players").LocalPlayer
local char = lp.Character
local hum = char.Humanoid
local root = char:FindFirstChild("HumanoidRootPart")

getgenv().Config = {

    playerTycoon,

    foundTycoon = false,

    toggles = {
        autoCollectPoop = false,
        autoKickPoopers = false
    }
}

local Bracket = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV33.lua"))()


-- see source code for more hidden things i forgot to add in this example
local Window = Bracket:Window({Name = "SELL POOP TYCOON Script by Kranz",Enabled = true,Color = Color3.new(1,0.5,0.25),Size = UDim2.new(0,496,0,496),Position = UDim2.new(0.5,-248,0.5,-248)}) do
    --Window.Name = "Name"
    --Window.Size = UDim2.new(0,496,0,496)
    --Window.Position = UDim2.new(0.5,-248,0.5,-248)
    --Window.Color = Color3.new(1,0.5,0.25)
    --Window.Enabled = true
    --Window.Blur = true

    --Window:SetValue("Flag",Value)
    --Window:GetValue("Flag")

    --Window:SaveConfig("FolderName","ConfigName")
    --Window:LoadConfig("FolderName","ConfigName")
    --Window:DeleteConfig("FolderName","ConfigName")

    --Window:GetAutoLoadConfig("FolderName")
    --Window:AddToAutoLoad("FolderName","ConfigName")
    --Window:RemoveFromAutoLoad("FolderName")
    --Window:AutoLoadConfig("FolderName")

    --Window.Background -- ImageLabel
    --Window.Background.ImageTransparency = 0
    --Window.Background.ImageColor3 = Color3.new(0,0,0)
    --Window.Background.Image = "rbxassetid://5553946656"

    -- Watermark draggable
    local Watermark = Window:Watermark({
        Title = "Bracket V3.3 | SELL POOP TYCOON by Kranz",
        Flag = "UI/Watermark/Position",
        Enabled = true,
    })


    local MainTab = Window:Tab({Name = "Main"}) do
        local StuffSection = MainTab:Section({Name = "Stuff", Side = "Left"}) do
            local FindTycoonButton = StuffSection:Button({Name = "Find Your Tycoon", Callback = function() end})

            FindTycoonButton.Callback = function() 
                -- tp to tycoon when pressing the button after playerTycoon is found
                if Config.foundTycoon == true then
                    root.CFrame = Config.playerTycoon.Claim.Part.CFrame
                end

                for i,v in ipairs(game:GetService("Workspace").Tycoons:GetChildren()) do
                    if v:FindFirstChild("TycoonOwner") and Config.foundTycoon == false then
                        if v.TycoonOwner.Value == lp.Name then
                            Config.playerTycoon = v
                            Config.foundTycoon = true
                            
                            root.CFrame = Config.playerTycoon.Claim.Part.CFrame

                            Bracket:Notification2({Title = "Found your tycoon: " .. Config.playerTycoon.Name, Description = "script should work now", Duration = 5})
                            Bracket:Notification2({Title = "Teleporting... ", Duration = 5})
                            break
                        else
                            Bracket:Notification2({Title = "Failed to find tycoon ", Duration = 3})
                        end
                    end
                end
            end
            FindTycoonButton:ToolTip("Use after claiming a tycoon")

            local AutoCollectPoopToggle = StuffSection:Toggle({Name = "Auto Collect Poop and Store", Flag = "Toggle", Value = false, Callback = function(Toggle_Bool) end})
            AutoCollectPoopToggle:Keybind({Value = "Q", Flag = "UI/Keybind", DoNotClear = true})

            AutoCollectPoopToggle.Callback = function(Bool) 
                Config.toggles.autoCollectPoop = Bool
                
                while Config.toggles.autoCollectPoop do
                    root.CFrame = Config.playerTycoon.Belts.Belt1.Collector.Prox.CFrame
                    task.wait(1)
                    fireproximityprompt(Config.playerTycoon.Belts.Belt1.Collector.Prox.ProximityPrompt, 1, true)
                    task.wait(1)
                    
                    root.CFrame = Config.playerTycoon.StaticItems.Storage1.CFrame
                    task.wait(1)
                    fireproximityprompt(Config.playerTycoon.StaticItems.Storage1.ProximityPrompt, 1, false)

                    task.wait(3)
                end
            end

            local AutoKickPoopersToggle = StuffSection:Toggle({Name = "auto kick friends", Flag = "Toggle", Value = false})
            AutoKickPoopersToggle:Keybind({Value = "R", Flag = "UI/Keybind", DoNotClear = true})

            AutoKickPoopersToggle.Callback = function(Bool)
                Config.toggles.autoKickPoopers = Bool

                while Config.toggles.autoKickPoopers do
                    task.wait()
                    for i,v in pairs(Config.playerTycoon.Items:GetChildren()) do
                        if string.find(v.Name, "Pooper") then
                            root.CFrame = v.NPC.HumanoidRootPart.CFrame
                            task.wait(1)
    
                            fireproximityprompt(v.NPC.HumanoidRootPart.ProximityPrompt)
                        end
                        task.wait(1)
                    end
                end

            end

            local PoopToCollectLabel = StuffSection:Label({Text = "Poop: "})
            task.spawn(function()
                while true do
                    if Config.playerTycoon then
                        PoopToCollectLabel.Text = "Poop: " .. Config.playerTycoon.Belts.Belt1.Activator.Amt.Value
                    end
                    task.wait()
                end
            end)

        end
    end


    local OptionsTab = Window:Tab({Name = "Options"}) do
        local MenuSection = OptionsTab:Section({Name = "Menu",Side = "Left"}) do
            local UIToggle = MenuSection:Toggle({Name = "UI Enabled",Flag = "UI/Enabled",IgnoreFlag = true,
            Value = Window.Enabled,Callback = function(Bool) Window.Enabled = Bool end})
            UIToggle:Keybind({Value = "RightShift",Flag = "UI/Keybind", DoNotClear = true})
            UIToggle:Colorpicker({Flag = "UI/Color",Value = {1,0.25,1,0,true},
            Callback = function(HSVAR,Color) Window.Color = Color end})

            MenuSection:Toggle({Name = "Open On Load",Flag = "UI/OOL",Value = true})
            MenuSection:Toggle({Name = "Blur Gameplay",Flag = "UI/Blur",Value = false,
            Callback = function(Bool) Window.Blur = Bool end})

            MenuSection:Toggle({Name = "Watermark",Flag = "UI/Watermark/Enabled",Value = true,
            Callback = function(Bool) Window.Watermark.Enabled = Bool end}):Keybind({Flag = "UI/Watermark/Keybind"})
        end


        local BackgroundSection = OptionsTab:Section({Name = "Background",Side = "Right"}) do
            BackgroundSection:Colorpicker({Name = "Color",Flag = "Background/Color",Value = {1,1,0,0,false},
            Callback = function(HSVAR,Color) Window.Background.ImageColor3 = Color Window.Background.ImageTransparency = HSVAR[4] end})
            BackgroundSection:Textbox({HideName = true,Flag = "Background/CustomImage",Placeholder = "rbxassetid://ImageId",
            Callback = function(String,EnterPressed) if EnterPressed then Window.Background.Image = String end end})
            BackgroundSection:Dropdown({HideName = true,Flag = "Background/Image",List = {
                {Name = "Legacy",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://2151741365"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Hearts",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073763717"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Abstract",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073743871"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Hexagon",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6073628839"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Circles",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6071579801"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Lace With Flowers",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://6071575925"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Floral",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://5553946656"
                    Window.Flags["Background/CustomImage"] = ""
                end,Value = true},
                {Name = "Halloween",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://11113209821"
                    Window.Flags["Background/CustomImage"] = ""
                end},
                {Name = "Christmas",Mode = "Button",Callback = function()
                    Window.Background.Image = "rbxassetid://11711560928"
                    Window.Flags["Background/CustomImage"] = ""
                end}
            }})
            BackgroundSection:Slider({Name = "Tile Offset",Flag = "Background/Offset",Wide = true,Min = 74,Max = 296,Value = 74,
            Callback = function(Number) Window.Background.TileSize = UDim2.fromOffset(Number,Number) end})
        end
    end
end

Window:SetValue("Background/Offset",74)
Window:AutoLoadConfig("Bracket_Example")
Window:SetValue("UI/Enabled",Window.Flags["UI/OOL"])


