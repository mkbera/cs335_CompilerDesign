// Java program for reversing the linked list
import IO;

class Node {
 
	int data;
	Node next;

	Node(int d) {
		data = d;
		// next;
	}
}

class LinkedList {
	IO io = new IO(); 
    Node head;
 
    /* Function to reverse the linked list */
    Node reverse(Node node) {
        Node prev;
        Node current = node;
        Node next;
        while (!current) {
            next = current.next;
            current.next = prev;
            prev = current;
            current = next;
        }
        node = prev;
        return node;
    }
 
    // prints content of double linked list
    void printList(Node node) {
        while (node != 0) {
            io.print_int(node.data);
            io.print_char(10);
            node = node.next;
        }
    }
 
    public static void main(String[] args) {
        LinkedList list = new LinkedList();
        list.head = new Node(85);
        list.head.next = new Node(15);
        list.head.next.next = new Node(4);
        list.head.next.next.next = new Node(20);
         
        list.printList(list.head);
        list.head = list.reverse(list.head);
        // System.out.println("");
        // System.out.println("Reversed linked list ");
        list.printList(list.head);
    }
}