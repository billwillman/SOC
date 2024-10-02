local baseClass = require("ServerCommon.CommonMsgProcesser")
local _M = _MOE.class("GMServerProcesser", baseClass)

local MsgIds = require("_NetMsg.MsgId")
local moon = require("moon")
require("ServerCommon.GlobalFuncs")
require("ServerCommon.ServerMsgIds")
local json = require("json")

local function TestConnectLocalDS(command, msg, loginToken, socket, fd)
    if not command or not msg or #msg < 2 then
        print("[GM] UseLocalDS: command is not vaild or msg is not vaild")
        return
    end
    local loginToken = msg.token
    if not loginToken then
        print("[GM] UseLocalDS: loginToken is not vaild")
        return
    end
    local playerInfo = msgProcesser:SendServerMsgSync("LoginSrv", _MOE.ServerMsgIds.SM_LS_QUERY_PLAYERINFO, {token = loginToken})
    if not playerInfo then
        print(string.format("[GM] UseLocalDS: not found playerInfo: %s", loginToken))
        return
    end
    print(string.format("[GM] UseLocalDS: %s(%s)", loginToken, playerInfo))
    -- 查询下login服务器
    local mapName = msg.mapName
    local ip, port = GetIpAndPort(socket, fd)
    if ip then
        local dsToken = GenerateToken(ip, 7777)
        if dsToken then
            local reqMsg = {
                loginToken = loginToken,
            }
            local locaDS = MsgProcesser:SendServerMsgSync("DSA", "QueryLocalDS", reqMsg)
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