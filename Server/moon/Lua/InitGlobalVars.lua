local moon = require("moon")
local _MOE = {}
moon.exports._MOE = _MOE
_MOE.class = require("_Common.BaseClass")

_MOE.ErrorHandler = function (err)
    print(err)
	print(debug.traceback())
end