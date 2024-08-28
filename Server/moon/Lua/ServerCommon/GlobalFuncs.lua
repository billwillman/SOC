local moon = require("moon")

local _DSA_ServerId = nil

moon.exports.GetDSAServerId = function ()
    if _DSA_ServerId then
        return _DSA_ServerId
    end
    _DSA_ServerId = moon.queryservice("DSA")
    return _DSA_ServerId
end

moon.exports.GetIpAndPort = function (socket, fd)
    if not socket or not fd then
        return
    end
    local addressStr = socket.getaddress(fd)
    if not addressStr or #addressStr <= 0 then
        return
    end
    local idx = string.find(addressStr, ":")
    if not idx then
        return
    end
    local ip = string.sub(addressStr, 1, idx - 1)
    local port = tonumber(string.sub(addressStr, idx + 1))
    return ip, port
end