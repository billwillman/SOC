local _M = _MOE.class("LoginMsgProcesser")

local MsgIds = require("_NetMsg.MsgId")

_M.MsgDispatch = {
    [MsgIds.CM_Heart] = function (msg)
    end
}

function _M:OnMsg(msg)
    print(_MOE.TableUtils.Serialize(msg))
    local func = _M.MsgDispatch[msg.MsgId]
    if func then
        func(msg)
    end
end

return _M