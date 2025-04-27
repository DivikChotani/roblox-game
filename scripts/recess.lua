local C = game:GetService("Chat")

local npc1 = workspace:WaitForChild("Interactions"):WaitForChild("Recess Interaction"):WaitForChild("Walter") --change this
local npc2 = workspace:WaitForChild("Interactions"):WaitForChild("Recess Interaction"):WaitForChild("Jesse") --change this

local function chat(message, npc)
	local head = npc:WaitForChild("Head")
	C:Chat(head, message)
end


local proximityPrompt = script.Parent

proximityPrompt.Triggered:Connect(function(player)
	proximityPrompt.Enabled = false
	chat("Look at you sitting alone, no wonder nobody likes you.", npc1) 
	wait(3)
	chat("I... I don’t really know how to make friends.", npc2) 
	wait(2)
	chat("Yeah, because no one wants to hang out with you.", npc1) 
	wait(3)
	chat("Maybe if I was different, people would...", npc2) 
	wait(3)
	chat("I know losers when I see them.", npc1) 
	npc1.ProximityPrompt.Enabled = true
	npc2.ProximityPrompt.Enabled = true
end)