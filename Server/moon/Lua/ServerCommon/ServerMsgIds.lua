_MOE = _MOE or {}
_MOE.ServerMsgIds = {
    CM_ReqDS = 1, -- 请求一个新的DS服务器
    SM_DSReady = 2, -- DS 准备好了
    SM_DS_STATUS = 3, -- DS 状态更新
}

_MOE.DsStatus = {
    StartError = -1, -- 启动失败
    WaitRunning = 0, -- 等待启动
    Running = 1, -- 已经启动
    Close = 2, -- DS关闭
    AddPlayers = 3, -- 增加玩家
    LoadingMap = 4, -- 加载地图
    KickOffPlayers = 5, -- DS主动踢出玩家
    PlayerExit = 6, -- 玩家主动退出
}