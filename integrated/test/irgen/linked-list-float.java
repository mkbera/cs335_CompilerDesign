import IO;

class List {
    float value = 10;
    List next;

	public void set_value(float x) {
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
			// linked_list:[i].value = 2*i;
			float jo = i;
			linked_list:[i].set_value(i);
        }
        
        float x;
        for (int i = 0; i < 9; i++) {
			// linked_list:[i].next = linked_list:[i+1];
			linked_list:[i].set_next(linked_list:[i+1]) ;
		}
		linked_list:[1].set_value(linked_list:[2].value);

        List a = linked_list:[0];
        for (int i = 0; i < 10; i++) {
			
			x = a.value;
			a = a.next;
            io.print_float(x);
			io.print_char(10);
            // io.print_float(linked_list:[i].value);
			// io.print_char(10);
			
        }
	}
}