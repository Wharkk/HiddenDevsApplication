local player = game.Players.LocalPlayer

local pingRemote = script:WaitForChild("GetPing")

local statsFrame = script.Parent.StatsFrameBG.StatsFrame

local pingLabel = statsFrame.PingLabel.Number
local playerNameLabel = statsFrame.PlayerNameLabel
local playerDisplayLabel = statsFrame.PlayerDisplayLabel
local winsLabel = statsFrame.WinsLabel.Number
local lossesLabel = statsFrame.LossesLabel.Number

local Colors = {
	Good = Color3.fromRGB(0, 255, 0),
	Normal = Color3.fromRGB(255, 255, 0),
	Bad = Color3.fromRGB(255, 0, 0)
}

playerDisplayLabel.Text = player.DisplayName
playerNameLabel.Text = "@"..player.Name

winsLabel.Text = player.leaderstats.Wins.Value
lossesLabel.Text = player.leaderstats.Losses.Value

function getPing()
	local send = tick()
	local ping = nil
	
	pingRemote:FireServer()
	
	local receive; receive = pingRemote.OnClientEvent:Connect(function()
		ping = tick() - send
	end)
	
	wait(1)
	
	receive:Disconnect()
	
	return ping or 999
end

local pingThread = coroutine.wrap(function()
	while wait(0.5) do
		local ping = tonumber(string.format("%.3f", getPing() * 1000))
		pingLabel.Text = (math.floor(ping)).." ms"
		
		if ping <= 100 then
			pingLabel.TextColor3 = Colors.Good
			
		elseif ping > 199 then
			pingLabel.TextColor3 = Colors.Normal
			
		elseif ping > 900 then
			pingLabel.TextColor3 = Colors.Bad
		end
	end
end)

pingThread()
