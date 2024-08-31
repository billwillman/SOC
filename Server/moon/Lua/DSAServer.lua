-- DSA服务器
require("LuaPanda").start("127.0.0.1", 20003)

local json = require("json")
local moon = require("moon")
local socket = require "moon.socket"
require("InitGlobalVars")
require("ServerCommon.GlobalFuncs")
require("ServerCommon.ServerMsgIds")
local TableUtils = require("_Common.TableUtils")
local io = require("io")

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
    print("[dsa] start dsServer Param: %s", TableUtils.Serialize(dsParam))
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

-------------------------------------------- 服务器之间通信 ------------------------------------------

-- 跨服务器处理
local _Server_DSA_Process = {
    [_MOE.ServerMsgIds.CM_ReqDS] = function (playerInfos)
        -- 拉起DS
        -- print("[DSA] PlayerInfo:" .. TableUtils.Serialize(playerInfo))
        if type(playerInfos) == "table" then
            if playerInfos[1] == nil and next(playerInfos) ~= nil then
                -- 说明是数组
                local arr = {}
                table.insert(arr, playerInfos)
                playerInfos = arr
            end
            StartDSAsync(playerInfos)
        end
    end
}

moon.dispatch("lua", function(_, _, cmd, ...)
    -- 处理 cmd
    local OnProcess = _Server_DSA_Process[cmd]
    if OnProcess then
        OnProcess(...)
    end
end)