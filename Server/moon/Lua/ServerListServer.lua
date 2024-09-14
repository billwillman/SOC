require("ServerCommon.GlobalServerConfig")
local ServerData = GetServerConfig("ServerListSrv")

require("LuaPanda").start("127.0.0.1", ServerData.Debug)

local json = require("json")
local httpserver = require("moon.http.server")

httpserver.content_max_len = 8192
httpserver.header_max_len = 8192


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
