-- // Game: A Universal time

-- docs : https://detourious.gitbook.io/project-finity/docs

-- // proximity prompt by sowd
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
getgenv().Config = {

    itemFarms = {
        "Meteor Farm",
        "Chest Farm",
        "Sand Debris Farm",
        "Item Farm"
    },

    plr = {
        Speed = 16,
        Jump = 50
    },

    farmMethod = nil,
    OnFarm = false,

    desc = [[
        
    A Universal time autofarm
    **USE AT YOUR OWN RISK**]]
}



local lp = game:GetService("Players").LocalPlayer
local char = lp.Character
local hum = char:WaitForChild("Humanoid")
local root = hum:WaitForChild("HumanoidRootPart")

local EnumKeys = {'Semicolon','Tab','Equals','Comma','Minus','Period','F1',"F2","F3","F4",'F5',"F6","F7",
    "F8","F9","F10","F11","F12",'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H',
    'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M','Slash','One','Two','Three',"Four","Five","Six","Seven","Eight",
    "Nine","Zero",'BackSlash','RightBracket','LeftBracket'}

-- // anti afk
for i,v in pairs(getconnections(lp.Idled)) do 
    v:Disable()
end


--[[// functions
local function meteorFarm()
    task.spawn(function()
        while task.wait() do
            if Config.Config.farmMethod == "Meteor Farm" then
                if lp.Character then
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns.Meteors:GetDescendants()) do
                            if v.Name == "Meteor" then
                                root.CFrame = v.CFrame + Vector3.new(0,7,0)
                            end
                        end
                    end
        
                        -- // collection
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns.Meteors:GetDescendants()) do
                        if v:FindFirstChild("Interaction") then
                            fireproximityprompt(v.Interaction, 1, true)
                        end
                    end
                end
            end
        end
    )
end

local function chestFarm()
    task.spawn(function()
        while task.wait() do
            if Config.Config.farmMethod == "Chest Farm" then
                if lp.Character then
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns.Chests:GetDescendants()) do
                        if v.Name == "RootPart" then
                            root.CFrame = v.CFrame + Vector3.new(0,7,0)
                        end
                    end

                        -- // collection
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns.Chests:GetDescendants()) do
                        if v:FindFirstChild("Interaction") then
                            fireproximityprompt(v.Interaction, 1, true)
                        end
                    end
                end
            end
        end 
    end)
end

local function sandDebrisFarm()
    task.spawn(function()
        while task.wait() do
            if Config.Config.farmMethod == "Sand Debris Farm" then
                if lp.Character then
                    print("Sand farming...")
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns["Sand Debris"]:GetDescendants()) do
                        if v.Name == "SandDebris" then
                            root.CFrame = v.CFrame + Vector3.new(0,0,5)
                        end
                    end
            
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns["Sand Debris"]:GetDescendants()) do
                        if v:FindFirstChild("Interaction") then
                            fireproximityprompt(v.Interaction, 1, true)
                        end
                    end
                end
            end
        end
    end)
end

local function itemFarm()
    task.spawn(function()
        while task.wait() do
            if Config.Config.farmMethod == "Item Farm" then
                if lp.Character then
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                        if v.Name == "SpawnLocation" then
                            if #v:GetChildren() > 0 then
                                root.CFrame = v:GetChildren()[1].CFrame
                            end
                        end
                    end
                            
                    for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                        if v:FindFirstChild("Interaction") then
                            fireproximityprompt(v.Interaction, 1, true)
                        end
                    end
                end
            end
        end
    end)
end
]]

if game:GetService("CoreGui"):FindFirstChild("FinityUI") then
    game.CoreGui.FinityUI:Destroy()
end
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/UI-Librarys/main/Finity%20UI%20Lib"))()
local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.Comma)

-- // Credits and stuff
local CreditsCategory = FinityWindow:Category("Credits and stuff")
local uiCreator = CreditsCategory:Sector("Ui Creator:")
local scriptCreator = CreditsCategory:Sector("Script Creator:")
local description = CreditsCategory:Sector("Description:")
uiCreator:Cheat("Label", "Detourious @ v3rmillion.net") 
scriptCreator:Cheat("Label", "KayD @ v3rmillion.net")
description:Cheat("Label", Config.desc)
local Notes = CreditsCategory:Sector("NOTE:")
Notes:Cheat("Label", "Re execute if anything doesn't work")

