public class CallingMethodsInSameClass
{
	public main(String[] args) : void {
		printOne();
		printOne();
		printTwo();
	}

	public printOne() : void {
		System.out.println("Hello World");
	}

	public printTwo() : void {
		printOne();
		printOne();
	}
}