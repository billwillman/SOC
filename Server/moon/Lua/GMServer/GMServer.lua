--- 给服务器做GM测试的微服务，正式上线不开启此服务
require("ServerCommon.GlobalServerConfig")
require("InitGlobalVars")

local ServerData = GetServerConfig("GM")

require("LuaPanda").start("127.0.0.1", ServerData.Debug)

local moon = require("moon")
local socket = require "moon.socket"

local listenfd = socket.listen(ServerData.ip, ServerData.port, moon.PTYPE_SOCKET_MOON)
socket.start(listenfd)

socket.on("accept",function(fd, msg)
    print("accept ", fd, moon.decode(msg, "Z"))
    socket.settimeout(fd, 10)
end)

-------------------------------------------- 服务器之间通信 ------------------------------------------

-- 跨服务器处理
local _Server_GM_Process = {

}

moon.dispatch("lua", function(_, _, cmd, ...)
    -- 处理 cmd
    local OnProcess = _Server_GM_Process[cmd]
    if OnProcess then
        OnProcess(...)
    end
end)
