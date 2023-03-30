--//Variables
local LocalPlayer = game.Players.LocalPlayer
local PlrGui = LocalPlayer.PlayerGui
--//Tables
local rebirth_ammount = {}
local all_eggs = {}
local all_islands = {}
--//Dropdown Vars
local SelectedRebirth;
local SelectedEgg;
local SelecteIsland;

----------------------------------------------------------------------------
--//For Loops
for _,v in pairs(game:GetService("Workspace").Scripted.EggHolders:GetChildren()) do
  if not table.find(all_eggs, v.Name) then
    table.insert(all_eggs,v.Name)
  end
end

for _,v in pairs(game:GetService("Workspace").Scripted.Islands:GetChildren()) do
  if not table.find(all_islands, v.Name) then
    table.insert(all_islands, v.Name)
  end
end

----------------------------------------------------------------------------
--//Lib Init
local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Patooh777/Rblx-Shit/SunsetXHub/libs/Solarislib.lua"))()


  local win = SolarisLib:New({
    Name = "Sunset X | Tapping Masters",
    FolderToSave = "SunsetX Hub"
  })
  
  
----------------------------------------------------------------------------
  --//MainTab
  local Maintab = win:Tab("Main")
  
  local Mainsec = Maintab:Section("Auto Stuff")
  
  local AutoClicktoggle = Mainsec:Toggle("Auto Click", false,"Toggle", function(t)
    click = t
    while click do task.wait()
      game:GetService("ReplicatedStorage").Events.Click:FireServer()
    end
  end)

  local AutoMasteryToggle = Mainsec:Toggle("Auto Mastery", false,"Toggle", function(t)
    Mastery = t
    while Mastery do task.wait(10)
        game:GetService("ReplicatedStorage").Functions.IncreaseMastery:InvokeServer()
    end
  end)

  local AutoChesttoggle = Mainsec:Toggle("Auto Chest", false,"Toggle", function(t)
    Chest = t
    while Chest do task.wait(60)
      for _,v in pairs(game:GetService("Workspace").Scripted.Chests:GetChildren()) do
        local args = {[1] = v.Name}    
        game:GetService("ReplicatedStorage").Functions.CollectChest:InvokeServer(unpack(args))
      end
    end
  end)

  local AutoDailyToggle = Mainsec:Toggle("Auto Daily", false,"Toggle", function(t)
    Daily = t
    while Daily do task.wait(30)
      for _,v in pairs(PlrGui.DailyRewards.Holder.Holder.Reward.Holder.Rewards:GetChildren()) do 
        if v:IsA("ImageButton") then
          local args = {[1] = v.Name}
          game:GetService("ReplicatedStorage").Events.CollectDailyReward:FireServer(unpack(args))
        end
      end
    end
  end)

  local AutoRebirthtoggle = Mainsec:Toggle("Auto Rebirth", false,"Toggle", function(t)
    Rebirth = t
    while Rebirth do task.wait()
      local args = {[1] = tonumber(SelectedRebirth)}
      game:GetService("ReplicatedStorage").Events.Rebirth:FireServer(unpack(args))
    end
  end)


  local Rebirthdropdown = Mainsec:Dropdown("Select Rebirth", { "5", "10", "15", "25", "50", "75", "100", "150", "250", "500", "750", "1000", "1250", "1500", "2000", "2500", "3000", "3500", "4500", "5000", "6000", "8000", "10000", "15000", "25000", "50000", "750000", "1000000", "1500000", "2500000", "3750000", "5000000", "7500000", "10000000", "12500000" },"","Dropdown", function(t)
    SelectedRebirth = t
  end)

  

  
----------------------------------------------------------------------------
  --//EggTab
  local Eggtab = win:Tab("Egg")
  
  local Eggsec = Eggtab:Section("Egg Stuff")

  local AutoHatchhtoggle = Eggsec:Toggle("Single Open", false,"Toggle", function(t)
    Hatch = t
    while Hatch do task.wait(1)
      local args = {[1] = SelectedEgg,[2] = "Single"}
      game:GetService("ReplicatedStorage").Functions.Hatch:InvokeServer(unpack(args))
    end
  end)

  local TripleOpentoggle = Eggsec:Toggle("Triple Open", false,"Toggle", function(t)
    Triple = t
    while Triple do task.wait(3)
      local args = {[1] = SelectedEgg,[2] = "Triple"}
      game:GetService("ReplicatedStorage").Functions.Hatch:InvokeServer(unpack(args))
    end
  end)

  local Eggdropdown = Eggsec:Dropdown("Select Egg", all_eggs,"","Dropdown", function(t)
    SelectedEgg = t
  end)

----------------------------------------------------------------------------
  --//IslandTab
  local IslandTab = win:Tab("Island")
  
  local Islandsec = IslandTab:Section("Island MultiPlier")

  local Multiplierdropdown = Islandsec:Dropdown("Select Multiplier", all_islands,"","Dropdown", function(t)
    SelecteIsland = t
  end)

  Islandsec:Button("Get Multiplier", function()
    local args = {[1] = SelecteIsland}
    game:GetService("ReplicatedStorage").Events.SetWorldBoost:FireServer(unpack(args))
  end)

  --//Teleport
  local Teleportsec = IslandTab:Section("Island Teleport")

  local Islanddropdown = Teleportsec:Dropdown("Select Island", all_islands,"","Dropdown", function(t)
    SelecteIsland = t
  end)

  Teleportsec:Button("Teleport", function()
    for _,v in pairs(game:GetService("Workspace").Scripted.Islands:FindFirstChild(SelecteIsland):GetChildren()) do
      if v.Name == "SpawnPoint" then
        LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
      end
    end
  end)

  ----------------------------------------------------------------------------
  --//Notes

