﻿// 是否允许版本回退
#define _CanBackVer

using System;
using System.IO;
using System.Collections;
using System.Collections.Generic;
using Utils;
using NsHttpClient;

// 更新模块
namespace AutoUpdate
{
	public enum AutoUpdateState
	{
		// 准备阶段
		auPrepare,
		// 请求检查版本
		auCheckVersionReq,
		// Zip版本信息
		auGetZipVerReq,
		// Zip下载
		auGetResZipReq,
		// 请求资源列表
		auGetResListReq,
		// 解压
		auUnZipRes,
		// 获得某个更新文件
		auUpdateFileProcess,
		// 完成
		auFinished,
		auEnd
	}

	public enum AutoUpdateErrorType
	{
		auError_None = 0,
		auError_NoGetVersion = 1,
		auError_NoGetFileList = 2,
		auError_FileDown = 3,
		auError_ResZipReq = 4,
		auError_ResZipVerReq = 5,
		auError_UnZipError = 6
	}

	public class AutoUpdateMgr: Singleton<AutoUpdateMgr>
	{
		// 是否需要更新Version.txt
		internal bool IsVersionTxtNoUpdate ()
		{
			int ret = string.Compare (LocalResVersion, CurrServeResrVersion, StringComparison.CurrentCultureIgnoreCase);

			// 是否允许版本回退
			#if _CanBackVer
			return ret == 0;
			#else
			return ret >= 0;
			#endif
		}

		internal bool IsFileListNoUpdate()
		{
			return string.Compare (LocalFileListContentMd5, ServerFileListContentMd5, StringComparison.CurrentCultureIgnoreCase) == 0;
		}

		internal bool IsVersionNoUpdate ()
		{
			return IsVersionTxtNoUpdate () && IsFileListNoUpdate();
		}

		public AutoUpdateMgr ()
		{
			DownProcess = 0;
			m_WritePath = FilePathMgr.Instance.WritePath;
			m_StateMgr = new AutoUpdateStateMgr (this);
			m_UpdateFile = new AutoUpdateCfgFile ();
			if (!string.IsNullOrEmpty (m_WritePath)) {
				m_UpdateFile.SaveFileName = StringHelper.Format ("{0}/{1}", m_WritePath, _cUpdateTxt);
			}
			RegisterStates ();
		}

		internal string WritePath {
			get {
				return m_WritePath;
			}
		}

		private void RegisterStates ()
		{
			AutoUpdateStateMgr.Register (AutoUpdateState.auPrepare,
				new AutoUpdatePrepareState ());

			AutoUpdateStateMgr.Register (AutoUpdateState.auCheckVersionReq, 
				new AutoUpdateCheckVersionState ());
			AutoUpdateStateMgr.Register (AutoUpdateState.auGetResListReq,
				new AutoUpdateFileListState ());

			AutoUpdateStateMgr.Register (AutoUpdateState.auUpdateFileProcess, 
				new AutoUpdateFileDownloadState ());

			AutoUpdateStateMgr.Register (AutoUpdateState.auFinished,
				new AutoUpdateFinishState ());

			AutoUpdateStateMgr.Register (AutoUpdateState.auEnd,
				new AutoUpdateStateEnd ());

			AutoUpdateStateMgr.Register(AutoUpdateState.auGetResZipReq,
				new AutoUpdateResZipReqState());

			AutoUpdateStateMgr.Register(AutoUpdateState.auGetZipVerReq,
				new AutoUpdateGetZipVerReqState());

			AutoUpdateStateMgr.Register(AutoUpdateState.auUnZipRes,
				new AutoUpdateUnZipState());
		}

		internal void HttpRelease ()
		{
			lock (m_Lock) {
				if (m_HttpClient != null) {
					m_HttpClient.Dispose ();
					m_HttpClient = null;
				}
			}
		}

		private void TasksRelease ()
		{
			lock (m_Lock) {
				if (m_TaskList != null) {
					m_TaskList.Clear ();
				}
			}
		}

		internal void Release ()
		{
			HttpRelease ();
			TasksRelease ();
		}

		public void Clear ()
		{
			lock (m_Lock)
			{
				m_StateMsgList.Clear ();
			}
			Release ();
		}

		public Action<AutoUpdateState> OnStateChanged {
			get;
			set;
		}

		private void CallStateChanged (AutoUpdateState state)
		{
			if (OnStateChanged != null)
				OnStateChanged (state);
		}

		public void ChangeState (AutoUpdateState state)
		{
			//Release ();
			AddChgState (state);
		}

