
local prompt = workspace.Rig1.ProximityPrompt -- change path to your prompt
local remoteEvent = Instance.new("RemoteEvent")
remoteEvent.Name = "OpenChatGui"
remoteEvent.Parent = game.ReplicatedStorage

prompt.Triggered:Connect(function(player)
	remoteEvent:FireClient(player) -- Tell the player to open their GUI
end)
