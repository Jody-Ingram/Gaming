-- Roblox Leaderboard for Hits and Kills
-- Jody Ingram

local Players = game:GetService("Players")
local winningScore = 20 -- The number of kills required to win the match

-- Add "Hits" stat to each player
Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local kills = Instance.new("IntValue")
    kills.Name = "Kills"
    kills.Value = 0
    kills.Parent = leaderstats

    local hits = Instance.new("IntValue")
    hits.Name = "Hits"
    hits.Value = 0
    hits.Parent = leaderstats
end)

-- Place this script near your NPC setup code
local npc = workspace:WaitForChild("NPC") -- Change to your NPC's name
local humanoid = npc:WaitForChild("Humanoid")

local lastHealth = humanoid.Health

humanoid.HealthChanged:Connect(function(newHealth)
    if newHealth < lastHealth then
        -- Checks for a creator tag on the humanoid object 
        local creator = humanoid:FindFirstChild("creator")
        if creator and creator.Value and creator.Value:IsA("Player") then
            local player = creator.Value
            local hits = player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Hits")
            if hits then
                hits.Value = hits.Value + 1
                print(player.Name .. " has hit the NPC! Total hits: " .. hits.Value)
            end
        end
    end
    lastHealth = newHealth
end)

-- Local tool script
local tool = script.Parent

tool.Activated:Connect(function()
    local character = --[the character you hit]--
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- Set or update the creator tag every hit
        local player = game.Players:GetPlayerFromCharacter(tool.Parent)
        if player then
            local creator = humanoid:FindFirstChild("creator")
            if not creator then
                creator = Instance.new("ObjectValue")
                creator.Name = "creator"
                creator.Parent = humanoid
            end
            creator.Value = player
        end

        -- Applies your damage as normal. Increase to attack for more.
        humanoid:TakeDamage(10)
    end
end)
