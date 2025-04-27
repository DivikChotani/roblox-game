local C = game:GetService("Chat")

local npc1 = workspace:WaitForChild("Interactions"):WaitForChild("Pool Interaction"):WaitForChild("Jim") --change this
local npc2 = workspace:WaitForChild("Interactions"):WaitForChild("Pool Interaction"):WaitForChild("Dwight") --change this

local function chat(message, npc)
	local head = npc:WaitForChild("Head")
	C:Chat(head, message)
end


local proximityPrompt = script.Parent

proximityPrompt.Triggered:Connect(function(player)
	proximityPrompt.Enabled = false
	chat("Wow, you can't even hit the ball right.", npc1)
	wait(3)
	chat("I’m just... trying my best, I guess.", npc2)
	wait(2)
	chat("Whatever, you'll never be good.", npc1)
	wait(3)
	chat("I... guess I should just sit out.", npc2)
	wait(3)
	chat("Finally, someone gets it.", npc1)
	npc1.ProximityPrompt.Enabled = true
	npc2.ProximityPrompt.Enabled = true
end)