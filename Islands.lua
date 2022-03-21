repeat task.wait() until game.isLoaded
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
    Farming = {
        autoMineSelection = "(Select/None)",
        autoMining = false,
        autoMiningIsland = false,

        islandTpSelection = "(Select/None)",

        autoCropping = false,
        autoCropSelection = "(Select/None)",
        autoPlanting = false,
        autoHiving = false
    },
    Machinery = {
        autoPicking = false,
        autoMachineryMetalInserting = false,
        autoMachineryCoalInserting = false,
        autoMachineryItemSelection = "(Select/None)",
        autoMachineryFurnaceSelection = "(Select/None)"
        
    },
    Misc = {
        autoPlowing = false,
        autoUnplowing = false,
        plowDistance = 10
    },

    KeyBinds = {
        ToggleBind = "RightShift"
    }

}

getgenv().ScriptList = {
    islandTpList = {
        "Home",
        "Hub",
        "Slime King",
        "Slime Island",
        "Buffalkor Island",
        "Pirate Island",
        "Wizard Island",
        "Desert Island",
        "Spirit Island",
        "Diamond Mine"
    },
    autoMineList = {
        "rockCoal",
        "rockGold",
        "rockIron",
        "rockStone",
		"rockDiamond",
        "rockPrismarine",
		"rockSandstone",
		"rockSandstoneRed"
    },
    cropList = {
        "wheat",
        "horseradish",
        "tomato",
        "pumpkin",
        "starfruit",
        "potato",
        "avocado",
        "carrot",
        "Candy Cane",
        "rice",
        "coconut",
        "spirit"
    },
    BerryList = {
        "Berries",
        "Blueberries",
        "Blackberries"
    },

    fruitList = {
        "Apple",
        "Orange",
        "Lemon",
        "Plum"
    },
    -- autoEquipPicList = {
        
    -- },
    -- autoEquipList = {
    --     "woodSword",
    --     "stoneSword",
    --     "woodPickaxe",
    --     "stonePickaxe",
    --     "gildedSteelPickaxe",
    --     "diamondPickaxe"
    -- },
    autoMachineryItemList = {
        "iron",
        "gold",
        "bambooDried"
    },
    autoMachineryFurnaceList = {
        "smallFurnace"
    }

}


--[[ Backups
https://raw.githubusercontent.com/Discord0000/Venyx-UI-Library/main/thing.lua
https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua
https://raw.githubusercontent.com/sannin9000/Ui-Libraries/main/Venyx 
]]--

-- // anti afk
task.spawn(function()
    for i, v in pairs(getconnections(lp.Idled)) do
        v:Disable()
    end
end)

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
    UI:Notify("Credits", "UI - Denosaur @ v3rmillion.net \nScript - KayD @ v3rmillion.net /Kranz#0737")
end)
desc:addButton("Important Info", function()
    UI:Notify("Stuff", Config.KeyBinds.ToggleBind.." for toggle")
end)

-- // Main stuff
local autofarmPage = UI:addPage("Farming", 9097098907)

-- // Auto Crop
local autoCrop = autofarmPage:addSection("Auto Crop")
autoCrop:addDropdown("Select Crop", ScriptList.cropList, function(v)
    Config.Farming.autoCropSelection = v
    print(Config.Farming.autoCropSelection)
end)

