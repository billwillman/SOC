local _M = _MOE.class("CommonMsgProcesser")
local MsgIds = require("_NetMsg.MsgId")
local json = require("json")
local moon = require("moon")

_M.MsgDispatch = {
    [MsgIds.CM_Heart] = function (self, msg, socket, fd)
        local sendMsg = {MsgId = MsgIds.SM_Heart}
        self:SendTableToJson(socket, fd, sendMsg)
    end
}

function _M:SendTableToJson(socket, fd, sendMsg)
    if not socket or not fd or not sendMsg or not sendMsg.MsgId then
        return false
    end
    local str = json.encode(sendMsg)
    socket.write(fd, string.pack(">H",#str)..str)
end

function _M:OnMsg(msg, socket, fd)
    print(_MOE.TableUtils.Serialize(msg))
    local func = _M.MsgDispatch[msg.MsgId]
    if func then
        func(self, msg, socket, fd)
        return true
    end
    return false
end

return _M