		internal void RemoveLocalFilesFromDiffServerFileList()
		{
			if (m_ServerResListFile == null || m_LocalResListFile == null || string.IsNullOrEmpty(m_WritePath))
				return;

			List<string> removeKeys = null;
			var iter = m_LocalResListFile.GetIter();
			while (iter.MoveNext())
			{
				string newKey = m_ServerResListFile.GetFileContentMd5(iter.Current.Key);
				if (string.IsNullOrEmpty(newKey))
				{
					if (removeKeys == null)
						removeKeys = new List<string>();
					removeKeys.Add(iter.Current.Key);
				}
			}
			iter.Dispose();

			if (removeKeys != null && removeKeys.Count > 0)
			{
				for (int i = 0; i < removeKeys.Count; ++i)
				{
					string key = removeKeys[i];
					m_LocalResListFile.RemoveKey(key);
					string fileName = StringHelper.Format("{0}/{1}", m_WritePath, key);
					if (File.Exists(fileName))
						File.Delete(fileName);
				}
			}
		}

		internal void ServerFileListToClientFileList ()
		{
			if (!string.IsNullOrEmpty (m_WritePath)) {
				m_LocalResListFile.Load (m_ServerResListFile);
				m_ServerResListFile.Clear ();
				string fileName = StringHelper.Format ("{0}/{1}", m_WritePath, AutoUpdateMgr._cFileListTxt);
				m_LocalResListFile.SaveToFile (fileName);
			}
		}

		internal void ServerResVerToClientResVer ()
		{
			if (IsVersionNoUpdate ())
				return;

			if (string.IsNullOrEmpty (m_WritePath))
				return;
			string fileName = StringHelper.Format ("{0}/{1}", m_WritePath, _cVersionTxt);
			LocalResVersion = CurrServeResrVersion;
			LocalFileListContentMd5 = ServerFileListContentMd5;

			FileStream stream = new FileStream (fileName, FileMode.Create, FileAccess.Write);
			try {
				string s = StringHelper.Format ("res={0}\r\nfileList={1}", LocalResVersion, LocalFileListContentMd5);
				byte[] bytes = System.Text.Encoding.ASCII.GetBytes (s);
				stream.Write (bytes, 0, bytes.Length);
			} finally {
				stream.Close ();
				stream.Dispose ();
				stream = null;
			}
		}

		internal void ChangeUpdateFileNames ()
		{
			if (string.IsNullOrEmpty (m_WritePath))
				return;

			var iter = m_UpdateFile.GetIter ();
			while (iter.MoveNext ()) {
				string fileName = StringHelper.Format ("{0}/{1}", m_WritePath, iter.Current.Key);
				if (File.Exists (fileName)) {
					string fileNameMd5 = m_LocalResListFile.FindFileNameMd5 (iter.Current.Key);
					if (!string.IsNullOrEmpty (fileNameMd5)) {
						string newFileName = StringHelper.Format ("{0}/{1}", m_WritePath, fileNameMd5);
						if (File.Exists (newFileName))
							File.Delete (newFileName);
						File.Move (fileName, newFileName);
					}
				}
			}
			iter.Dispose ();

			m_UpdateFile.Clear ();
			string updateFileName = StringHelper.Format ("{0}/{1}", m_WritePath, _cUpdateTxt);
			if (File.Exists (updateFileName))
				File.Delete (updateFileName);
		}

		private void AddChgState (AutoUpdateState state)
		{
			AutoUpdateMsgNode node = AutoUpdateMsgNode.Create ();
			node.autoUpdateState = (int)state;
			lock (m_Lock) {
				m_StateMsgList.AddLast (node);
			}
		}

		private void AddErrMsg (AutoUpdateErrorType errType, int errStatus)
		{
			AutoUpdateMsgNode node = AutoUpdateMsgNode.Create ();
			node.errType = (int)errType;
			node.errStatus = errStatus;
			lock (m_Lock) {
				m_StateMsgList.AddLast (node);
			}
		}

		public int ThreadCount
		{
			get
			{
				lock (m_Lock)
				{
					return m_ThreadCount;
				}
			}

			protected set
			{
				lock (m_Lock)
				{
					m_ThreadCount = value;
				}
			}
		}

