-- Nicklaus_s

local OutOfStock = script.OutOfStock

return function(Events)
    Events.Pickup:Connect(function(Player, Category, Product)
		local Clone = OutOfStock:Clone()
		Clone.Adornee = Product
		Clone.Parent = Product
    end)

	Events.Restock:Connect(function(Player, Category, Product)
		local Interface = Product:FindFirstChild(OutOfStock.Name)
		
		if Interface then
			Interface:Destroy()
		end
    end)
end
