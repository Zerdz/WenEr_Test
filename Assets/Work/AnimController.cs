using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimController : MonoBehaviour
{
    public delegate void Getter(float x);
    public delegate float Setter();
    float stepTime = 0.02f;
    Animator animator;
    int stage;

    public GameObject root;
    public Material material;
    public float time1;
    public float time2;
    public float time3;

    IEnumerator To(Setter setter, Getter getter, float target, float time)
    {
        float totalTime = 0;
        while (totalTime < time)
        {
            getter?.Invoke(Mathf.Lerp((float)setter?.Invoke(), target, totalTime / time));
            yield return new WaitForSecondsRealtime(stepTime);
            totalTime += stepTime;
        }
        getter?.Invoke(target);
    }

    public void Start()
    {
        animator = GetComponent<Animator>();
    }

    public void Update()
    {
        
    }

    private void OnMouseDown()
    {
        root.SetActive(false);
        root.SetActive(true);
        material.SetFloat("_Progress", 0);

        if(stage == 0) 
        {
            StartCoroutine(Process_A());
        }
        else if(stage == 1) 
        {
            StartCoroutine(Process_B());
        }   
    }

    IEnumerator Process_A() 
    {
        animator.Play("ScreenAnim", 0);
        yield return new WaitForSecondsRealtime(0.5f);
        StartCoroutine(To(() => 0, (x)=> material.SetFloat("_Progress",x), 0.3f, time1));
        yield return new WaitForSecondsRealtime(time1);
        StartCoroutine(To(() => 0.3f, (x) => material.SetFloat("_Progress", x), 0.4f, time2));
        yield return new WaitForSecondsRealtime(time2);
        StartCoroutine(To(() => 0.4f, (x) => material.SetFloat("_Progress", x), 1f, time3));
        yield return new WaitForSecondsRealtime(time3);
    }

    IEnumerator Process_B()
    {

        yield return null;
    }
}
