import IO;

class rec {
	public int[5][5] array_func(int[5][5] a, int b) {
		for (i=0; i<5; i++){
			for (int j=0; j<5; j++){
				a:[i][j] = b;
			}
		}
		return a;
	}

	public void main() {
		int[5][5] a;
		int b = 9;
		a = array_func(a, b);
		// int c = gcd(a, b);
	}
}