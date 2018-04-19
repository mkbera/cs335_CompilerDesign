import IO;

class List {
    float value = 10.0;
	
	public void main() {
		IO io = new IO();

		List[1] linked_list;
        
        linked_list:[0] = new List();
		
		linked_list:[0].value = (20.1 * 0);
        
		List current = linked_list:[0];

        for (int i = 0; i<1; i++) {
            if (current.value < 6.0) {
                io.print_char(' ');
			}
			io.print_float(current.value);
        }
	}
}