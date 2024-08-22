local baseClass = require("CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")

local CurrentMsgProcess = {

}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

return _M