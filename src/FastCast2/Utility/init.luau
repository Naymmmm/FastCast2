--[[
	- Author : Mawin CK
	- Date : 2025
]]

--!strict

-- Requires
local UtilityModule = script.Parent:WaitForChild("Utility")

local MathUtil = require(UtilityModule.Math)
local ErrorMsgs = require(UtilityModule.ErrorMessage)
local TypeDef = require(script.Parent:WaitForChild("TypeDefinitions"))

-- CONSTs
local FC_VIS_OBJ_NAME = "FastCastVisualizationObjects"

-- Local functions


-- Module

local module = {}

function module.CloneCastParams(params: RaycastParams): RaycastParams
	local clone : RaycastParams = RaycastParams.new()
	clone.CollisionGroup = params.CollisionGroup
	clone.FilterType = params.FilterType
	clone.FilterDescendantsInstances = params.FilterDescendantsInstances
	clone.IgnoreWater = params.IgnoreWater
	return clone
end

function module.GetFastCastVisualizationContainer(): Instance
	local fcVisualizationObjects = workspace.Terrain:FindFirstChild(FC_VIS_OBJ_NAME)
	if fcVisualizationObjects then
		return fcVisualizationObjects
	end
	
	fcVisualizationObjects = Instance.new("Folder")
	fcVisualizationObjects.Name = FC_VIS_OBJ_NAME
	fcVisualizationObjects.Archivable = false
	fcVisualizationObjects.Parent = workspace.Terrain
	return fcVisualizationObjects
end

function module.GetTrajectoryInfo(
	cast: TypeDef.ActiveCast | TypeDef.ActiveBlockCast, 
	index: number
): {[number]: Vector3}
	assert(cast.StateInfo.UpdateConnection ~= nil, ErrorMsgs.ERR_OBJECT_DISPOSED)
	local trajectories = cast.StateInfo.Trajectories
	local trajectory = trajectories[index]
	local duration = trajectory.EndTime - trajectory.StartTime

	local origin = trajectory.Origin
	local vel = trajectory.InitialVelocity
	local accel = trajectory.Acceleration

	return {MathUtil.GetPositionAtTime(duration, origin, vel, accel), MathUtil.GetVelocityAtTime(duration, vel, accel)}
end

function module.GetLatestTrajectoryEndInfo(cast: TypeDef.ActiveCast | TypeDef.ActiveBlockCast): {[number]: Vector3}
	return module.GetTrajectoryInfo(cast, #cast.StateInfo.Trajectories)
end

return module
