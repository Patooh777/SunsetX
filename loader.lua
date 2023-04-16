local BFS = 12289293395
local TM = 12422074717
local FH = 11162791099
local AS = 10521031051
local ALS = 12413786484
local GameID = game.PlaceId

if GameID == BFS then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/BoxingFightersSimulator.lua?raw=true", true))()
elseif GameID == TM then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/TappingMasters.lua?raw=true", true))()
elseif GameID == FH then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/FreeHatchers.lua?raw=true", true))()
elseif GameID == AS then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/AnimeSimulator.lua?raw=true", true))()
elseif GameID == ALS then
    loadstring(game:HttpGet("https://github.com/Patooh777/SunsetX/blob/Main/Games/AnimeLostSimulator.lua?raw=true", true))()
    end
else
    print("invalid Place")
    game.Players.LocalPlayer:Kick("Ur script dont support this shit ass game")
end
