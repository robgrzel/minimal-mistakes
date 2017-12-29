---
title: "Data-Structures: double linked list"

categories:
  - Data-Structures double-linked-list
  
tags:
  - Data-Structures
  - Data
  - Structures
  - Java
  - Algorithms
  - Linked-List
  - List
  - Double-Linked-List
  
gallery:
  - url: /assets/images/unsplash-gallery-image-1.jpg
    image_path: /assets/images/unsplash-gallery-image-1-th.jpg
    alt: "placeholder image 1"
    title: "Image 1 title caption"
---


{% include gallery caption="This is a sample gallery with **Markdown support**." %}

# Java Implementation of Double-Linked-List

Todo:
- implementation:
- - add, get, set, remove, insert, etc...             (done)
- comments                                            (todo)
- unit test                                           (todo)

```java
import java.util.ConcurrentModificationException;
import java.util.Iterator;
import java.util.NoSuchElementException;

public class DoubleLinkedList<E> implements Iterable<E> {

    /*
    ref:
    https://en.wikipedia.org/wiki/Doubly_linked_list
     */
    /////////////////////////////////////////////////////////////////////////
    //// Additional classes
    /////////////////////////////////////////////////////////////////////////

    private static class Node<E> {
        Node next;
        Node prev;
        E data;

        Node(E d, Node<E> p, Node<E> n) {
            this.data = d;
            this.prev = p;
            this.next = n;
        }

        @Override
        public String toString() {
            String str = "<";

            if (prev == null) str += "null,";
            else if (prev.data == null) str += "null,";
            else str += prev.data.toString() + ',';

            if (data == null) str += "null,";
            else str += data.toString()+',';

            if (next == null) str += "null";
            else if (next.data == null) str += "null";
            else str += next.data.toString();

            str += ">";
            return str;
        }

    }

    private class LinkedListIterator implements Iterator<E> {

        private Node<E> current = beginMarker.next;
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

            Node tmp = current;

            while (true) {
                if (tmp == null) break;
                str.append(tmp.toString());
                tmp = tmp.next;
            }

            return str.toString();

        }

        @Override
        public boolean hasNext() {
            return current != endMarker;
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
    private Node<E> beginMarker;
    private Node<E> endMarker;

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

    public boolean add(E x) {
        add(size(), x);
        return true;
    }

    public void add(int idx, E x) {
        addBefore(getNode(idx, 0, size()), x);

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
     * @param p Node to add before.
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
     * Gets the Node at position idx, which must range from 0 to size( ) - 1.
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
     * Gets the Node at position idx, which must range from lower to upper.
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
            p = beginMarker.next;
            for (int i = 0; i < idx; i++) p = p.next;

        } else {
            p = endMarker;
            for (int i = size(); i > idx; i--) p = p.prev;
        }

        return p;

    }//todo

    private void doClear() {
        beginMarker = new Node<E>(null, null, null);
        endMarker = new Node<E>(null, beginMarker, null);
        beginMarker.next = endMarker;

        size = 0;
        modCount++;
    }

    @Override
    public String toString(){
        return iterator().toString();
    }

    public void print(){
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

        list.set(1,"violet");
        list.print();


        list.addBefore(list.getNode(6),"before");
        list.print();
    }
}

```