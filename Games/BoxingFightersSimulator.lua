--//Variables
local LocalPlayer = game.Players.LocalPlayer

--//Dropdowns
local SelectedNpc;
local SelectedEgg;
local SelectedIsland;
local WalkspeedV;
--//Tables
local npcs = {};
local eggs = {};
local islands = {};

----------------------------------------------------------------------------

--//For Loops
for _,v in pairs(game:GetService("Workspace").NPC:GetChildren()) do
    if not table.find(npcs, v.Name) then
      table.insert(npcs, v.Name)
    end
end

for _,Egg in pairs(game:GetService("Workspace").Eggs:GetChildren()) do
  if not table.find(eggs, Egg.Name) then
    table.insert(eggs, Egg.Name)
  end
end

for _,v in pairs(game:GetService("Workspace").Teleporters:GetChildren()) do
  if not table.find(islands, v.Name) then
    table.insert(islands, v.Name)
  end
end
----------------------------------------------------------------------------

--//Functions
local function RefreshMobList()
  for _,v in pairs(game:GetService("Workspace").NPC:GetChildren()) do
    if not table.find(npcs, v.Name) then
      table.insert(npcs, v.Name)
    end
  end
end

local function AutoKillNearFunc(Dist)
	for _,Area in pairs(game:GetService("Workspace").NPC:GetChildren()) do
		for _,Mobs in pairs(Area:GetChildren()) do 
			local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Mobs.HumanoidRootPart.Position).magnitude 
            
            if mag < 6 then 
				local args = {
						[1] = Area.Name,
						[2] = Mobs.Name
				}

				game:GetService("ReplicatedStorage").Network.Punch:FireServer(unpack(args))
            end
		end
	end
end

local function AutoCollectCoin()
  for _,coins in pairs(game:GetService("Workspace").Interaction.Coins:GetChildren()) do
    if coins then
      coins.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
  end
end

local function AutoCollectGems()
  for _,gems in pairs(game:GetService("Workspace").Interaction.Gems:GetChildren()) do
    if gems then
      gems.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    end
  end
end

local function getNPC()
  local dist, thing = math.huge
  for i, v in pairs(game:GetService("Workspace").NPC:GetDescendants()) do
      if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Head") and v.Parent.Name == SelectedNpc then
          local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
          if mag < dist then
              dist = mag
              thing = v
          end
      end
  end
  return thing
end

----------------------------------------------------------------------------

-- //Solaris
local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Patooh777/Rblx-Shit/SunsetXHub/libs/Solarislib.lua"))()


  local win = SolarisLib:New({
    Name = "Sunset X | Boxing Fighters Simulator",
    FolderToSave = "SunsetX Hub"
  })
  
  ----------------------------------------------------------------------------

  -- //MainTab
  local Maintab = win:Tab("Main")
  
  local Mainsec = Maintab:Section("Auto Stuff")
  
  local AutoClicktoggle = Mainsec:Toggle("AutoClick", false,"Toggle", function(t)
    a = t 
    while a do task.wait(0.01)
      game:GetService("ReplicatedStorage").Network.Punch:FireServer()
    end 
  end)

  local KillNearToggle = Mainsec:Toggle("KillNear", false,"Toggle", function(t)
    d = t 
    while d do task.wait()
      AutoKillNearFunc()
    end 
  end)

  local MagnetToggle = Mainsec:Toggle("Magnet Coin", false,"Toggle", function(t)
    c = t 
    while c do task.wait()
      AutoCollectCoin()
      AutoCollectGems()
    end 
  end)

  local AutoEquipToggle = Mainsec:Toggle("EquipBest Glove", false,"Toggle", function(t)
    b = t 
    while b do task.wait(15)
      game:GetService("ReplicatedStorage").Network.EquipBestGlove:FireServer()
    end 
  end)

  --//MobSection
  local MobSec = Maintab:Section("Farm")

  local AutoFarmToggle = MobSec:Toggle("AutoFarm Mob", false,"Toggle", function(t)
      f = t
      while f do task.wait(.01)
        pcall(function()
          LocalPlayer.Character.HumanoidRootPart.CFrame = getNPC().Head.CFrame
        end)
      end
  end)

  local Mobdropdown = MobSec:Dropdown("Mob Dropdown", npcs ,"None","Dropdown", function(t)
      SelectedNpc = t;
    end)

    MobSec:Button("Refresh MobList", function()
      RefreshMobList()
      Mobdropdown:Refresh(npcs, true)
    end)

  ----------------------------------------------------------------------------

  --//EggTab
  local Eggtab = win:Tab("Egg")
  
  local Eggsec = Eggtab:Section("Egg stuff")

  local OpenSingleToggle = Eggsec:Toggle("Auto Hatch", false,"Toggle", function(t)
    e = t
    while e do task.wait()
      LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Eggs:FindFirstChild(SelectedEgg).key.CFrame

      local args = {[1] = SelectedEgg,[2] = "Single"} 
      game:GetService("ReplicatedStorage").Network.OpenEgg:InvokeServer(unpack(args))
    end
  end)

  local EquipBestPet = Eggsec:Toggle("EquipBest Pet", false,"Toggle", function(t)
    p = t
    while p do task.wait(2)
      game:GetService("ReplicatedStorage").Network.EquipBestPets:FireServer()
    end
  end)
  
  local Eggdropdown = Eggsec:Dropdown("Egg Dropdown", eggs ,"None","Dropdown", function(t)
    SelectedEgg = t;
  end)

