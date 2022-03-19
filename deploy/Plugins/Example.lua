-- ██████╗░██████╗░░█████╗░██████╗░██╗░░░░░███████╗████████╗
-- ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██║░░░░░██╔════╝╚══██╔══╝
-- ██║░░██║██████╔╝██║░░██║██████╔╝██║░░░░░█████╗░░░░░██║░░░
-- ██║░░██║██╔══██╗██║░░██║██╔═══╝░██║░░░░░██╔══╝░░░░░██║░░░
-- ██████╔╝██║░░██║╚█████╔╝██║░░░░░███████╗███████╗░░░██║░░░
-- ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░╚══════╝╚══════╝░░░╚═╝░░░
-- Refer to our documentation to learn about plugins: https://nicklaus.gitbook.com/droplet/

return function(Events)
    Events.Pickup:Connect(function(Player, Product)
        print(Player.Name, ' picked up ', Product.Name)
    end)  -- This can also be used to display interface when a product goes out of stock - view our documentation!

    Events.Restock:Connect(function(Player, Product)
        print(Player.Name, ' started to restock ', Product.Name)
    end) -- This can also be used to display interface when a product goes out of stock - view our documentation!

    Events.SupplyToolPickup:Connect(function(Player)
        print(Player.Name, ' picked up the supply tool.')
    end)
end