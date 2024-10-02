require("ServerCommon.GlobalServerConfig")
require("ServerCommon.ServerMsgIds")
local moon = require("moon")
local ServerData = GetServerConfig("ServerListSrv")

require("LuaPanda").start("127.0.0.1", ServerData.Debug)

require("InitGlobalVars")
require("ServerCommon.CommonMsgProcesser")

local json = require("json")
local httpserver = require("moon.http.server")

local clientServerListStr = io.readfile("./Config/ClientServerList.json")

httpserver.content_max_len = 8192
httpserver.header_max_len = 8192


local G_StartTimer = os.clock() * 1000


---------------------------------------------- 服务之间通信 ------------------------------------------

local function StartServer()
    httpserver.listen(ServerData.ip, ServerData.port, 60)
    print("[ServerListServer] ", ServerData.ip, ServerData.port)
    httpserver.error = function (fd, err)
        print("http server fd",fd," disconnected:",  err)
    end
    
    httpserver.on("/serverlist", function(req, rep)
        -- 返回区服数据
        rep.status_code = 200
        rep:write(clientServerListStr)
    end)
end

--[[
local _Server_List_Process = {
    [_MOE.ServicesCall.Start] = function ()
        StartServer()
    end,
    [_MOE.ServicesCall.Shutdown] = function ()
    end
}

RegisterServerCommandProcess(_Server_List_Process)
]]

StartServer()
