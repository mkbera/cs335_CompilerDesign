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
        next_exists = true;
    }

	public void main() {
		IO io = new IO();

		List start = new List(io.scan_float());
        List current = start;
        
        float x = 0;
        while ((x = io.scan_float()) >= 0) {
            current.set_next(new List(x));
            current = current.next;
        }

        // io.print_int((int) start.value);
        // io.print_char('\n');
		current = start;

        io.print_int(current);
        io.print_char('\n');
        io.print_int(start);
        io.print_char('\n');

        float t = current.value;
        if (t < 10) {
            io.print_char('>');
            io.print_float(t);
        }
        else {
            io.print_int(start);
            io.print_char('<');
            io.print_float(current.value);
        }
        io.print_char('\n');

        // while (current.next_exists) {
        //     if (current.value < 10) {
        //         io.print_char(' ');
        //         io.print_float(current.value);
        //     }
        //     else {
        //         int t = current.value;
		// 	    io.print_int(t);
        //     }
		// 	io.print_char('\n');
		// 	current = current.next;
        // }
	}
}