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
            -- 不需要一登陆就开DSA
            -- moon.send("lua", dsa, _MOE.ServerMsgIds.CM_ReqDS, playerInfo) -- 从DSA请求服务器
            -- MsgProcesser:SendServerMsgAsync("DSA", _MOE.ServerMsgIds.CM_ReqDS, playerInfo)
            local ret = {
                session = playerInfo.session,
                token = playerInfo.token,
            }
            self:SendTableToJson2(socket, fd, MsgIds.SM_LoginRet, ret)
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
    end,
    -- 查询角色信息
    [_MOE.ServerMsgIds.SM_LS_QUERY_PLAYERINFO] = function (msg)
        print("SM_LS_QUERY_PLAYERINFO")
        if not msg then
            return
        end
        local token = msg.token
        if not token then
            return
        end
        local ret = PlayerManager:GetPlayerInfo(token)
        return ret
    end,
}

local _SERVER_SYNC_MSG = {
    [_MOE.ServerMsgIds.SM_LS_QUERY_PLAYERINFO] = true,
}

RegisterServerCommandSync(_SERVER_SYNC_MSG)
RegisterServerCommandProcess(_Server_TO_LOGIN)

return _M