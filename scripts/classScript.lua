local C = game:GetService("Chat")

local npc1 = workspace:WaitForChild("Interactions"):WaitForChild("Classroom Interaction"):WaitForChild("Anakin") --change this
local npc2 = workspace:WaitForChild("Interactions"):WaitForChild("Classroom Interaction"):WaitForChild("Obi-Wan") --change this

local function chat(message, npc)
	local head = npc:WaitForChild("Head")
	C:Chat(head, message)
end


local proximityPrompt = script.Parent

proximityPrompt.Triggered:Connect(function(player)
	proximityPrompt.Enabled = false
	chat("Ugh, why do you even bother answering questions?", npc1)
	wait(3)
	chat("I... thought maybe I could get it right this time.", npc2)
	wait(2)
	chat("You sound so dumb though, it's embarrassing.", npc1)
	wait(3)
	chat("I guess I should just stay quiet then...", npc2)
	wait(3)
	chat("Good idea, save us all the pain.", npc1)
	npc1.ProximityPrompt.Enabled = true
	npc2.ProximityPrompt.Enabled = true
end)