local LocalPlayer = game.Players.LocalPlayer
local LPName = LocalPlayer.Name
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local AutoClickConnection
local AutoEuqipConnection
local SelectedMob;
local SelectedDist;
local SelectedMethod = nil
local SelectedWeapon = nil

local all_mobs = {}
local all_trainers = {}
local plr_weapons = {}

for _,v in pairs(game:GetService("Workspace").Trainers:GetChildren()) do
    if not table.find(all_trainers, v.Name) then
        table.insert(all_trainers, v.Name)
    end
end

for _,v in pairs(game:GetService("Workspace").Live.Npcs:GetChildren()) do
    if not table.find(all_mobs, v.Name) then
        table.insert(all_mobs, v.Name)
    end
end

for _,v in pairs(game:GetService("Players")[LPName].Backpack:GetChildren()) do
    if v:FindFirstChild("Animations") then
        table.insert(plr_weapons, v.Name)
    end
end 

local function RefreshMobList()
    table.clear(all_mobs)
    for _,v in pairs(game:GetService("Workspace").Live.Npcs:GetChildren()) do
        if not table.find(all_mobs, v.Name) then
            table.insert(all_mobs, v.Name)
        end
    end    
end

local function RefreshWeaponList()
    table.clear(plr_weapons)
    for _,v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:FindFirstChild("Animations") then
            table.insert(plr_weapons, v.Name)
        end
    end 
end

local function getNPC()
    local dist, thing = math.huge
    for i, v in pairs(game:GetService("Workspace").Live.Npcs:GetChildren()) do
      if v:FindFirstChild("HumanoidRootPart") and v.Name == SelectedMob and v:IsA("Model")  then
        local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).magnitude
        if mag < dist then
            print(v.Humanoid.Health)
            dist = mag
            thing = v
        end
      end
    end
    return thing
  end

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
--local EspLib = loadstring(game:HttpGet())()
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/Patooh777/Rblx-Shit/SunsetXHub/LinoriaThemes.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Sunset X | DS Midnight Sun',
    Center = true,
    AutoShow = true,
    TabPadding = 8
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Misc = Window:AddTab('Visual & Misc'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}


local LeftGroupBox = Tabs.Main:AddLeftGroupbox("       \\\\ Settings Farm //       ")


LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Front/Behind', 'Above/Below'},
    Default = 0, 
    Multi = false, 

    Text = 'Select Method',
    Tooltip = 'Behind or above the mob', 

    Callback = function(Value)
        SelectedMethod = Value
    end
})


LeftGroupBox:AddSlider('MySlider', {
    Text = 'Distance on the mob',
    Default = 5,
    Min = -10,
    Max = 10,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        SelectedDist = t
    end
})

Options.MySlider:OnChanged(function()
    SelectedDist = Options.MySlider.Value
end)

LeftGroupBox:AddDropdown('WeaponDropDown', {
    Values = plr_weapons,
    Default = 0, 
    Multi = false, 

    Text = 'Select Weapon',
    Tooltip = 'This is for the auto equip', 

    Callback = function(Value)
        SelectedWeapon = Value
    end
})


local RefreshWeaponButton = LeftGroupBox:AddButton({
    Text = 'Refresh Weapons',
    Func = function()
        RefreshWeaponList()
        Options.WeaponDropDown.Values = plr_weapons
        Options.WeaponDropDown:SetValues()
    end,
    DoubleClick = false,
    Tooltip = 'Nigger'
})

local LeftGroupBox2 = Tabs.Main:AddLeftGroupbox('           \\\\ Main //            ');

LeftGroupBox2:AddDropdown('MobsDropdown', {
    Values = all_mobs,
    Default = 0, 
    Multi = false, 

    Text = 'Select Mob',
    Tooltip = 'Select a mob niger', 

    Callback = function(Value)
        SelectedMob = Value
    end
})

local MyButton = LeftGroupBox2:AddButton({
    Text = 'Refresh Mobs',
    Func = function()
        RefreshMobList()
        Options.MobsDropdown.Values = all_mobs
        Options.MobsDropdown:SetValues()
    end,
    DoubleClick = false,
    Tooltip = 'Nigger'
})


