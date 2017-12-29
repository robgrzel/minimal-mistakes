---
title: "Data-Structures: worst case time complexity"
categories:
  - Datastructures Complexity
tags:
  - Data Structures
  - Data
  - Structures
  - Java
  - Algorithms
gallery:
  - url: /assets/images/datastructures-complexity-java.pdf
    image_path: /assets/images/datastructures-complexity-java.pdf
    alt: "PDF"
    title: "Cheet sheet of complexity of datastructues in Java"
  - url: /assets/images/zt_java_collections_cheat_sheet.pdf
    image_path: /assets/images/zt_java_collections_cheat_sheet.pdf
    alt: "PDF"
    title: "Cheat sheet of datastructues collections in Java"

---

# Big-O (worst case) time complexity of Data Structures implemented in Java

## Cheat Sheets


{% include gallery caption="Complexity of datastructues in **Java**" %}


## In tables

Below are the Big O performance of common functions of different Java Collections.


List                 | Add  | Remove | Get  | Contains | Next | Data Structure
---------------------|------|--------|------|----------|------|---------------
ArrayList            | O(1) |  O(n)  | O(1) |   O(n)   | O(1) | Array
LinkedList           | O(1) |  O(1)  | O(n) |   O(n)   | O(1) | Linked List
CopyOnWriteArrayList | O(n) |  O(n)  | O(1) |   O(n)   | O(1) | Array



Set                   |    Add   |  Remove  | Contains |   Next   | Size | Data Structure
----------------------|----------|----------|----------|----------|------|-------------------------
HashSet               | O(1)     | O(1)     | O(1)     | O(h/n)   | O(1) | Hash Table
LinkedHashSet         | O(1)     | O(1)     | O(1)     | O(1)     | O(1) | Hash Table + Linked List
EnumSet               | O(1)     | O(1)     | O(1)     | O(1)     | O(1) | Bit Vector
TreeSet               | O(log n) | O(log n) | O(log n) | O(log n) | O(1) | Red-black tree
CopyOnWriteArraySet   | O(n)     | O(n)     | O(n)     | O(1)     | O(1) | Array
ConcurrentSkipListSet | O(log n) | O(log n) | O(log n) | O(1)     | O(n) | Skip List



Queue                   |  Offer   | Peak |   Poll   | Remove | Size | Data Structure
------------------------|----------|------|----------|--------|------|---------------
PriorityQueue           | O(log n) | O(1) | O(log n) |  O(n)  | O(1) | Priority Heap
LinkedList              | O(1)     | O(1) | O(1)     |  O(1)  | O(1) | Array
ArrayDequeue            | O(1)     | O(1) | O(1)     |  O(n)  | O(1) | Linked List
ConcurrentLinkedQueue   | O(1)     | O(1) | O(1)     |  O(n)  | O(n) | Linked List
ArrayBlockingQueue      | O(1)     | O(1) | O(1)     |  O(n)  | O(1) | Array
PriorirityBlockingQueue | O(log n) | O(1) | O(log n) |  O(n)  | O(1) | Priority Heap
SynchronousQueue        | O(1)     | O(1) | O(1)     |  O(n)  | O(1) | None!
DelayQueue              | O(log n) | O(1) | O(log n) |  O(n)  | O(1) | Priority Heap
LinkedBlockingQueue     | O(1)     | O(1) | O(1)     |  O(n)  | O(1) | Linked List



Map                   |   Get    | ContainsKey |   Next   | Data Structure
----------------------|----------|-------------|----------|-------------------------
HashMap               | O(1)     |   O(1)      | O(h / n) | Hash Table
LinkedHashMap         | O(1)     |   O(1)      | O(1)     | Hash Table + Linked List
IdentityHashMap       | O(1)     |   O(1)      | O(h / n) | Array
WeakHashMap           | O(1)     |   O(1)      | O(h / n) | Hash Table
EnumMap               | O(1)     |   O(1)      | O(1)     | Array
TreeMap               | O(log n) |   O(log n)  | O(log n) | Red-black tree
ConcurrentHashMap     | O(1)     |   O(1)      | O(h / n) | Hash Tables
ConcurrentSkipListMap | O(log n) |   O(log n)  | O(1)     | Skip List


## With descriptions:

