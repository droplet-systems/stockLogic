-- ██████╗░██████╗░░█████╗░██████╗░██╗░░░░░███████╗████████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░░░░██╔════╝╚══██╔══╝
-- ██║░░██║██████╔╝██║░░██║██████╔╝██║░░░░░█████╗░░░░░██║░░░
-- ██║░░██║██╔══██╗██║░░██║██╔═══╝░██║░░░░░██╔══╝░░░░░██║░░░
-- ██████╔╝██║░░██║╚█████╔╝██║░░░░░███████╗███████╗░░░██║░░░
-- ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚══════╝╚══════╝░░░╚═╝░░░
-- Refer to our documentation to set up our product properly: https://nicklaus.gitbook.com/droplet/

local Workspace = game:GetService('Workspace')
local ServerStorage = game:GetService('ServerStorage')

require(script.MainModule)(script.Configuration, {
    Items = Workspace.Items,
    Supplies = Workspace.Supplies,
    Tools = ServerStorage.Tools,
    SupplyTool = ServerStorage['Restock Tool'],

    Plugins = script.Plugins
})