-- TODO:
---- Functions.BindDetectorToEvent
--- Make sure debug.traceback() works as expected.

-- STOP! These are internal functions that are not recommened to be used by plugins, therefore no documentation has been provided.

local Shared = script.Parent
local Configuration = require(Shared.Configuration)
local warn = require(Shared.Warn)

local Functions = {}
Functions.__index = Functions

---- Returns detector based off of configuration.
-- @returns Detector <ClickDetector> <ProximityPrompt>
Functions.CreateDetector = function()
    local Detector = nil

    if Configuration.Types['ClickDetector'] and Configuration.Types['ProximityPrompt'] then
        warn('Both ClickDetector and ProximityPrompt were defined as true in the configuration file, please only select one - no detector has been created.')
        return
    end
    
    for Type, Value in pairs(Configuration.Types) do
        if Value then
            Detector = Instance.new(Type)
        end
    end

    return Detector
end

---- Bind a detector created by Functions.CreateDetector to it's specific event when it's activated.
-- @param Detector <ClickDetector> <ProximityPrompt>
-- @param Execute <function>
-- @returns nil
Functions.BindDetectorToEvent = function(Detector, Run)
    local Types = {
        ClickDetector = function(Obj, Execute)
            return Obj.MouseClick:Connect(Execute)
        end,
    
        ProximityPrompt = function(Obj, Execute)
            return Obj.Triggered:Connect(Execute)
        end
    }

    if Types[Detector.ClassName] then
        Types[Detector.ClassName](Detector, Run)
    else
        warn(string.format('[%s] Detector.ClassName (%s), was not found in Types.', debug.traceback(), Detector.ClassName))
        return
    end
end

---- Set transparency of a BasePart, or it's descendants.
-- @param Obj <BasePart> <Instance>
-- @param Value <Number>
Functions.SetProductTransparency = function(Obj, Value)
    if Obj:IsA('BasePart') then
        Obj.Transparency = Value
    elseif #Obj:GetDescendants() > 0 then
        for _, Child in pairs(Obj:GetDescendants()) do
            if Child:IsA('BasePart') then
                Child.Transparency = Value
            end
        end
    end
end

return Functions