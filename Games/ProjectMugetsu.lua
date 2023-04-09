--//CheckVersion
local LocalPlayer = game.Players.LocalPlayer
local CheckedVersion = 4136
local PlaceVersion = game.PlaceVersion

if PlaceVersion > CheckedVersion then
    LocalPlayer:Kick("Script is outdated due to a game update, please contact wertyz#3837 on discord or send a screenshot on #bugs")
end
---------------------------------------------------------------------------
--//Tables
local all_mobs = {}
local all_islands = {}

--//Dropdown vars
local SelectedMob;
local SelectedIsland;
  
----------------------------------------------------------------------------

--//For Loops
for _,v in pairs(game:GetService("Workspace").World.Live.Mobs:GetChildren()) do
  if not table.find(all_islands, v.Name) then
    table.insert(all_islands, v.Name)
  end
end

----------------------------------------------------------------------------

--//Functions
local function UpdateMobList() 
    table.clear(all_mobs)
  for _,v in pairs(game:GetService("Workspace").World.Live.Mobs:FindFirstChild(SelectedIsland):GetDescendants()) do
    if v:IsA("Model") then
      if not table.find(all_mobs, v.Name) then
        table.insert(all_mobs, v.Name)
      end
    end 
  end
end


----------------------------------------------------------------------------

--//LibInit
local SolarisLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Patooh777/Rblx-Shit/SunsetXHub/libs/Solarislib.lua"))()


  local win = SolarisLib:New({
    Name = "Sunset X | Project Mugetsu",
    FolderToSave = "SunsetX Hub"
  })
  
  local function getNPC()
    local dist, thing = math.huge
    for i, v in pairs(game:GetService("Workspace").World.Live.Mobs:FindFirstChild(SelectedIsland):GetDescendants()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") and v.Name == SelectedMob and v.Humanoid.Health > 0 then
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

--//MainTab
  local Maintab = win:Tab("Main")
  
  local Mainsec = Maintab:Section("Auto Stuff")

  local AutoClicktoggle = Mainsec:Toggle("AutoClick", false,"Toggle", function(t)
    Click = t
    while Click do wait()
      local args = {[1] = "Swing",[2] = 1,[3] = "Fist"}
      game:GetService("ReplicatedStorage").Remotes.Server.Initiate_Server:FireServer(unpack(args)) 
    end
  end)

  local AutoFarmToggle = Mainsec:Toggle("AutoFarm", false,"Toggle", function(t)
    farm = t
    while farm do wait()
      LocalPlayer.Character.HumanoidRootPart.CFrame = getNPC().HumanoidRootPart.CFrame * CFrame.new(0, 1, 4)
    end
  end)

  local Mobdropdown = Mainsec:Dropdown("Select Mob", all_mobs,"None","Dropdown", function(t)
    SelectedMob = t
  end)

  local Islanddropwdown = Mainsec:Dropdown("Select Area", all_islands,"None","Dropdown", function(t)
    SelectedIsland = t
  end)
    
  Mainsec:Button("Update MobList", function()
    UpdateMobList()
    Mobdropdown:Refresh(all_mobs, true)
  end)
  
----------------------------------------------------------------------------

--//MiscTab
  local Misctab = win:Tab("Misc")

  local Miscsec = Playertab:Section("Misc Stuff")

  Miscsec:Button("Discord Link", function()
    setclipboard("https://discord.gg/k5ZWRKmD7v")
    SolarisLib:Notification("Sunset X Notify", "Copied discord link!")
  end)
