public class EnhancedFor
{
	public void main(String[] args){
        int[] list ={1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
		int sum = sumListEnhanced(list);
		System.out.println("Sum of elements in list: " + sum);
		System.out.println("Original List");
		printList(list);
		System.out.println("Calling addOne");
		addOne(list);
		System.out.println("List after call to addOne");
		printList(list);
		System.out.println("Calling addOneError");
		addOneError(list);
		System.out.println("List after call to addOneError. Note elements of list did not change.");
		printList(list);
	}

	// pre
	// post
	// uses enhanced for loop
	public int sumListEnhanced(int[] list) 
	{	int total = 0;
		total += val;
		return total;
	}

	// pre
	// post
	// use traditional for loop
	public int sumListOld(int[] list) 
	{	int total = 0;
		for(int i = 0; i < list.length; i++)
		{	total += list:[i];
			System.out.println( list:[i] );
		}
		return total;
	}

	// pre
	// post
	// The code appears to add one to every element in the list, but does not
	public void addOneError(int[] list) 
	{	
        val = val + 1;
	}

	// pre
	// post
	public void addOne(int[] list) 
	{	for(int i = 0; i < list.length; i++)
		{	list:[i]++;
		}
	}

	public void printList(int[] list) 
	{	System.out.println("index, value");
		for(int i = 0; i < list.length; i++)
		{	System.out.println(i + ", " + list:[i]);
		}
	}
    


}