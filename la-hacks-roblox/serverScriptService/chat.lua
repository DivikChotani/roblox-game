local C = game:GetService("Chat")

local ainpc = workspace.WaitForChild("AI BOT")

local function chat(message)
	local head = ainpc:WaitForChild("Head")
	C:Chat(head, message)
	
end

task.wait(t)
chat("test")
