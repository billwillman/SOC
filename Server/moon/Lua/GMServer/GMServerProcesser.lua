local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("GMServerProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
require("ServerCommon.GlobalFuncs")

local function TestConnectLocalDS(command, paramStr, loginToken, socket, fd)
    if not command then
        return
    end
    local ip, port = GetIpAndPort(socket, fd)
    if ip then
        local dsToken = GenerateToken(ip, 7777)
        if dsToken then
            local reqMsg = {
                loginToken = loginToken,
            }
            MsgProcesser:SendServerMsgAsync("DSA", "QueryLocalDS", reqMsg)
        end
    end
end

local GMCommands = {
    ["UseLocalDS"] = TestConnectLocalDS,
}

local CurrentMsgProcess = {
    [MsgIds.CM_GM] = function (self, msg, socket, fd)
        local command = msg.command
        local paramStr = msg.param
        if command then
            local func = GMCommands[command]
            if func then
                func(command, paramStr, socket, fd)
            end
        end
    end
}

RegisterClientMsgProcess(CurrentMsgProcess)

-------------------------------------------- 服务器之间通信 ------------------------------------------

-- 跨服务器处理
local _Server_GM_Process = {

}

RegisterServerCommandProcess(_Server_GM_Process)

return _M