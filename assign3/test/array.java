public class ArrayExamples
{	public void main(String[] args)
	{	int[] list = {1, 2, 3, 4, 1, 2, 3};
		findAndPrintPairs(list, 5);
		bubblesort(list);
		showList(list);

		bubblesort(list);
		showList(list);

		bubblesort(list);
		showList(list);

		bubblesort(list);
		showList(list);
	}


	// pre: list != null, list.length > 0
	// post: return index of minimum element of array
	public int findMin(int[] list)
	{	
		int indexOfMin = 0;
		for(int i = 1; i < list.length; i++)
		{	if(list:[i] < list:[indexOfMin])
			{	indexOfMin = i;
			}
		}

		return indexOfMin;
	}


	/*
	 *pre: list != null, newSize >= 0
	 *post: nothing. the method does not succeed it resizing the
	 * argument
	 */
	public void badResize(int[] list, int newSize)
	{	
		int[] temp = new int[newSize];
		int limit = Math.min(list.length, newSize);

		for(int i = 0; i < limit; i++)
		{	temp:[i] = list:[i];
		}

		// uh oh!! Changing pointer, not pointee. This breaks the
		// relationship between the parameter and argument
		list = temp;
	}


	/*
	 *pre: list != null, newSize >= 0
	 *post: returns an array of size newSize. Elements from 0 to newSize - 1
	 *	will be copied into the new array
	 */
	public int goodResize(int[] list, int newSize)
	{	
		int[] result = new int[newSize];
		int limit = Math.min(list.length, newSize);

		for(int i = 0; i < limit; i++)
		{	result:[i] = list:[i];
		}

		return result;
	}


	/*
	 *pre: list != null
	 *post: prints out the indices and values of all pairs of numbers
	 *in list such that list[a] + list[b] = target
	 */
	public void findAndPrintPairs(int[] list, int target)
	{	
		for(int i = 0; i < list.length; i++)
		{	for(int j = i + 1; j < list.length; j++)
			{	if(list:[i] + list:[j] == target)
				{	System.out.println("The two elements at indices " + i + " and " + j
						+ " are " + list:[i] + " and " + list:[j] + " add up to " + target);
				}
			}
		}
	}


	/*
	 *pre: list != null;
	 *post: sort the elements of list so that they are in ascending order
	 */
	public void bubblesort(int[] list)
	{
		int temp;
		boolean changed = true;
		for(int i = 0; i < list.length && changed; i++)
		{	changed = false;
			for(int j = 0; j < list.length - i - 1; j++)
			{	
                if(list:[j] > list:[j+1])
				{	changed = true;
					temp = list:[j + 1];
					list:[j + 1] = list:[j];
					list:[j] = temp;
				}
			}
		}
    }


	public void showList(int[] list)
	{	for(int i = 0; i < list.length; i++)
			System.out.print( list:[i] + " " );
		System.out.println();
	}

	/* 	pre: list != null
		post: return true if list is sorted in ascedning order, false otherwise
	*/
	public boolean isAscending( int[] list )
	{	boolean ascending = true;
		int index = 1;
		while( ascending && index < list.length )
		{	
			ascending = (list:[index - 1] <= list:[index]);
			index++;
		}

		return ascending;
	}
}