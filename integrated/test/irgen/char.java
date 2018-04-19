import IO;

class rec {
	public void main() {
		IO io = new IO();
		char a = io.scan_char();
		io.print_char(a);
		int c = io.scan_int(); 	
		io.print_int(c);
		char b = io.scan_char();
		b = io.scan_char();
		// io.print_int(8);
		// io.print_int(9);
		// io.print_char('%');
		io.print_char(b);

	}
}