-- // main
local autofarm = FinityWindow:Category("Autofarm")
local farms = autofarm:Sector("Farms")
-- // Dropdown to select method
farms:Cheat("Dropdown", "Select Farm Method", 
function(s)
    Config.Config.farmMethod = s
    print("Selected", Config.Config.farmMethod)
end,
{
options = Config.itemFarms
})
-- // farm
farms:Cheat("Checkbox", "Farm Selected", 
function(v)
    Config.OnFarm = v

    while Config.OnFarm do
        if Config.farmMethod == "Meteor Farm" then
            print("Meteor farming...")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Meteors:GetDescendants()) do
                if lp.Character then
                    if v.Name == "Meteor" then
                        root.CFrame = v.CFrame + Vector3.new(0,7,0)
                    end
                end
            end

                -- // collection
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Meteors:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end

                repeat task.wait() until Config.OnFarm

        -- // chest farm
        elseif Config.farmMethod == "Chest Farm" then
            print("Chest Farming...")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Chests:GetDescendants()) do
                if v.Name == "RootPart" then
                    root.CFrame = v.CFrame + Vector3.new(0,7,0)
                end
            end

                -- // collection
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Chests:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end

                repeat task.wait() until Config.OnFarm

        elseif Config.farmMethod == "Sand Debris Farm" then
            print("Sand farming...")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns["Sand Debris"]:GetDescendants()) do
                if v.Name == "SandDebris" then
                    root.CFrame = v.CFrame + Vector3.new(0,0,5)
                end
            end

            for i,v in pairs(game:GetService("Workspace").ItemSpawns["Sand Debris"]:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end

                repeat task.wait() until Config.OnFarm
                
        elseif Config.farmMethod == "Item Farm" then
            print("Regular farm....")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                if v.Name == "SpawnLocation" then
                    if #v:GetChildren() > 0 then
                        root.CFrame = v:GetChildren()[1].CFrame
                    end
                end
            end
                    
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end
                repeat task.wait() until Config.OnFarm
                
        end
    end
end)

--[[ idk

        -- // Meteor farm
        
        if Config.farmMethod == "Meteor Farm" then
            print("Meteor farming...")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Meteors:GetDescendants()) do
                if lp.Character then
                    if v.Name == "Meteor" then
                        root.CFrame = v.CFrame + Vector3.new(0,7,0)
                    end
                end
            end

                -- // collection
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Meteors:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end

                repeat task.wait() until Config.OnFarm

        -- // chest farm
        elseif Config.farmMethod == "Chest Farm" then
            print("Chest Farming...")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Chests:GetDescendants()) do
                if v.Name == "RootPart" then
                    root.CFrame = v.CFrame + Vector3.new(0,7,0)
                end
            end

                -- // collection
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.Chests:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end

                repeat task.wait() until Config.OnFarm

        elseif Config.farmMethod == "Sand Debris Farm" then
            print("Sand farming...")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns["Sand Debris"]:GetDescendants()) do
                if v.Name == "SandDebris" then
                    root.CFrame = v.CFrame + Vector3.new(0,0,5)
                end
            end

            for i,v in pairs(game:GetService("Workspace").ItemSpawns["Sand Debris"]:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end

                repeat task.wait() until Config.OnFarm
                
        elseif Config.farmMethod == "Item Farm" then
            print("Regular farm....")
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                if v.Name == "SpawnLocation" then
                    if #v:GetChildren() > 0 then
                        root.CFrame = v:GetChildren()[1].CFrame
                    end
                end
            end
                    
            for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                if v:FindFirstChild("Interaction") then
                    fireproximityprompt(v.Interaction, 1, true)
                end
            end
                repeat task.wait() until Config.OnFarm
                
        end]]
--[[ previous stuff

                        for i,v in pairs(game:GetService("Workspace").ItemSpawns.StandardItems:GetDescendants()) do
                                    if v.Name == "SpawnLocation" then
                                        root.CFrame = v.CFrame
                                    end
                                end
                    ]]

-- // Misc
local misc = FinityWindow:Category("Misc")
local SpeednJump = misc:Sector("Speed & Jump")
local godMode = misc:Sector("God Mode")

-- // Walk speed and Jump power changer
SpeednJump:Cheat("Slider", "Walk Speed", function(s)
    Config.plr.Speed = s
end, {min = 16, max = 250, suffix = " Walk Speed"})
SpeednJump:Cheat("Slider", "Jump Power", function(s)
    Config.plr.Jump = s
end, {min = 50, max = 250, suffix = " Jump Power"})
SpeednJump:Cheat("Checkbox", "Start Walk/jump power", function(s)
yes = s
    while yes do task.wait()
        if lp.Character then
            hum.WalkSpeed = Config.plr.Speed
            hum.JumpPower = Config.plr.Jump
        end   
    end
end)

-- // god mode
godMode:Cheat("Button", "God Mode", function()
    game:GetService("Players").LocalPlayer.Character.Values.Block:Destroy()
end)


-- // Settings
local Settings = FinityWindow:Category("Settings")
local ChangeToggleKey = Settings:Sector("Change Toggle")
ChangeToggleKey:Cheat("Dropdown", "Change Toggle Key", 
function(s)
    FinityWindow.ChangeToggleKey(Enum.KeyCode[s])
end,
{
options = EnumKeys
})

-- // delete gui button
local deletegui = Settings:Sector("Deletegui")
deletegui:Cheat("Button", "Delete GUI", function()
    game.CoreGui.FinityUI:Destroy()
end)




-- // Examples?

--[[
    S1:Cheat("Slider", "Render Distance", function(v)--Slider
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
    end
    )
    ]]
