import IO;

class test {
	public int x = 10;
	int a, c = 5.012;
	int[2][5] d;

	float[2][1] test = {{12}, {4}};

	test() {
		a = x;
		test:[1][0] = 1.0;
	}
	
	int test2(int x) {
		return (float) x + 1.020 + a;
	}

	public int test_func(int[2][5] arr) {
		int a = 1;
		int b = 0;

		a = b + 5;
		a = -b;

		a = test2(1);

		a += 1;

		d:[-1][4] = 0.0;

		for (int i = 0; i = 5; ++i) {
			for (int j = 0; j = 5; ++j) {
				d:[i][j] = 1 + b;
				return 1;
			}
		}

		return a;
	}

	test dummy() {
		return self;
	}

	public void main() {
		int a = 2.0;
		test self = new test();
		self.dummy();
		float b = self.dummy().dummy().test2(5);
		b = a;
	}
}
