-- 启动入口脚本
---__init__---
if _G["__init__"] then
    local arg = ... --- command line args
    return {
        thread = 16,
        enable_stdout = true,
        logfile = string.format("log/moon-%s-%s.log", arg[1], os.date("%Y-%m-%d-%H-%M-%S")),
        loglevel = 'DEBUG',
    }
end

-- Define lua module search dir, all services use same lua search path
-- 注意工作目录时当前脚本所在路径
local path = table.concat({
    "./?.lua",
    "./?/init.lua",
    "../lualib/?.lua",   -- moon lualib 搜索路径
    "../service/?.lua",  -- moon 自带的服务搜索路径，需要用到redisd服务
    -- Append your lua module search path
}, ";")

package.path = path .. ";"

local moon = require("moon")

--保存为env所有服务共享PATH配置
moon.env("PATH", string.format("package.path='%s'", package.path))

-------------------------------以上代码是固定写法--------------------------------------

--[[
-- 启动HttpPayServer
moon.async(function ()
    local id = moon.new_service(
        {
            name = "PayHttpServer",
            file = "PayHttpServer.lua",
            unique = true
        }
    )
    assert(id > 0, "Create PayHttpServer Fail")
end)
]]

-- 登录服务器
moon.async(function ()
    local id = moon.new_service(
        {
            name = "LoginServer",
            file = "LoginServer.lua",
            unique = true
        }
    )
    assert(id > 0, "Create LoginServer Fail")
end)

-- 区服服务器
moon.async(function ()
    local id = moon.new_service(
        {
            name = "ServerListServer",
            file = "ServerListServer.lua",
            unique = true
        }
    )
    assert(id > 0, "Create ServerListServer Fail")
end)

--[[
moon.async(function ()
    local id = moon.new_service(
        {
            name = "HttpFileStatic",
            file = "HttpFileStatic.lua",
            unique = true
        }
    )
    assert(id > 0, "Create HttpFileStatic Fail")
end)
]]

moon.shutdown(function ()
    moon.async(function ()
        --[[
        -- 控制其它唯一服务的退出逻辑
        assert(moon.call("lua", moon.queryservice("center"), "shutdown"))
        moon.raw_send("system", moon.queryservice("db"), "wait_save")

        ---wait all service quit
        while true do
            local size = moon.server_stats("service.count")
            if size == 1 then
                break
            end
            moon.sleep(200)
            print("bootstrap wait all service quit, now count:", size)
        end
        ]]
        moon.quit()
    end)
end)