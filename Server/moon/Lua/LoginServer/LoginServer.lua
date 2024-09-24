require("ServerCommon.GlobalServerConfig")
require("InitGlobalVars")

local ServerData = GetServerConfig("LoginSrv")
require("LuaPanda").start("127.0.0.1", ServerData.Debug)

local json = require("json")
local moon = require("moon")
local socket = require "moon.socket"

local MsgProcesser = require("LoginServer/LoginMsgProcesser").New()

moon.exports.ServerData = ServerData
moon.exports.PlayerManager = require("LoginServer.PlayerManager").New()

moon.exports.OnAccept = function(fd, msg)
    print("accept ", fd, moon.decode(msg, "Z"))
    socket.settimeout(fd, 10)
    --socket.setnodelay(fd)
    --socket.set_enable_chunked(fd, "w")
    --[[
    local serverInfo = moon.server_stats()
    print(serverInfo)
    ]]
end

moon.exports.OnMessage = function(fd, msg)
    MsgProcesser:OnMsg(msg, socket, fd)
end

moon.exports.OnClose = function(fd, msg)
    PlayerManager:RemovePlayer(fd)
    print("close ", fd, moon.decode(msg, "Z"))
end

--[[
socket.on("error", function(fd, msg)
    print("error ", fd, moon.decode(msg, "Z"))
end)
]]