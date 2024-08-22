local baseClass = require("CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")

local CurrentMsgProcess = {

}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M