--Game: a one piece game

-- lost motivation

-- docs : https://detourious.gitbook.io/project-finity/docs
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character
local hum = char.Humanoid
local root = char:FindFirstChild("HumanoidRootPart")

-- services
local ts = game:GetService("TweenService")


local desc = [[
    **USE AT YOUR OWN RISK**
]]

local EnumKeys = {'Semicolon','Tab','Equals','Comma','Minus','Period','F1',"F2","F3","F4",'F5',"F6","F7",
    "F8","F9","F10","F11","F12",'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H',
    'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M','Slash','One','Two','Three',"Four","Five","Six","Seven","Eight",
    "Nine","Zero",'BackSlash','RightBracket','LeftBracket'}

getgenv().Config = {
    quests = {
        selected = "Bandit",
        autoQuest = false,
        autoTping = false,
        hasQuest = false
    },

    moveSpams = {
        e = false,
        q = false,
        r = false,
        f = false,
    }
    
}

getgenv().lists = {
    quests = {'Bandit', 'Noob', 'Monkey', 'Gorilla', 'Bandit Leader'}
}
-- config module
local ConfigSystem = Debug and loadfile("Modules/ConfigSystem.lua")() or loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/ConfigSystem.lua"))()
-- config system
local function SaveConfig()
    if isfile("Kranz's Scripts/aopg's Config.json") then
        ConfigSystem.WriteJSON(Config, "Kranz's Scripts/aopg's Config.json")

    else
        makefolder("Kranz's Scripts")
        ConfigSystem.WriteJSON(Config, "Kranz's Scripts/aopg's Config.json")
    end
end

local function LoadConfig()
    if isfile("Kranz's Scripts/aopg's Config.json") then
        getgenv().Config = ConfigSystem.ReadJSON("Kranz's Scripts/aopg's Config.json", Config)

    else
        makefolder("Kranz's Scripts")
        ConfigSystem.WriteJSON(Config, "Kranz's Scripts/aopg's Config.json")
    end
end


-- // functions
for i,v in pairs(getconnections(lp.Idled)) do
	v:Disable()
end

local function GetTime(Distance, Speed)
    local time = Distance / Speed
    return time
end

-- // getting the char when ded
lp.CharacterAdded:Connect(function(Character)
    char = Character
    hum = Character:WaitForChild("Humanoid")
    root = Character:WaitForChild("HumanoidRootPart")
end)

function enemy()
    for _,v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
        if v.Name == Config.quests.selected then
            return v
        end
    end
end

if game:GetService("CoreGui"):FindFirstChild("FinityUI") then
    game.CoreGui.FinityUI:Destroy()
end

--[[ Back up
https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Finity%20Ui
https://raw.githubusercontent.com/bloodball/UI-Librarys/main/Finity%20UI%20Lib
]]

LoadConfig()
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Finity%20Ui.lua"))()
local FinityWindow = Finity.new(true, "A one piece game script by Kranz#0737", UDim2.new(0, 500, 0, 200)) -- name of thing
FinityWindow.ChangeToggleKey(Enum.KeyCode.Semicolon)

-- // Credits and stuff
local CreditsCategory = FinityWindow:Category("Credits and stuff")
local uiCreator = CreditsCategory:Sector("Ui Creator:")
local scriptCreator = CreditsCategory:Sector("Script Creator:")
local description = CreditsCategory:Sector("Description:")

-- // Text for credits
uiCreator:Cheat("Label", "Detourious @ v3rmillion.net") 
scriptCreator:Cheat("Label", "KayD @ v3rmillion.net")
description:Cheat("Label", desc)

-- // Main 
local main = FinityWindow:Category("Main")
local first = main:Sector("first")

first:Cheat("Dropdown", "Quest n Npc Select", function(s)
    Config.quests.selected = s
end, {
    options = lists.quests
})
first:Cheat("Checkbox", "auto quest", function(s)
    Config.quests.autoQuest = s

    

    Config.quests.hasQuest = true
    while Config.quests.autoQuest and Config.quests.hasQuest do task.wait()
        questIndex = 1
        npc = 'Quest Dummy 1'

        if Config.quests.selected == 'Bandit' then
                questIndex = 1
                npc = 'Quest Dummy 1'
        elseif Config.quests.selected == 'Noob' then
                questIndex = 2
                npc = 'Quest Dummy 1'
        elseif Config.quests.selected == 'Monkey' then
                questIndex = 3
                npc = 'Quest Dummy 1'
        elseif Config.quests.selected == 'Gorilla' then
                questIndex = 4
                npc = 'Quest Dummy 1'
        elseif Config.quests.selected == 'Bandit Leader' then
                questIndex = 5
                npc = 'Quest Dummy 1'
        end
        
        local args = {
            [1] = "Accept",
            [2] = {
                ["Index"] = questIndex,
                ["Model"] = workspace.Interactables:FindFirstChild(npc):FindFirstChild(npc)
            }
        }

        game:GetService("ReplicatedStorage").Remotes.quest:FireServer(unpack(args))

    end
end)

