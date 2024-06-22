-- 支付相关HttpServer
--local moon = require("moon")
require("LuaPanda").start("127.0.0.1", 8818)

local json = require("json")
local httpserver = require("moon.http.server")

--local node_file = moon.args()[2]

httpserver.content_max_len = 8192
httpserver.header_max_len = 8192

local ETC_HOST = "127.0.0.1"
local ETC_PORT = 9999

--[[
local cluster_etc

local function load_cluster_etc()
    print("[cluster] load node file:" .. node_file)
    cluster_etc = {}
    local res = json.decode(io.readfile(node_file))
    for _,v in ipairs(res) do
        print(tostring(v))
        cluster_etc[v.node] = v
    end
end

load_cluster_etc()

httpserver.on("/reload", function (req, rep)
    load_cluster_etc()
    rep.status_code = 200
    rep:write_header("Content-Type","text/plain")
    rep:write("OK")
end)
]]

-- 加载支付模板
local payIndexTemple
local function LoadPayIndexTemple()
    payIndexTemple = io.readfile("./html/payTemplate.html")
    payIndexTemple = string.gsub(payIndexTemple, "{IP}", "http://" .. ETC_HOST)
end
LoadPayIndexTemple()

httpserver.on("/notify", function (req, rep)
    -- 支付通知
end)

httpserver.on("/return", function (req, rep)
    -- 支付返回
end)

-- 测试使用
httpserver.on("/test", function (req, rep)
    rep.status_code = 200
    rep:write_header("Content-Type","text/plain")
    rep:write("OK")
    print("[test] " .. tostring(req.content))
end)

local PayType = {
    alipay = "alipay",
    wxpay = "wxpay",
    qqpay = "qqpay",
}

local DeviceType = {
    pc = "pc",
    mobile = "mobile",
    qq = "qq",
    wechat = "wechat",
    alipay = "alipay",
    jump = "jump",
}

local G_StartTimer = os.clock() * 1000

-- 通过HTTP SERVER更改APK包参数
httpserver.on("/GetPayData", function(req, rep)
    -- 传入json
    rep.status_code = 200
    rep:write_header("Content-Type", "text/json")
    local param = {
        m_ClientBaseURL = "http://zfbyzf.js668.work/submit.php",
        m_ServerBaseURL = "http://zfbyzf.js668.work/mapi.php",
        m_MerchantID = 1007,
        m_PayNo = "20160806151343349",
        m_MerchantKey = "4k2hJ2W4C2ss4S2a6Ksys44S62ksz624",
        m_PayType = PayType.jump,
        m_PayDeviceType = DeviceType.jump,
        m_NotifyURL = "http://127.0.0.1:9999/notify",
        m_ReturnURL = "http://127.0.0.1:9999/return",
        m_TestURL = "http://127.0.0.1:9999/test",
    }
    local ret = json.encode(param)
    print(ret)
    rep:write(ret)
end)

httpserver.error = function (fd, err)
    print("http server fd",fd," disconnected:",  err)
end

-- 生成订单号
local function GeneratePayNo()
    local ret = os.date("%Y%m%d%H%M%S", os.time())
    local t = os.clock() * 1000 - G_StartTimer
    local deltaTStr = string.format("%05d", t)
    ret = ret .. deltaTStr
    return ret
end

local G_Shop = {
    pid = 1007
}

---- 正式支付根节点
httpserver.on("/pay", function (req, rep)
    rep.status_code = 200
    local data = req:parse_query()
    local str = json.encode(data)
    print(str)
    local payNo = GeneratePayNo()

    local content = string.format(payIndexTemple, G_Shop.pid, payNo, data.clientip)

    rep:write(content)
end)

httpserver.on("/payResult", function(req, rep)
    print(ok)
end)

httpserver.listen(ETC_HOST, ETC_PORT, 60)
print("[PayHttpServer] ", ETC_HOST, ETC_PORT)