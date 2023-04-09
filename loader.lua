local BFS = 12289293395
local TM = 12422074717
local FH = 11162791099
local AS = 10521031051
local PM = 10202329527
local PM2 = 9474703390
local GameID = game.PlaceId

if GameID == BFS then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/BoxingFightersSimulator.lua?raw=true", true))()
    
elseif GameID == TM then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/TappingMasters.lua?raw=true", true))()
elseif GameID == FH then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/FreeHatchers.lua?raw=true", true))()
elseif GameID == AS then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/AnimeSimulator.lua?raw=true", true))()
elseif GameID == PM or GameID == PM2 then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/ProjectMugetsu.lua?raw=true", true))()
else
    print("invalid Place")
    game.Players.LocalPlayer:Kick("Ur script dont support this shit ass game")
end
