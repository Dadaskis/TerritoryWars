local TW = TerritoryWars

function TW.Permisions() 
	local result = {}
	for key, _ in pairs(TW.PermisionsList) do
		result[key] = false
	end
	return result
end