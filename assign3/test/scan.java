import Scanner;

public class ScannerAndKeyboard
{

	public void main(String[] args) 
	{	Scanner s = new Scanner(System.in);
		System.out.print( "Enter your name: "  );
		String name = s.nextLine();
		System.out.println( "Hello " + name + "!" );
	}
}