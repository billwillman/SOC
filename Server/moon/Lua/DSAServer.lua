-- DSA服务器
require("LuaPanda").start("127.0.0.1", 20003)

local json = require("json")
local moon = require("moon")
local socket = require "moon.socket"
require("InitGlobalVars")
require("ServerCommon.ServerMsgIds")

local serverCfgStr = io.readfile("./Config/Server.json")
local serverCfg = json.decode(serverCfgStr)
local ServerData = serverCfg.DSA
serverCfg = nil
serverCfgStr = nil

local listenfd = socket.listen(ServerData.ip, ServerData.port, moon.PTYPE_SOCKET_MOON)
socket.start(listenfd)

--注册网络事件
socket.on("accept",function(fd, msg)
    print("accept ", fd, moon.decode(msg, "Z"))
    socket.settimeout(fd, 10)
    --socket.setnodelay(fd)
    --socket.set_enable_chunked(fd, "w")
end)

socket.on("close", function(fd, msg)
    print("close ", fd, moon.decode(msg, "Z"))
end)

-- 异步拉起DS
local function StartDSAsync()
end

-------------------------------------------- 服务器之间通信 ------------------------------------------

-- 跨服务器处理
local _Server_DSA_Process = {
    [_MOE.ServerMsgIds.CM_ReqDS] = function (playerInfo)
        -- 拉起DS
    end
}

moon.dispatch("lua", function(_, _, cmd, ...)
    -- 处理 cmd
    local OnProcess = _Server_DSA_Process[cmd]
    if OnProcess then
        OnProcess(...)
    end
end)