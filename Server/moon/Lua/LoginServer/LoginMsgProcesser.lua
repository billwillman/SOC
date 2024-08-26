local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")

local CurrentMsgProcess = {
    [MsgIds.CM_Login] = function (self, msg, socket, fd)
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
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M