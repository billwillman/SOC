local baseClass = require("CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")

_M.MsgDispatch = {
    [MsgIds.CM_Heart] = function (msg)
    end
}

return _M