local moon = require("moon")

local _DSA_ServerId = nil

function GetDSAServerId()
    if _DSA_ServerId then
        return _DSA_ServerId
    end
    _DSA_ServerId = moon.queryservice("DSA")
    return _DSA_ServerId
end