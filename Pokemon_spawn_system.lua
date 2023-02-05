local ReplicatedStorage = game:GetService("ReplicatedStorage")
local pokemonSpawnConfig = require(ReplicatedStorage:WaitForChild("PokemonSpawnConfig"))

local bear = ReplicatedStorage:WaitForChild("Bear")
local remote = ReplicatedStorage:WaitForChild("PokemonIsReady")

while pokemonSpawnConfig.NumberofPokemoninThe1stZone < pokemonSpawnConfig.NumberofPokemonMaxinTheZone do
	
	local TimeBeforeSpawnAgain = math.random(3, 6)
	
	local randomXaxis = math.random(-28, -20)
	local randomYaxis = math.random(1.541, 1.541)
	local randomZaxis = math.random(-14, -5)
	local randomRotation = math.random(-180, 180)
			
	local newBear = bear:Clone()
	local newHandler = script:WaitForChild("PokemonHandler"):Clone()
		
	newBear.Parent = workspace:WaitForChild("Spawns")
	newHandler.Parent = newBear
	print("Spawned")
	newBear.Primary.CFrame = CFrame.new(randomXaxis, randomYaxis, randomZaxis) * CFrame.Angles(0, math.rad(randomRotation), 0)
	newHandler.Enabled = true
	remote:Fire()
			
	pokemonSpawnConfig.NumberofPokemoninThe1stZone += 1
	
	wait(TimeBeforeSpawnAgain)
end