----------------------------------------------------------------------------

--//Upgrades
local Upgradestab = win:Tab("Upgrades")
  
local Upgradessec = Upgradestab:Section("Auto Upgrade")

local Islanddropwdown = Upgradessec:Dropdown("Select Island", islands,"None","Dropdown", function(t)
  SelectedIsland = t
end)

local UpgradeCoinToggle = Upgradessec:Toggle("Upgrade Coins", false,"Toggle", function(t)
  coin = t
  while coin do task.wait(1)
    local args = {[1] = "Coins",[2] = SelectedIsland}
    game:GetService("ReplicatedStorage").Network.BuyUpgrade:FireServer(unpack(args))
  end
end)

local UpgradeStrengthToggle = Upgradessec:Toggle("Upgrade Strength", false,"Toggle", function(t)
  Strength = t
  while Strength do task.wait(1)
    local args = {[1] = "Strength",[2] = SelectedIsland}
    game:GetService("ReplicatedStorage").Network.BuyUpgrade:FireServer(unpack(args))
  end
end)

local UpgradeCritToggle = Upgradessec:Toggle("Upgrade Critical Chance", false,"Toggle", function(t)
  Critical = t
  while Critical do task.wait(1)
    local args = {[1] = "Critical",[2] = SelectedIsland}
    game:GetService("ReplicatedStorage").Network.BuyUpgrade:FireServer(unpack(args))
  end
end)

local UpgradeWalkspeedToggle = Upgradessec:Toggle("Upgrade WalkSpeed", false,"Toggle", function(t)
  WalkSpeed = t
  while WalkSpeed do task.wait(1)
    local args = {[1] = "Walkspeed",[2] = SelectedIsland}
    game:GetService("ReplicatedStorage").Network.BuyUpgrade:FireServer(unpack(args))
  end
end)




----------------------------------------------------------------------------

--//MiscTab
local MiscTab = win:Tab("Misc")
  
local Missec = MiscTab:Section("Useful")

local AutoPrestigeToggle = Missec:Toggle("Auto Prestige", false,"Toggle", function(t)
  prestige = t
  while prestige do task.wait(5)
    game:GetService("ReplicatedStorage").Network.Prestige:FireServer()
  end
end)

--[[local WalkToggle = Missec:Toggle("Walkspeed Changer", false,"Toggle", function(t)
  walk = t
  while walk do task.wait()
    LocalPlayer.Character.Humanoid.WalkSpeed = WalkspeedV
  end
end)

local Walkslider = Missec:Slider("WalkSpeed Value", 16,40,16,1,"Slider", function(t)
  WalkspeedV = t
end)]]--


local InvisToggle = Missec:Toggle("Invisible", false,"Toggle", function(t)
  i = t
  while i do task.wait(5)
    if LocalPlayer.Character:FindFirstChild("LowerTorso") then
      LocalPlayer.Character.LowerTorso:Destroy()
    end
  end
end)

----------------------------------------------------------------------------
--//Notes

  --[[local args = {
    [1] = "Forest Castle"
}

game:GetService("ReplicatedStorage").Network.BuyLocation:FireServer(unpack(args))--]]
