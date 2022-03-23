local Players = game:GetService('Players')

local Stocking = script.Parent.Parent
local Shared = Stocking.Shared
local Functions = require(Shared.Functions)
local warn = require(Shared.Warn)

return function(Objects, Events, Configuration)
    local Items = Objects.Items
    local Tools = Objects.Tools

    for _, Category in pairs(Items:GetChildren()) do
        for _, Obj in pairs(Category:GetChildren()) do
            Obj:SetAttribute('Stock', true)
            local Detector = Functions.CreateDetector()
            Detector.Parent = Obj

            Functions.BindDetectorToEvent(Detector, function(Player)
                if not Obj:GetAttribute('Stock') then
                    return
                end -- Make sure product isn't out of stock.
                    
                local Backpack = Player:WaitForChild('Backpack')
                local Tool = Tools:FindFirstChild(Category.Name)

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

                    if Detector.ClassName == 'ClickDetector' then
                        Detector.MaxActivationDistance = 0
					end -- Hacky but working method to "disable" a click detector without destroying or dealing with connections.
					
					if Detector.ClassName == 'ProximityPrompt' then
						Detector.Enabled = false
					end
                end
            end)
        end
    end
end
