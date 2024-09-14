require("InitGlobalVars")
local io = require("io")
local json = require("json")


local serverCfgStr = io.readfile("./Config/Server.json")
_MOE.ServerConfig = json.decode(serverCfgStr)