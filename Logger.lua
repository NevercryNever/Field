-- NevercryNever Logger (não exponha este link publicamente)
local WEBHOOK = "https://discord.com/api/webhooks/SEU_WEBHOOK_AQUI"  -- ← coloque aqui

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local username = player.Name
local userId = player.UserId
local executor = identifyexecutor and identifyexecutor() or "Unknown Executor"
local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local placeId = game.PlaceId
local jobId = game.JobId

local embed = {
    ["title"] = "🎮 HUD Aberto - NevercryNever",
    ["color"] = 0x8B00FF,  -- roxo/vinho (pra combinar com seu tema)
    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
    ["fields"] = {
        {
            ["name"] = "Usuário",
            ["value"] = username .. " (`" .. userId .. "`)",
            ["inline"] = true
        },
        {
            ["name"] = "Jogo",
            ["value"] = gameName .. "\n`PlaceId: " .. placeId .. "`",
            ["inline"] = true
        },
        {
            ["name"] = "Executor",
            ["value"] = executor,
            ["inline"] = true
        },
        {
            ["name"] = "Server JobId",
            ["value"] = "```" .. jobId .. "```",
            ["inline"] = false
        }
    },
    ["footer"] = {
        ["text"] = "NevercryNever HUD Logger"
    }
}

local data = {
    ["username"] = "Nevercry Logger",
    ["embeds"] = {embed},
    ["avatar_url"] = "https://i.imgur.com/algumavatar.png" -- opcional
}

local success, err = pcall(function()
    HttpService:PostAsync(WEBHOOK, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
end)

if not success then
    warn("[Logger] Falha ao enviar log: " .. tostring(err))
end
