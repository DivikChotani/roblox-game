--[[

-- DonaldDuck5150 --

]]

local RedTP = script.Parent.PortalRed.RedTeleport
local BlueTP = script.Parent.PortalBlue.BlueTeleport

local RedArrive = script.Parent.PortalRed.RedArrive
local BlueArrive = script.Parent.PortalBlue.BlueArrive

RedTP.Touched:Connect(function(hit)
	local HumanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		-- Move to BlueArrive, 4 studs forward relative to its facing direction
		local forward = BlueArrive.CFrame.LookVector
		HumanoidRootPart.CFrame = BlueArrive.CFrame + forward * 4

		BlueTP.CanTouch = false
		task.wait(2)
		BlueTP.CanTouch = true
	end
end)

BlueTP.Touched:Connect(function(hit)
	local HumanoidRootPart = hit.Parent:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		-- Move to RedArrive, 4 studs forward relative to its facing direction
		local forward = RedArrive.CFrame.LookVector
		HumanoidRootPart.CFrame = RedArrive.CFrame - forward * 15

		RedTP.CanTouch = false
		task.wait(2)
		RedTP.CanTouch = true
	end
end)

