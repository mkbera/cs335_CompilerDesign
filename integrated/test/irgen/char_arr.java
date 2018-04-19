import IO;

class rec {
	public void main() {
		IO io = new IO();
		char[5] a;
		for (int i=0; i<5; i++){
			a:[i] = io.scan_char();
			io.scan_char();
			// io.print_char(10);
		}
		for (int i=0; i<5; i++){
			io.print_char(a:[i]);
		}
		// char a = io.scan_char();
		// io.print_char(a);
		// int c = io.scan_int(); 	
		// char b = io.scan_char();
		// b = io.scan_char();
		// // io.print_int(8);
		// // io.print_int(9);
		// io.print_char('%');
		// io.print_int(c);
		// io.print_char(b);

	}
}
