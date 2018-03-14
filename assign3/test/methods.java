public class CallingMethodsInSameClass
{
	public void main(String[] args) {
		printOne();
		printOne();
		printTwo();
	}

	public void printOne() {
		System.out.println("Hello World");
	}

	public void printTwo() {
		printOne();
		printOne();
	}
}