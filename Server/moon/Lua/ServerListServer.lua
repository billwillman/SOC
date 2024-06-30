require("LuaPanda").start("127.0.0.1", 20001)

local json = require("json")
local httpserver = require("moon.http.server")

httpserver.content_max_len = 8192
httpserver.header_max_len = 8192

local serverCfgStr = io.readfile("./Config/Server.json")
local serverCfg = json.decode(serverCfgStr)
local ServerData = serverCfg.ServerListSrv
local clientServerListStr = io.readfile("./Config/ClientServerList.json")
serverCfgStr = nil
serverCfg = nil


local G_StartTimer = os.clock() * 1000


httpserver.error = function (fd, err)
    print("http server fd",fd," disconnected:",  err)
end

httpserver.on("/serverlist", function(req, rep)
    -- 返回区服数据
    rep.status_code = 200
    rep:write(clientServerListStr)
end)

httpserver.listen(ServerData.ip, ServerData.port, 60)
print("[ServerListServer] ", ServerData.ip, ServerData.port)
