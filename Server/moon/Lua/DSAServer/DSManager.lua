require("ServerCommon.GlobalFuncs")
require("ServerCommon.GlobalServerConfig")
local moon = require("moon")
local json = require("json")
local fs = require("fs")
local socket = require "moon.socket"

local ServerData = GetServerConfig("DSA")
local battlSrvData = GetServerConfig("BattleSrv")

local _M = _MOE.class("DSManager")

function _M:Ctor()
    self.DsTokenHandlerMap = {}
end

------------------------------------- 外部调用 -------------------------

function _M:GetDsToknFromAddr(ip, port)
    if not ip or not port then
        return
    end
    return moon.md5(string.format("%s:%d", ip, port))
end

-- 启动一个DS(只负责启动，其他类逻辑不在DSA管)
function _M:StartDSAsync(playerInfos)
    if not playerInfos then
        return
    end
    -- 获取一个空闲的端口号
    local ip, port = GetFreeAdress()
    local dsToken = self:GetDsToknFromAddr(ip, port)
    if not dsToken then
        return
    end
    local dsParam = {playerInfos = playerInfos, 
        dsData = {
            ip = ip,
            port = port, 
            token = dsToken
        },
        dsaData = {
            ip = ServerData.ip,
            port = ServerData.port
        },
        battleData = {
            ip = battlSrvData.ip,
            port = battlSrvData.port
        }
    }
    local jsonStr = json.encode(dsParam)
    jsonStr = string.gsub(jsonStr, "\"", "\\\"")
    local absolutePath = fs.abspath("../../DS/Server.exe")
    local command = string.format("%s \"%s\"",absolutePath, jsonStr)
    print("[DSA] Command: " .. command)
    local handler = io.popen(command, "r")
    if not handler then
        print("[dsa] not run SOC.exe...")
        return
    end
    print(string.format("[DSA] DS Handle: %s", handler))
    --local result = handler:read("*a")
    --print("[DSA] DS Handler: " .. result)
    local ret = {
        dsToken = dsToken,
        dsIp = ip,
        dsPort = port
    }
    -- 设置定时器，30秒必须连接上DSA，否则杀进程
    local connectTime = moon.timeout(30 * 1000,
        function ()
            self:StopDS(dsToken) -- 直接杀进程
            return
        end
        )
    self.DsTokenHandlerMap[dsToken] = {
        handler = handler,
        connectTime = connectTime
    }
    return ret
end

function _M:OnDsSocketConnect(fd)
    local ip, port = GetIpAndPort(socket, fd)
    local dsToken = self:GetDsToknFromAddr(ip, port)
    if not dsToken then
        return
    end
    print(string.format("[DSA] OnDsSocketConnect ip: %s port: %d dsToken: %s", ip, port, dsToken))
    local data = self.DsTokenHandlerMap[dsToken]
    if data then
        local connectTime = data.connectTime
        if connectTime then
            moon.remove_timer(connectTime) -- 关掉定时器
            data.connectTime = nil
        end
    else
        self.DsTokenHandlerMap[dsToken] = {}
    end
end

-- Ds突然断线
function _M:OnDsSocketClose(fd)
    local ip, port = GetIpAndPort(socket, fd)
    local dsToken = self:GetDsToknFromAddr(ip, port)
    if not dsToken then
        return
    end
    print(string.format("[DSA] OnDsSocketClose ip: %s port: %d dsToken: %s", ip, port, dsToken))
    local data = self.DsTokenHandlerMap[dsToken]
    if data then
        local connectTime = data.connectTime
        if connectTime then
            moon.remove_timer(connectTime) -- 关掉定时器
        end
        self.DsTokenHandlerMap[dsToken] = nil
    end
end

function _M:StopDS(dsToken)
    if not dsToken then
        return false
    end
    local data = self.DsTokenHandlerMap[dsToken]
    if data then
        local handler = data.handler
        local connectTime = data.connectTime
        self.DsTokenHandlerMap[dsToken] = nil
        if connectTime then
            moon.remove_timer(connectTime) -- 关掉定时器
        end
        if handler then
            print("[DSA] StopDS: " .. tostring(handler))
            handler:close() -- 杀进程
        end
        return true
    end
    return false
end

return _M