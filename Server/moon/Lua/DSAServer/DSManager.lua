require("ServerCommon.GlobalFuncs")
require("ServerCommon.GlobalServerConfig")
local moon = require("moon")
local json = require("json")
local fs = require("fs")

local ServerData = GetServerConfig("DSA")
local battlSrvData = GetServerConfig("BattleSrv")

local _M = _MOE.class("DSManager")

function _M:Ctor()
    self.DsTokenHandlerMap = {}
end

------------------------------------- 外部调用 -------------------------

-- 启动一个DS(只负责启动，其他类逻辑不在DSA管)
function _M:StartDSAsync(playerInfos)
    if not playerInfos then
        return
    end
    -- 获取一个空闲的端口号
    local ip, port = GetFreeAdress()
    local dsToken = moon.md5(string.format("%s:%d", ip, port))
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
    local absolutePath = fs.abspath("../../DS/Server.exe")
    local command = string.format("%s \"%s\"",absolutePath, jsonStr)
    print("[DSA] Command: " .. command)
    local handler = io.popen(command, "r")
    if not handler then
        print("[dsa] not run SOC.exe...")
        return
    end
    print(string.format("[DSA] DS Handle: %s", handler))
    local ret = {
        dsToken = dsToken,
        dsIp = ip,
        dsPort = port
    }
    self.DsTokenHandlerMap[dsToken] = handler
    return ret
end

function _M:StopDS(dsToken)
    if not dsToken then
        return false
    end
    local handler = self.DsTokenHandlerMap[dsToken]
    if handler then
        self.DsTokenHandlerMap[dsToken] = nil
        handler:close() -- 杀进程
        return true
    end
    return false
end

return _M