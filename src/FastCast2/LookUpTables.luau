--[[
	- Author : Mawin CK
	- Date : 2025
]]

local LookUpTable = {}

LookUpTable.Supported_Lib_GETPART = {
	["PartCache"] = function(
		CosmeticBulletProvider : any, 
		origin : Vector3,
		direction : Vector3
	)
		local newPart = CosmeticBulletProvider:GetPart()
		newPart.CFrame = CFrame.new(origin, origin + direction)
		return newPart
	end,
	["ObjectCache"] = function(
		CosmeticBulletProvider : any, 
		origin : Vector3,
		direction : Vector3
	)
		return CosmeticBulletProvider:GetPart(CFrame.new(origin, origin+direction))
	end,
}

LookUpTable.Supported_Lib_GETCONTAINER = {
	["PartCache"] = function(CosmeticBulletProvider : any)
		return CosmeticBulletProvider.CurrentCacheParent
	end,
	["ObjectCache"] = function(CosmeticBulletProvider : any)
		return CosmeticBulletProvider.CacheHolder
	end,
}

return LookUpTable
