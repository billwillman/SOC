-- DSA服务器
require("ServerCommon.GlobalServerConfig")
require("InitGlobalVars")
local ServerData = GetServerConfig("DSA")

require("LuaPanda").start("127.0.0.1", ServerData.Debug)

local json = require("json")
local moon = require("moon")
local socket = require "moon.socket"
-- require("ServerCommon.GlobalFuncs")
-- local TableUtils = require("_Common.TableUtils")

local DSManager = require("DSAServer.DSManager").New()
moon.exports.DSManager = DSManager
moon.exports.ServerData = ServerData
local MsgProcesser = require("DSAServer/DSAServerProcesser").New()
moon.exports.MsgProcesser = MsgProcesser

moon.exports.OnAccept = function(fd, msg)
    print("accept ", fd, moon.decode(msg, "Z"))
    socket.settimeout(fd, 10)
    --socket.setnodelay(fd)
    --socket.set_enable_chunked(fd, "w")
    DSManager:OnDsSocketConnect(fd)
end

moon.exports.OnClose = function(fd, msg)
    print("close ", fd, moon.decode(msg, "Z"))
    DSManager:OnDsSocketClose(fd)
end

moon.exports.OnMessage = function(fd, msg)
    MsgProcesser:OnMsg(msg, socket, fd)
end

--[[
local TokenToDSHandleMap = {}
local DSHandleToTokens = {}
local DSSeverMap = {} -- 已经连接成功的DS

-- 异步拉起DS
local function StartDSAsync(playerInfos)
    if not playerInfos then
        return false
    end
    for _, playerInfo in pairs(playerInfos) do
        local token = playerInfo.token
        local handler = TokenToDSHandleMap[token]
        if handler then
            local tokens = DSHandleToTokens[handler]
            DSHandleToTokens[handler] = nil
            if tokens then
                for _, t in pairs(tokens) do
                    TokenToDSHandleMap[t] = nil
                end
            end
            handler:close() -- 杀进程
        end
    end
    -- 获取一个空闲的端口号
    local ip, port = GetFreeAdress()
    local dsToken = moon.md5(string.format("%s:%d", ip, port))
    local dsParam = {playerInfos = playerInfos, DsIp = ip, DsPort = port, DsToken = dsToken}
    -- print("[dsa] start dsServer Param: %s", TableUtils.Serialize(dsParam))
    local jsonStr = json.encode(dsParam)
    print("[DSA] Command: " .. jsonStr)
    local handler = io.popen("SOC.exe " .. jsonStr, "r")
    if not handler then
        print("[dsa] not run SOC.exe...")
        return false
    end
    -- 关联handler,如果服务器断线关闭此DS
    local t = DSHandleToTokens[handler]
    if not t then
        t = {}
        DSHandleToTokens[handler] = t
    end
    for _, playerInfo in pairs(playerInfos) do
        local token = playerInfo.token
        TokenToDSHandleMap[token] = handler
        table.insert(t, token)
    end
    --
    return true
end
]]