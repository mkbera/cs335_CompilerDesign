import IO;
public class MyBinarySearch {

    public int binarySearch(int[8] inputArr, int len, int key) {
        int start = 0,mid;
        int end = len - 1;
        while (start <= end) {
            mid = (start + end) / 2;
            if (key == inputArr:[mid]) {
                return mid;
            }
            if (key < inputArr:[mid]) {
                end = mid - 1;
            } else {
                start = mid + 1;
            }
        }
        return -1;
    }
    public void main() {
		IO io = new IO();
        MyBinarySearch mbs = new MyBinarySearch();
        int[8] arr;
        arr:[0] = 2;
        arr:[1] = 4;
        arr:[2] = 6;
        arr:[3] = 8;
        arr:[4] = 10;
        arr:[5] = 12;
        arr:[6] = 14;
        arr:[7] = 16;
        io.print_int(mbs.binarySearch(arr, 8, 14));io.print_char(10);

        int[8] arr1;
        arr1:[0] = 6;
        arr1:[1] = 34;
        arr1:[2] = 78;
        arr1:[3] = 123;
        arr1:[4] = 432;
        arr1:[5] = 900;
        arr1:[6] = 990;
        arr1:[7] = 1000;
        io.print_int(mbs.binarySearch(arr1, 8, 431));
    }
}