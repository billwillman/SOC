local _M = _MOE.class("CommonMsgProcesser")
local MsgIds = require("_NetMsg.MsgId")
local json = require("json")
local moon = require("moon")
require("ServerCommon.ServerMsgIds")

_M.MsgDispatch = {
    [MsgIds.CM_Heart] = function (self, msg, socket, fd)
        self:SendHeartMsg(socket, fd)
    end
}

moon.exports.SERVER_COMMAND_PROCESS = {
    [_MOE.ServicesCall.InitDB] = function ()
        return 1
    end,
    [_MOE.ServicesCall.SaveAndQuit] = function ()
        return 1
    end,
    [_MOE.ServicesCall.Shutdown] = function ()
        return 1
    end,
    [_MOE.ServicesCall.Start] = function ()
        return 1
    end
}

function _M:SendHeartMsg(socket, fd)
    local sendMsg = {msgId = MsgIds.SM_Heart}
    self:SendTableToJson(socket, fd, sendMsg)
end

function _M:SendTableToJson2(socket, fd, msgId, msg)
    msg = msg or {}
    msg.msgId = msgId
    self:SendTableToJson(socket, fd, msg)
end

function _M:SendTableToJson(socket, fd, sendMsg)
    if not socket or not fd or not sendMsg or not sendMsg.msgId then
        return false
    end
    local str = json.encode(sendMsg)
    --socket.write(fd, string.pack(">H",#str)..str)
    socket.write(fd, str)
    return true
end

function _M:_OnMsg(msg, socket, fd)
    -- print(_MOE.TableUtils.Serialize(msg))
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

------------------------------------------- 服务器交互协议 -----------------------

moon.dispatch("lua", function(_, _, cmd, ...)
    -- 处理 cmd
    local OnProcess = SERVER_COMMAND_PROCESS[cmd]
    if OnProcess then
        OnProcess(...)
    end
end)

return _M