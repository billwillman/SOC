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
    --socket.write(fd, string.pack(">H",#str)..str)
    socket.write(fd, str)
end

function _M:_OnMsg(msg, socket, fd)
    print(_MOE.TableUtils.Serialize(msg))
    local func = _M.MsgDispatch[msg.msgId]
    if func then
        func(self, msg, socket, fd)
        return true
    end
    print("[OnMsg Error] MsgId: " .. msg.msgId)
    return false
end

function _M:OnMsg(msg, socket, fd)
    local data = moon.decode(msg, "Z")
    if not data then
        print("[OnMsg] socket close: not data")
        -- 关闭Socket
        socket.close(fd)
        return false
    end
    msg = json.decode(data)
    if not msg.msgId then
        print("[OnMsg] socket close: not msg.msgId")
        socket.close(fd)
        return false
    end
    if not self:_OnMsg(msg, socket, fd) then
        print("[OnMsg] socket close: not _OnMsg")
        socket.close(fd)
        return false
    end
    return true
end

return _M