		public void StartMultAutoUpdate(string url, int threadCnt = 5, float connectTimeOut = 5.0f, int httpFileBufSize = 1024 * 64)
		{
			Clear ();
			m_ResServerAddr = url;

			DownProcess = 0;
			TotalDownM = 0;
			CurDownM = 0;
			ThreadCount = threadCnt;
			m_HttpConnectTimeOut = connectTimeOut;
			m_HttpFileBufSize = httpFileBufSize;

			AddChgState (AutoUpdateState.auPrepare);
		}


		// 开始
		public void StartAutoUpdate (string url, float connectTimeOut = 5.0f, int httpFileBufSize = 1024 * 64)
		{
			StartMultAutoUpdate(url, 1, connectTimeOut, httpFileBufSize);
		}

		public float HttpConnectTimeOut {
			get {
				return m_HttpConnectTimeOut;
			}
		}

		public int HttpFileBufSize {
			get {
				return m_HttpFileBufSize;
			}
		}

		internal void EndAutoUpdate ()
		{
			//Release ();
			AddChgState (AutoUpdateState.auEnd);
		}

		// 新的HTTP框架文本请求
		internal void CreateHttpTxt(string url, Action<HttpClient, HttpListenerStatus> onEnd, Action<HttpClient> onProcess = null)
		{
			if (string.IsNullOrEmpty(url))
				return;

			HttpRelease ();
			HttpClientStrResponse response = new HttpClientStrResponse (4 * 1024);
			lock (m_Lock)
			{
				m_HttpClient = HttpHelper.OpenUrl<HttpClientStrResponse>(url, response, onEnd, onProcess, m_HttpConnectTimeOut);   
			}
		}

		internal HttpClient CreateHttpTxt (string url, Action<HttpClientResponse, long> OnReadEvt, 
		                                  Action<HttpClientResponse, int> OnErrorEvt)
		{
			HttpRelease ();
			HttpClientStrResponse response = new HttpClientStrResponse (4 * 1024);
			response.OnReadEvt = OnReadEvt;
			response.OnErrorEvt = OnErrorEvt;
			lock (m_Lock)
			{
				m_HttpClient = new HttpClient (url, response, m_HttpConnectTimeOut);
			}
			return m_HttpClient;
		}

		// 新的下载文件接口
		internal void CreateHttpFile(string url, long process, Action<HttpClient, HttpListenerStatus> onEnd, Action<HttpClient> onProcess)
		{
			if (string.IsNullOrEmpty(m_WritePath) || string.IsNullOrEmpty(url))
				return;
			string fileName = Path.GetFileName (url);
			string dstFileName = StringHelper.Format ("{0}/{1}", m_WritePath, fileName);
			HttpRelease ();
			HttpClientFileStream response = new HttpClientFileStream (dstFileName, process, m_HttpFileBufSize);
			lock (m_Lock)
			{
				m_HttpClient = HttpHelper.OpenUrl<HttpClientFileStream>(url, response, onEnd, onProcess, m_HttpConnectTimeOut);
			}
		}

		internal HttpClient CreateHttpFile (string url, long process, Action<HttpClientResponse, long> OnReadEvt,
		                                   Action<HttpClientResponse, int> OnErrorEvt)
		{
			if (string.IsNullOrEmpty (m_WritePath))
				return null;
			string fileName = Path.GetFileName (url);
			string dstFileName = StringHelper.Format ("{0}/{1}", m_WritePath, fileName);
			HttpRelease ();
			HttpClientFileStream response = new HttpClientFileStream (dstFileName, process, m_HttpFileBufSize);
			response.OnReadEvt = OnReadEvt;
			response.OnErrorEvt = OnErrorEvt;
			lock (m_Lock)
			{
				m_HttpClient = new HttpClient (url, response, process, m_HttpConnectTimeOut, 5.0f);
			}
			return m_HttpClient;
		}

		internal WWWFileLoadTask CreateWWWStreamAssets (string fileName, bool usePlatform)
		{
			WWWFileLoadTask ret = WWWFileLoadTask.LoadFileAtStreamingAssetsPath (fileName, usePlatform);
			lock (m_Lock) {
				m_TaskList.AddTask (ret, true);
			}
			return ret;
		}

		public string ResServerAddr {
			get {
				return m_ResServerAddr;

			}
		}

		internal string CurrServeResrVersion {
			get;
			set;
		}

		internal string ServerFileListContentMd5 {
			get;
			set;
		}

		// 当前要下载的Zip文件名
		internal string CurrUpdateZipFileMd5
		{
			get;
			set;
		}

		internal string ServerZipVerMd5
		{
			get;
			set;
		}

		internal string LocalResVersion {
			get;
			set;
		}

