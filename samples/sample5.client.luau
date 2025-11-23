-- Services
local Rep = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RS = game:GetService("RunService")

-- Modules
local FastCast2Module = Rep:WaitForChild("FastCast2")

-- Requires
local FastCast = require(FastCast2Module)
local TypeDef = require(FastCast2Module:WaitForChild("TypeDefinitions"))

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local OriginPart = character:WaitForChild("Head")

local TargetPos = Vector3.new(0,5,0)
local SPEED = 45

local ProjectileTemplate = Rep:WaitForChild("Projectile")
-- Setup

local CastParams = RaycastParams.new()
CastParams.FilterType = Enum.RaycastFilterType.Exclude
CastParams.FilterDescendantsInstances = {character}
CastParams.IgnoreWater = true


local behavior = FastCast.newBehavior()
behavior.RaycastParams = CastParams
behavior.AutoIgnoreContainer = true
behavior.Acceleration = Vector3.new(0,-workspace.Gravity,0)


local Caster = FastCast.new()
Caster:Init(
	12, -- numWorkers
	player, -- Where VMs Stored
	"CastVMs", -- Name of VMs
	game:GetService("ReplicatedFirst"):WaitForChild("CastVMsContainer"), -- Where workers stored
	"VMsContainer", -- Name Folder of workerFolder
	"CastWorkers",-- Name of workers
	true, -- useObjectCache?
	ProjectileTemplate, -- BulletTemplate
	100, -- CacheSize
	workspace:WaitForChild("Projectiles") -- ProjectileContainer
)

-- Local functions
local function OnRayHit(
	ActiveCast : TypeDef.ActiveCast, 
	resultOfCast : RaycastResult, 
	segmentVelocity : Vector3, 
	segmentAcceleration : Vector3, 
	cosmeticBulletObject : Instance?
)
	FastCast:SafeCall(ActiveCast.Terminate)
end

local function OnLengthChanged(
	ActiveCast : TypeDef.ActiveCast, 
	lastPoint : Vector3, 
	rayDir : Vector3, 
	rayDisplacement : number, 
	segmentVelocity : Vector3, 
	cosmeticBulletObject : Instance?
)
	if cosmeticBulletObject then
		cosmeticBulletObject.CFrame = CFrame.new(lastPoint, lastPoint + rayDir) * CFrame.new(0, 0, -rayDisplacement / 2)
	end
end

local function OnCastTerminating(cast : TypeDef.ActiveCast)
	local obj = cast.RayInfo.CosmeticBulletObject

	Caster:ReturnObject(obj)
end

-- Listeners
Caster.LengthChanged:Connect(OnLengthChanged)
Caster.CastTerminating:Connect(OnCastTerminating)
Caster.RayHit:Connect(OnRayHit)


RS.Heartbeat:Connect(function()
	local Origin = OriginPart.Position
	local Direction = (TargetPos - Origin).Unit
	
	Caster:RaycastFire(Origin, Direction, SPEED, behavior)
end)
