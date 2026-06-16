/**
 * Singly linked list of Task nodes (head-insertion).
 *
 * A linked list never needs a bulk resize/copy the way an array does —
 * each Task simply gets wrapped in a new Node that points to the previous
 * head. That makes insertion O(1). The cost is that nodes aren't
 * contiguous in memory, so there's no arithmetic shortcut to "the 5th
 * element": every lookup, traversal, or deletion has to walk node-by-node
 * from the head, which is why those are all O(n) below.
 *
 * This repo's bonus note (Doubly Linked List): a doubly linked list adds a
 * `prev` pointer to each node, allowing O(1) backward traversal and O(1)
 * removal of a node once you already hold a reference to it (no need to
 * search for its predecessor) — at the cost of extra memory per node and
 * slightly more bookkeeping on insert/delete.
 */
public class TaskLinkedList {

    private static class Node {
        Task task;
        Node next;
        Node(Task task) { this.task = task; }
    }

    private Node head;
    private int size = 0;

    /** O(1) — new node becomes the head. */
    public void add(Task task) {
        Node newNode = new Node(task);
        newNode.next = head;
        head = newNode;
        size++;
    }

    /** O(n) — must walk from the head until a match is found. */
    public Task search(int taskId) {
        Node current = head;
        while (current != null) {
            if (current.task.getTaskId() == taskId) return current.task;
            current = current.next;
        }
        return null;
    }

    /** O(n) — visits every node. */
    public void traverse() {
        Node current = head;
        while (current != null) {
            System.out.println(current.task);
            current = current.next;
        }
    }

    /** O(n) — must find the node and keep a reference to its predecessor to unlink it. */
    public boolean delete(int taskId) {
        Node current = head, previous = null;
        while (current != null) {
            if (current.task.getTaskId() == taskId) {
                if (previous == null) head = current.next;
                else previous.next = current.next;
                size--;
                return true;
            }
            previous = current;
            current = current.next;
        }
        return false;
    }

    public int size() { return size; }
}
