local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
    Name = "TDS Player Stats | v2.0.0",
})

local Tab = Window:CreateTab("Player", 4483362458)

-- local Player = Tab:CreateSection("NAME")

local Name = Tab:CreateLabel("Name: ")
local Coins = Tab:CreateLabel("Coins: ")
local Gems = Tab:CreateLabel("Gems: ")
local Level = Tab:CreateLabel("Level: ")
local Troops = Tab:CreateLabel("Troops: ")

local Extra = Tab:CreateSection("Extra")

local Instructions = Tab:CreateParagraph({Title = "Instructions", Content = "just click on someone to see their loadout and more"})
local Credits = Tab:CreateParagraph({Title = "Credits", Content = "made by poseidon#0364 (feel free to dm for questions, comments, and concerns)"})

local players = game:GetService("Players")
local player = players.LocalPlayer

local mouse = player:GetMouse()

mouse.Button1Down:Connect(function()
    local model = mouse.Target:FindFirstAncestorOfClass('Model')
    
    if model then
        local clickedPlayer = game.Players:GetPlayerFromCharacter(model)
        
        if clickedPlayer then
            local player = game:GetService("Players")[clickedPlayer.Name]
            Name:Set("Name: " .. clickedPlayer.Name)
            -- Player:Set(clickedPlayer.Name)
            Coins:Set("Coins: " .. player['Coins']['Value'])
            Gems:Set("Gems: " .. player['Gems']['Value'])
            Level:Set("Level: " .. player['Level']['Value'])
        
            local args = {
                [1] = "Profiles",
                [2] = "Download",
                [3] = player
            }
            
            local returnedPlayer = game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
            local troopText = "Troops: "
            for i, v in pairs(returnedPlayer.Troops) do
                if i ~= 1 then
                    troopText = troopText .. ", "
                end
                troopText = troopText .. v
            end
            
            Troops:Set(troopText)
        end
    end
end)