Question: 
- Time Comeplexity of different data structures in Java ? [source](http://stackoverflow.com/questions/7294634/what-are-the-time-complexities-of-various-data-structures) 


#### Arrays
- Set, Check element at a particular index: O(1)
- Searching: 
-- O(n) if array is unsorted and O(log n) if array is sorted and something like a binary search is used. 
-- As pointed out by Aivean, there is no Delete operation available on Arrays. 
-- We can symbolically delete an element by setting it to some specific value, e.g. -1, 0, etc. depending on our requirements 
-- Similarly, Insert for arrays is basically Set as mentioned in the beginning

##### ArrayList:
- Add: Amortized O(1)
- Remove: O(n)
- Contains: O(n)
- Size: O(1)

##### Linked List:
- Inserting: O(1), if done at the head, O(n) if anywhere else since we have to reach that position by traveseing the linkedlist linearly.
- Deleting: O(1), if done at the head, O(n) if anywhere else since we have to reach that position by traveseing the linkedlist linearly.
- Searching: O(n)

##### Doubly-Linked List:
- Inserting: O(1), if done at the head or tail, O(n) if anywhere else since we have to reach that position by traveseing the linkedlist linearly.
- Deleting: O(1), if done at the head or tail, O(n) if anywhere else since we have to reach that position by traveseing the linkedlist linearly.
- Searching: O(n)

##### Stack:
- Push: O(1)
- Pop: O(1)
- Top: O(1)
- Search (Something like lookup, as a special operation): O(n) (I guess so)

##### Queue/Deque/Circular Queue:
- Insert: O(1)
- Remove: O(1)
- Size: O(1)

#### Binary Search Tree:
- Insert, delete and search: Average case: O(log n), Worst Case: O(n)

##### Red-Black Tree:
- Insert, delete and search: Average case: O(log n), Worst Case: O(log n)

##### Heap/PriorityQueue (min/max):
- findMin/findMax: O(1)
- insert: O(log n)
- deleteMin/Max: O(log n)
- lookup, delete (if at all provided): O(n), we will have to scan all the elements as they are not ordered like BST

## Java datastructures complexity descriptions:

### Java ArrayList time complexity :
- Read/Search any element O(n). If you know the index then the complexity is O(1)
- Update : O(n)
- Delete at beginning: O(n)
- Delete in middle: O(n)
- Delete at end: O(n)
- Add at beginning: O(n)
- Add in middle: O(n)
- Add at end: O(n)

### Linked List time complexity : 
It has elements linked in one direction so as to provide ordered iteration of elements.
- Read/Search any element O(n)
- Update : O(n)
- Delete at beginning: O(1)
- Delete in middle: O(n)
- Delete at end: O(n)
- Add at beginning: O(1)
- Add in middle: O(n)
- Add at end: O(n)

### HashMap time complexity : 
The elements are placed randomly as per the hashcode. Here the assumption is that a good implementation of hashcode has been provided.
- Read/Search any element O(1)
- Update : O(1)
- Delete : O(1)
- Add : O(1)

### LinkedHashMap time complexity : 
The elements are placed randomly as with HashMap but are linked together to provide ordered iteration of elements.
- Read/Search any element O(1)
- Update : O(1)
- Delete : O(1)
- Add at beginning: O(1)
- Add in middle: O(n)
- Add at end: O(n)

### HashSet time complexity : 
The elements are distributed randomly in memory using their hashcode. Here also the assumption is that good hashcode which generated unique hashcode for different objects has been provided.
- Read/Search any element O(1)
- Update : O(1)
- Delete : O(1)
- Add : O(1)

### LinkedHashSet time complexity : 
It is same as HashSet with the addition of links between the elements of the Set.
- Read/Search any element O(1)
- Update : O(1)
- Delete : O(1)
- Add at beginning: O(1)
- Add in middle: O(n)
- Add at end: O(n)

### TreeMap time complexity : 
Provides natural sorting of elements. Uses equals, compare and compareTo methods to determine the sorting order.
- Read/Search any element O(log n)
- Update : O(log n)
- Delete : O(log n)
- Add : O(log n)

### TreeSet time complexity : 
Internally used an instances of TreeMap with the elements as key and a dummy value for all entries in the TreeMap.
- Read/Search any element O(log n)
- Update : O(log n)
- Delete : O(log n)
- Add : O(log n)
