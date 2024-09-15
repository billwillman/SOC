local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
require("ServerCommon.ServerMsgIds")
require("ServerCommon.GlobalFuncs")


local CurrentMsgProcess = {
    -- 登录协议
    [MsgIds.CM_Login] = function (self, msg, socket, fd)
        local dsa = GetDSAServerId()
        if dsa then
            local playerInfo = PlayerManager:AddPlayer(msg.userName, msg.password, fd)
            moon.send("lua", dsa, _MOE.ServerMsgIds.CM_ReqDS, playerInfo) -- 从DSA请求服务器
            local ret = {
                session = session,
                token = token,
                msgId = MsgIds.SM_LoginRet, -- 消息ID
            }
            self:SendTableToJson(socket, fd, ret)
        end
    end
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})


return _M