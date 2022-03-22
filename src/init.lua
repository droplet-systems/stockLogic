-- ██████╗░██████╗░░█████╗░██████╗░██╗░░░░░███████╗████████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░░░░██╔════╝╚══██╔══╝
-- ██║░░██║██████╔╝██║░░██║██████╔╝██║░░░░░█████╗░░░░░██║░░░
-- ██║░░██║██╔══██╗██║░░██║██╔═══╝░██║░░░░░██╔══╝░░░░░██║░░░
-- ██████╔╝██║░░██║╚█████╔╝██║░░░░░███████╗███████╗░░░██║░░░
-- ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚══════╝╚══════╝░░░╚═╝░░░
-- Refer to our documentation to set up our product properly: https://nicklaus.gitbook.com/droplet/
-- STOP! Programmers only, if you don't know what you are doing, DO NOT change anything in this file.

local RunService = game:GetService('RunService')
if RunService:IsClient() then
    warn('Attempted to deploy on the client! Did you complete the setup properly? Perhaps you should read our documentation.')
    return
end

local Stocking = script
local Server = Stocking.Server
local Shared = Stocking.Shared
local Signal = require(Shared.Events)
local warn = require(Shared.Warn)

return function (Config: ModuleScript, Objects)
    local Configuration = nil

    if Config then
        Config.Parent = Shared
        Configuration = require(Config)
    else
        warn('The configuration file was not found. Did you complete the setup properly? Perhaps you should read our documentation.')
        return
    end

    local Items = Objects.Items
    local Supplies = Objects.Supplies
    local Tools = Objects.Tools
    local SupplyTool = Objects.SupplyTool

    if not (Items or Tools) then
        warn('Items or tools were not included while being deployed. Did you complete the setup properly? Perhaps you should read our documentation.')
        return
    end

    if not (Supplies or SupplyTool) and Configuration.Stocking.Enabled then
        warn('Suppliers or the supply tool were not included while being deployed. Did you complete the setup properly? Perhaps you should read our documentation.')
    end

    local Events = {
        Pickup = Signal.New(),
        Restock = Signal.New(),
        SupplyToolPickup = Signal.New()
    }

    if Objects.Plugins then
        local Plugins = Objects.Plugins

        for _, Obj in pairs(Plugins:GetChildren()) do
            if Obj:IsA('ModuleScript') then
                local Module = require(Obj)

                if type(Module) == 'function' then
                    Module(Events, Config)
                else
                    warn(string.format('[Malformed Plugin - %s] Expected type function, but got type %s, plugin has been skipped & ignored.', Obj.Name, typeof(Module)))
                    return
                end
            end
        end
    end

    for _, Script in pairs(Server:GetChildren()) do
        if Script:IsA('ModuleScript') then
            local Module = require(Script)

            if type(Module) == 'function' then
                Module(Objects, Events, Configuration)
            end
        end
    end
end
