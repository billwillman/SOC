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
            -- print(_MOE.TableUtils.Serialize(msg))
            local playerInfo = PlayerManager:AddPlayer(msg.userName, msg.password or "", fd)
            if not playerInfo then
                return
            end
            moon.send("lua", dsa, _MOE.ServerMsgIds.CM_ReqDS, playerInfo) -- 从DSA请求服务器
            local ret = {
                session = playerInfo.session,
                token = playerInfo.token,
                msgId = MsgIds.SM_LoginRet, -- 消息ID
            }
            self:SendTableToJson(socket, fd, ret)
        end
    end
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

----------------------------------------------- 服务器间通信 -------------------------------
moon.exports._Server_TO_LOGIN = {
    [_MOE.ServerMsgIds.SM_DS_STATUS] = function (msg)
    end
}


return _M