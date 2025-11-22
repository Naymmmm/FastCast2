--[[
	- Author : Mawin CK
	- Date : 2025
]]

local ErrorMessage = {}

ErrorMessage.ERR_NOT_INSTANCE = "Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"
ErrorMessage.ERR_INVALID_TYPE = "Invalid type for parameter '%s' (Expected %s, got %s)"
ErrorMessage.FC_VIS_OBJ_NAME = "FastCastVisualizationObjects"
ErrorMessage.ERR_OBJECT_DISPOSED = "This ActiveCast has been terminated. It can no longer be used."

return ErrorMessage
