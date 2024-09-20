local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("DSAServerProcesser", baseClass)

local json = require("json")
local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
require("ServerCommon.ServerMsgIds")
require("ServerCommon.GlobalFuncs")
local TableUtils = require("_Common.TableUtils")

local function SendLoginServer(msgId, msg)
    local loginSrvId = GetLoginSrvId()
    if not loginSrvId then
        return false
    end
    -- print(string.format("[%d] msgId=%d msg=%s", loginSrvId, msgId, _MOE.TableUtils.Serialize(msg)))
    moon.send("lua", loginSrvId, msgId, msg)
    return true
end

local CurrentMsgProcess = {
}

setmetatable(_M.MsgDispatch, {__index = CurrentMsgProcess})

-------------------------------------------- 服务器之间通信 ------------------------------------------

-- 跨服务器处理
local _Server_DSA_Process = {
    [_MOE.ServerMsgIds.CM_ReqDS] = function (playerInfos)
        -- 拉起DS
        -- print("[DSA] PlayerInfo:" .. TableUtils.Serialize(playerInfo))
        if type(playerInfos) == "table" then
            if playerInfos[1] == nil and next(playerInfos) ~= nil then
                -- 说明是数组
                local arr = {}
                table.insert(arr, playerInfos)
                playerInfos = arr
            end
            -- StartDSAsync(playerInfos)
            local dsData = DSManager:StartDSAsync(playerInfos)
            if dsData then
                -- 返回等待登录成功
                local msg = {
                    playerInfos = playerInfos,
                    dsData = {
                        dsStatus = _MOE.DsStatus.WaitRunning,
                        dsToken = dsData.token,
                        dsIp = dsData.dsIp,
                        dsPort = dsData.dsPort
                    }
                }
                if not SendLoginServer(_MOE.ServerMsgIds.SM_DS_STATUS, msg) then
                    print("[DSA] SendLoginServer Error: " .. msg.dsData.dsStatus)
                    DSManager:StopDS(dsData.dsToken) -- 主动关闭
                end
            else
                -- 返回失败状态
                local msg = {
                    playerInfos = playerInfos,
                    dsData = {
                        dsStatus = _MOE.DsStatus.StartError
                    }
                }
                if not SendLoginServer(_MOE.ServerMsgIds.SM_DS_STATUS, msg) then
                    print("[DSA] SendLoginServer Error: " .. msg.dsStatus)
                end
            end
        end
    end,
    -- DS准备好
    [_MOE.ServerMsgIds.SM_DSReady] = function ()
    end
}

moon.dispatch("lua", function(_, _, cmd, ...)
    -- 处理 cmd
    local OnProcess = _Server_DSA_Process[cmd]
    if OnProcess then
        OnProcess(...)
    end
end)

return _M