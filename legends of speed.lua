--Game: Legends Of speed

-- docs : https://detourious.gitbook.io/project-finity/docs
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character
local hum = char.Humanoid
local root = char:FindFirstChild("HumanoidRootPart")
 
-- script variables
local cities = {
    "Main City",
    "Snow City",
    "Magma City",
    "Legends Highway"
}
getgenv().autofarm = false
getgenv().hoops = false
getgenv().rebirthtoggle = false

getgenv().cityorb = false
getgenv().snoworb = false
getgenv().magmaorb = false
getgenv().legendsorb = false

getgenv().selectcity = false

--[[
    for i,v in pairs(game:GetService("Workspace").orbFolder:GetDescendants()) do
        if v.Name == "TouchInterest" and v.Parent then
            firetouchinterest(char.Head , v.Parent, 0)
        end
    end
]]--
local desc = [[

    has anti afk btw
    **USE AT YOUR OWN RISK**
]]
local EnumKeys = {'Semicolon','Tab','Equals','Comma','Minus','Period','F1',"F2","F3","F4",'F5',"F6","F7",
    "F8","F9","F10","F11","F12",'Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P', 'A', 'S', 'D', 'F', 'G', 'H',
    'J', 'K', 'L', 'Z', 'X', 'C', 'V', 'B', 'N', 'M','Slash','One','Two','Three',"Four","Five","Six","Seven","Eight",
    "Nine","Zero",'BackSlash','RightBracket','LeftBracket'}


-- // functions

local function City()
    spawn(function()
        while wait(0.1) do
            if not autofarm then break end

            for i,v in pairs(game:GetService("Workspace").orbFolder.City:GetDescendants()) do
                if v.Name == "TouchInterest" then
                    firetouchinterest(char.Head, v.Parent, 0)
                end
            end
        end
    end)
end

local function Snow()
    spawn(function()
        while wait(0.1) do
            if not autofarm then break end

            for i,v in pairs(game:GetService("Workspace").orbFolder["Snow City"]:GetDescendants()) do
                if v.Name == "TouchInterest" then
                    firetouchinterest(char.Head, v.Parent, 0)
                end
            end
        end
    end)
end

local function Magma()
    spawn(function()
        while task.wait(.1) do
            if not autofarm then break end

            for i, v in pairs(game:GetService("Workspace").orbFolder["Magma City"]:GetDescendants()) do
                if v.Name == "TouchInterest" then
                    firetouchinterest(char.Head, v.Parent, 0)
                end
            end
        end
    end)
end

local function LegendsHighway()
    spawn(function()
        while task.wait(.1) do
            if not autofarm then break end

            for i, v in pairs(game:GetService("Workspace").orbFolder["Legends Highway"]:GetDescendants()) do
                if v.Name == "TouchInterest" then
                    firetouchinterest(char.Head, v.Parent, 0)
                end
            end
        end
    end)
end

local function Hoops()
    spawn(function()
        while task.wait() do
            if not autofarm then break end
            for i, v in pairs(game:GetService("Workspace").Hoops:GetDescendants()) do
                if v.Name == "TouchInterest" then
                    firetouchinterest(char.Head, v.Parent, 0)
                    task.wait(0.1)
                    firetouchinterest(char.Head, v.Parent, 1)
                end
            end
        end
    end)
end

local function rebirth()
    spawn(function()
        while task.wait(5) do
            if not rebirthtoggle then break end
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
        end
    end)
end

local function tp(city)
    if city == "Main City" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9682.98828, 74.8522873, 3099.03394, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
    elseif city == "Snow City" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-9676.13867, 74.8522873, 3782.69385, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    elseif city == "Magma City" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-11054.9688, 232.791656, 4898.62842, -0.0872479677, 0.000158954252, -0.996186614, -0.00054083002, 0.999999821, 0.00020692969, 0.996186495, 0.000556821818, -0.0872478485)
    elseif city == "Legends Highway" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-13098.8711, 232.791656, 5907.62793, -0.0872479677, 0.000158954252, -0.996186614, -0.00054083002, 0.999999821, 0.00020692969, 0.996186495, 0.000556821818, -0.0872478485)
    end
end

-- // anti afk
for i,v in pairs(getconnections(lp.Idled)) do
	v:Disable()
end

if game:GetService("CoreGui"):FindFirstChild("FinityUI") then
    game.CoreGui.FinityUI:Destroy()
end
--[[ Back up : 
https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Finity%20Ui
https://raw.githubusercontent.com/bloodball/UI-Librarys/main/Finity%20UI%20Lib
]]
local Finity = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Finity%20Ui.lua"))()
local FinityWindow = Finity.new(true)
FinityWindow.ChangeToggleKey(Enum.KeyCode.BackSlash)

-- // Credits and stuff
local CreditsCategory = FinityWindow:Category("Credits and stuff")
local uiCreator = CreditsCategory:Sector("Ui Creator:")
local scriptCreator = CreditsCategory:Sector("Script Creator:")
local description = CreditsCategory:Sector("Description:")

-- // Text for credits
uiCreator:Cheat("Label", "Detourious @ v3rmillion.net") 
scriptCreator:Cheat("Label", "KayD @ v3rmillion.net")
description:Cheat("Label", desc)

-- // Main stuff
local autos = FinityWindow:Category("Autos")
local autosector = autos:Sector("Farms")

autosector:Cheat("Dropdown", "Select City", function(v)
    selectcity = v
    print("city selection is", selectcity)

    if selectcity == "Main City" then
        cityorb = true
        City()
    elseif selectcity == "Snow City" then
        snoworb = true
        Snow()
    elseif selectcity == "Magma City" then
        magmaorb = true
        Magma()
    elseif selectcity == "Legends Highway" then
        legendsorb = true
        LegendsHighway()
    end
end, {
    options = cities
})

autosector:Cheat("Checkbox", "Autofarm", function(v)
    autofarm = v
    print("auto state is", autofarm)
    if autofarm then
        if selectcity == "Main City" then
            City()
        elseif selectcity == "Snow City" then
            Snow()
        elseif selectcity == "Magma City" then
            Magma()
        elseif selectcity == "Legends Highway" then
            LegendsHighway()
        end
        Hoops()
    end
end)


autosector:Cheat("Label", "Note: You farm what you have selected in the dropdown")


-- // rebirth toggle
autosector:Cheat("Checkbox", "Rebirth toggle", function(v)
    rebirthtoggle = v
    if rebirthtoggle then
        rebirth()
    end
end)


--// teleports

local teleport = FinityWindow:Category("Teleports")
local CitesTp = teleport:Sector("Cities")

CitesTp:Cheat("Dropdown", "Cities", function(v)
    tpTo = v

    if tpTo == "Main City" then
        tp("Main City")
    elseif tpTo == "Snow City" then
    	tp("Snow City")
    	
    elseif tpTo == "Magma City" then
    	tp("Magma City")
    	
    elseif tpTo == "Legends Highway" then
    	tp("Legends Highway")
    end
end, {
    options = cities
})

-- // speed/ jump
local misc = FinityWindow:Category("Misc")
local speed_Jump = misc:Sector("Speed/Jump")

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
local ChangeToggleKey = Settings:Sector("Change Toggle")

local delete = Settings:Sector("Deletion")

ChangeToggleKey:Cheat("Dropdown", "Change Toggle Key", 
function(Option)
    FinityWindow.ChangeToggleKey(Enum.KeyCode[Option])
end,
{
options = EnumKeys
})

delete:Cheat("Button", "Delete GUI", function()
    game.CoreGui.FinityUI:Destroy()
end)

