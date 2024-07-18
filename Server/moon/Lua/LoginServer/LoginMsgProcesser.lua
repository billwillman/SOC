local _M = _MOE.class("LoginMsgProcesser")

local TableUtils = require("_Common.TableUtils")
local MsgIds = require("_NetMsg.MsgId")

_M.MsgDispatch = {
    [MsgIds.CM_Heart] = function (msg)
    end
}

function _M:OnMsg(msg)
    print(TableUtils.Serialize(msg))
    local func = _M.MsgDispatch[msg.MsgId]
    if func then
        func(msg)
    end
end

return _M