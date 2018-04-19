import IO;

class List {
    int value = 10;
    List next;

	public void set_value(int x) {
        value = x;
	}

    public void set_next(List next) {
        this.next = next;
    }

	public void main() {
		IO io = new IO();

		List[10] linked_list;
        
        // int x;
        for (int i = 0; i < 10; i++) {
            linked_list:[i] = new List();
            linked_list:[i].value = 2 * i;
        }
        
        int x;
        for (int i = 0; i < 9; i++) {
			// linked_list:[i].next = linked_list:[i+1];
			linked_list:[i].set_next(linked_list:[i+1]); 
        }

        // List current = linked_list:[0];
		List a = linked_list:[0];

        for (int i = 0; i < 10; i++) {
			io.print_int(a.value);
			io.print_char(10);
			a = a.next;
        //     io.print_int(current.value);
		//     current = current.next;
            // x = linked_list:[i].value;
            // io.print_int(linked_list:[i].value);
			// io.print_char(10);
            // io.print_int(linked_list:[i].next.value);
			// io.print_char(10);
			
        }
	}
}