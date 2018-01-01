---
title: "Kattis: basics - vote"
categories:
  - Kattis 
  - Java
tags:
  - Interview
  - Kattis
  - Basic 
  - Programming
  - Java
  - Algorithms
gallery:
  - url: /assets/images/ladder-hright.png
    image_path: /assets/images/ladder-hright.png
    alt: "splash layout example"
---

# Problem
 
During one of my interviews I had to solve problem of leader election by best vote as in: [popular-vote](https://open.kattis.com/problems/vote)


# Solution

My first solution do:
 - check if there is only one value of votes
 - if winner votes are lesser than half of total amount its minority win
 - else if bigger than half, then its majority win
 
```java 
import java.lang.Math; // headers MUST be above the first class
import java.util.*;

// one class needs to have a main() method
public class CandidatesElection
{


    // arguments are passed using the text field below this editor
    public static void main(String[] args)
    {
        Scanner sc = new Scanner(System.in);
        int t = sc.nextInt(); //number of test cases
        Set<Integer> testCase;
        for (int j=0; j<t; j++) { //scan over number of test cases
            int votes;
            int winnerId=0;
            int totalVotes=0;
            int winnerVotes=0;
            int n = sc.nextInt();
            testCase = new HashSet<>();
            for (int i=0; i<n; i++){//scan over number of candidates with votes in test case
                votes = sc.nextInt();//i-candidate get no of votes
                totalVotes += votes;
                if (votes > winnerVotes) {//if new candidate has more wotes
                    winnerVotes = votes; //he is new winner
                    winnerId = i;
                }
                testCase.add(votes);
            }

            if (testCase.size() == 1){ //if all candidates has same vote key
                System.out.println("no winner"); //...then no winner
            } else if (winnerVotes*2 > totalVotes) {//if winner has more than half votes
                System.out.format("majority winner %d\n", winnerId+1);
            } else { //else winner has minority wotes
                System.out.format("minority winner %d\n", winnerId+1);
            }

        }
    }
}


```
 
 
Test it with this set:
```md
4
3
10
21
10
3
20
10
10
3
10
10
10
4
15
15
15
45
```


# Second solution

My first solution unfortunately failed, I simply omited that:
- check if winning amount of votes do not share more than one candidates:
-- if so, then we do not have winner either.

```java 
import java.util.*;

// one class needs to have a main() method
public class Votes
{


    // arguments are passed using the text field below this editor
    public static void main(String[] args)
    {
        Scanner sc = new Scanner(System.in);
        int t = sc.nextInt(); //number of test cases

        if (t == 0){//if no test cases
            System.out.println("no winner"); //...then no winner
            return;
        }

        int n;
        int votes;
        int votesArr[];
        int winnerId;
        int totalVotes;
        int winnerVotes;

        Map<Integer, Set<Integer>> testCase;

        for (int j=0; j<t; j++) { //scan over number of test cases

            n = sc.nextInt();
            votesArr = new int[n];

            for (int i=0; i<n; i++) {//scan over number of candidates with votes in test case
                votesArr[i] = sc.nextInt();//i-candidate get no of votes
            }

            winnerId=0;
            totalVotes=0;
            winnerVotes=0;
            testCase = new HashMap<>(n);

            for (int i=0; i<n; i++) {//iterate over number of candidates with votes in test case
                votes = votesArr[i];
                totalVotes += votes;
                if (votes > winnerVotes) {//if new candidate has more wotes
                    winnerVotes = votes; //he is new winner
                    winnerId = i;
                }

                if (!testCase.containsKey(votes)){
                    testCase.put(votes,new HashSet<>());
                }
                testCase.get(votes).add(i);
            }

            totalVotes -= winnerVotes;

            if (testCase.size() <= 1) { //if all candidates has same vote key
                System.out.println("no winner"); //...then no winner
            } else if (testCase.get(winnerVotes).size()>1){//if for maximum vote are more than one candidates
                System.out.println("no winner"); //...then no winner
            } else if (winnerVotes > totalVotes) {//if winner has more than half votes
                System.out.format("majority winner %d\n", winnerId+1);
            } else { //else winner has minority wotes
                System.out.format("minority winner %d\n", winnerId+1);
            }

        }
    }
}


```


Test it with

```md
4
3
10
21
10
3
20
10
10
3
10
10
10
4
15
15
45
45
```