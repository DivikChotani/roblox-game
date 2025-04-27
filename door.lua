local doorModel = script.Parent
local door = doorModel:WaitForChild("doorframe")
local handle = doorModel:WaitForChild("doorhandle")
local wall = workspace:FindFirstChild("portalWall")

local TweenService = game:GetService("TweenService")
local ClickDetector = door:WaitForChild("ClickDetector")

-- Weld handle to door so they move together
local weld = Instance.new("WeldConstraint")
weld.Part0 = door
weld.Part1 = handle
weld.Parent = door

-- Hinge math
local hingeOffset = door.Size.X / 2
local pivot = door.CFrame * CFrame.new(-hingeOffset, 0, 0)
local rotation = CFrame.Angles(0, math.rad(90), 0)
local finalDoorCFrame = pivot * rotation * CFrame.new(hingeOffset, 0, 0)

local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local doorTween = TweenService:Create(door, tweenInfo, {CFrame = finalDoorCFrame})

ClickDetector.MouseClick:Connect(function()
	doorTween:Play()

	task.wait(1)

	door.CanCollide = false
	handle.CanCollide = false
	if wall then
		wall.CanCollide = false
	end
end)

