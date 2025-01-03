﻿/*
 * Description:             BaseParal.cs
 * Author:                  TONYTANG
 * Create Date:             2020/08/19
 */

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace LuaBehaviourTree
{
    /// <summary>
    /// BaseParal.cs
    /// 并发节点抽象基类
    /// </summary>
    public abstract class BaseParal : Composition
    {
        /// <summary>
        /// 并发策略
        /// </summary>
        public enum EBTParalPolicy
        {
            AllSuccess = 1,                 // 所有都成功就算成功
            OneSuccess,                     // 一个成功就算成功
        }

        /// <summary>
        /// 并发成功策略
        /// </summary>
        public EBTParalPolicy ParalPolicy
        {
            get;
            protected set;
        }

        /// <summary>
        /// 子节点执行结果列表
        /// </summary>
        protected List<EBTNodeRunningState> mChildNodeExecuteStateList;

        public BaseParal()
        {

        }

        public BaseParal(BTNode node, TBehaviourTree btowner, BTNode parentnode, int instanceid) : base(node, btowner, parentnode, instanceid)
        {
            OnCreate();
        }

        public override void OnCreate()
        {
            base.OnCreate();
            mChildNodeExecuteStateList = new List<EBTNodeRunningState>();
        }

        public override void SetDatas(BTNode node, TBehaviourTree btowner, BTNode parentnode, int instanceid)
        {
            base.SetDatas(node, btowner, parentnode, instanceid);
            foreach (var childnode in ChildNodes)
            {
                mChildNodeExecuteStateList.Add(childnode.NodeRunningState);
            }
        }

        /// <summary>
        /// 重置所有子节点执行状态
        /// </summary>
        protected void ResetAllChildNodeRunningState()
        {
            for(int i = 0, length = mChildNodeExecuteStateList.Count; i < length; i++)
            {
                mChildNodeExecuteStateList[i] = EBTNodeRunningState.Invalide;
            }
        }

        protected override void OnExit()
        {
            base.OnExit();
            ResetAllChildNodeRunningState();
        }

        /// <summary>
        /// 释放
        /// </summary>
        public override void Dispose()
        {
            base.Dispose();
            mChildNodeExecuteStateList = null;
        }

        //protected override EBTNodeRunningState OnExecute()
        //{
        //    var successcount = 0;
        //    var failedcount = 0;
        //    foreach (var childnode in ChildNodes)
        //    {
        //        EBTNodeRunningState childnodestate = childnode.NodeRunningState;
        //        if (!childnode.IsTerminated)
        //        {
        //            childnodestate = childnode.OnUpdate();
        //        }
        //        if (childnodestate == EBTNodeRunningState.Success)
        //        {
        //            successcount++;
        //            if (ParalPolicy == EBTParalPolicy.OneSuccess)
        //            {
        //                return EBTNodeRunningState.Success;
        //            }
        //        }
        //        else if (childnodestate == EBTNodeRunningState.Failed)
        //        {
        //            failedcount++;
        //            if (ParalPolicy == EBTParalPolicy.AllSuccess)
        //            {
        //                return EBTNodeRunningState.Failed;
        //            }
        //        }
        //    }

        //    if (ParalPolicy == EBTParalPolicy.AllSuccess)
        //    {
        //        if (successcount == ChildNodes.Count)
        //        {
        //            return EBTNodeRunningState.Success;
        //        }
        //        else
        //        {
        //            return EBTNodeRunningState.Running;
        //        }
        //    }
        //    else
        //    {
        //        if(failedcount == ChildNodes.Count)
        //        {
        //            return EBTNodeRunningState.Failed;
        //        }
        //        else
        //        {
        //            return EBTNodeRunningState.Running;
        //        }
        //    }
        //}
    }
}