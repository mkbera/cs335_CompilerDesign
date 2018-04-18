import IO;

class rec {
	public void main() {
		IO io = new IO();
		char a = io.scan_char();
		io.print_char(a);
		char b = io.scan_char();
		b = io.scan_char();
		io.print_char(b+a);
		// io.print_char(b);

	}
}
