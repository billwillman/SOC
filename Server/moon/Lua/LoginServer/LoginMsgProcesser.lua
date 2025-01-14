local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("LoginMsgProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
local socket = require "moon.socket"
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
                session = playerInfo.Data.session,
                token = playerInfo.Data.token,
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
    [_MOE.ServerMsgIds.SM_LS_Exist_PLAYERINFO] = function (msg)
        if not msg then
            return
        end
        local token = msg.token
        if not token then
            return
        end
        local ret = PlayerManager:GetPlayerInfo(token)
        if ret then
            print("[LoginSrv] SM_LS_Exist_PLAYERINFO is found: " .. token)
        else
            print("[LoginSrv] SM_LS_Exist_PLAYERINFO is not found: " .. token)
        end
        return ret ~= nil, ret.Data
    end,
    -- Client进入DS
    [_MOE.ServerMsgIds.SM_LS_DS_Enter] = function (msg)
        -- print("[LoginSrv] SM_LS_DS_Enter")
        local loginToken = msg.loginToken
        if not loginToken then
            print("[LoginSrv] SM_LS_DS_Enter Error: loginToken is not vaild")
            return
        end
        local dsToken = msg.dsToken
        if not dsToken then
            print("[LoginSrv] SM_LS_DS_Enter Error: dsToken is not vaild")
            return
        end
        local playerInfo = PlayerManager:GetPlayerInfo(loginToken)
        if not playerInfo then
            print(string.format("[LoginSrv] SM_LS_DS_Enter Error: playerInfo is not vaild(%s)", loginToken))
            return
        end
        local fd = playerInfo:GetFD()
        if not fd then
            print("[LoginSrv] SM_LS_DS_Enter Error: fd is not vaild")
            return
        end
        print(string.format("[LoginSrv] SM_LS_DS_Enter: SUCCESS: MsgId(%d) fd(%d) dsToken(%s) dsIp(%s) dsPort(%d) isLocalDS(%s) mapName(%s)",
            MsgIds.SM_CLIENT_ENTER_DS, fd, dsToken,
            msg.dsIp, msg.dsPort, tostring(msg.isLocalDS), msg.mapName))
        MsgProcesser:SendTableToJson2(socket, fd, MsgIds.SM_CLIENT_ENTER_DS,
            {
                dsToken = dsToken,
                dsIp = msg.dsIp,
                dsPort = msg.dsPort,
                isLocalDS = msg.isLocalDS,
                mapName = msg.mapName,
            })
    end,
}

local _SERVER_SYNC_MSG = {
    [_MOE.ServerMsgIds.SM_LS_Exist_PLAYERINFO] = true,
}

RegisterServerCommandSync(_SERVER_SYNC_MSG)
RegisterServerCommandProcess(_Server_TO_LOGIN)

return _M