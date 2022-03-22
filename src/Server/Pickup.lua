local Players = game:GetService('Players')

local Stocking = script.Parent.Parent
local Shared = Stocking.Shared
local Functions = require(Shared.Functions)
local warn = require(Shared.Warn)

return function(Objects, Events, Configuration)
    local Items = Objects.Items
    local Tools = Objects.Tools

    for _, Obj in pairs(Items:GetChildren()) do
        Obj:SetAttribute('Stock', true)
        local Detector = Functions.CreateDetector()
        Detector.Parent = Obj

        Functions.BindDetectorToEvent(Detector, function(Player)
            if not Obj:GetAttribute('Stock') then
                return
            end -- Make sure product isn't out of stock.
                
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
                Functions.SetProductTransparency(Obj, 1)
                Obj.CanCollide = false
                Obj:SetAttribute('Stock', false)
            end
        end)
    end
end
