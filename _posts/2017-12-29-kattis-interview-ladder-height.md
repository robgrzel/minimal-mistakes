---
title: "Kattis: basics - ladder length"
categories:
  - Kattis Basics
  - Java
tags:
  - Kattis
  - Basics
  - Programming
  - Java
  - Algorithms
problem_gallery:
  - url: /assets/images/ladder-hright.png
    image_path: /assets/images/ladder-hright.png
    alt: "splash layout example"
---

# Problem
 
During one of my interviews I had to solve problem:

{% include problem_gallery id="intro" type="center" %}


Solution in Java is very simple, its worth to note that I had to use ceil to round in Java to get next integer from float. 

```java 
import java.lang.Math; // headers MUST be above the first class
import java.util.Scanner;

// one class needs to have a main() method
public class LadderLength
{
    // arguments are passed using the text field below this editor
    public static void main(String[] args)
    {
        Scanner sc = new Scanner(System.in);
        while (sc.hasNextLong()) {
            int h = sc.nextInt();
            int v = sc.nextInt();
            System.out.println((int) Math.ceil(h / Math.sin(Math.toRadians(v))));
        }
    }
}

```