LeftGroupBox2:AddToggle('AutoFarmToggle', {
    Text = 'Auto Farm Mob',
    Default = false, 
    Tooltip = 'Farm', 

    Callback = function(Value)

    end
})

Toggles.AutoFarmToggle:OnChanged(function()
    while Toggles.AutoFarmToggle.Value do task.wait()
        if not found then
            if SelectedMethod == nil then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getNPC().HumanoidRootPart.CFrame * CFrame.new(0,0,5) 
            elseif SelectedMethod == "Front/Behind" then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getNPC().HumanoidRootPart.CFrame * CFrame.new(0,0,SelectedDist) 
            elseif SelectedMethod == "Above/Below" then
                LocalPlayer.Character.HumanoidRootPart.CFrame = getNPC().HumanoidRootPart.CFrame * CFrame.new(0,SelectedDist,0)
            end
        end
    end
end)


LeftGroupBox2:AddToggle('AutoAttackToggle', {
    Text = 'Auto Attack',
    Default = false, 
    Tooltip = 'Auto Attack', 

    Callback = function(Value)
        if Value then
            AutoClickConnection = RunService.RenderStepped:Connect(function()
                local args = {[1] = "M1"}
                game:GetService("Players").LocalPlayer.Character.Nichirin.RemoteEvent:FireServer(unpack(args))

                local args = {[1] = "Hitbox",[2] = 1,[3] = "M1" }
                game:GetService("Players").LocalPlayer.Character.Nichirin.RemoteEvent:FireServer(unpack(args))
                

            end)
        else
            pcall(function() AutoClickConnection:Disconnect() end)
        end
    end
})

LeftGroupBox2:AddToggle('AutoEquipToggle', {
    Text = 'Auto Equip Weapon',
    Default = false, 
    Tooltip = 'Auto Equip Weapon', 

    Callback = function(Value)
        if Value then
            AutoEuqipConnection = RunService.RenderStepped:Connect(function()
                if LocalPlayer.Backpack:FindFirstChild(SelectedWeapon) and LocalPlayer.Character:FindFirstChild(SelectedWeapon) == nil then
                    local tool = LocalPlayer.Backpack:FindFirstChild(SelectedWeapon)
                    LocalPlayer.Character.Humanoid:EquipTool(tool)
                end
            end)
        else
            pcall(function() AutoEuqipConnection:Disconnect() end)
        end
    end
})

local RightGroupbox = Tabs.Main:AddRightGroupbox('        \\\\ Player Stuff //           ');  

RightGroupbox:AddSlider('WalkSpeedSlider', {
    Text = 'Walk-Speed',
    Default = 50,
    Min = 16,
    Max = 350,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        
    end
})


RightGroupbox:AddSlider('JumpPowerSlider', {
    Text = 'Jump-Power',
    Default = 50,
    Min = 50,
    Max = 350,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        
    end
})


RightGroupbox:AddToggle('WalkSpeedToggle', {
    Text = 'WalkSpeed Enabled',
    Default = false, 
    Tooltip = 'Player Velocity', 

    Callback = function(Value)

    end
})
local OldWalk = LocalPlayer.Character.Humanoid.WalkSpeed
Toggles.WalkSpeedToggle:OnChanged(function()
    while Toggles.WalkSpeedToggle.Value do task.wait()
        pcall(function()
            LocalPlayer.Character.Humanoid.WalkSpeed = Options.WalkSpeedSlider.Value  
        end)
    end
    if not Toggles.WalkSpeedToggle.Value then
        LocalPlayer.Character.Humanoid.WalkSpeed = OldWalk
    end
end)

RightGroupbox:AddToggle('JumpPowerToggle', {
    Text = 'JumpPower Enabled',
    Default = false, 
    Tooltip = 'Jump Height', 

    Callback = function(Value)

    end
})

local OldJump = LocalPlayer.Character.Humanoid.WalkSpeed
Toggles.JumpPowerToggle:OnChanged(function()
    while Toggles.JumpPowerToggle.Value do task.wait()
        pcall(function()
            LocalPlayer.Character.Humanoid.JumpPower = Options.JumpPowerSlider.Value
        end)
    end
    if not JumpPowerToggle then
        LocalPlayer.Character.Humanoid.JumpPower = OldJump
    end
end)

