local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("GMServerProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
require("ServerCommon.GlobalFuncs")
require("ServerCommon.ServerMsgIds")
local json = require("json")

local function TestConnectLocalDS(command, msg, socket, fd)
    if not command or not msg or #msg < 2 then
        print("[GM] UseLocalDS: command is not vaild or msg is not vaild")
        return
    end
    local loginToken = msg[1]
    local mapName = msg[2]
    if not loginToken then
        print("[GM] UseLocalDS: loginToken is not vaild")
        return
    end
    if not mapName then
        print("[GM] UseLocalDS: mapName is not vaild")
        return
    end
    local isExits, playerData = MsgProcesser:SendServerMsgSync("LoginSrv", _MOE.ServerMsgIds.SM_LS_Exist_PLAYERINFO, {token = loginToken})
    --local playerInfo = moon.call("lua", GetLoginSrvId(), _MOE.ServerMsgIds.SM_LS_QUERY_PLAYERINFO, {token = loginToken})
    if not isExits then
        print(string.format("[GM] UseLocalDS: not found playerInfo: %s", loginToken))
        return
    end
    print(string.format("[GM] UseLocalDS: %s(%s)", loginToken, isExits))
    -- 查询下login服务器
    local ip, port = GetIpAndPort(socket, fd)
    if ip then
        local dsToken =  playerData.dsData.dsToken and playerData.dsData.dsToken or GenerateToken2(ip, 7777)
        if dsToken then
            print(dsToken)
            local reqMsg = {
                loginToken = loginToken,
                dsToken = dsToken,
                mapName = mapName, -- 地图加载的场景
            }
            local isExits, dsServerData = MsgProcesser:SendServerMsgSync("DSA", _MOE.ServerMsgIds.SM_DSA_Exist_DS, reqMsg)
            if not isExits then
                print("[GM] TestConnectLocalDS: not found dsToken: " .. dsToken)
            else
                print("[GM] TestConnectLocalDS: found dsToken: " .. _MOE.TableUtils.Serialize(dsServerData))
                -- 发送DS加载地图
                MsgProcesser:SendServerMsgAsync("LoginSrv", _MOE.ServerMsgIds.SM_LS_DS_Enter,
                    {
                        isLocalDS = dsServerData.isLocalDS,
                        dsIp = dsServerData.ip,
                        dsPort = dsServerData.port,
                        loginToken = loginToken,
                        dsToken = dsToken,
                        mapName = mapName,
                })
            end
        end
    end
end

local GMCommands = {
    ["UseLocalDS"] = TestConnectLocalDS,
}

local CurrentMsgProcess = {
    [MsgIds.CM_GM] = function (self, msg, socket, fd)
        local command = msg.command
        local paramStr = msg.param
        if command then
            local func = GMCommands[command]
            if func then
                local msg = nil
                if paramStr and string.len(paramStr) > 0 then
                    msg = json.decode(paramStr)
                end
                func(command, msg, socket, fd)
            end
        end
    end
}

RegisterClientMsgProcess(CurrentMsgProcess)

-------------------------------------------- 服务器之间通信 ------------------------------------------

-- 跨服务器处理
local _Server_GM_Process = {

}

RegisterServerCommandProcess(_Server_GM_Process)

return _M