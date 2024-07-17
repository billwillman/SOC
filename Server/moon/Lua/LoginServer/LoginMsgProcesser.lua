local _M = _MOE.class("LoginMsgProcesser")

local TableUtils = require("_Common.TableUtils")

function _M:OnMsg(msg)
    print(TableUtils.Serialize(msg))
end

return _M