RightGroupbox:AddToggle('InfinityJumpToggle', {
    Text = 'Infinity Jump',
    Default = false, 
    Tooltip = 'Inf jump', 

    Callback = function(Value)

    end
})

Toggles.InfinityJumpToggle:OnChanged(function()
    UserInputService.JumpRequest:connect(function()
        if Toggles.InfinityJumpToggle.Value then
            LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

RightGroupbox:AddToggle('GodModeToggle', {
    Text = 'God Mode',
    Default = false, 
    Tooltip = 'God Mode nigger', 

    Callback = function(Value)

    end
})

Toggles.GodModeToggle:OnChanged(function()
    while Toggles.GodModeToggle.Value do task.wait(1)
        LocalPlayer.Character.Dash.RemoteEvent:FireServer("Falldmg", 0/0);
    end
end)



local RightGroupbox2 = Tabs.Main:AddRightGroupbox('          \\\\ Players //           ');  

RightGroupbox2:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'Select Player',
    Tooltip = 'Select a player', -- Information shown when you hover over the dropdown

    Callback = function(Value)
        print('[cb] Player dropdown got changed:', Value)
    end
})

local MyButton = RightGroupbox2:AddButton({
    Text = 'Teleport to Player',
    Func = function()
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").PLRCharacters:FindFirstChild(Options.MyPlayerDropdown.Value).HumanoidRootPart.CFrame
        end)
    end,
    DoubleClick = false,
    Tooltip = 'Nigger'
})


RightGroupbox2:AddToggle('SpectatePlayerToggle', {
    Text = 'Spectate',
    Default = false, 
    Tooltip = 'Your camera will be on the player', 

    Callback = function(Value)

    end
})

Toggles.SpectatePlayerToggle:OnChanged(function()
    while Toggles.SpectatePlayerToggle.Value do task.wait()
        pcall(function()
            game.Workspace.Camera.CameraSubject = game:GetService("Workspace").Live.Players:FindFirstChild(Options.MyPlayerDropdown.Value).Humanoid
        end)
    end
    if not Toggles.SpectatePlayerToggle.Value then
        game.Workspace.Camera.CameraSubject = LocalPlayer.Character.Humanoid
    end 
end)

RightGroupbox2:AddToggle('AutoFarmPlayerToggle', {
    Text = 'Auto Farm Player',
    Default = false, 
    Tooltip = 'Dumb ass nigger', 

    Callback = function(Value)

    end
})

Toggles.AutoFarmPlayerToggle:OnChanged(function()
    while Toggles.AutoFarmPlayerToggle.Value do task.wait()
        pcall(function()
            LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Live.Players:FindFirstChild(Options.MyPlayerDropdown.Value).HumanoidRootPart.CFrame * CFrame.new(0,0,3)
        end)
    end
end)

local LeftGroupboxTab2 = Tabs.Misc:AddLeftGroupbox('          \\\\ Teleports //            ');

LeftGroupboxTab2:AddDropdown('TrainersDropdown', {
    Values = all_trainers,
    Default = 0, 
    Multi = false, 

    Text = 'Select Trainer',
    Tooltip = 'Select a trainer to Teleport', 

    Callback = function(Value)
        
    end
})

local IslandTpButton = LeftGroupboxTab2:AddButton({
    Text = 'Teleport to Trainer',
    Func = function()
        LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Trainers[Options.TrainersDropdown.Value].HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
    end,
    DoubleClick = false,
    Tooltip = 'Nigger'
})


Library.KeybindFrame.Visible = false;

Library:OnUnload(function()
    print('Unloaded!')
    Library.Unloaded = true
end)


local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')


MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })

Library.ToggleKeybind = Options.MenuKeybind 


-- Hand the library over to our managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('Sunset X')
SaveManager:SetFolder('Sunset X/'.. game.PlaceId)

-- Builds our config menu on the right side of our tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Builds our theme menu (with plenty of built in themes) on the left side
-- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()