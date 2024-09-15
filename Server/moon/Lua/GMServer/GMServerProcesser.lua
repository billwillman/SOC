local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("GMServerProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")

local CurrentMsgProcess = {
    [MsgIds.CM_GM] = function (self, msg, socket, fd)
    end
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M