first:Cheat("Checkbox", "auto tp", function(s)
    Config.quests.autoTping = s

    while Config.quests.autoTping do task.wait()
        for _,v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
            if v.Name == Config.quests.selected then
                
                repeat task.wait()
                    local speed = 100
                    local distance = (v.PrimaryPart.Position - root.Position).magnitude
                    local time = GetTime(distance, speed)
                    ts:Create(root, TweenInfo.new(time), {CFrame = v.PrimaryPart.CFrame + Vector3.new(0, 10, 5)}):Play()
                until v.PrimaryPart == nil or v:FindFirstChildOfClass("Humanoid").Health < 1 or Config.quests.autoTping == false
            end
        end
    end
end)

first:Cheat("Checkbox", "auto attack", function(s)
    Config.quests.autoAttacking = s

    while Config.quests.autoAttacking do task.wait()
        for _,v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
            if v.Name == Config.quests.selected then
                repeat task.wait()
                    local args = {
                        [1] = "Fighting Style",
                        [2] = "MouseButton1",
                        [3] = root.CFrame,
                        [4] = workspace.Map.Islands:FindFirstChild("Starter Island").Model:FindFirstChild("Starter island").MeshPart,
                        [5] = 5
                    }
                    
                    game:GetService("ReplicatedStorage").Remotes.requestAbility:FireServer(unpack(args))
                until v.PrimaryPart == nil or Config.quests.autoAttacking == false
            end
        end
    end
end)



first:Cheat("Checkbox", "Devil Fruit spam key: E", function(s)
    Config.moveSpams.e = s

    while Config.moveSpams.e do task.wait()
        local args = {
            [1] = "Devil Fruit",
            [2] = "E",
            [3] = root.CFrame,
            [4] = workspace.Map.Islands:FindFirstChild("Starter Island").Model:FindFirstChild("Starter island").MeshPart,
            [5] = 5
        }
        
        game:GetService("ReplicatedStorage").Remotes.requestAbility:FireServer(unpack(args))
    end
end)

first:Cheat("Checkbox", "Devil Fruit spam key: Q", function(s)
    Config.moveSpams.q = s

    while Config.moveSpams.q do task.wait()
        local args = {
            [1] = "Devil Fruit",
            [2] = "Q",
            [3] = root.CFrame,
            [4] = workspace.Map.Islands:FindFirstChild("Starter Island").Model:FindFirstChild("Starter island").MeshPart,
            [5] = 5
        }
        
        game:GetService("ReplicatedStorage").Remotes.requestAbility:FireServer(unpack(args))
    end
end)

first:Cheat("Checkbox", "Devil Fruit spam key: R", function(s)
    Config.moveSpams.r = s

    while Config.moveSpams.r do task.wait()
        local args = {
            [1] = "Devil Fruit",
            [2] = "R",
            [3] = root.CFrame,
            [4] = workspace.Map.Islands:FindFirstChild("Starter Island").Model:FindFirstChild("Starter island").MeshPart,
            [5] = 5
        }
        
        game:GetService("ReplicatedStorage").Remotes.requestAbility:FireServer(unpack(args))
    end
end)

first:Cheat("Checkbox", "Devil Fruit spam key: F", function(s)
    Config.moveSpams.f = s

    while Config.moveSpams.f do task.wait()
        local args = {
            [1] = "Devil Fruit",
            [2] = "F",
            [3] = root.CFrame,
            [4] = workspace.Map.Islands:FindFirstChild("Starter Island").Model:FindFirstChild("Starter island").MeshPart,
            [5] = 5
        }
        
        game:GetService("ReplicatedStorage").Remotes.requestAbility:FireServer(unpack(args))
    end
end)

local tps = FinityWindow:Category("Teleports")
local islands = tps:Sector("Islands")

for i,v in pairs(game:GetService("Workspace").Visuals:GetChildren()) do
    islands:Cheat("Button", v.Name, function()
        root.CFrame = v.CFrame
    end)
end
-- // misc
local misc = FinityWindow:Category("Misc")
local speed_Jump = misc:Sector("Speed/Jump")
local miscSec = misc:Sector("Misc")

miscSec:Cheat("Button", "Get Nearest Chest", function()
    for _,v in pairs(game.Workspace.Map.Islands:GetDescendants()) do
        if v:IsA('ClickDetector') and v.Parent.Name ~= "Crystal" then
            print("found clickdetector for chest")
            v.MaxActivationDistance = math.huge
            local speed = 700
            local distance = (v.Parent.Position - root.Position).magnitude
            local time = GetTime(distance, speed)
            ts:Create(root, TweenInfo.new(time), {CFrame = v.Parent.CFrame}):Play()

            repeat task.wait()
                fireclickdetector(v)
            until v.Parent == nil
        end
    end
end)

