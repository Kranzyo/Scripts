local Game = "Anime Fighting Simulator"

getgenv().Config = {

    plr = {
        Speed = 16,
        Jump = 50
    },

    desc = [[
        
    autofarm
    **USE AT YOUR OWN RISK**]]
}
-- docs : https://github.com/GreenDeno/Venyx-UI-Library/blob/main/example.lua
local lp = game:GetService("Players").LocalPlayer
local char = lp.Character
local hum = char.Humanoid
local root = char:FindFirstChild("HumanoidRootPart")

--[[ Backups
https://raw.githubusercontent.com/Discord0000/Venyx-UI-Library/main/thing.lua
https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua
https://raw.githubusercontent.com/sannin9000/Ui-Libraries/main/Venyx 
]]--

-- // anti afk
for i,v in pairs(getconnections(lp.Idled)) do
	v:Disable()
end

if game:GetService("CoreGui"):FindFirstChild(Game) then
    game.CoreGui.Game:Destroy()
end
local venyx = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Venyx.lua"))()
local UI = venyx.new(Game, 5012540643)

-- // Credits
local creditsPage = UI:addPage("Credits", 4102979828)
local creditsSection = creditsPage:addSection("Devs")
local desc = creditsPage:addSection("Description")
creditsSection:addButton("Click for Credits", function()
    UI:Notify("Credits", [[UI - Denosaur @ v3rmillion.net
Script - KayD @ v3rmillion.net /Kranz#0737]])
end)
desc:addButton("Click for description", function()
    UI:Notify("Description", "Game description")
end)

-- // Main stuff
local autoPage = UI:addPage("Auto");
local autoFarms = autoPage:addSection("Auto Farm")

local dragonBalls = autoFarms:addToggle("Toggle", nil, function(v)
    
end)


local misc = UI:addPage("Misc", 5012544961)
local speed_Jump = misc:addSection("Walk Speed/JumpPower")
-- // speed slider
speed_Jump:addSlider("Speed", 16, 16, 300, function(v)
    Config.plr.Speed = v
    hum.WalkSpeed = Config.plr.Speed
end)
-- // jump slider
speed_Jump:addSlider("Jump", 50, 50, 300, function(v)
    Config.plr.Jump = v
    hum.JumpPower = Config.plr.Jump
end)

-- // Settings
local settings = UI:addPage("Settings", 5012544386)
local general = settings:addSection("Toggle Keybind")
general:addKeybind("Toggle Keybind", Enum.KeyCode.P, function()
	UI:toggle()
end)

UI:SelectPage(UI.pages[1], true)
--[[

-- init
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Venyx", 5013109572)

-- first page
local page = venyx:addPage("Test", 5012544693)
local section1 = page:addSection("Section 1")
local section2 = page:addSection("Section 2")

section1:addToggle("Toggle", nil, function(v)
	print("Toggled", v)
end)
section1:addButton("Button", function()
	print("Clicked")
end)
section1:addTextbox("Notification", "Default", function(v, focusLost)
	print("Input", v)

	if focusLost then
		venyx:Notify("Title", v)
	end
end)

section2:addKeybind("Toggle Keybind", Enum.KeyCode.One, function()
	print("Activated Keybind")
	venyx:toggle()
end, function()
	print("Changed Keybind")
end)
section2:addColorPicker("ColorPicker", Color3.fromRGB(50, 50, 50))
section2:addColorPicker("ColorPicker2")

section2:addSlider("Slider", 0, -100, 100, function(v) -- // slider
	print("Dragged", v)
end)
section2:addDropdown("Dropdown", {"Hello", "World", "Hello World", "Word", 1, 2, 3})
section2:addDropdown("Dropdown", {"Hello", "World", "Hello World", "Word", 1, 2, 3}, function(s)
	print("Selected", s)
end)
section2:addButton("Button")


-- load
venyx:SelectPage(venyx.pages[1], true)
]]--