local replantCount = 0
local cropLoopCount = 0 
local currentCropPos = {}
local currentCrop = {}
autoCrop:addToggle("Auto Crops", nil, function(v)
    Config.Farming.autoCropping = v
	if island.Blocks[Config.Farming.autoCropSelection] then
		root.CFrame = island.Blocks[Config.Farming.autoCropSelection].CFrame
	end

    local args = {
        [1] = "sickleStone",
        [2] = {
                        
            }
    }
    
	while Config.Farming.autoCropping do
        for i,v in pairs(island.Blocks:GetChildren()) do
            if island.Blocks[Config.Farming.autoCropSelection] then
                if v.Name == Config.Farming.autoCropSelection then
                        table.insert(currentCrop, v)
                        table.insert(currentCropPos, v.CFrame)
                    --    print(#args[2],' ', #currentCrop)

                    -- cropLoopCount for how many time for loop is run for later checking
                    cropLoopCount = cropLoopCount + 1
                end 
			end
        end

        
        -- placing into args[2] currentCrop values
        task.spawn(function()
            for place, value in pairs(currentCrop) do
                table.insert(args[2], value)
                --print(#args[2],' ', #currentCrop)
            end
        end)

        -- checks if cropLoopCount var is equal to length of args variable to avoid remote spamming
        --print(cropLoopCount)
        if cropLoopCount == #args[2] then
            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.SwingSickle:InvokeServer(unpack(args))
            table.clear(currentCrop)
            table.clear(args[2])
            cropLoopCount = 0
        end
        
        repeat task.wait() until Config.Farming.autoCropping
    end
end)


autoCrop:addToggle("Auto Replant", nil, function(v)
    Config.Farming.autoPlanting = v

    while Config.Farming.autoPlanting do
        if Config.Farming.autoPlanting == false then break end

        for i,v in pairs(currentCropPos) do
            if Config.Farming.autoPlanting == false then continue end
            root.CFrame = v
            wait(0.1)
            local args = {
                [1] = {
                    ["upperBlock"] = false,
                    ["cframe"] = v,
                    ["blockType"] = Config.Farming.autoCropSelection
                }
            }
            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_PLACE_REQUEST:InvokeServer(unpack(args))
            replantCount = replantCount + 1
            
        end
        
       -- print(replantCount)
        if replantCount == cropLoopCount then
            table.clear(currentCropPos)
            replantCount = 0
        end
        repeat task.wait() until Config.Farming.autoPlanting
    end
end)

autoCrop:addToggle("Auto Sell", nil, function(v)
	Config.Farming.autoCropSelling = v

	while Config.Farming.autoCropSelling do task.wait(5)
		if Config.Farming.autoCropSelection == Config.Farming.autoCropSelection then
			for i,v in pairs(lp.Backpack:GetChildren()) do
				if v.Name == Config.Farming.autoCropSelection..'Harvested' then
					if v.Amount.Value > 0 then
						local args = {
							[1] = {
								["merchant"] = "cropSell",
								["offerId"] = 1,
								["amount"] = v.Amount.Value
							}
						}

						if Config.Farming.autoCropSelection == 'wheat' then
							args[1]["merchant"] = "cropSell"
							args[1]['offerId'] = 1

						elseif Config.Farming.autoCropSelection == 'tomato' then
							args[1]["merchant"] = "cropSell"
							args[1]['offerId'] = 5

						elseif Config.Farming.autoCropSelection == 'potato' then
							args[1]["merchant"] = "cropSell"
							args[1]['offerId'] = 4

						elseif Config.Farming.autoCropSelection == 'horseradish' then
							args[1]["merchant"] = "adventurer"
							args[1]['offerId'] = 2

						elseif Config.Farming.autoCropSelection == 'pumpkin' then
							UI:Notify('Notice', 'not sure but the autumn shop is where pumkins are at, so if it doesn\' work don\'t blame me')

                        elseif Config.Farming.autoCropSelection == 'carrot' then
                            args[1]["merchant"] = "cropSell"
                            args[1]["offerId"] = 2 
						end

						game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_MERCHANT_ORDER_REQUEST:InvokeServer(unpack(args))
					end
				end
			end
		end
	end
end)


-- // Auto Miner
local autoMiner = autofarmPage:addSection("Auto Miner")
autoMiner:addDropdown("Select", ScriptList.autoMineList, function(v)
    Config.Farming.autoMineSelection = v
end)
autoMiner:addToggle("Auto Mine (Hub)", nil, function(v)
    Config.Farming.autoMining = v

    while Config.Farming.autoMining do
        if char then
            if Config.Farming.autoMineSelection == Config.Farming.autoMineSelection then
                for i,v in pairs(workspace.WildernessBlocks:GetChildren()) do
                    if v.Name == Config.Farming.autoMineSelection then
                        repeat task.wait()
                            root.CFrame = v.CFrame + Vector3.new(0,5,0)

                            local args = {
                                [1] = {
                                    ["part"] = v,
                                    ["block"] = v,
                                    ["norm"] = v.Position,
                                    ["pos"] = v.Position
                                }
                            }

                            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))

                        until v.Parent == nil or Config.Farming.autoMining == false
                    end
                end

                repeat task.wait() until Config.Farming.autoMining
            end
        end
    end
end)

