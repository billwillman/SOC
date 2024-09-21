using System;
using System.IO;
using UnityEngine;
using Utils;
public class LogFileWriter: DisposeObject, ILogHandler
{
    public LogFileWriter(string saveFileName) {
        if (string.IsNullOrEmpty(saveFileName))
            saveFileName = "logWriter.log";
        m_SaveFileName = string.Format("{0}/{1}", Application.persistentDataPath, saveFileName);
        m_FileStream = new FileStream(m_SaveFileName, FileMode.Create, FileAccess.Write);
    }

    protected override void OnFree(bool isManual) {
        if (m_FileStream != null) {
            m_FileStream.Dispose();
            m_FileStream = null;
        }
    }

    // 如果后面日志需要优化采用 Memory<char> RingBuffer + 异步的策略
    // 目前暂时采用直接异步
    protected void WriteLog(string log) {
        if (string.IsNullOrEmpty(log) || m_FileStream == null)
            return;
        byte[] buffer = System.Text.Encoding.UTF8.GetBytes(log);
        m_FileStream.WriteAsync(buffer);
    }

    public void LogFormat(LogType logType, UnityEngine.Object context, string format, params object[] args) {
        if (m_FileStream != null) {
            string log = string.Format("LOG: [{0}] {1}==>> {2}", Enum.GetName(GetLogType(), logType), context != null ? context.name : string.Empty, string.Format(format, args));
            WriteLog(log);
        }
    }

    public void LogException(Exception exception, UnityEngine.Object context) {
        if (m_FileStream != null) {
            string log = string.Format("EXCEPTION: {0}==>> {1}", context != null ? context.name : string.Empty, exception != null ? exception.ToString():string.Empty);
            WriteLog(log);
        }
    }

    protected Type GetLogType() {
        if (m_LogType == null)
            m_LogType = typeof(LogType);
        return m_LogType;
    }

    private string m_SaveFileName = string.Empty;
    private Type m_LogType = null;
    private FileStream m_FileStream = null;
}