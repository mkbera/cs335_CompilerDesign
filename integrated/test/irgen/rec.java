import IO;

class rec {
	int c = 9;
	public int[5][5] array_func(int[5][5] a, int b) {
		for (int i=0; i<5; i++){
			for (int j=0; j<5; j++){
				a:[i][j] = b + i + j;
			}
		}
		return a;
	}

	public void main() {
		IO io = new IO();
		int[5][5] a;
		int b = 9;
		rec first_object = new rec();
		a = first_object.array_func(a, b);
		for (int i = 0; i < 5; i++) {
			for (int j = 0; j < 5; j++) {
				b = a:[i][j];
				io.print_int(b);
			}
		}
	}
}