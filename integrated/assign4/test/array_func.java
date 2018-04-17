import IO;

class rec {
	public int[5][5] array_func(int[5][5] a, int b) {
		for (int i=0; i<5; i++){
			for (int j=0; j<5; j++){
				a:[i][j] = b;
			}
		}
		return a;
	}

	public void main() {
		int[5][5] a;
		int b = 9;
		rec first_object = new rec();
		a = first_object.array_func(a, b);
		IO ip = new IO();
		ip.print(b);
		// int c = gcd(a, b);
	}
}