using UnityEngine;

public class TestRot : MonoBehaviour
{
    float _NormalDegree(float degree) {
        if (degree > 180.0f)
            degree = degree - 360.0f;
        else if (degree < -180.0f)
            degree = 360 + degree;
        return degree;
    }
    Vector3 _RelativeDegree(Vector3 parentDegree, Vector3 currDegree) {
        Quaternion q1 = new Quaternion();
        Quaternion q2 = new Quaternion();
        q1.eulerAngles = -parentDegree;
        q2.eulerAngles = currDegree;
        Quaternion q = q1 * q2;
        Vector3 ret = q.eulerAngles;
        ret.x = _NormalDegree(ret.x);
        ret.y = _NormalDegree(ret.y);
        ret.z = _NormalDegree(ret.z);
        return ret;
    }
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        Vector3 parentDegree = parentNode.eulerAngles;
        Vector3 childDegree = childNode.eulerAngles;
        Vector3 subDegree = _RelativeDegree(parentDegree, childDegree);
        Debug.Log(subDegree.ToString());

        var m = parentNode.worldToLocalMatrix * Matrix4x4.TRS(childNode.position, childNode.rotation, childNode.lossyScale);
        var degrees = m.rotation.eulerAngles;
        Debug.Log(degrees.ToString());
        var m1 = Matrix4x4.TRS(childNode.position, childNode.rotation, childNode.lossyScale);
        Debug.Log(m1.ToString());
        Debug.Log(childNode.localToWorldMatrix);

        var q = new Quaternion();
         q.eulerAngles = new Vector3(-97.512f, 90.152f, 269.847f);
        //q.eulerAngles = new Vector3(-90, 0, 180);
        //q.Normalize();
        Debug.LogError(q.ToString());
        Debug.LogError(q.eulerAngles);
    }

    public Transform parentNode;
    public Transform childNode;

    // Update is called once per frame
    void Update()
    {
        
    }
}
