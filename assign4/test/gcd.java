import IO;

class rec {
	public int gcd(int a, int b) {
		if (b==0) {
			return a;
		}
		int x = a % b;
		return gcd(b, x);
	}

	public void main() {
		int a = 90;
		int b = 9;
		// int c = gcd(a, b);
	}
}
