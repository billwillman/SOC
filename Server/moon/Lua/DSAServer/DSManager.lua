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
    self.FdToDsTokenMap = {}
end

------------------------------------- 外部调用 -------------------------

function _M:GetDsToknFromAddr(ip, port)
    if not ip or not port then
        return
    end
    local ret = GenerateToken2(ip, port)
    return ret
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
    handler:read("*a")
    print(string.format("[DSA] DS Handle: %s", handler))
    --local result = handler:read("*a")
    --print("[DSA] DS Handler: " .. result)
    local ret = {
        dsToken = dsToken,
        dsIp = ip,
        dsPort = port
    }
    -- 设置定时器，60秒必须连接上DSA，否则杀进程
    local connectTime = moon.timeout(60 * 1000,
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

function _M:OnEnterMap(dsToken, mapName)
    if not dsToken or not mapName or string.len(mapName) <= 0 then
        return
    end
    local dsData = self:GetDsData(dsToken)
    if not dsData then
        return
    end
    local fd = dsData.fd
    if not fd then
        return
    end
    MsgProcesser:SendTableToJson2(socket, fd, _MOE.MsgIds.SM_DSA_DS_ENTER_MAP, {mapName = mapName})
end

function _M:OnDsStartReady(msg, fd, msgProcesser)
    if not msg then
        return
    end
    local dsToken = msg.dsToken
    local isLocalDS = false
    if not dsToken then
        local ip = msg.dsIp
        local port = msg.dsPort
        dsToken = self:GetDsToknFromAddr(ip, port)
        local clientToken = self:GetDsClientToken(fd)
        if clientToken and dsToken then
            self.DsClientTokenToDsToken[clientToken] = dsToken
            if not self.DsTokenHandlerMap[dsToken] then
                self.DsTokenHandlerMap[dsToken] = {}
                isLocalDS = true
            end
            local data = self.DsTokenHandlerMap[dsToken]
            data.ServerData = {
                clientToken = clientToken,
                isLocalDS = isLocalDS,
                ip = ip, -- dsIp
                port = port -- dsPort
            }
            data.fd = fd
            if fd then
                self.FdToDsTokenMap[fd] = dsToken
            end
            -- 通知DS更新dsToken
            msgProcesser:SendTableToJson2(socket, fd, _MOE.MsgIds.SM_DS_ReadyRep, {dsToken = dsToken})
        end
    else
        local data = self.DsTokenHandlerMap[dsToken]
        data.fd = fd
        if fd then
            self.FdToDsTokenMap[fd] = dsToken
        end
    end
    -- 关掉定时器关闭
    self:ClearDs_ConnectStopTimer(dsToken)
    print(string.format("[DSA] IsLocalDs: %s dsIp: %s dsPort: %d dsToken: %s Ds Ready", isLocalDS, msg.dsIp, msg.dsPort, dsToken))
end

function _M:IsLocalDS(dsToken)
    if not dsToken then
        return false
    end
    local dsData = self.DsTokenHandlerMap[dsToken]
    return dsData.isLocalDS
end

function _M:GetDsTokenFromDsClientToken(clientToken)
    if not clientToken then
        return
    end
    local dsToken = self.DsClientTokenToDsToken[clientToken]
    return dsToken
end

function _M:GetDsData(dsToken)
    if not dsToken then
        return
    end
    return self.DsTokenHandlerMap[dsToken]
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
    if data.ServerData then
        local clientToken = data.ServerData.clientToken
        if clientToken then
            self.DsClientTokenToDsToken[clientToken] = nil
        end
    end
    self:ClearDs_ConnectStopTimer(dsToken)
    if data.fd then
        self.FdToDsTokenMap[data.fd] = nil
    end

    self.DsTokenHandlerMap[dsToken] = nil
end

local function GetDsTokenFromFd(self, fd)
    if not fd then
        return
    end
    local ret = self.FdToDsTokenMap[fd]
    return ret
end

-- Ds突然断线
function _M:OnDsSocketClose(fd)
    local dsToken = GetDsTokenFromFd(self, fd) -- 在CLOSE函数里无法使用 GetIpAndPort，会返回nil
    print(string.format("[DSA] OnDsSocketClose dsToken: %s", dsToken))
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