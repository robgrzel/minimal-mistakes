---
title: "Geometric Primitives: polygon java implementation"
categories:
  - Geometric Primitives
  - Java
  - Polygon
tags:
  - Geometry
  - Java 
  - Programming
  - Polygon

---

# Polygon 

Simple polygon implementation in Java with area calculated by Scholace formula.

Once I needed to calculate area by Scholace formula, found this [here](https://algs4.cs.princeton.edu/91primitives/Polygon.java.html) may be useful later.

```java 
******************************************************************************
 *  Compilation:  javac Polygon.java
 *  Execution:    java Polygon
 *  Dependencies: Point.java
 *
 *  Implementation of 2D polygon, possibly intersecting.
 *
 ******************************************************************************/

public class Polygon { 
    private int N;        // number of points in the polygon
    private Point[] a;    // the points, setting points[0] = points[N]
   
    // default buffer = 4
    public Polygon() {
        N = 0;
        a = new Point[4];
    }


    // double size of array
    private void resize() {
        Point[] temp = new Point[2*N+1];
        for (int i = 0; i <= N; i++) temp[i] = a[i];
        a = temp;
    }

    // return size
    public int size() { return N; }

    // draw polygon
    public void draw() {
        for (int i = 0; i < N; i++)
            a[i].drawTo(a[i+1]);
    }


    // add point p to end of polygon
    public void add(Point p) {
        if (N >= a.length - 1) resize();   // resize array if needed
        a[N++] = p;                        // add point
        a[N] = a[0];                       // close polygon
    }

    // return the perimeter
    public double perimeter() {
        double sum = 0.0;
        for (int i = 0; i < N; i++)
            sum = sum + a[i].distanceTo(a[i+1]);
        return sum;
    }

    // return signed area of polygon
    public double area() {
        double sum = 0.0;
        for (int i = 0; i < N; i++) {
            sum = sum + (a[i].x * a[i+1].y) - (a[i].y * a[i+1].x);
        }
        return 0.5 * sum;
    }

    // does this Polygon contain the point p?
    // if p is on boundary then 0 or 1 is returned, and p is in exactly one point of every partition of plane
    // Reference: http://exaflop.org/docs/cgafaq/cga2.html
    public boolean contains2(Point p) {
        int crossings = 0;
        for (int i = 0; i < N; i++) {
            int j = i + 1;
            boolean cond1 = (a[i].y <= p.y) && (p.y < a[j].y);
            boolean cond2 = (a[j].y <= p.y) && (p.y < a[i].y);
            if (cond1 || cond2) {
                // need to cast to double
                if (p.x < (a[j].x - a[i].x) * (p.y - a[i].y) / (a[j].y - a[i].y) + a[i].x)
                    crossings++;
            }
        }
        if (crossings % 2 == 1) return true;
        else                    return false; 
    }

    // does this Polygon contain the point p?
    // Reference: http://softsurfer.com/Archive/algorithm_0103/algorithm_0103.htm
    public boolean contains(Point p) {
        int winding = 0;
        for (int i = 0; i < N; i++) {
            int ccw = Point.ccw(a[i], a[i+1], p);
            if (a[i+1].y >  p.y && p.y >= a[i].y)  // upward crossing
                if (ccw == +1) winding++;
            if (a[i+1].y <= p.y && p.y <  a[i].y)  // downward crossing
                if (ccw == -1) winding--;
        }
        return winding != 0;
    }


    // return string representation of this point
    public String toString() {
        if (N == 0) return "[ ]";
        String s = "";
        s = s + "[ ";
        for (int i = 0; i <= N; i++)
            s = s + a[i] + " ";
        s = s + "]";
        return s;
    }


    // test client
    public static void main(String[] args) {
        int N = Integer.parseInt(args[0]);

        // a square
        Polygon poly = new Polygon();
        poly.add(new Point(5, 5));
        poly.add(new Point(9, 5));
        poly.add(new Point(9, 9));
        poly.add(new Point(5, 9));

        StdOut.println("polygon    = " + poly);
        StdOut.println("perimeter  = " + poly.perimeter());
        StdOut.println("area       = " + poly.area());

        StdOut.println("contains(5, 5) = " + poly.contains(new Point(5, 5)));
        StdOut.println("contains(9, 5) = " + poly.contains(new Point(9, 5)));
        StdOut.println("contains(9, 9) = " + poly.contains(new Point(9, 9)));
        StdOut.println("contains(5, 9) = " + poly.contains(new Point(5, 9)));
        StdOut.println("contains(7, 5) = " + poly.contains(new Point(7, 5)));
        StdOut.println("contains(5, 7) = " + poly.contains(new Point(5, 7)));
        StdOut.println("contains(7, 9) = " + poly.contains(new Point(7, 9)));
        StdOut.println("contains(9, 7) = " + poly.contains(new Point(9, 7)));

        // generate N random points in the unit square and check what fraction are in the polygon
        int yes = 0;
        for (int i = 0; i < N; i++) {
            int x = (int) (10 * Math.random());
            int y = (int) (10 * Math.random());
            Point p = new Point(x, y);
            if (poly.contains(p)) yes++;
            if (poly.contains(p) != poly.contains2(p)) StdOut.println("different " + p);
        }

        // true answer is = 0.16 (depends on how boundary points are handled)
        StdOut.println("Fraction in polygon = " + 1.0 * yes / N);


    }
}

```