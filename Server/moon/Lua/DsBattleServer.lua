-- Ds连接到GS
require("ServerCommon.GlobalServerConfig")
local ServerData = GetServerConfig("BattleSrv")

require("LuaPanda").start("127.0.0.1", ServerData.Debug)

local json = require("json")
local moon = require("moon")
local socket = require "moon.socket"
require("InitGlobalVars")

local MsgProcesser = require("DsBattleServer/DsBattleServerProcesser").New()

local listenfd = socket.listen(ServerData.ip, ServerData.port, moon.PTYPE_SOCKET_MOON)
socket.start(listenfd)--auto accept

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

socket.on("message", function(fd, msg)
    MsgProcesser:OnMsg(msg, socket, fd)
end)