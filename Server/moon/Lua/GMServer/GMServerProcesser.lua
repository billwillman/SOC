local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("GMServerProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")

local CurrentMsgProcess = {
    [MsgIds.CM_GM] = function (self, msg, socket, fd)
        local command = msg.command
        local paramStr = msg.param
        if command then
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