-- // Game: Islands

local gameName = "Islands" -- put game

-- docs for lib: https://github.com/GreenDeno/Venyx-UI-Library/blob/main/example.lua

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local lp = PlayerService.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

lp.CharacterAdded:Connect(function(character)
	char = character
	hum = character:WaitForChild("Humanoid")
	root = character:WaitForChild("HumanoidRootPart")
end)

-- config module
local ConfigSystem = Debug and loadfile("Modules/ConfigSystem.lua")() or loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/ConfigSystem.lua"))()
-- config system
local function SaveConfig()
	if isfile("Kranz's Scripts/Island's Config.json") then
		ConfigSystem.WriteJSON(Config, "Kranz's Scripts/Island's Config.json")

	else
		makefolder("Kranz's Scripts")
		ConfigSystem.WriteJSON(Config, "Kranz's Scripts/Island's Config.json")
	end
end

local function LoadConfig()
	if isfile("Kranz's Scripts/Island's Config.JSON") then
		getgenv().Config = ConfigSystem.ReadJSON("Kranz's Scripts/Island's Config.json", Config)

	else
		makefolder("Kranz's Scripts")
		ConfigSystem.WriteJSON(Config, "Kranz's Scripts/Island's Config.json")
	end
end

local island = game:GetService("Workspace").Islands:GetChildren()[1]


getgenv().Config = {

	themes = {
		Background = Color3.fromRGB(24, 24, 24),
		Glow = Color3.fromRGB(0, 0, 0),
		Accent = Color3.fromRGB(10, 10, 10),
		LightContrast = Color3.fromRGB(20, 20, 20),
		DarkContrast = Color3.fromRGB(14, 14, 14),  
		TextColor = Color3.fromRGB(255, 255, 255)
	},

	islandTpList = {
		"Portal"

	},
	autoMineList = {
		"rockCoal",
		"rockGold",
		"rockIron",
		"rockStone",
		"rockPrismarine"
	},
	autoMineSelection = "",
	autoMining = false,
	islandTpSelection = "",
}



--[[ Backups
https://raw.githubusercontent.com/Discord0000/Venyx-UI-Library/main/thing.lua
https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua
https://raw.githubusercontent.com/sannin9000/Ui-Libraries/main/Venyx 
]]--

-- making the list for me hehe
task.spawn(function()
	for i,v in pairs(game:GetService("Workspace").spawnPrefabs.PortalDestinations:GetChildren()) do
		Config.islandTpList[1+i] = tostring(v)
	end
end)
-- tp to main island and back to load stuff cuz islands stupid
task.spawn(function()
	root.CFrame = CFrame.new(-76.4506836, 46.7478752, -621.069397, 0.814922869, 4.50604709e-08, 0.579569459, -4.02935241e-09, 1, -7.20825781e-08, -0.579569459, 5.64064493e-08, 0.814922869)
	task.wait(.5)
	root.CFrame = CFrame.new(-7494, 37.699955, -7515, 1, -6.6518574e-10, 5.88613042e-16, 6.6518574e-10, 1, -8.8171646e-08, -5.29962522e-16, 8.8171646e-08, 1)
end)

-- // anti afk
for i,v in pairs(getconnections(lp.Idled)) do
	v:Disable()
end

if game:GetService("CoreGui"):FindFirstChild(gameName) then
    game.CoreGui[gameName]:Destroy()
end

LoadConfig()
-- ui lib
local venyx = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kranzyo/UI-Libraries/main/Venyx.lua"))()
local UI = venyx.new(gameName)


-- // Credits
local creditsPage = UI:addPage("Credits", 5012544693)