		internal string LocalFileListContentMd5 {
			get;
			set;
		}

		public Action<AutoUpdateErrorType, int> OnError {
			get;
			set;
		}

		internal void Error (AutoUpdateErrorType errType, int status)
		{
			AddErrMsg (errType, status);
		}

		public void Update ()
		{
			TasksUpdate ();
			StateUpdate ();
			StateMsgUpdate ();
		}

		// 需要下载的兆
		public double TotalDownM
		{
			get
			{
				lock (m_Lock)
				{
					return m_TotalDownM;
				}
			}

			internal set
			{
				lock (m_Lock)
				{
					m_TotalDownM = value;
				}
			}
		}

		// 已经下载的兆数
		public double CurDownM
		{
			get
			{
				lock (m_Lock)
				{
					return m_CurDownM;
				}
			}

			internal set
			{
				lock (m_Lock)
				{
					m_CurDownM = value;
				}
			}
		}

		void StateMsgUpdate ()
		{
			do {
				LinkedListNode<AutoUpdateMsgNode> node;
				lock (m_Lock) {
					node = m_StateMsgList.First;
					if (node == null)
						break;
					m_StateMsgList.RemoveFirst ();
				}

				if (node.Value.autoUpdateState >= 0) {
					Release();
					AutoUpdateState state = (AutoUpdateState)node.Value.autoUpdateState;
					if (m_StateMgr.ChangeState (state))
						CallStateChanged (state);
				} else if (node.Value.errType >= 0) {
					AutoUpdateErrorType errType = (AutoUpdateErrorType)node.Value.errType; 
					if (OnError != null)
						OnError (errType, node.Value.errStatus);
				}
			} while (true);
		}

		void TasksUpdate ()
		{
			lock (m_Lock) {
				if (m_TaskList != null)
					m_TaskList.Process ();
			}
		}

		void StateUpdate ()
		{
			if (m_StateMgr != null)
				m_StateMgr.Process (this);
		}

		/*
		public Action<int, long, bool> OnDownloadFileEvt
		{
			get;
			set;
		}*/

		public float DownProcess {
			get {
				float ret;
				lock (m_Lock) {
					ret = m_DownProcess;
				}
				
				return ret;
			}
			
			internal set {
				lock (m_Lock) {
					m_DownProcess = value;
				}
			}
		}

		/*
		internal void CallDownloadFileEvt(int idx, long readBytes, bool isDone)
		{
			if (OnDownloadFileEvt != null)
				OnDownloadFileEvt(idx, readBytes, isDone);
		}*/

		// 获得Zip的MD5
		internal void GetResZipFileMd5(string content, out string zipMd5)
		{
			zipMd5 = string.Empty;
			if (string.IsNullOrEmpty(content))
				return;
			string[] lines = content.Split('\n');
			if (lines == null || lines.Length <= 0)
				return;
			for (int i = 0; i < lines.Length; ++i) {
				string line = lines [i].Trim();
				if (string.IsNullOrEmpty (line))
					continue;
				if (line.StartsWith("zip=", StringComparison.CurrentCultureIgnoreCase))
				{
					string str = line.Substring(4);
					zipMd5 = str.Trim();
					break;
				}
			}
		}

		public static bool GetResVerByFileName(string fileName, out string ver, out string fileListMd5, out string zipMd5)
		{
			ver = string.Empty;
			fileListMd5 = string.Empty;
			zipMd5 = string.Empty;
			if (string.IsNullOrEmpty(fileName) || !File.Exists(fileName))
				return false;
			FileStream stream = new FileStream(fileName, FileMode.Open, FileAccess.Read);
			try
			{
				if (stream.Length > 0)
				{
					byte[] buf = new byte[stream.Length];
					stream.Read(buf, 0, buf.Length);
					string content = System.Text.Encoding.ASCII.GetString(buf);
					return GetResVer(content, out ver, out fileListMd5, out zipMd5);
				}
			} finally
			{
				stream.Close();
				stream.Dispose();
			}

			return false;
		}

