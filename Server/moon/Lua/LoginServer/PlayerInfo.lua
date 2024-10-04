--- 用户数据封装
require("InitGlobalVars")
local PlayerInfo = _MOE.class("PlayerInfo")

function PlayerInfo:Ctor(info)
    self.Data = {
        token = info and info.token or nil,
        session = info and info.session or nil,
        dsData = {
            dsToken = info and info.dsToken,
            dsState = nil, -- 在DS的状态
            gsState = nil, -- 在GS的状态
        },
        fd = info.fd,   -- 通信用
    }
end

function PlayerInfo:GetFD()
    if not self.Data then
        return
    end
    return self.Data.fd
end

return PlayerInfo