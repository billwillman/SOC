local _M = _MOE.class("CommonMsgProcesser")

_M.MsgDispatch = {
}

function _M:OnMsg(msg)
    print(_MOE.TableUtils.Serialize(msg))
    local func = _M.MsgDispatch[msg.MsgId]
    if func then
        func(msg)
        return true
    end
    return false
end

return _M