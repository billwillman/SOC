local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
require("ServerCommon.ServerMsgIds")

local DSA_ServerId = nil

function GetDSAServerId()
    if DSA_ServerId then
        return DSA_ServerId
    end
    DSA_ServerId = moon.queryservice("DSA")
    return DSA_ServerId
end

local CurrentMsgProcess = {
    -- 登录协议
    [MsgIds.CM_Login] = function (self, msg, socket, fd)
        local dsa = GetDSAServerId()
        if dsa then
            moon.send("lua", dsa, _MOE.ServerMsgIds.CM_ReqDS) -- 从DSA请求服务器
            local s = string.format("%s+%s+%d", msg.userName, msg.password, os.time())
            local ret = {
                -- 暂时这样，后面采用DSA分配拉起模式
                DsServer = {
                    ip = "127.0.0.1",
                    port = 7777
                },
                token = moon.md5(s) -- token 
            }
            self:SendTableToJson(socket, fd, ret)
        end
    end
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M