local creditsSection = creditsPage:addSection("Devs")
local desc = creditsPage:addSection("Description")
creditsSection:addButton("Click for Credits", function()
    UI:Notify("Credits", [[UI - Denosaur @ v3rmillion.net
Script - KayD @ v3rmillion.net /Kranz#0737]])
end)
desc:addButton("Click for description", function()
    UI:Notify("Description", "Island's Script ig")
end)

-- // Main stuff
local autofarmPage = UI:addPage("Farming", 9097098907)
local autoMiner = autofarmPage:addSection("Auto Miner")
autoMiner:addDropdown("Select", Config.autoMineList, function(v)
	Config.autoMineSelection = v
end)
autoMiner:addToggle("Auto Mine", nil, function(v)
	Config.autoMining = v

	while Config.autoMining do
		if char then
			if Config.autoMineSelection == Config.autoMineSelection then
				for i,v in pairs(workspace.WildernessBlocks:GetChildren()) do
					if v.Name == Config.autoMineSelection then
						repeat task.wait() 

							root.CFrame = v.CFrame + Vector3.new(0,5,0)

							local args = {
								[1] = {
									["player_tracking_category"] = "join_from_web",
									["part"] = v,
									["block"] = v,
									["norm"] = v.Position,
									["pos"] = v.Position
								}
							}

							game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
						
						until v.Parent == nil or Config.autoMining == false
					end
				end

				repeat task.wait() until Config.autoMining
			end
		end
	end
end)

-- // Teleports
local teleportPage = UI:addPage("Teleports", 5012543481)
local islandTeleports = teleportPage:addSection("Teleports")

islandTeleports:addDropdown("Teleports", Config.islandTpList, function(v)
	Config.islandTpSelection = v
	
	print(Config.islandTpSelection)
	if Config.islandTpSelection == "Portal" then
		if char then
				-- checking for distance and then tweens to which is closest
			if  (root.Position - game:GetService("Workspace").spawnPrefabs["Main Island"].portalToIsland.Root.Position).magnitude < (root.Position - game:GetService("Workspace").Islands["2ba88dec-db21-4123-a5b4-3c5a7e0e2dd5-island"].Blocks.portalToSpawn.Position).magnitude then
				root.CFrame = game:GetService("Workspace").spawnPrefabs["Main Island"].portalToIsland.Root.CFrame
			elseif (root.Position - game:GetService("Workspace").spawnPrefabs["Main Island"].portalToIsland.Root.Position).magnitude > (root.Position - game:GetService("Workspace").Islands["2ba88dec-db21-4123-a5b4-3c5a7e0e2dd5-island"].Blocks.portalToSpawn.Position).magnitude then
				root.CFrame = island.Blocks.portalToSpawn.CFrame
			end
		end

	elseif Config.islandTpSelection == "Slime King" then
		if char then
			root.CFrame = game:GetService("Workspace").spawnPrefabs.WildEventTriggers["slime_king_spawn"].CFrame
		end

	elseif Config.islandTpSelection == Config.islandTpSelection then
		if char then
			root.CFrame = game:GetService("Workspace").spawnPrefabs.PortalDestinations[Config.islandTpSelection].CFrame
		end
	end
end)


-- // Misc
local misc = UI:addPage("Misc", 5012544944)
local speed_Jump = misc:addSection("Walk Speed/JumpPower")
-- // jump slider
speed_Jump:addSlider("Jump", 50, 50, 250, function(v)
    getgenv().Jump = v
end)
speed_Jump:addToggle("Activate Speed/Jump", nil, function(v)
	speedOn = v
    while speedOn do task.wait()
		if char then
			hum.JumpPower = Jump
		end
    end
end)

local antiLagSec = misc:addSection("AntiLag Section")
antiLagSec:addButton("Click to Enable", function()
	workspace:FindFirstChildOfClass('Terrain').WaterWaveSize = 0
	workspace:FindFirstChildOfClass('Terrain').WaterWaveSpeed = 0
	workspace:FindFirstChildOfClass('Terrain').WaterReflectance = 0
	workspace:FindFirstChildOfClass('Terrain').WaterTransparency = 0
	sethiddenproperty(workspace:FindFirstChildOfClass('Terrain'), "Decoration", false)
	game:GetService("Lighting").GlobalShadows = false
	game:GetService("Lighting").FogEnd = 9e9
	settings().Rendering.QualityLevel = 1
	for i,v in pairs(game:GetDescendants()) do
		if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
			v.Material = "Plastic"
			v.Reflectance = 0
		elseif v:IsA("Decal") then
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

-- // Settings
local settings = UI:addPage([[Setting n
Themes]], 5012544372)
local themeChanger = settings:addSection("Theme Colors")

for theme, color in pairs(Config.themes) do
	themeChanger:addColorPicker(theme, color, function(color3)
		color = color3 
		Config.themes[theme] = color3
		UI:setTheme(theme, Config.themes[theme])
	end)
end

local general = settings:addSection("General")
general:addKeybind("Toggle Keybind", Enum.KeyCode.P, function()
	UI:toggle()
end)

general:addButton("Delete GUI", function()
	game.CoreGui[gameName]:Destroy()
end)


for theme, color in pairs(Config.themes) do
	UI:setTheme(theme, color)
end
-- load
UI:SelectPage(UI.pages[1], true)

PlayerService.PlayerRemoving:Connect(function(plr)
	if plr == lp then SaveConfig() end
end)
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
		venyx:Notify("Title", v) -- Notification
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