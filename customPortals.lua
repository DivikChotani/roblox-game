local RedTP = script.Parent.PortalRed.RedTeleport
local BlueTP = script.Parent.PortalBlue.BlueTeleport

local RedArrive = script.Parent.PortalRed.RedArrive
local BlueArrive = script.Parent.PortalBlue.BlueArrive

RedTP.Touched:Connect(function(hit)
	local HumanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
	if HumanoidRootPart then
		HumanoidRootPart.CFrame = BlueArrive.CFrame + Vector3.new(0, 4, 0)
		BlueTP.CanTouch = false
		task.wait(2)
		BlueTP.CanTouch = true
	end
end)

BlueTP.Touched:Connect(function(hit)
	local HumanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")
	if HumanoidRootPart then
		HumanoidRootPart.CFrame = RedArrive.CFrame + Vector3.new(0, 4, 0)
		RedTP.CanTouch = false
		task.wait(2)
		RedTP.CanTouch = true
	end
end)
