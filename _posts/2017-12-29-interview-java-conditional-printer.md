---
title: "Interview-Task: conditional printing"
categories:
  - Interview 
  - Java 
tags:
  - Interview
  - Basics
  - Programming
  - Java
  - Algorithms
---

# Programming exercise:

- In a programing language of your choice, write a program/function that prints all the numbers between 1 and 100.
- For multiples of 3 print ”lingon” instead of the number.
- For multiples of 5 print ”berry” instead of the number
- For numbers which are multiples of both 3 and 5 print ”lingonberry” instead of the number.

# Solution:

## First solution

I thought that its so simple, I was wrong, hope will avoide mistakes like this again

```java 
class Main {
  public static void main(String[] args) {
    System.out.println("########### TASK 1: write a program/function that prints all the numbers between 1 and 100");
    for (int i=1; i<100; ++i){
      System.out.println(i);
    }
    System.out.println("########### TASK 2: For multiples of 3 print ”lingon” instead of the number.");
    for (int i=1; i<100; ++i){
      if (i%3 == 0){
        System.out.println("lingon");
      } else {
        System.out.println(i);
      }
    }
    System.out.println("########### TASK 3: For multiples of 5 print ”berry” instead of the number");
    for (int i=1; i<100; ++i){
      if (i%3 == 0){
        System.out.println("berry");
      } else {
        System.out.println(i);
      }    
    }
    System.out.println("########### TASK 4: For numbers which are multiples of both 3 and 5 print ”lingonberry” instead of the number.");
    for (int i=1; i<100; ++i){
      if (i%3 == 0 && i%5 == 0){
        System.out.println("lingonberry");
      } else {
        System.out.println(i);
      }    
    }
  }
}

```

## Second solution

This nice solution, J. said it and I belive him!

```java 
import java.util.HashMap;
import java.util.stream.IntStream;

public class ConditionalPrinter {
    private HashMap<Integer, String> map;

    public ConditionalPrinter() {
        map = new HashMap<Integer, String>();
    }

    public ConditionalPrinter(int n, String s) {
        map = new HashMap<Integer, String>();
        addNewCondition(n, s);
    }

    public void addNewCondition(int n, String s) {
        map.put(n, s);
    }

    public void addNewCondition(int[] n, String[] s) {
        IntStream.range(0, n.length).forEach(i -> map.put(n[i], s[i]));
    }

    public void conditionalPrint(int n) {

        if (map.isEmpty()) {
            System.out.println(n);

        } else {
            StringBuilder s = new StringBuilder();

            for (int i : map.keySet()) {
                if (n % i == 0) {
                    s.append(map.get(i));
                }
            }

            String word = s.toString();

            if (word.isEmpty()) {
                System.out.println(n);
            } else {
                System.out.println(word);
            }
        }
    }

    public void checkOverRange(int start, int stop){
        for (int i = start; i < stop; i++) {
            conditionalPrint(i);
        }
    }

    @Override
    public String toString() {
        return "new ConditionalPrinter(\" conditions : " + map.keySet().toString() + "\n\", conditional returns : " + map.keySet().toString() + ")";
    }

    public static void main (String[] args){
        ConditionalPrinter myprinter = new ConditionalPrinter();

        System.out.println("########### TASK 1: write a program/function that prints all the numbers between 1 and 100");
        myprinter.checkOverRange(1,100);
        System.out.println("########### TASK 2: For multiples of 3 print ”lingon” instead of the number.");
        myprinter.addNewCondition(3, "lingon");
        myprinter.checkOverRange(1,100);
        System.out.println("########### TASK 3: For multiples of 5 print ”berry” instead of the number +++...");
        System.out.println("...######## TASK 4: For numbers which are multiples of both 3 and 5 print ”lingonberry” instead of the number.");
        myprinter.addNewCondition(5, "berry");
        myprinter.checkOverRange(1,100);


    }

}

```