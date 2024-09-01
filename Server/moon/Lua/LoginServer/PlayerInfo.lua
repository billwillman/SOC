--- 用户数据封装
require("InitGlobalVars")
local PlayerInfo = _MOE.class("PlayerInfo")

function PlayerInfo:Ctor()
    self.token = nil
    self.session = nil
    self.dsToken = nil
    self.dsData = {
        dsToken = nil,
        dsState = nil, -- 在DS的状态
    }
end

return PlayerInfo