import IO;

class BubbleSort {
  public void main() {
	int n, c, d;
	
	float swap;
    
    // System.out.println("Input number of integers to sort");
    n = 5;
 
    float[5] array;
 
    // System.out.println("Enter " + n + " integers");
	IO io = new IO();
 
    for (c = 0; c < n; c++){ 
	  array:[c] = io.scan_float();
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
		for (int i=0; i<n; i++){
			io.print_float(array:[i]);
		}
    // System.out.println("Sorted list of numbers");
 
//     for (c = 0; c < n; c++) 
//       System.out.println(array[c]);
  }
}