		public static bool GetResVer (string content, out string ver, out string fileListMd5, out string zipMd5)
		{
			ver = string.Empty;
			fileListMd5 = string.Empty;
			zipMd5 = string.Empty;
			if (string.IsNullOrEmpty (content))
				return false;
			char[] split = new char[1];
			split [0] = '\n';
			string[] lines = content.Split (split, StringSplitOptions.RemoveEmptyEntries);
			if (lines == null || lines.Length <= 0)
				return false;
			for (int i = 0; i < lines.Length; ++i) {
				string line = lines [i].Trim ();
				if (string.IsNullOrEmpty (line))
					continue;
				int idx = line.IndexOf ('=');
				if (idx >= 0) {
					string preStr = line.Substring (0, idx);
					string valueStr = line.Substring (idx + 1);
					if (string.Compare (preStr, "res", StringComparison.CurrentCultureIgnoreCase) == 0) {
						ver = valueStr.Trim ();
					} else if (string.Compare (preStr, "fileList", StringComparison.CurrentCultureIgnoreCase) == 0) {
						fileListMd5 = valueStr.Trim ();
					} else if (string.Compare(preStr, "zip", StringComparison.CurrentCultureIgnoreCase) == 0)
					{
						zipMd5 = valueStr.Trim();
					}
				}
			}

			return true;
		}

		internal void DownloadUpdateToUpdateTxt (AutoUpdateCfgItem item)
		{
			if (m_UpdateFile == null)
				return;
			if (m_UpdateFile.DownloadUpdate (item))
				m_UpdateFile.SaveToLastFile ();
		}

		// 需要更新的文件大小
		internal void UpdateTotalDownloadBytes(ResListFile.ResDiffInfo[] newInfos)
		{
			double downBytes = 0;
			double M = 1024 * 1024;
			if (newInfos != null && newInfos.Length > 0)
			{
				for (int i = 0; i < newInfos.Length; ++i)
				{
					ResListFile.ResDiffInfo info = newInfos[i];
					downBytes += ((double)info.fileSize)/M;
				}
			}
				
			TotalDownM = downBytes;
		}

		internal void UpdateToUpdateTxt (ResListFile.ResDiffInfo[] newInfos)
		{
			if (newInfos == null || m_UpdateFile == null)
				return;
			if (newInfos.Length <= 0) {
				m_UpdateFile.RemoveAllDowningFiles ();
				m_UpdateFile.Clear ();
				m_UpdateFile.SaveToLastFile ();
				return;
			}

			if (m_UpdateFile.UpdateToRemoveFiles (newInfos))
				m_UpdateFile.SaveToLastFile ();
		}

		internal void LoadServerResVer (string ver)
		{
			if (string.IsNullOrEmpty (ver))
				return;

			string v;
			string fileListMd5;
			string zipMd5;
			if (GetResVer (ver, out v, out fileListMd5, out zipMd5)) {
				CurrServeResrVersion = v;
				ServerFileListContentMd5 = fileListMd5;
				ServerZipVerMd5 = zipMd5;
			}
		}

		internal ResListFile LocalResListFile {
			get {
				return m_LocalResListFile;
			}
		}

		internal ResListFile ServerResListFile {
			get {
				return m_ServerResListFile;
			}
		}

		internal AutoUpdateCfgFile LocalUpdateFile {
			get {
				return m_UpdateFile;
			}
		}

		private struct AutoUpdateMsgNode
		{
			public static AutoUpdateMsgNode Create ()
			{
				AutoUpdateMsgNode ret = new AutoUpdateMsgNode ();
				ret.autoUpdateState = -1;
				ret.errType = -1;
				ret.errStatus = 0;
				return ret;
			}

			public int autoUpdateState;
			public int errType;
			public int errStatus;
		}

		internal static readonly string _cVersionTxt = "version.txt";
		internal static readonly string _cFileListTxt = "fileList.txt";
		internal static readonly string _cUpdateTxt = "update.txt";
		
		private AutoUpdateStateMgr m_StateMgr = null;
		private HttpClient m_HttpClient = null;
		private string m_WritePath = string.Empty;
		private TaskList m_TaskList = new TaskList ();
		private ResListFile m_LocalResListFile = new ResListFile ();
		private ResListFile m_ServerResListFile = new ResListFile ();
		private AutoUpdateCfgFile m_UpdateFile = null;
		private double m_TotalDownM = 0;
		private double m_CurDownM = 0;
		private float m_DownProcess = 0;
		private object m_Lock = new object ();
		// 资源服务器地址 例如：http://192.168.199.147:1983
		private string m_ResServerAddr = string.Empty;
		private LinkedList<AutoUpdateMsgNode> m_StateMsgList = new LinkedList<AutoUpdateMsgNode> ();
		private float m_HttpConnectTimeOut = 5.0f;
		private int m_HttpFileBufSize = 1024 * 64;
		private int m_ThreadCount = 1;
	}
}