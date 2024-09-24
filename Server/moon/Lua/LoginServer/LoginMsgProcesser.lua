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

RegisterClientMsgProcess(CurrentMsgProcess)

----------------------------------------------- 服务器间通信 -------------------------------
local _Server_TO_LOGIN = {
    [_MOE.ServerMsgIds.SM_DS_STATUS] = function (msg)
        local playerInfos = msg.playerInfos
        if not playerInfos then
            return
        end
        local dsData = msg.dsData
        for _, playerInfo in pairs(playerInfos) do
            if PlayerManager:UpdateDsData(playerInfo, dsData) then
                if dsData.dsStatus == _MOE.DsStatus.StartError then
                    -- 启动DS失败
                end
            end
        end
    end
}

RegisterServerCommandProcess(_Server_TO_LOGIN)

return _M