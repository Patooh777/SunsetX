local BFS = 12289293395
local TM = 12422074717
local GameID = game.PlaceId

if GameID == BFS then
    loadstring(game:HttpGet("https://github.com/Patooh777/WickedHub/blob/Main/Smash%26Grab.lua?raw=true", true))()
    
elseif GameID == TM then
    loadstring(game:HttpGet("https://github.com/Patooh777/WickedHub/blob/Main/CarTycoon.lua?raw=true", true))()
    
else
    print("invalid Place")
    game.Players.LocalPlayer:Kick("Ur script dont support this shit ass game")
end
