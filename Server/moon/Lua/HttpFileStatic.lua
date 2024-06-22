require("LuaPanda").start("127.0.0.1", 8819)
local httpserver = require("moon.http.server")

httpserver.static("/html")

local ETC_HOST = "127.0.0.1"
local ETC_PORT = 9998

httpserver.listen(ETC_HOST, ETC_PORT, 60)
print("[HttpFileStatic] ", ETC_HOST, ETC_PORT)