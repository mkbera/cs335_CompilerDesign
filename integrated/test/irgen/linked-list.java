import IO;

class List {
    float value = 10.0;
    boolean next_exists = false;
    List next;

	List(float x) {
        value = x;
	}

    public void set_next(List next) {
        this.next = next;
        this.next_exists = true;
    }

	public void main() {
		IO io = new IO();

		List start = new List(io.scan_float());
        List current = start;
        
        float x = 0;
        while ((x = io.scan_float()) >= 0) {
            io.print_float(x);
            // io.print_char(x);
            current.set_next(new List(x));
            current = current.next;
        }
		
        current = start;

        io.print_char('\n');

        while (current.next_exists) {
            if (current.value < 10) {
                io.print_char(' ');
                io.print_float(current.value);
            }
            else {
			    io.print_float(current.value);
            }
			io.print_char('\n');
			current = current.next;
        }
	}
}