-- LocalScript inside the ChatFrame

local chatFrame = script.Parent
local messageBox = chatFrame:WaitForChild("MessageBox")
local sendButton = chatFrame:WaitForChild("SendButton")
local chatDisplay = chatFrame:WaitForChild("ChatDisplay")

local player = game.Players.LocalPlayer
print("This script is running!")
-- Function to add a new message to the chat display
local function addMessage(text)

	print("IN here")
	local messageLabel = Instance.new("TextLabel")
	messageLabel.Size = UDim2.new(1, 0, 0, 30) -- Full width, 30 pixels tall
	messageLabel.BackgroundTransparency = 1
	messageLabel.Text = player.Name .. ": " .. text
	messageLabel.TextColor3 = Color3.new(0, 0, 0)
	messageLabel.TextScaled = true
	messageLabel.Font = Enum.Font.SourceSans
	messageLabel.Parent = chatDisplay
end

-- When send button clicked
sendButton.MouseButton1Click:Connect(function()
	print("clicky")
	print("MessageBox:", messageBox)
	print("MessageBox.Text:", messageBox.Text)
	local message = messageBox.Text
	if message ~= "" then
		addMessage(message)
		messageBox.Text = "" -- Clear the box
	end
end)print("Hello world!")

