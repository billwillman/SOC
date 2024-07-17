local moon = require("moon")
local _MOE = {}
moon.exports._MOE = _MOE
_MOE.class = require("_Common.BaseClass")

_MOE.ErrorHandler = function (err)
    _MOE.Logger.LogError(err)
	_MOE.Logger.LogError(debug.traceback())
end