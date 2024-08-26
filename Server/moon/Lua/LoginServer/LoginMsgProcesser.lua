local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")

local CurrentMsgProcess = {
    [MsgIds.CM_Login] = function (self, msg, socket, fd)
    end
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M