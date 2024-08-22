local _M = _MOE.class("CommonMsgProcesser")

_M.MsgDispatch = {
    [MsgIds.CM_Heart] = function (msg, socket, fd)
    end
}

function _M:OnMsg(msg, socket, fd)
    print(_MOE.TableUtils.Serialize(msg))
    local func = _M.MsgDispatch[msg.MsgId]
    if func then
        func(msg, socket, fd)
        return true
    end
    return false
end

return _M