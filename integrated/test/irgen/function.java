import IO;

class rec {
	public int two_times(int a){	
		return 2*a;
	}

	public int sum(int a, int b) {
		int c =  two_times(a + b);
		return c;
	}

	public void main() {
		int a = 909;
		int b = 101;
		int c = sum(a, b);
	}
}
