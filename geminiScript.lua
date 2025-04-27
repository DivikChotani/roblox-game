
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local LLM_SERVER_URL = "https://1364-2607-f010-2a7-201d-1843-a8fc-cc41-729a.ngrok-free.app" -- Replace with your server's URL

--local npcHelper
--local npcHelperHead = game.Workspace:WaitForChild("Trash bin")

-- Listen to player chat
local function getGeminiResponse(message)
	--print(player.Name .. " said: " .. message)
	--game:GetService("Chat"):Chat(npcHelperHead, "...")

	-- Create request payload
	local payload = {
		prompt = message,
		history = {} -- You could store chat history here for context
	}

	-- Send the player's message to the Gemini chatbot server
	local success, response = pcall(function()
		return HttpService:PostAsync(LLM_SERVER_URL, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
	end)

	-- Handle the chatbot's response
	if success then
		print("Chatbot Response: " .. response)

		-- Send the chatbot's response back to the player's chat
		--game:GetService("Chat"):Chat(npcHelperHead, response, Enum.ChatColor.Blue)
	else
		warn("Error sending request: " .. tostring(response))
		--game:GetService("Chat"):Chat(npcHelperHead, "Error: Could not reach the chatbot.", Enum.ChatColor.Red)
	end
	
	return response
end

-- Connect to player joining
Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(message)
		getGeminiResponse(message)
	end)
end)

print("Chatbot integration ready!")


-- Listening for a request from the client
local remoteEvent = game.ReplicatedStorage:WaitForChild("GeminiEvent")
local remoteEvent2 = game.ReplicatedStorage:WaitForChild("GeminiEventReverseDir")

remoteEvent.OnServerEvent:Connect(function(player, message)
	-- Handle the incoming chat request from the client
	print("in here")
	print(message)
	local response = getGeminiResponse(message)
	print(response)
	remoteEvent2:FireClient(player, response)
end)