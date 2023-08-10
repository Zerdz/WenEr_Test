using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UiTest : MonoBehaviour
{
    Camera mainCam;

    Vector3[] oriCornersWorldPos;
    Vector3[] newCornersWorldPos;
    Vector4[] oriCornersScreenPos;
    Vector4[] newCornersScreenPos;

    public RectTransform oriPos;
    public RectTransform newPos;

    void Start()
    {
        mainCam = Camera.main;

        oriCornersWorldPos = new Vector3[4];
        newCornersWorldPos = new Vector3[4];
        oriCornersScreenPos = new Vector4[4];
        newCornersScreenPos = new Vector4[4];

        //oriPos.GetWorldCorners(oriCornersWorldPos);
        //newPos.GetWorldCorners(newCornersWorldPos);

        //for (int i = 0; i < 4; i++) 
        //{
        //    oriCornersScreenPos[i] = mainCam.WorldToScreenPoint(oriCornersWorldPos[i]);
        //    newCornersScreenPos[i] = mainCam.WorldToScreenPoint(newCornersWorldPos[i]);
        //}

        //Shader.SetGlobalVectorArray("_OriPos", oriCornersScreenPos);
        //Shader.SetGlobalVectorArray("_NewPos", newCornersScreenPos);
    }

    void FixedUpdate()
    {
        oriPos.GetWorldCorners(oriCornersWorldPos);
        newPos.GetWorldCorners(newCornersWorldPos);

        for (int i = 0; i < 4; i++)
        {
            oriCornersScreenPos[i] = mainCam.WorldToScreenPoint(oriCornersWorldPos[i]);
            newCornersScreenPos[i] = mainCam.WorldToScreenPoint(newCornersWorldPos[i]);
        }

        Shader.SetGlobalVectorArray("_OriPos", oriCornersScreenPos);
        Shader.SetGlobalVectorArray("_NewPos", newCornersScreenPos);

        //for (int i = 0; i < 4; i++)
        //{
        //    print(oriCornersScreenPos[i] + "   " + newCornersScreenPos[i]);
        //}
    }
}
