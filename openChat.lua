
--local prompt = workspace.Rig1.ProximityPrompt -- change path to your prompt
local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "OpenChatGui"
remoteEvent.Parent = game.ReplicatedStorage

--prompt.Triggered:Connect(function(player)
--	remoteEvent:FireClient(player) -- Tell the player to open their GUI
--end)

local interactionsFolder = workspace.Interactions -- all your NPCs are grouped here?

for _, interaction in pairs(interactionsFolder:GetChildren()) do
	for _, npc in pairs(interaction:GetChildren()) do
		if npc.Name ~= "Base" then
			local prompt = npc:FindFirstChild("ProximityPrompt")
			if prompt then
				prompt.Triggered:Connect(function(player)
					remoteEvent:FireClient(player, npc.Name) -- Send NPC name to client
				end)
			end 
		end
	end
end