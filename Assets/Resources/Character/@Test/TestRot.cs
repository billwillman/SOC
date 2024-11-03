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
    }

    public Transform parentNode;
    public Transform childNode;

    // Update is called once per frame
    void Update()
    {
        
    }
}
