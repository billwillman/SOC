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
        session, session
    }
    local PlayerInfo = PlayerInfoClass.New(info)
    self.ClientPlayerInfos[token] = PlayerInfo
end

return _M