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
            local s = string.format("%s+%s+%d", msg.userName, msg.password, os.time())
            local token = moon.md5(s) -- token
            local ip, port = GetIpAndPort(socket, fd)
            -- 1.通知DB Server写入redius,token定时销毁
            local playerInfo = {ip = ip, port = port, token = token}
            moon.send("lua", dsa, _MOE.ServerMsgIds.CM_ReqDS, playerInfo) -- 从DSA请求服务器
            local ret = {
                token = token,
                msgId = MsgIds.SM_LoginRet, -- 消息ID
            }
            self:SendTableToJson(socket, fd, ret)
        end
    end
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M