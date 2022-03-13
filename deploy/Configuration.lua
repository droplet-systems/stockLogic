-- ██████╗░██████╗░░█████╗░██████╗░██╗░░░░░███████╗████████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░░░░██╔════╝╚══██╔══╝
-- ██║░░██║██████╔╝██║░░██║██████╔╝██║░░░░░█████╗░░░░░██║░░░
-- ██║░░██║██╔══██╗██║░░██║██╔═══╝░██║░░░░░██╔══╝░░░░░██║░░░
-- ██████╔╝██║░░██║╚█████╔╝██║░░░░░███████╗███████╗░░░██║░░░
-- ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚══════╝╚══════╝░░░╚═╝░░░
-- Refer to our documentation to set up our product properly: https://nicklaus.gitbook.com/droplet/

return {
    AnalyticalLogging = true,

    Group = 1,
    Whitelisted = {200, 250, 255},
    IgnoreIfNoStaff = true,

    Type = {
        ClickDetector = true,
        Prompt = false
    },
    Restriction = 1,
    Magnitude = 15
}