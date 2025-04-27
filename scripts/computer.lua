local C = game:GetService("Chat")

local npc1 = workspace:WaitForChild("Interactions"):WaitForChild("Computer Lab Interaction"):WaitForChild("Jake") --change this
local npc2 = workspace:WaitForChild("Interactions"):WaitForChild("Computer Lab Interaction"):WaitForChild("Charles") --change this

local function chat(message, npc)
	local head = npc:WaitForChild("Head")
	C:Chat(head, message)
end


local proximityPrompt = script.Parent

proximityPrompt.Triggered:Connect(function(player)
	proximityPrompt.Enabled = false
	chat("Why are you even here? You probably can't even turn the computer on.", npc1)
	wait(3)
	chat("I... I think I could do it.", npc2)
	wait(2)
	chat("Haha, sure, maybe if someone else does it for you.", npc1)
	wait(3)
	chat("I know I'm not good, but I'm trying...", npc2)
	wait(3)
	chat("Relax, it's just a joke, can't you take one?", npc1)
	npc1.ProximityPrompt.Enabled = true
	npc2.ProximityPrompt.Enabled = true
end)