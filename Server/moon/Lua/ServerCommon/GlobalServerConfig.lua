local io = require("io")
require("InitGlobalVars")

local serverCfgStr = io.readfile("./Config/Server.json")
_MOE.ServerConfig = json.decode(serverCfgStr)