autoMiner:addToggle("Auto Mine (Island)", nil, function(v)
    Config.Farming.autoMiningIsland = v

    while Config.Farming.autoMiningIsland do
        if char then
            if Config.Farming.autoMineSelection == Config.Farming.autoMineSelection then
                for i,v in pairs(island.Blocks:GetChildren()) do
                    if v.Name == Config.Farming.autoMineSelection then
                        repeat task.wait()
                            root.CFrame = v.CFrame + Vector3.new(0,5,0)

                            local args = {
                                [1] = {
                                    ["part"] = v,
                                    ["block"] = v,
                                    ["norm"] = v.Position,
                                    ["pos"] = v.Position
                                }
                            }

                            game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))

                        until v.Parent == nil or Config.Farming.autoMiningIsland == false
                    end
                end

                repeat task.wait() until Config.Farming.autoMiningIsland
            end
        end
    end
end)

-- // Mobs farming page
local mobPage = UI:addPage("Mobs", 9097607528)
local mobAutoSec = mobPage:addSection("WIP")
mobAutoSec:addButton("WIP", function()
    return
end)

-- // Teleports
local teleportPage = UI:addPage("Teleports", 5012543481)
local islandTeleports = teleportPage:addSection("Teleports")

islandTeleports:addDropdown("Teleports", ScriptList.islandTpList, function(v)
    Config.Farming.islandTpSelection = v

    print(Config.Farming.islandTpSelection)
    if Config.Farming.islandTpSelection == "Hub" then
        if char then
            root.CFrame = CFrame.new(-15.7872686, 46.9910393, -635.01355, 0.0311217327, 2.64968811e-08, -0.999515593, -4.82117057e-09, 1, 2.63596078e-08, 0.999515593, 3.99847844e-09, 0.0311217327)
        end
    elseif Config.Farming.islandTpSelection == "Home" then
        if char then
            root.CFrame = CFrame.new(-7494, 37.699955, -7515, 1, -5.16532914e-08, -2.44628637e-07, 5.16532772e-08, 1, -6.17510807e-08, 2.44628637e-07, 6.17510665e-08, 1)
        end

    elseif Config.Farming.islandTpSelection == "Slime King" then
        if char then
            root.CFrame = game:GetService("Workspace").spawnPrefabs.WildEventTriggers["slime_king_spawn"].CFrame
        end

    elseif Config.Farming.islandTpSelection == "Diamond Mine" then
        if char then
            root.CFrame = CFrame.new(2880.32422, 285, 1176.29675, -0.0757208243, 1.15132046e-07, 0.997129083, -1.62103113e-08, 1, -1.16694522e-07, -0.997129083, -2.49999772e-08, -0.0757208243)
        end

    elseif Config.Farming.islandTpSelection == "Slime Island" then
        if char then
            root.CFrame = CFrame.new(691.712891, 177.889725, -71.4396973, -0.981482506, -6.32204831e-08, 0.19155167, -4.71530193e-08, 1, 8.84389095e-08, -0.19155167, 7.7769009e-08, -0.981482506)
        end

    elseif Config.Farming.islandTpSelection == "Buffalkor Island" then
        if char then
            root.CFrame = CFrame.new(1254.98425, 437.162415, 44.0008926, -0.924392283, 1.65986047e-09, -0.381443232, 6.36016528e-09, 1, -1.10617435e-08, 0.381443232, -1.26514328e-08, -0.924392283)
        end

    elseif Config.Farming.islandTpSelection == "Wizard Island" then
        if char then
            root.CFrame = CFrame.new(1496.72437, 336.992493, -700.559814, 0.824572325, -6.39146975e-08, -0.565756559, 7.2611428e-08, 1, -7.14322113e-09, 0.565756559, -3.51902898e-08, 0.824572325)
        end

    elseif Config.Farming.islandTpSelection == "Desert Island" then
        if char then
            root.CFrame = CFrame.new(900.123657, 293.742065, -1875.72083, 0.363023937, -6.62864679e-08, 0.931779802, -3.52753133e-08, 1, 8.48829842e-08, -0.931779802, -6.36833803e-08, 0.363023937)
        end

    elseif Config.Farming.islandTpSelection == "Spirit Island" then
        if char then
            root.CFrame = CFrame.new(-2.39787984, 295.576447, 863.235474, -0.0422376581, 1.87707219e-08, -0.999107599, -2.98149949e-08, 1, 2.00479278e-08, 0.999107599, 3.06351673e-08, -0.0422376581)
        end

    elseif Config.Farming.islandTpSelection == "Pirate Island" then
        if char then
            root.CFrame = CFrame.new(-282.973572, 365.107178, -2004.78796, -0.998574078, -9.69962421e-09, 0.0533836633, -1.21391892e-08, 1, -4.53744633e-08, -0.0533836633, -4.59577976e-08, -0.998574078)
        end
    end
end)

