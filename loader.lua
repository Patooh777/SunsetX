local Repo = 'https://raw.githubusercontent.com/Patooh777/SunsetX/Main/Games/'
local GameId = game.PlaceId
local GamesList = {
    [12289293395] = 'BoxingFightersSimulator.lua',
    [12422074717] = 'TappingMasters.lua',
    [11162791099] = 'FreeHatchers.lua',
    [10521031051] = 'AnimeSimulator.lua',
    [12413786484] = 'AnimeLostSimulator.lua',

    [8874112980] = 'DemonSlayerMidnightSun.lua', 
    [10136095859] = 'DemonSlayerMidnightSunTrainer.lua', 
    [12999874474] = 'DemonSlayerMidnightSunRanked.lua', 
}

if GamesList[GameId] ~= nil then
    loadstring(game:HttpGet(Repo.. GamesList[GameId]))()
else
    game.Players.LocalPlayer:Kick("Script dont support this game, if u think this is a error report to wertyz#3837")
end 
