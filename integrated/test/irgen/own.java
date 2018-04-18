import IO;

class rec {
	int a = 4;
	int b = 9;
	public int two_times(){
		int a = 7;
		return (2*b) + a;
	}

	public int sum(int a, int b) {
		int c =  two_times();
		return c;
	}

	public void main() {
		int a = 909;
		int b = 101;
		IO io = new IO();
		rec obj = new rec();
		int c = obj.two_times();
		io.print_int(c);
	}
}
