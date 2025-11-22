--[[
	- Author : Mawin CK
	- Date : 2025
]]

local Math = {}

function Math.GetPositionAtTime(time: number, origin: Vector3, initialVelocity: Vector3, acceleration: Vector3): Vector3
	local force = Vector3.new((acceleration.X * time^2) / 2,(acceleration.Y * time^2) / 2, (acceleration.Z * time^2) / 2)
	return origin + (initialVelocity * time) + force
end

function Math.GetVelocityAtTime(time: number, initialVelocity: Vector3, acceleration: Vector3): Vector3
	return initialVelocity + acceleration * time
end

return Math