-- // Machinery page

local machinery = UI:addPage("Machinery", 9157181391)

local machinerySec = machinery:addSection("Machinery")

machinerySec:addDropdown("Metal", ScriptList.autoMachineryItemList, function(v)
    Config.Machinery.autoMachineryItemSelection = v
    print(Config.Machinery.autoMachineryItemSelection)
end)

machinerySec:addDropdown("Furnace", ScriptList.autoMachineryFurnaceList, function(v)
    Config.Machinery.autoMachineryFurnaceSelection = v
    print(Config.Machinery.autoMachineryFurnaceSelection)
end)

machinerySec:addToggle("Auto Coal Insert", nil, function(v)
    Config.Machinery.autoMachineryCoalInserting = v

    while Config.Machinery.autoMachineryCoalInserting do
        for i,v in pairs(island.Blocks:GetChildren()) do
            if v.Name == Config.Machinery.autoMachineryFurnaceSelection then
                print('inserting coal....')
                local args = {
                    [1] = {
                        ["amount"] = 1,
                        ["block"] = v,
                        ["toolName"] = "coal"
                    }
                }

                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_WORKER_DEPOSIT_TOOL_REQUEST:InvokeServer(unpack(args))
            end
        end

        repeat task.wait() until Config.Machinery.autoMachineryCoalInserting
    end
end)

machinerySec:addToggle("Auto Metal Insert", nil, function(v)
    Config.Machinery.autoMachineryMetalInserting = v

    while Config.Machinery.autoMachineryMetalInserting do
            for i,v in pairs(island.Blocks:GetChildren()) do
                if v.Name == Config.Machinery.autoMachineryFurnaceSelection then
                    --print('inserting'..Config.Machinery.autoMachineryItemSelection..'...')
                    local args = {
                        [1] = {
                            ["amount"] = 1,
                            ["block"] = v,
                            ["toolName"] = Config.Machinery.autoMachineryItemSelection..'Ore'
                        }
                    }
                    
                    task.wait(0.01)
                    game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_WORKER_DEPOSIT_TOOL_REQUEST:InvokeServer(unpack(args))
                end
            end

        repeat task.wait() until Config.Machinery.autoMachineryMetalInserting
    end
end)

machinerySec:addToggle("Auto Pickup", nil, function(v)
    Config.Machinery.autoPicking = v

    local furnace = nil
    while Config.Machinery.autoPicking do
        task.spawn(function()
            for i,v in pairs(island.Blocks:GetChildren()) do
                    if v.Name == Config.Machinery.autoMachineryFurnaceSelection then
                        furnace = v
                    end
            end
        end)

       -- TODO: fix below
        for i,v in pairs(furnace.WorkerContents:GetChildren()) do
            if v.Name == Config.Machinery.autoMachineryItemSelection then
                local args = {
                    [1] = {
                        ["tool"] = v
                    }
                }

                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_TOOL_PICKUP_REQUEST:InvokeServer(unpack(args))
            end
        end

        repeat task.wait() until Config.Machinery.autoPicking
    end
end)

