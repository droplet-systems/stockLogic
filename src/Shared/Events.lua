-- Events.lua
-- Nicklaus_s
-- March 13th 2022

local HttpService = game:GetService('HttpService')

local Events = {}
Events.__index = Events

function Events.New()
    local self = setmetatable({}, Events)

    self._Event = Instance.new('BindableEvent')
    self._Arguments = {}

    return self
end

function Events:Fire(...)
    if not self._Event then
        return
    end

    local Key = HttpService:GenerateGUID(false)

    local Arguments = table.pack(...)
    self._Arguments[Key] = Arguments

    self._Event:Fire(Key)
end

function Events:Connect(Run)
    if not type(Run) == 'function' then return end

    return self._Event.Event:Connect(function(Key)
        local Arguments = self._Arguments[Key]

        if Arguments then
            Run(table.unpack(Arguments, 1, Arguments.n))
        else
            return
        end


    end)
end

function Events:OnRun()
    local Key = self._Event.Event:Wait()
    local Arguments = self._Arguments[Key]

    if Arguments then
        return table.unpack(Arguments, 1, Arguments.n)
    else
        return
    end
end

function Events:Destroy()
    if self._Event then
        self._Event:Destroy()
        self._Event = nil
    end

    setmetatable(self, nil)
end

return Events