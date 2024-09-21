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
    self.DsClientTokenToDsToken = {} -- DS Client端口 转 DsToken
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
    local command = string.format("%s \"%s\" -batchmode -nographics",absolutePath, jsonStr) -- -logFile dsRuntime.log
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
    local clientToken = self:GetDsToknFromAddr(ip, port)
    print(string.format("[DSA] OnDsSocketConnect ip: %s port: %d clientToken: %s", ip, port, clientToken))
end

function _M:GetDsClientToken(fd)
    local ip, port = GetIpAndPort(socket, fd)
    local clientToken = self:GetDsToknFromAddr(ip, port)
    return clientToken
end

function _M:OnDsStartReady(msg, fd, msgProcesser)
    if not msg then
        return
    end
    local dsToken = msg.dsToken
    if not dsToken then
        local ip = msg.dsIp
        local port = msg.dsPort
        dsToken = self:GetDsToknFromAddr(ip, port)
        local clientToken = self:GetDsClientToken(fd)
        if clientToken and dsToken then
            self.DsClientTokenToDsToken[clientToken] = dsToken
            if not self.DsTokenHandlerMap[dsToken] then
                self.DsTokenHandlerMap[dsToken] = {}
            end
            local data = self.DsTokenHandlerMap[dsToken]
            data.clientToken = clientToken
            -- 通知DS更新dsToken
            msgProcesser:SendTableToJson2(socket, fd, _MOE.MsgIds.SM_DS_ReadyRep, {dsToken = dsToken})
        end
    end
    -- 关掉定时器关闭
    self:ClearDs_ConnectStopTimer(dsToken)
end

function _M:GetDsTokenFromDsClientToken(clientToken)
    if not clientToken then
        return
    end
    local dsToken = self.DsClientTokenToDsToken[clientToken]
    return dsToken
end

function _M:ClearDs_ConnectStopTimer(dsToken)
    if not dsToken then
        return
    end
    local data = self.DsTokenHandlerMap[dsToken]
    if not data then
        return
    end
    local connectTime = data.connectTime
    if connectTime then
        moon.remove_timer(connectTime) -- 关掉定时器
        data.connectTime = nil
    end
end

function _M:ClearDsData(dsToken)
    if not dsToken then
        return
    end
    local data = self.DsTokenHandlerMap[dsToken]
    if not data then
        return
    end
    local clientToken = data.clientToken
    if clientToken then
        self.DsClientTokenToDsToken[clientToken] = nil
    end
    self:ClearDs_ConnectStopTimer(dsToken)

    self.DsTokenHandlerMap[dsToken] = nil
end

-- Ds突然断线
function _M:OnDsSocketClose(fd)
    local clientToken = self:GetDsClientToken(fd)
    if not clientToken then
        return
    end
    local dsToken = self:GetDsTokenFromDsClientToken(clientToken)
    print(string.format("[DSA] OnDsSocketClose ip: %s port: %d clientToken: %s dsToken: %s", ip, port, clientToken, dsToken))
    self:ClearDsData(dsToken)
end

function _M:StopDS(dsToken)
    if not dsToken then
        return false
    end
    local data = self.DsTokenHandlerMap[dsToken]
    if data then
        local handler = data.handler
        self:ClearDsData(dsToken)
        if handler then
            print("[DSA] StopDS: " .. tostring(handler))
            handler:close() -- 杀进程
        end
        return true
    end
    return false
end

return _M