miscSec:Cheat("Button", "Lag Remover", function()
    settings().Rendering.QualityLevel = 'Level01'
    workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
    workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
    workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
    workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
    setscriptable(workspace:FindFirstChildOfClass('Terrain'), "Decoration", true)
    sethiddenproperty(workspace:FindFirstChildOfClass('Terrain'), "Decoration", false)
    game:GetService("Lighting").GlobalShadows = false
    game:GetService("Lighting").FogEnd = 9e9
    for i,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA('Texture') then
            v:Destroy()
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        end
    end
    for i,v in pairs(game:GetService("Lighting"):GetDescendants()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
            v:Destroy()
        end
    end
    workspace.DescendantAdded:Connect(function(child)
        coroutine.wrap(function()
            if child:IsA('ForceField') then
                game:GetService('RunService').Heartbeat:Wait()
                child:Destroy()
            elseif child:IsA('Sparkles') then
                game:GetService('RunService').Heartbeat:Wait()
                child:Destroy()
            elseif child:IsA('Smoke') or child:IsA('Fire') then
                game:GetService('RunService').Heartbeat:Wait()
                child:Destroy()
            end
        end)()
    end)
end)

-- // Cheat for jump and speed
speed_Jump:Cheat("Slider", "Speed", function(v)
    getgenv().Speed = v
end, {min = 16, max = 250, suffix = " Speed"})

speed_Jump:Cheat("Slider", "Jump", function(v)
    getgenv().Jump = v
end, {min = 50, max = 250, suffix = " JumpPower"})

speed_Jump:Cheat("Checkbox", "Activate Speed/Jump", function(state) 
    while state do
       task.wait()
        hum.WalkSpeed = Speed
        hum.JumpPower = Jump
    end
end)

-- // OR
--[[
    speed_Jump:Cheat("Button", "Activate Speed/Jump", function(v) 
    hum.WalkSpeed = Speed
    hum.JumpPower = Jump
end)
]]--

-- // Settings
local Settings = FinityWindow:Category("Settings")
local generalSettings = Settings:Sector("General")

generalSettings:Cheat("Dropdown", "Change Toggle Key", 
function(Option)
    FinityWindow.ChangeToggleKey(Enum.KeyCode[Option])
end,
{
options = EnumKeys
})

generalSettings:Cheat("Button", "Delete GUI", function() --Button
    game:GetService("CoreGui").FinityUI:Destroy()
    end)


--Examples

--[[
    S1:Cheat("Slider", "Render Distance", function(v) --Slider
    print("Silder value changed:", v)
    end, {min = 0, max = 1500, suffix = " studs"})
    
    
    S1:Cheat("Dropdown", "ESP Color", function(Option) --Dropdowns
    print("Dropdown option changed:", Option)
    end, {
    options = {
    "Red",
    "White",
    "Green",
    "Pink",
    "Blue"
    }
    })
    

    S1:Cheat("Textbox", "Item To Whitelist", function(v) --Textbox
    print("Textbox value changed:", v)
    end, {
    placeholder = "Item Name"
    })
    
    S1:Cheat("Button", "Reset Whitelist", function() --Button
    print("Button pressed")
    end)
    
    Check box code :
    S1:Cheat("Checkbox","Name",
    function(State)
        if not State then
            _G.on = 0
        else
            _G.on = 1
        end
        while _G.on == 1 do
            game:GetService('RunService').Stepped:wait()
        end
    end)
    
    -- Default color
Sector:Cheat("ColorPicker", "Color", function(Color) -- Color picker
  print("Color changed: " .. "R:" .. tostring(Color.R) .. "; G:" .. tostring(Color.G) .. "; B:" .. tostring(Color.B))
end, {
  color = Color3.new(0, 1, 0) -- Bright green
})

Keybind cheat type
Cheat menus are now scrollable when they are too big
New dropdown methods to allow for more dynamic options
    ^ Dropdown:AddOption(String ValueToAdd)
    ^ Dropdown:RemoveOption(String ValueToRemove)
    ^ Dropdown:SetValue(String Value) <-- Value doesn't have to exist as an option
Customizable background image
    ^ Window:ChangeBackgroundImage(String AssetURL [, Number Transparency])
New constructor parameters
    ^ Finity.new([Boolean IsDarkMode, String ProjectName, Boolean SingleColumn])
        ^ Setting the ProjectName will change the text at the top of the window
        ^ Setting the SingleColumn boolean to a UDim2 value allows for a custom window size

Bind pseudo-code:
-- No default bind
Sector:Cheat("Keybind", "Label Text", function(KeyCode)
    print("Keybind pressed: " .. KeyCode.Name)
end)

- With default bind
Sector:Cheat("Keybind", "Label Text", function(KeyCode)
    print("Keybind pressed: " .. KeyCode.Name)
end, {
    bind = DefaultBind -- KeyCode, ex: "Enum.KeyCode.LeftShift"
})

Color-picker pseudo-code:
-- No default color
Sector:Cheat("ColorPicker", "Color", function(Color)
  print("Color changed: " .. "R:" .. tostring(Color.R) .. "; G:" .. tostring(Color.G) .. "; B:" .. tostring(Color.B))
end)


-

]]
    