local moon = require("moon")
local json = require("json")
local httpc = require("moon.http.client")

local http_server = require("moon.http.server")

-- http_server.content_max_len = 8192

http_server.error = function(fd, err)
    print("http server fd", fd, " disconnected:", err)
end

http_server.on("/hello", function(request, response)
    print_r(request:parse_query())
    response:write_header("Content-Type", "text/plain")
    response:write("GET:Hello World")
end)

http_server.on("/chat", function(request, response)
    print_r(request.content)
    response:write_header("Content-Type", "text/plain")
    response:write("POST:Hello World/home")
end)

http_server.on("/login", function(request, response)
    print_r(request:parse_form())
    response:write_header("Content-Type", "application/json")
    response:write(json.encode({ score = 112, level = 100, item = { id = 1, count = 2 } }))
end)

http_server.listen("127.0.0.1", 9991)
print("http_server start", "127.0.0.1", 9991)

-- use http proxy
-- moon.async(function ()
--     print_r(httpc.get("https://www.google.com",{
--         path ='/',
--         proxy = "127.0.0.1:8443",
--         connect_timeout = 1000,
--         read_timeout = 5000
--     }))
-- end)

moon.async(function()
    httpc.get("http://127.0.0.1:9991", {
        path = "/hello?a=1&b=2",
        keepalive = 300
    })

    httpc.post("http://127.0.0.1:9991", "Hello Post", {
        path = "/chat",
        keepalive = 300
    })

    local form = { username = "wang", passwd = "456", age = 110 }
    local response = httpc.postform("http://127.0.0.1:9991", form, {
        path = "/login",
        keepalive = 300
    })

    print_r(response:json())

    moon.exit(100)
end)
