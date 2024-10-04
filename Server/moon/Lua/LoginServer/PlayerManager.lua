require("ServerCommon.GlobalFuncs")
local PlayerInfoClass = require("LoginServer.PlayerInfo")

local _M = _MOE.class("PlayerManager")
local moon = require("moon")
local socket = require "moon.socket"

function _M:Ctor()
    self.ClientPlayerInfos = {}
end

function _M:_RemovePlayer(token)
    if not token then
        return
    end
    self.ClientPlayerInfos[token] = nil
end

---------------------------------------- 开放接口 ---------------------------

function _M:RemovePlayer(fd)
    if not fd then
        return
    end
    local token = GenerateToken(socket, fd)
    self:_RemovePlayer(token)
end

function _M:AddPlayer(userName, password, fd)
    if not userName or not password or not fd then
        return
    end
    -- 1.判断当前是否有玩家，并且判断玩家角色的登录状态如果在DS中则退出DS
    -- 2.玩家登录数据更新或增加
    local s = string.format("%s+%s+%d", userName, password, os.time())
    local session = moon.md5(s) -- session
    local token = GenerateToken(socket, fd) -- token
    local info = {
        token = token,
        session = session,
        fd = fd,
    }
    local PlayerInfo = PlayerInfoClass.New(info)
    self.ClientPlayerInfos[token] = PlayerInfo
    return PlayerInfo
end

function _M:UpdateDsData(playerInfo, dsData)
    if not playerInfo then
        return false
    end
    local token = playerInfo.token
    local session = playerInfo.session
    local currentPlayerInfo = self.ClientPlayerInfos[token]
    if not currentPlayerInfo then
        print(string.format("[LoginSrv] UpdateDsData: token=%s is not found", token))
        return false
    end
    if currentPlayerInfo.Data.session ~= session then
        print(string.format("[LoginSrv] UpdateDsData: token=%s currentSession=%s UpdateSession=%s is session not vaild", token,
            currentPlayerInfo.session, session))
        return false
    end

    currentPlayerInfo.Data.dsData = dsData or {}

    return true
end

function _M:GetPlayerInfo(token)
    if not token then
        return
    end
    --[[
    print(token)
    for _, info in pairs(self.ClientPlayerInfos) do
        print(info.token)
    end
    ]]
    return self.ClientPlayerInfos[token]
end

return _M