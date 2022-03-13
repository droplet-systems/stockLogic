-- Stocking.lua
-- Nicklaus_s
-- Mar 3, 2022

local RunService = game:GetService('RunService')

local Players = game:GetService('Players')
local ServerScriptService = game:GetService('ServerScriptService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local Stocking = script
local Server = Stocking.Server
local Shared = Stocking.Shared
local warn = require(Shared.Modules.Warn)

if RunService:IsClient() then
    warn('Attempted to deploy on the client!')
end

return function (Configuration: ModuleScript, Objects)
    local Items = Objects.Items
    local Supplies = Objects.Supplies
    local Tools = Objects.Tools
    local Screens = Objects.Screens

    if not (Items or Supplies or Tools or Screens) then
        warn('Items, supplies, tools, or screens were not included while being deployed. Did you complete the setup properly?')
        return
    end

    Server.Name, Server.Parent = 'Stocking', ServerScriptService
    Shared.Name, Shared.Parent = 'Stocking', ReplicatedStorage

    -- We use this system to help prevent race conditions and ensure parents are set before being indexed, etc.
    for _, Obj in pairs(Server:GetDescendants()) do
        if Obj:IsA('ModuleScript') then
            local Module = require(Obj)

            if type(Module) == 'function' then
                Module()
            end
        end
    end
end