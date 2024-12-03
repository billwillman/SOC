using System;
using System.IO;
using UnityEngine;

namespace SOC.GamePlay
{
    public enum FileControlType
    {
        Read = 0,
        Write = 1,
    }
    // �ļ�������װ
    public static class FileHelper
    {
        // �����ļ�Stream
        public static Stream CreateFileStream(string path, FileControlType controlType = FileControlType.Read) {
            if (string.IsNullOrEmpty(path))
                return null;
#if WX_MINI_PLATFORM
#else
            FileMode fileMode = FileMode.Open;
            FileAccess fileAccess = FileAccess.Read;
            switch (controlType) {
                case FileControlType.Read:
                    fileMode = FileMode.Open;
                    fileAccess = FileAccess.Read;
                    break;
                case FileControlType.Write:
                    if (File.Exists(path)) {
                        try {
                            File.Delete(path);
                        } catch(Exception e) {
                            Debug.LogError(e.ToString());
                        }
                    }
                    fileMode = FileMode.Create;
                    fileAccess = FileAccess.Write;
                    break;
                default:
                    return null;
            }
            FileStream stream = new FileStream(path, fileMode, fileAccess);
            return stream;
#endif
        }
    }

}
