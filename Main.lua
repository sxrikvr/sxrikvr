local camera = workspace.CurrentCamera 
local functions = {}
local Keybindactive = false
local Camlockactive = false

do
    functions.getMouseposition = function()
        local MouseLocation = game:GetService("UserInputService"):GetMouseLocation()
        return Vector2.new(MouseLocation.x, MouseLocation.y)
    end
    
    functions.getNearestPlayer = function()
        local nearestPlayer, closestDistance = nil, math.huge

        for _, Player in (game:GetService("Players"):GetPlayers()) do
            if Player == game:GetService("Players").LocalPlayer then continue end
            
            local Mobroot = Player.Character:FindFirstChild("HumanoidRootPart")
            if not Mobroot then continue end
            
            local Position, onScreen = camera:WorldToViewportPoint(Mobroot.Position)
            if not onScreen then continue end

            local distance = (functions.getMouseposition() - Vector2.new(Position.x, Position.y)).Magnitude
            if distance <= closestDistance then
                nearestPlayer, closestDistance = Player, distance
            end 
        end
        return nearestPlayer, closestDistance
    end
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        Keybindactive = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        Keybindactive = false
    end
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if not Camlockactive then return end
    if not Keybindactive then return end

    local Target = functions.getNearestPlayer()
    if not Target then return end

    camera.CFrame = CFrame.new(camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
end)

local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()

local X = Material.Load({
	Title = "made by striker (under spectrum supervision)",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Dark",
})

local Y = X.New({
	Title = "1"
})

local Z = X.New({
	Title = "2"
})

local B = Y.Toggle({
	Text = "Camlock",
	Callback = function(Value)
        Camlockactive = Value
	end,
	Enabled = false
})
