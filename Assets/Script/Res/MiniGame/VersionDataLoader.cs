using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VersionDataLoader
{
    public VersionDataLoader(string versionStr) {
        string[] lines = versionStr.Split('\n');
        // ��ȡFileList�ļ���
        string line = lines[1].Trim();
        string[] datas = line.Split('=');
        FileListFileName = datas[1].Trim() + ".txt";
        // ��ȡ��Դ�汾
        line = lines[0].Trim();
        datas = line.Split('=');
        Version = datas[1].Trim();
    }

    public string FileListFileName {
        get;
        set;
    }

    public string Version {
        get;
        set;
    }
}
