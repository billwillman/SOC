--- 用户数据封装
require("InitGlobalVars")
local PlayerInfo = _MOE.class("PlayerInfo")

function PlayerInfo:Ctor(info)
    self.token = info and info.token or nil
    self.session = info and info.session or nil
    self.dsData = {
        dsToken = info and info.dsToken,
        dsState = nil, -- 在DS的状态
    }
end

return PlayerInfo