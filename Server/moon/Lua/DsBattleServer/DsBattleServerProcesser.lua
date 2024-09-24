local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("DsBattleServerProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")

local CurrentMsgProcess = {
    [MsgIds.CM_DS_StartReady] = function (self, msg, socket, fd)
        local dsToken = msg.dsToken
        if not dsToken then
            return
        end
    end
}

RegisterClientMsgProcess(CurrentMsgProcess)
RegisterDefaultServerCommandProcess()

return _M