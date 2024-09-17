local moon = require("moon")

local _DSA_ServerId = nil
local _Login_ServerId = nil

moon.exports.GetDSAServerId = function ()
    if _DSA_ServerId then
        return _DSA_ServerId
    end
    _DSA_ServerId = moon.queryservice("DSA")
    return _DSA_ServerId
end

moon.exports.GetLoginSrvId = function ()
    if _Login_ServerId then
        return _Login_ServerId
    end
    _Login_ServerId = moon.queryservice("LoginServer")
    return _Login_ServerId
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

moon.exports.GenerateToken = function (socket, fd)
    local addressStr = socket.getaddress(fd)
    local token = moon.md5(addressStr)
    return token
end

moon.exports.GetFreeAdress = function ()
    local so = require("socket")
    local tcpServer = so.tcp4()
    tcpServer:bind("*", 0)
    local _, port = tcpServer:getsockname()
    tcpServer:close()
    local ip = so.dns.gethostname()
    ip = so.dns.toip(ip)
    return ip, port
end