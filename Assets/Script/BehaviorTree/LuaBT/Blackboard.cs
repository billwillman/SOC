﻿/*
 * Description:             Blackboard.cs
 * Author:                  TANGHUAN
 * Create Date:             2020/09/16
 */

using System;
using System.Collections.Generic;
using UnityEngine;

namespace LuaBehaviourTree
{
    /// <summary>
    /// 黑板模式，数据共享中心
    /// </summary>
    public class Blackboard
    {
        /// <summary>
        /// 黑板数据集合中心
        /// </summary>
        protected Dictionary<string, IBlackboardData> mBlackboardDataMap;

        public Blackboard()
        {
            mBlackboardDataMap = new Dictionary<string, IBlackboardData>();
        }

        /// <summary>
        /// 添加黑板数据
        /// </summary>
        /// <param name="key"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public bool AddData(string key, IBlackboardData data)
        {
            IBlackboardData value;
            if (!mBlackboardDataMap.TryGetValue(key, out value))
            {
                mBlackboardDataMap.Add(key, data);
                return true;
            }
            else
            {
                Debug.LogError(string.Format("黑板数据里已存在Key:{0}的数据，添加数据失败!", key));
                return false;
            }
        }

        /// <summary>
        /// 移除黑板数据
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public bool RemoveData(string key)
        {
            return mBlackboardDataMap.Remove(key);
        }

        /// <summary>
        /// 获取指定黑板数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key"></param>
        /// <returns></returns>
        public T GetData<T>(string key)
        {
            var value = GetBlackboardData(key);
            if (value != null)
            {
                return (value as BlackboardData<T>).Data;
            }
            else
            {
                Debug.LogError($"黑板里找不到数据Key:{key},返回默认值!");
                return default(T);
            }
        }

        /// <summary>
        /// 更新黑板数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public bool UpdateData<T>(string key, T data)
        {
            var value = GetBlackboardData(key);
            if (value != null)
            {
                (value as BlackboardData<T>).Data = data;
                return true;
            }
            else
            {
                Debug.LogError(string.Format("更新Key:{0}的数据失败!", key));
                return false;
            }
        }

        /// <summary>
        /// 清除黑板数据
        /// </summary>
        public void ClearData()
        {
            mBlackboardDataMap.Clear();
        }

        /// <summary>
        /// 获取所有的黑板数据Key列表
        /// </summary>
        /// <returns></returns>
        public List<string> GetAllBlackBoardKeysList()
        {
            return new List<string>(mBlackboardDataMap.Keys);
        }

        /// <summary>
        /// 获取所有的黑板数据Value列表
        /// </summary>
        /// <returns></returns>
        public List<IBlackboardData> GetAllBlackBoardValuesList()
        {
            return new List<IBlackboardData>(mBlackboardDataMap.Values);
        }

        /// <summary>
        /// 打印所有黑板数据
        /// </summary>
        public void PrintAllBlackBoardDatas()
        {
            Debug.Log($"打印黑板数据:");
            foreach (var blackboarddata in mBlackboardDataMap)
            {
                var blackboarddatatype = blackboarddata.Value.GetType();
                if (blackboarddatatype == typeof(BlackboardData<bool>))
                {
                    var realblackboarddata = blackboarddata.Value as BlackboardData<bool>;
                    Debug.Log($"变量名:{blackboarddata.Key}变量值:{realblackboarddata.Data}");
                }
                else if(blackboarddatatype == typeof(BlackboardData<int>))
                {
                    var realblackboarddata = blackboarddata.Value as BlackboardData<int>;
                    Debug.Log($"变量名:{blackboarddata.Key}变量值:{realblackboarddata.Data}");
                }
                else if (blackboarddatatype == typeof(BlackboardData<float>))
                {
                    var realblackboarddata = blackboarddata.Value as BlackboardData<float>;
                    Debug.Log($"变量名:{blackboarddata.Key}变量值:{realblackboarddata.Data}");
                }
                else if (blackboarddatatype == typeof(BlackboardData<string>))
                {
                    var realblackboarddata = blackboarddata.Value as BlackboardData<string>;
                    Debug.Log($"变量名:{blackboarddata.Key}变量值:{realblackboarddata.Data}");
                }
                else
                {
                    Debug.LogError($"不支持的黑板数据类型:{blackboarddatatype},打印失败!");
                }
            }
        }

        /// <summary>
        /// 获取黑板指定数据
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        private IBlackboardData GetBlackboardData(string key)
        {
            IBlackboardData value;
            if (!mBlackboardDataMap.TryGetValue(key, out value))
            {
                Debug.LogError(string.Format("找不到Key:{0}的黑板数据!", key));
            }
            return value;
        }
    }

    /// <summary>
    /// 黑板数据接口抽象
    /// </summary>
    public interface IBlackboardData
    {

    }

    /// <summary>
    /// 黑板数据泛型基类
    /// </summary>
    public class BlackboardData<T> : IBlackboardData
    {
        /// <summary>
        /// 数据
        /// </summary>
        public T Data
        {
            get;
            set;
        }
        public BlackboardData()
        {
            Data = default(T);
        }

        public BlackboardData(T data)
        {
            Data = data;
        }
    }

    #region 黑板数据常用数据类型定义
    /// <summary>
    /// 黑板数据整形数据
    /// </summary>
    public class IntBlackboardData : BlackboardData<int>
    {
        public IntBlackboardData(int data) : base(data)
        {
        }
    }

    /// <summary>
    /// 黑板数据浮点型数据
    /// </summary>
    public class FloatBlackboardData : BlackboardData<float>
    {
        public FloatBlackboardData(float data) : base(data)
        {
        }
    }

    /// <summary>
    /// 黑板数据Boolean型数据
    /// </summary>
    public class BoolBlackboardData : BlackboardData<bool>
    {
        public BoolBlackboardData(bool data) : base(data)
        {
        }
    }

    /// <summary>
    /// 黑板数据字符串型数据
    /// </summary>
    public class StringBlackboardData : BlackboardData<string>
    {
        public StringBlackboardData(string data) : base(data)
        {
        }
    }
    #endregion
}