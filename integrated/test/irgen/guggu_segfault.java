import IO;

class List {
    float value = 10.0;
    List next;

	public void set_value(float x) {
        this.value = x;
	}

    public void set_next(List next) {
        this.next = next;
    }

	public void main() {
		IO io = new IO();

		List[10] linked_list;
        
        for (int i = 0; i < 10; i++) {
            linked_list:[i] = new List();
            linked_list:[i].set_value(2.1 * i);
        }
        
        for (int i = 0; i < 9; i++) {
			linked_list:[i].set_next(linked_list:[i+1]); 
        }

		List current = linked_list:[0];

        for (int i = 0; i<10; i++) {
            if (current.value < 18.1) {
                io.print_char(' ');
			}
			io.print_int(i);
			io.print_float(current.value);
			io.print_char(10);
			current = current.next;
        }
	}
}