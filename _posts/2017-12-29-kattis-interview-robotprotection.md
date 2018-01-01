---
title: "Kattis: medium - area of robot protection"
categories:
  - Kattis 
  - Java 
  - Algorithms
  - Convex Hull
  - Polygon 
tags:
  - Interview
  - Kattis
  - Medium 
  - Programming
  - Java
  - Algorithms
  - Convex Hull
  - Double Linked List
  - Gift Wrapping
  - Scholace Formula
  - Polygon Area
gallery:
  - url: /assets/images/ladder-hright.png
    image_path: /assets/images/ladder-hright.png
    alt: "splash layout example"
---


# Problem
 
During one of my interviews I had to solve problem of finding maximum area of robot protection as in: [robot-protection](https://open.kattis.com/problems/robotprotection)

## Conclusions about problem:
```md
- Given a configuration of beacons, your job is to determine the area that the robot can patrol. 
- You should assume that the robot starts at the first beacon of the configuration.
```

My understanding:
- Second information seems useless. 
- Basically robot may move between any given points in straight lines. Task is to find maximum area he can move around. 
- Hmm.... For me it seems like convex hull problem. So to solve it, one has to implement Convex Hull Algorithm. 

# Solution

## Simple implementation:

Lets check character of our points set
- We do not have any keys here, 
- We store points in order how we get them
- We will not index randomly
- We will pick some n-th point and move to it, then select other from n-1 points, etc...

Looking at above, we check from point to point, so lets use DoubleLinkedList.
 
We use Gift Wrapping (aka Jarvis's march) algorithm to solve the problem. Even if it has time complexity of O(h*n),
we will use Akl-Toussaint heuristic algorithm to more it more efficient and gain complexity of O(n). Both algorithm will 
have own classes and implement interface of Algorithm. For debugging purposes we will use drawing in JavaFX with class
Point Printer, also printing to stdout. Finally to calculate area of robot protection we will use Scholace formula for
polygon in Robot Area class. 
 
# Code

## Double linked list:
  
This is simple implementation of double linked list, where each node has pointer to next one and previous one.
It is implemented in this way that black-box head node (at index 0) has null data and point to not-null next note, 
similarly tail node (at index n) has null data and point to not-null previous node. But method getHead will return node with 
index 1, and getTail will return node with index n-1.
  
```java 
import java.util.ConcurrentModificationException;
import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 *  ref: https://en.wikipedia.org/wiki/Doubly_linked_list
 * @param <E>
 */
public class DoubleLinkedList<E> implements Iterable<E> {


    /////////////////////////////////////////////////////////////////////////
    //// Additional classes
    /////////////////////////////////////////////////////////////////////////

    public static class Node<E> {
        Node<E> next;
        Node<E> prev;
        E data;

        Node(E d, Node<E> p, Node<E> n) {
            this.data = d;
            this.prev = p;
            this.next = n;
        }

        public void print() {
            System.out.println(toString());
        }

        /**
         * Returns the node before this node in the doubly linked list.
         *
         * @return the node before this node
         */
        public Node<E> getPrev() {
            return this.prev;
        }

        /**
         * Sets the node that comes before this node in the doubly linked list.
         *
         * @param prev the node to be set as the previous node
         */
        public void setPrev(Node<E> prev) {
            this.prev = prev;
        }

        /**
         * Returns the node after this node in the doubly linked list.
         *
         * @return the node after this one
         */
        public Node<E> getNext() {
            return this.next;
        }

        /**
         * Sets the node that comes after this node in the doubly linked list.
         *
         * @param next the node to be set as the next
         */
        public void setNext(Node<E> next) {
            this.next = next;
        }

        /**
         * Returns the Point2D.Double object contained.
         *
         * @return the point that this node holds
         */
        public E getData() {
            return this.data;
        }

        @Override
        public String toString() {
            String str = "<";

            if (prev == null) str += "null,";
            else if (prev.data == null) str += "null,";
            else str += prev.data.toString() + ',';

            if (data == null) str += "null,";
            else str += data.toString() + ',';

            if (next == null) str += "null";
            else if (next.data == null) str += "null";
            else str += next.data.toString();

            str += ">\n";
            return str;
        }

    }

    private class LinkedListIterator implements Iterator<E> {

        private Node<E> current = head.next;
        private int modCountExpected = modCount;
        private boolean isRemovable = false;


        public void remove() {

            if (modCount != modCountExpected) {
                throw new ConcurrentModificationException();
            }

            if (!isRemovable) {
                throw new IllegalStateException();
            }

            DoubleLinkedList.this.remove(current.prev);
            modCountExpected++;
            isRemovable = false;

        }

        @Override
        public String toString() {
            StringBuilder str = new StringBuilder();

            Node<E> tmp = current;
            str.append(head.toString());
            while (true) {
                if (tmp == null)  break;
                str.append(tmp.toString());
                tmp = tmp.next;
            }

            return str.toString();

        }

        @Override
        public boolean hasNext() {
            return current != tail;
        }

        @Override
        public E next() {
            if (modCount != modCountExpected) {
                throw new ConcurrentModificationException();
            }

            if (!hasNext()) {
                throw new NoSuchElementException();
            }

            E nextItem = current.data;
            current = current.next;
            isRemovable = true;
            return nextItem;
        }


    }//todo

    /////////////////////////////////////////////////////////////////////////
    //// Doublie Linked List methods
    /////////////////////////////////////////////////////////////////////////

    private int size;
    private int modCount = 0;
    private Node<E> head; //idx = 0
    private Node<E> tail; //idx = len - 1

    public DoubleLinkedList() {
        doClear();
    }

    public void clear() {
        doClear();
    } //todo

    public int size() {
        return size;
    } //todo

    public boolean isEmpty() {
        return size() == 0;
    }

    public boolean contains(E point) {
        Node<E> node = this.getHead();
        while (node != null) {
            if (point == null && node.getData() == null) {
                return true;
            } else if (point != null && node.getData() != null && node.getData().equals(point)) {
                return true;
            }
            node = node.getNext();
        }
        return false;
    }


    /**
     * Adds all nodes from another linked list to this list.
     *
     * @param list points to be inserted into the linked list
     */
    public boolean add(DoubleLinkedList<E> list) {

        Iterator<E> iter = list.iterator();

        boolean isAdd = true;
        for (int i = 0; i < list.size(); i++) {
            isAdd &= add(iter.next());

        }

        return isAdd;
    }

    public boolean add(E x) {
        add(size(), x);
        return true;
    }

    public void add(int idx, E x) {
        addBefore(getNode(idx, 0, size()), x);
        size();
    }

    /**
     * Returns the first node of the linked list, idx = 0.
     *
     * @return the first node in the linked list
     */
    public Node<E> getHead() {
        if (this.head == null) return null;
        return this.head.getNext();
    }

    /**
     * Sets a new head for the list. For manual list manipulation.
     *
     * @param head new head node
     */
    public void setHead(Node<E> head) {
        this.head = head;
    }

    /**
     * Returns the last node of the linked list, idx = len-1.
     *
     * @return the first node in the linked list
     */
    public Node<E> getTail() {
        if (this.tail == null) return null;
        return this.tail.getPrev();
    }

    /**
     * Sets a new tail for the list. For manual list manipulation.
     *
     * @param tail new tail node
     */
    public void setTail(Node<E> tail) {
        this.tail = tail;
    }


    // finds the middle element of the node list for splitting
    private Node<E> getMiddleNode(DoubleLinkedList<E> list) {
        if (list.getHead() == null) {
            return null;
        }
        Node<E> slow, fast;
        slow = list.getHead();
        fast = list.getHead();
        while (fast.getNext() != null && fast.getNext().getNext() != null) {
            slow = slow.getNext();
            fast = fast.getNext().getNext();
        }
        // when fast reaches the end, slow is half way there
        return slow;
    }

    public E get(int idx) {
        return getNode(idx).data;
    }

    public E set(int idx, E val) {
        Node<E> p = getNode(idx);
        E oldVal = p.data;
        p.data = val;
        return oldVal;
    }

    public E remove(int idx) {
        return remove(getNode(idx));
    }

    /**
     * Adds an item to this collection, at specified position p.
     * Items at or after that position are slid one position higher.
     *
     * @param p Node<E>to add before.
     * @param x any object.
     * @throws IndexOutOfBoundsException if idx is not between 0 and size(),.
     */
    private void addBefore(Node<E> p, E x) {

        Node<E> node = new Node<E>(x, p.prev, p);
        node.prev.next = node;
        p.prev = node;
        size++;
        modCount++;

    }//todo

    private E remove(Node<E> p) {
        p.next.prev = p.prev;
        p.prev.next = p.next;
        size--;
        modCount++;
        return p.data;

    } //todo

    /**
     * Gets the Node<E>at position idx, which must range from 0 to size( ) - 1.
     *
     * @param idx index to search at.
     * @return internal node corresponding to idx.
     * @throws IndexOutOfBoundsException if idx is not
     *                                   between 0 and size( ) - 1, inclusive.
     */
    private Node<E> getNode(int idx) {

        return getNode(idx, 0, size() - 1);

    }//todo

    /**
     * Gets the Node<E>at position idx, which must range from lower to upper.
     *
     * @param idx   index to search at.
     * @param lower lowest valid index.
     * @param upper highest valid index.
     * @return internal node corresponding to idx.
     * @throws IndexOutOfBoundsException if idx is not
     *                                   between lower and upper, inclusive.
     */
    private Node<E> getNode(int idx, int lower, int upper) {

        Node<E> p;

        if (idx < lower || idx > upper) {
            throw new IndexOutOfBoundsException();
        }

        if (idx < size() >> 1) {
            p = head.next;
            for (int i = 0; i < idx; i++) p = p.next;

        } else {
            p = tail;
            for (int i = size(); i > idx; i--) p = p.prev;
        }

        return p;

    }//todo

    private void doClear() {
        head = new Node<E>(null, null, null);
        tail = new Node<E>(null, head, null);
        head.next = tail;

        size = 0;
        modCount++;
    }

    @Override
    public String toString() {
        return iterator().toString();
    }

    public void print() {
        System.out.println(toString());
    }

    @Override
    public Iterator<E> iterator() {
        return new LinkedListIterator();
    } //todo

    public static void main(String[] args) {

        DoubleLinkedList<String> list = new DoubleLinkedList<>();

        list.add("0");
        list.add("1");
        list.add("1");
        list.add("2");
        list.add("3");
        list.add("5");

        list.print();

        list.remove(3);
        list.print();
        list.remove(1);
        list.print();
        list.remove(3);
        list.print();

        list.add(3, "ala");
        list.print();
        list.add(1, "berry");
        list.print();
        list.add(2, "lingon");
        list.print();
        list.add(0, "straw");
        list.print();

        list.set(1, "violet");
        list.print();


        list.addBefore(list.getNode(6), "before");
        list.print();
    }
}

```
 
## Algorithm (interface)

This interface was made to restrict implementing it classes to using data container of type 
DoubleLinkedList<Point2D.Double>.

```java 
import java.awt.geom.Point2D;

/**
 * Interface for all algorithms and Akl-Toussaint heuristics.
 */
public interface Algorithm {

    /**
     * Gets a set of points, processes them and returns the result set.
     *
     * @param points    set of points to run algorithm on
     * @return          result set of points after algorithm has handled the
     *                   input set
     */
    public DoubleLinkedList<Point2D.Double> calculate(DoubleLinkedList<Point2D.Double> points, boolean DEBUG);
}
```
 
## Akl-Toussaint heuristic
 
Class for Akl-Toussaint heuristic [Quote from Wikipedia](http://en.wikipedia.org/wiki/Convex_hull_algorithms): 

- The following simple heuristic is often used as the first step in implementations of convex hull algorithms to improve their performance. It is based on the efficient convex hull algorithm by Selim Akl and G. T. Toussaint, 1978.  

### Characteristics:

- The idea is to quickly exclude many points that would not be part of the convex hull anyway. This method is based on the following idea:
-- Find the two points with the lowest and highest x-coordinates, and the two points with the lowest and highest y-coordinates. (Each of these operations takes O(n).)
-- These four points form a convex quadrilateral, and all points that lie in this quadrilateral (except for the four initially chosen vertices) are not part of the convex hull. 
-- Finding all of these points that lie in this quadrilateral is also O(n), and thus, the entire operation is O(n). 
-- Optionally, the points with smallest and largest sums of x- and y-coordinates as well as those with smallest and largest differences of x- and y-coordinates can also be added to the quadrilateral, thus forming an irregular convex octagon, whose insides can be safely discarded. 
-- If the points are random variables, then for a wide class of probability density functions, this throw-away pre-processing step will make a convex hull algorithm run in linear expected time, even if the worst-case complexity of the convex hull algorithm is quadratic in n."
 
```java 

import java.awt.geom.Point2D;

/**
 * Class for Akl-Toussaint heuristic <p> Quote from Wikipedia
 * (http://en.wikipedia.org/wiki/Convex_hull_algorithms) <p> "The following
 * simple heuristic is often used as the first step in implementations of convex
 * hull algorithms to improve their performance. It is based on the efficient
 * convex hull algorithm by Selim Akl and G. T. Toussaint, 1978. <p> The idea is
 * to quickly exclude many points that would not be part of the convex hull
 * anyway. This method is based on the following idea. Find the two points with
 * the lowest and highest x-coordinates, and the two points with the lowest and
 * highest y-coordinates. (Each of these operations takes O(n).) These four
 * points form a convex quadrilateral, and all points that lie in this
 * quadrilateral (except for the four initially chosen vertices) are not part of
 * the convex hull. Finding all of these points that lie in this quadrilateral
 * is also O(n), and thus, the entire operation is O(n). Optionally, the points
 * with smallest and largest sums of x- and y-coordinates as well as those with
 * smallest and largest differences of x- and y-coordinates can also be added to
 * the quadrilateral, thus forming an irregular convex octagon, whose insides
 * can be safely discarded. If the points are random variables, then for a wide
 * class of probability density functions, this throw-away pre-processing step
 * will make a convex hull algorithm run in linear expected time, even if the
 * worst-case complexity of the convex hull algorithm is quadratic in n."
 */
public class AklToussaintHeuristic implements Algorithm {

    /**
     * The main method that runs the algorithm described in the class
     * description.
     *
     * @param points set of points to run the algorithm on
     * @return points remaining in set after running the heuristic
     */
    @Override
    public DoubleLinkedList<Point2D.Double> calculate(DoubleLinkedList<Point2D.Double> points, boolean DEBUG) {

        DoubleLinkedList<Point2D.Double> octagonPoints = octagonPoints(points);
        if (DEBUG) System.out.println(octagonPoints.size());
        // need at least a triangle to remove points
        if (points.size() < 4 || octagonPoints.size() < 3) {
            if (DEBUG) System.out.println("Akl-Toussaint heuristic removed 0 nodes.");
            return points;
        }
        // go through all points to remove points that are inside the octagon
        DoubleLinkedList<Point2D.Double> outsideNodes = removePointsInsideOctagon(points, octagonPoints);

        if (DEBUG) System.out.println("Akl-Toussaint heuristic removed " + (points.size() - outsideNodes.size()) + " nodes.");

        return outsideNodes;
    }

    // returns points of param points that are not inside the octagon defined by
    // param octagonPoints
    private DoubleLinkedList<Point2D.Double> removePointsInsideOctagon(DoubleLinkedList<Point2D.Double> points, DoubleLinkedList<Point2D.Double> octagonPoints) {
        DoubleLinkedList<Point2D.Double> outsideNodes = new DoubleLinkedList<>();
        DoubleLinkedList.Node<Point2D.Double> pNode = points.getHead();

        while (pNode != null) {
            DoubleLinkedList.Node<Point2D.Double> oNode = octagonPoints.getHead().getNext();
            boolean inside = true;
            double area;
            while (oNode != null) {
                Point2D.Double p1, p2, p3;
                p1 = oNode.getPrev().getData();
                p2 = oNode.getData();
                p3 = pNode.getData();
                if (p2 != null && p3 != null) {
                    area = this.triangleArea(p1, p2, p3);
                    boolean isInside = area >= 0;
                    if (isInside) {
                        inside = false;
                        break;
                    }
                }
                oNode = oNode.getNext();
            }
            if (!inside) {
                outsideNodes.add(pNode.getData());
            }
            pNode = pNode.getNext();
        }
        return outsideNodes;
    }

    // Helper method for finding the points needed.
    private DoubleLinkedList<Point2D.Double> octagonPoints(DoubleLinkedList<Point2D.Double> points) {
        // array for points, indexes:
        // 0 = min(x), 1 = min(x-y), 2 = max(y), 3 = max(x+y)
        // 4 = max(x), 5 = max(x-y), 6 = min(y), 7 = min(x+y)
        Point2D.Double[] octagonPoints = new Point2D.Double[8];
        DoubleLinkedList.Node<Point2D.Double> node = points.getHead();
        // array indexes to first point
        presetArray(octagonPoints, node.getData());
        while (node != null) {
            if (node.getData() == null) break;
            Point2D.Double point = node.getData();
            // minimum and maximum x value
            octagonPoints[0] = minXPoint(point, octagonPoints[0]);
            octagonPoints[4] = maxXPoint(point, octagonPoints[4]);
            // minimum and maximum y value
            octagonPoints[6] = minYPoint(point, octagonPoints[6]);
            octagonPoints[2] = maxYPoint(point, octagonPoints[2]);
            // minimum and maximum sum of coordinates
            octagonPoints[7] = minCoordSum(point, octagonPoints[7]);
            octagonPoints[3] = maxCoordSum(point, octagonPoints[3]);
            // minimum and maximum differences of x- and y-coordinates
            octagonPoints[1] = minCoordDiff(point, octagonPoints[1]);
            octagonPoints[5] = maxCoordDiff(point, octagonPoints[5]);
            node = node.getNext();
        }

        // add points to list in order and delete duplicates
        return linkedListFromArray(octagonPoints);
    }

    /*
     * Area of triangle P0P1P2 is
     * (1/2) * det([[x0, x1, x2], [y0, y1, y2], [1, 1, 1]]).
     *
     * If the area is positive then the points occur in
     * anti-clockwise order and P2 is to the left of the line P0P1.
     * Since we only care whether the area is positive,
     * we can discard multiplication by 0.5.
     */
    private double triangleArea(Point2D.Double p0, Point2D.Double p1, Point2D.Double p2) {
        return (p1.getX() - p0.getX()) * (p2.getY() - p0.getY())
                - (p1.getY() - p0.getY()) * (p2.getX() - p0.getX());
    }

    // turns array of points to linked list of points without doubles except the
    // first and the last point
    private DoubleLinkedList<Point2D.Double> linkedListFromArray(Point2D.Double[] points) {
        DoubleLinkedList<Point2D.Double> newList = new DoubleLinkedList<Point2D.Double>();
        newList.add(points[0]);
        DoubleLinkedList.Node<Point2D.Double> current = newList.getHead();
        for (int i = 1; i < 8; i++) {
            if (!points[i].equals(current.getData())) {
                newList.add(points[i]);
                current = current.getNext();
            }
        }
        newList.add((Point2D.Double) newList.getHead().getData());
        return newList;
    }

    // sets all array indexes to given point
    private void presetArray(Point2D.Double[] array, Point2D.Double point) {
        for (int i = 0; i < array.length; i++) {
            array[i] = point;
        }
    }

    // return the point with lesser x coordinate
    private Point2D.Double minXPoint(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getX() < point2.getX()) {
            return point1;
        }
        return point2;
    }

    // return the point with greater x coordinate
    private Point2D.Double maxXPoint(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getX() > point2.getX()) {
            return point1;
        }
        return point2;
    }

    // return the point with lesser y coordinate
    private Point2D.Double minYPoint(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getY() < point2.getY()) {
            return point1;
        }
        return point2;
    }

    // return the point with greater y coordinate
    private Point2D.Double maxYPoint(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getY() > point2.getY()) {
            return point1;
        }
        return point2;
    }

    // return the point with lesser sum of coordinates
    private Point2D.Double minCoordSum(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getX() + point1.getY() < point2.getX() + point2.getY()) {
            return point1;
        } else {
            return point2;
        }
    }

    // return the point with greater sum of coordinates
    private Point2D.Double maxCoordSum(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getX() + point1.getY() > point2.getX() + point2.getY()) {
            return point1;
        } else {
            return point2;
        }
    }

    // return the point with lesser difference of coordinates
    private Point2D.Double minCoordDiff(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getX() - point1.getY() < point2.getX() - point2.getY()) {
            return point1;
        } else {
            return point2;
        }
    }

    // return the point with greater difference of coordinates
    private Point2D.Double maxCoordDiff(Point2D.Double point1, Point2D.Double point2) {
        if (point1.getX() - point1.getY() > point2.getX() - point2.getY()) {
            return point1;
        } else {
            return point2;
        }
    }
}

```
## GiftWrapping

Class for Gift Wrapping (aka Jarvis's march) algorithm. 

### Characteristics

From [wikipedia](http://en.wikipedia.org/wiki/Gift_wrapping_algorithm):

- Run time: O(n*h)
-- where n is the number of input points 
-- h is the number of hull points.
- This makes this algorithm an output-sensitive algorithm. 
- Steps:
-- The gift wrapping algorithm begins with i=0 and a point p_0 known to be on
the convex hull, e.g., the leftmost point, 
-- selects the point p_(i+1) such that all points are to the right of the line pi pi+1. This point may be found in O(n) time by comparing polar angles of all points with respect to point pi taken for the center of polar coordinates. 
-- Letting i=i+1, and repeating with until one reaches p_h=p_0 again yields the convex hull in h steps. 
- In two dimensions, the gift wrapping algorithm is similar to the process of winding a string (or wrapping paper) around the set of points."



```java 

import java.awt.geom.Point2D;

/**
 * Class for Gift Wrapping (aka Jarvis's march) algorithm. Wikipedia article:
 * http://en.wikipedia.org/wiki/Gift_wrapping_algorithm <p> Run time: O(n*h)
 * where n is the number of input points and h is the number of hull points.
 * This makes this algorithm an output-sensitive algorithm. <p> Wikipedia quote:
 * "The gift wrapping algorithm begins with i=0 and a point p_0 known to be on
 * the convex hull, e.g., the leftmost point, and selects the point p_(i+1) such
 * that all points are to the right of the line pi pi+1. This point may be found
 * in O(n) time by comparing polar angles of all points with respect to point pi
 * taken for the center of polar coordinates. Letting i=i+1, and repeating with
 * until one reaches p_h=p_0 again yields the convex hull in h steps. In two
 * dimensions, the gift wrapping algorithm is similar to the process of winding
 * a string (or wrapping paper) around the set of points."
 */
public class GiftWrapping implements Algorithm {

    /**
     * Processes point set using Gift Wrapping algorithm and returns the points
     * of the convex hull of the input set.
     *
     * @param points set of points to run the algorithm on
     * @return convex hull points
     */
    @Override
    public DoubleLinkedList<Point2D.Double> calculate(DoubleLinkedList<Point2D.Double> points, boolean DEBUG) {
        if (points.size() < 4) {
            return points;
        }

        // Find the point with minimum x coordinate: O(n).
        Point2D.Double minXPoint = findMinX(points);

        DoubleLinkedList<Point2D.Double> hullPoints = new DoubleLinkedList<Point2D.Double>();
        hullPoints.add(minXPoint);

        Point2D.Double endPoint = minXPoint;
        Point2D.Double newEndPoint = null;

        // Do until hull closes, that is, for all hull points: O(h).
        // Inner loop checks every point of the set: O(n).
        // Run time is O(n*h).
        while (true) {
            // initial candidate for new end point
            DoubleLinkedList.Node<Point2D.Double> current = points.getHead();
            newEndPoint = current.getData();
            current = current.getNext();
            double totalArea = 0.0;
            while (current != null) {
                Point2D.Double temp = current.getData();
                // ignore if temp is the current end point
                if (temp != null) {
                    if (!temp.equals(endPoint)) {
                        double triangleArea = triangleArea(endPoint, newEndPoint, temp);
                        // If temp is left of line from endpoint to candidate
                        // (area positive), update candidate.
                        totalArea += triangleArea;
                        if (triangleArea >= 0) {
                            newEndPoint = temp;
                        }
                        if (totalArea == 0.0 && current.getNext() == null) {
                            // all collinear so return all
                            return points;
                        }
                    }
                }
                current = current.getNext();
            }
            // if the new end point candidate is the same as the starting point
            // hull is closed and we can exit the loop
            if (newEndPoint.equals(minXPoint)) {
                break;
            }
            // Add to hull points and update end point.
            hullPoints.add(newEndPoint);
            endPoint = newEndPoint;
        }

        return hullPoints;
    }

    // Finds the point with minimum x coordinate.
    private Point2D.Double findMinX(DoubleLinkedList<Point2D.Double> points) {
        Point2D.Double minXPoint = null;
        DoubleLinkedList.Node<Point2D.Double> node = points.getHead();
        while (node != null) {
            Point2D.Double point = node.getData();
            if (point != null) {
                if (minXPoint == null || point.getX() < minXPoint.getX()) {
                    minXPoint = point;
                }
            }
            node = node.getNext();
        }
        return minXPoint;
    }

    /*
     * Area of triangle P0P1P2 is
     * (1/2) * det([[x0, x1, x2], [y0, y1, y2], [1, 1, 1]]).
     *
     * If the area is positive then the points occur in
     * anti-clockwise order and P2 is to the left of the line P0P1.
     * Since we only care whether the area is positive,
     * we can discard multiplication by 0.5.
     */
    private double triangleArea(Point2D.Double p0, Point2D.Double p1, Point2D.Double p2) {
        double triangleArea =
                (p1.getX() - p0.getX()) * (p2.getY() - p0.getY())
                        - (p1.getY() - p0.getY()) * (p2.getX() - p0.getX());
        return triangleArea;
    }
}

```
## Point Printer

This java class allows to graphically display initial set of points, outer set of points from 
Akl-Toussaint algorithm and final ordered set of points from Gift Wrapping algorithm.

```java

import javax.swing.*;
import java.awt.*;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Point2D;

/**
 * Takes care of scaling and printing all points and hull points.
 *
 * @author Heikki Haapala
 */
public class PointPrinter extends JPanel {

    private DoubleLinkedList<Point2D.Double> hullPoints;
    private DoubleLinkedList<Point2D.Double> aklPoints;
    private DoubleLinkedList<Point2D.Double> allPoints;
    private double xCorrection;
    private double yCorrection;
    private double pointAreaWidth;
    private double pointAreaHeight;
    private double maxX, minX, maxY, minY;
    private boolean awesomeColours;

    public static class Draw{

        public Draw(DoubleLinkedList<Point2D.Double> allPoints,
                                         DoubleLinkedList<Point2D.Double> aklPoints,
                                         DoubleLinkedList<Point2D.Double> hullPoints, boolean awesomeColours) {
            JFrame frame = new JFrame("Points");
            frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            frame.add(new PointPrinter(allPoints, aklPoints, hullPoints, awesomeColours));
            frame.setSize(800, 800);
            frame.setLocationRelativeTo(null);
            frame.setVisible(true);
        }
    }

    /**
     * @param allPoints
     * @param aklPoints
     * @param hullPoints
     */
    public PointPrinter(DoubleLinkedList<Point2D.Double> allPoints,
                        DoubleLinkedList<Point2D.Double> aklPoints,
                        DoubleLinkedList<Point2D.Double> hullPoints, boolean awesomeColours) {
        this.hullPoints = hullPoints;
        this.aklPoints = aklPoints;
        this.allPoints = allPoints;
        this.awesomeColours = awesomeColours;
        if (awesomeColours) {
            setBackground(Color.BLACK);
        } else {
            setBackground(Color.WHITE);
        }
        findMax();
    }



    /**
     * @param g
     */
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);

        Graphics2D g2d = (Graphics2D) g;

        Dimension size = getSize();
        Insets insets = getInsets();

        int width = size.width - insets.left - insets.right - 20;
        int height = size.height - insets.top - insets.bottom - 20;

        double xScaler = width;
        if (pointAreaWidth != 0) {
            xScaler /= pointAreaWidth;
        }
        double yScaler = height;
        if (pointAreaHeight != 0) {
            yScaler /= pointAreaHeight;
        }

        // print axles
        if (awesomeColours) {
            g2d.setColor(Color.GRAY);
        } else {
            g2d.setColor(Color.BLACK);
        }

        Shape xAxle = new Line2D.Double(0, yScaler * yCorrection + 10, width + 20, yScaler * yCorrection + 10);
        g2d.draw(xAxle);
        Shape yAxle = new Line2D.Double(xScaler * xCorrection + 10, 0, xScaler * xCorrection + 10, height + 20);
        g2d.draw(yAxle);

        // print hull points
        if (awesomeColours) {
            g2d.setColor(Color.MAGENTA);
        } else {
            g2d.setColor(Color.BLUE);
        }
        Shape circle = new Ellipse2D.Double(0, 0, 15, 15);
        g2d.draw(circle);
        double x1 = Integer.MAX_VALUE;
        double y1 = Integer.MAX_VALUE;
        DoubleLinkedList.Node<Point2D.Double> node = this.hullPoints.getHead();
        while (node != null) {
            if (node.getData() != null) {
                Point2D.Double point1 = node.getData();
                x1 = (point1.getX() + xCorrection) * xScaler + 10;
                y1 = (point1.getY() + yCorrection) * yScaler + 10;
                circle = new Ellipse2D.Double(x1 - 3, y1 - 3, 7, 7);
                g2d.draw(circle);
                if (node.getPrev() != null) {
                    if (node.getPrev().getData() != null) {
                        Point2D.Double point2 = node.getPrev().getData();
                        double x2 = (point2.getX() + xCorrection) * xScaler + 10;
                        double y2 = (point2.getY() + yCorrection) * yScaler + 10;
                        Shape line = new Line2D.Double(x1, y1, x2, y2);
                        g2d.draw(line);
                    }
                }

            }

            node = node.getNext();
        }

        if (hullPoints.getHead().getData() != null) {
            if (x1 != Integer.MAX_VALUE && y1 != Integer.MAX_VALUE) {
                Point2D.Double point2 = hullPoints.getHead().getData();
                double x2 = (point2.getX() + xCorrection) * xScaler + 10;
                double y2 = (point2.getY() + yCorrection) * yScaler + 10;
                Shape line = new Line2D.Double(x1, y1, x2, y2);
                g2d.draw(line);
            }
        }

        // print all points
        if (awesomeColours) {
            g2d.setColor(Color.BLUE);
        } else {
            g2d.setColor(Color.GREEN);
        }

        node = this.allPoints.getHead();
        while (node != null) {
            if (node.getData() != null) {
                Point2D.Double point1 = node.getData();
                x1 = (point1.getX() + xCorrection) * xScaler + 10;
                y1 = (point1.getY() + yCorrection) * yScaler + 10;
                circle = new Ellipse2D.Double(x1 - 1, y1 - 1, 3, 3);
                g2d.draw(circle);
            }
            node = node.getNext();
        }

        // print aklPoints
        if (awesomeColours) {
            g2d.setColor(Color.GREEN);
        } else {
            g2d.setColor(Color.RED);
        }

        node = this.aklPoints.getHead();
        while (node != null) {
            if (node.getData() != null) {
                Point2D.Double point1 = node.getData();
                x1 = (point1.getX() + xCorrection) * xScaler + 10;
                y1 = (point1.getY() + yCorrection) * yScaler + 10;
                circle = new Ellipse2D.Double(x1 - 1, y1 - 1, 3, 3);
                g2d.draw(circle);
            }
            node = node.getNext();
        }

        if (awesomeColours) {
            g2d.setColor(Color.GRAY);
        } else {
            g2d.setColor(Color.BLACK);
        }
        g2d.drawString("X: [" + minX + "," + maxX + "]", 10, 20);
        g2d.drawString("Y: [" + minY + "," + maxY + "]", 10, 35);
    }

    private void findMax() {
        DoubleLinkedList.Node<Point2D.Double> node = this.allPoints.getHead();
        maxX = node.getData().getX();
        minX = node.getData().getX();
        maxY = node.getData().getY();
        minY = node.getData().getY();
        while (node != null) {
            if (node.getData() != null) {
                Point2D.Double point = node.getData();
                if (point.getX() > maxX) {
                    maxX = point.getX();
                } else if (point.getX() < minX) {
                    minX = point.getX();
                }
                if (point.getY() > maxY) {
                    maxY = point.getY();
                } else if (point.getY() < minY) {
                    minY = point.getY();
                }
            }
            node = node.getNext();
        }

        this.xCorrection = -minX;
        this.yCorrection = -minY;
        this.pointAreaWidth = maxX - minX;
        this.pointAreaHeight = maxY - minY;
    }
}

```

## Robot Area

This final class set initial points, calculate and give output of convex hull points. 
In debug mode it will plot points and outer hull.

```java
import java.awt.geom.Point2D;
import java.util.Scanner;

public class RobotArea {
    private static boolean DEBUG = false;

    /**
     * @param args
     */
    // arguments are passed using the text field below this editor
    public static void main(String[] args) {

        if (DEBUG) {

            testCase5();
            testCase10();

        } else {
            Scanner sc = new Scanner(System.in);

            while (sc.hasNextInt()) {
                int n = sc.nextInt();
                if (n == 0) break;

                int x[] = new int[n];
                int y[] = new int[n];

                for (int i = 0; i < n; i++) {
                    x[i] = sc.nextInt();
                    y[i] = sc.nextInt();
                }

                testCase(x, y);


            }
        }
    }

    private static double polygonArea(DoubleLinkedList<Point2D.Double> points) {
        //Scholace formula
        double area = 0;
        Point2D.Double p0 = null;
        for (Point2D.Double p1 : points) {
            if (p0 != null)  area += (p0.x * p1.y) - (p0.y * p1.x);
            p0 = p1;
        }

        p0 = points.getTail().getData();
        Point2D.Double p1 = points.getHead().getData();

        area += (p0.x * p1.y) - (p0.y * p1.x);
        area = Math.abs(0.5 * area);
        area = Math.round(area * 10) * 0.1;

        return area;

    }

    private static void testCase5() {

        double x[] = {0, 10, 0, 10, 5};
        double y[] = {0, 10, 10, 0, 5};

        testCase(x, y);
    }

    private static void testCase10() {

        double x[] = {6, 28, 28, 31, 11, 31, 26, 18, 30, 25};
        double y[] = {39, 25, 13, 3, 19, 17, 19, 13, 11, 20};

        testCase(x, y);

    }

    private static void testCase(double x[], double y[]) {
        DoubleLinkedList<Point2D.Double> list = new DoubleLinkedList<>();
        for (int i = 0; i < x.length; i++) {
            Point2D.Double point = new Point2D.Double(x[i], y[i]);
            list.add(point);

        }

        testCase(list,x.length);
    }

    private static void testCase(int x[], int y[]) {
        DoubleLinkedList<Point2D.Double> list = new DoubleLinkedList<>();
        for (int i = 0; i < x.length; i++) {
            Point2D.Double point = new Point2D.Double(x[i], y[i]);
            list.add(point);

        }

        testCase(list,x.length);
    }

    private static void testCase(DoubleLinkedList<Point2D.Double> allPoints, int n){

        DoubleLinkedList<Point2D.Double> hullPoints;
        DoubleLinkedList<Point2D.Double> aklPoints;
        Algorithm algo;

        algo = new AklToussaintHeuristic();
        aklPoints = algo.calculate(allPoints,DEBUG);

        algo = new GiftWrapping();
        hullPoints = aklPoints;
        for (int i = 0; i < n; i++) {
            hullPoints = algo.calculate(hullPoints,DEBUG);
        }

        System.out.println(polygonArea(hullPoints));

        if (DEBUG) {
            hullPoints.print();
            
            new PointPrinter.Draw(allPoints, aklPoints, hullPoints, true);

        }
    }
}

```

# Test data

You may test this solution by build in methods by setting DEBUG=true, or interactively with this set of points:

```md
5
0 0
10 10
0 10
10 0
5 5
10
6 39
28 25
28 13
31 3
11 19
31 17
26 19
18 13
30 11
25 20
0
```