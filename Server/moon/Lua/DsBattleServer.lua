-- Ds连接到GS
require("LuaPanda").start("127.0.0.1", 20002)

local json = require("json")
local moon = require("moon")
local socket = require "moon.socket"
require("InitGlobalVars")

local MsgProcesser = require("DsBattleServer/DsBattleServerProcesser").New()

local serverCfgStr = io.readfile("./Config/Server.json")
local serverCfg = json.decode(serverCfgStr)
local ServerData = serverCfg.BattleSrv -- 战斗服务器
serverCfg = nil
serverCfgStr = nil

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