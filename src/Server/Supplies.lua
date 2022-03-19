-- Supplies.lua
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
    local Supplies = Objects.Supplies
    local SupplyTool = Objects.SupplyTool

    for _, Obj in pairs(Supplies:GetChildren()) do
        local Detector = nil

        for Type, Value in pairs(Configuration.Types) do
            if Value then
                Detector = Instance.new(Type)
                Detector.Parent = Obj
            end
        end

        Types[Detector.ClassName](Detector, function(Player)
            if table.find(Configuration.Stocking.Whitelisted, Player:GetRankInGroup(Configuration.Stocking.Group)) then
                local Backpack = Player:WaitForChild('Backpack')

                local Tool = SupplyTool:Clone()
                Tool.Parent = Backpack

                Events.SupplyToolPickup:Fire(Player)

                Tool.Activated:Connect(function()
                    for _, Item in pairs(Items:GetChildren()) do
                        if not Item:GetAttribute('Stock') then
                            local Character = Player.Character or Player.CharacterAdded:Wait()
                            local HumanoidRootPart = Character.HumanoidRootPart
                            -- In theory since we are waiting for the Character to load, the HumanoidRootPart
                            -- SHOULD be loaded, I probably should use WaitForChild, but..

                            local Magnitude = math.round((HumanoidRootPart.Position - Item.Position or Item:GetPivot()).Magnitude)

                            if Magnitude <= Configuration.Stocking.MaxDistance then
                                setObjTransparency(Item, 0)
                                Item:SetAttribute('Stock', true)

                                Events.Restock:Fire(Player, Item)
                                
                                return
                            end
                        end
                    end
                end)
            end
        end)
    end
end