-- // Misc
local misc = UI:addPage("Misc", 5012544944)

local miscSec = misc:addSection("Misc")

miscSec:addSlider("Plow/Unplow Distance", 10, 0, 15, function(v)
    Config.Misc.plowDistance = v
    print(Config.Misc.plowDistance)
end)
miscSec:addToggle("Auto Plow", nil, function(v)
    Config.Misc.autoPlowing = v

    while Config.Misc.autoPlowing do
        for i,v in pairs(island.Blocks:GetChildren()) do
            if v.Name == 'grass' then
                if (root.Position - v.Position).magnitude < Config.Misc.plowDistance then
                    local args = {
                        [1] = {
                            ["block"] = v
                        }
                    }

                    game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_PLOW_BLOCK_REQUEST:InvokeServer(unpack(args))
                end
            end
        end

        repeat task.wait() until Config.Misc.autoPlowing
    end
end)
miscSec:addToggle("Auto Unplow", nil, function(v)
    Config.Misc.autoUnPlowing = v

    while Config.Misc.autoUnPlowing do
        for i,v in pairs(island.Blocks:GetChildren()) do
            if v.Name == 'soil' then
                if (root.Position - v.Position).magnitude < Config.Misc.plowDistance then
                    local args = {
                        [1] = {
                            ["block"] = v
                        }
                    }

                    game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_PLOW_BLOCK_REQUEST:InvokeServer(unpack(args))
                end
            end
        end

        repeat task.wait() until Config.Misc.autoUnPlowing
    end
end)
miscSec:addToggle("Clear rocks and tallGrass", nil, function(v)
	getgenv().clearingClutter = v

	while clearingClutter do
		for i,v in pairs(island.Blocks:GetChildren()) do
			if v.Name == 'naturalRock1' or v.Name == 'tallGrass' then
				repeat task.wait()
					root.CFrame = v.CFrame + Vector3.new(0,2,0)

					local args = {
						[1] = {
							["part"] = v,
							["block"] = v,
							["norm"] = v.Position,
							["pos"] = v.Position
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))

				until v.Parent == nil or clearingClutter == false
			end
		end

		repeat task.wait() until clearingClutter
	end
end)

miscSec:addToggle("Auto Hive", nil, function(v)
    Config.Farming.autoHiving = v

    while Config.Farming.autoHiving do
        for i,v in pairs(island.Blocks:GetChildren()) do
            if v.Name == 'tree4' then
                local args = {
                    [1] = {
                        ["tree"] = v
                    }
                }

                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_COLLECT_HONEY:InvokeServer(unpack(args))
            end
        end

        repeat task.wait() until Config.Farming.autoHiving
    end
end)


miscSec:addDropdown("Season Changer",{'summer','winter','fall','spring'} ,function(v)
    workspace.Season.Value = v
end)

miscSec:addButton("Lag Remover", function()
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
            v.BrickColor = BrickColor.new(155, 155, 155)
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

-- // Settings
local settings = UI:addPage("Setting n\nThemes", 5012544372)
local themeChanger = settings:addSection("Theme Colors")

for theme, color in pairs(Config.themes) do
    themeChanger:addColorPicker(theme, color, function(color3)
        color = color3
        Config.themes[theme] = color3
        UI:setTheme(theme, Config.themes[theme])
    end)
end
local scriptSettings = settings:addSection("Settings For Script")

local generalSettings = settings:addSection("General")
generalSettings:addKeybind("Toggle Keybind", Enum.KeyCode[Config.KeyBinds.ToggleBind], function()
    UI:toggle()
end)

generalSettings:addButton("Delete GUI", function()
    game.CoreGui[gameName]:Destroy()
end)

-- // Saved theme loader
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
                        default  min   max
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
]]								
