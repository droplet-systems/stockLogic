-- Pickup.lua
-- Nicklaus_s
-- Mar 18, 2022

local Players = game:GetService('Players')

local Stocking = script.Parent.Parent
local Shared = Stocking.Shared
local warn = require(Shared.Warn)

local Types = {
    ['ClickDetector'] = function(Obj, Run)
        return Obj.MouseClick:Connect(Run)
    end,

    ['ProximityPrompt'] = function(Obj, Run)
        return Obj.Activated:Connect(Run)
    end
}

local setObjTransparency = function(Obj, Value)
    if Obj:IsA('BasePart') then Obj.Transparency = Value end

    for _, Object in pairs(Obj:GetDescendants()) do
        if Object:IsA('BasePart') then
            Object.Transparency = Value
        end
    end
end

return function(Objects, Events, Configuration)
    local Items = Objects.Items
    local Tools = Objects.Tools

    for _, Obj in pairs(Items:GetChildren()) do
        Obj:SetAttribute('Stock', true)
        local Detector = nil

        for Type, Value in pairs(Configuration.Types) do
            if Value then
                Detector = Instance.new(Type)
                Detector.Parent = Obj
            end
        end

        Types[Detector.ClassName](Detector, function(Player)
            local Backpack = Player:WaitForChild('Backpack')
            local Tool = Tools:FindFirstChild(Obj.Name)

            if Tool then
                for _, Object in pairs(Backpack:GetChildren()) do
                    if Object.Name == Object.Name and Configuration.Stocking.RestrictAmount then
                        return
                    end
                end

                local Clone = Tool:Clone()
                Clone.Parent = Backpack

                Events.Pickup:Fire(Player, Obj)
            end

            if Configuration.Stocking.Enabled then
                setObjTransparency(Obj, 1)
                Obj:SetAttribute('Stock', false)
            end
        end)
    end
end