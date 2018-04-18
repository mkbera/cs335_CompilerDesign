class BubbleSort {
  public void main() {
    int n, c, d, swap;
    
    // System.out.println("Input number of integers to sort");
    n = 20;
 
    int[20] array;
 
    // System.out.println("Enter " + n + " integers");
 
    for (c = 0; c < n; c++){ 
	  array:[c] = 8;
	}
 
    for (c = 0; c < ( n - 1 ); c++) {
      for (d = 0; d < n - c - 1; d++) {
        if (array:[d] > array:[d+1]) /* For descending order use < */
        {
          swap       = array:[d];
          array:[d]   = array:[d+1];
          array:[d+1] = swap;
        }
      }
    }
 
    // System.out.println("Sorted list of numbers");
 
//     for (c = 0; c < n; c++) 
//       System.out.println(array[c]);
  }
}