import IO;
class bubblesort {
    void sort(int[7] arr, int len) {
        int n = len;
        int temp, i, j;
        for(i=0; i < n; i++){
            for(j=1; j < (n-i); j++){
                if(arr:[j-1] > arr:[j]){
                    temp = arr:[j-1];
                    arr:[j-1] = arr:[j];
                    arr:[j] = temp;
                }
            }
        }
    }
    public void main() {
		IO io = new IO();
		bubblesort bub = new bubblesort();
                int[7] arr;
                
                arr:[0] = 7;
                arr:[1] = 6;
                arr:[2] = 5;
                arr:[3] = 4;
                arr:[4] = 3;
                arr:[5] = 2;
                arr:[6] = 1;
                // for(int i=0; i < 7; i++){
                //         io.print_int(arr[i]);
                //         if (arr[i] > 5) {
                //             break;
                //         }
                // }
                bub.sort(arr, 7);               
                for(int i=0; i < 7; i++){
                    io.print_int(arr:[i]);io.print_char(10);
                }

        }
}