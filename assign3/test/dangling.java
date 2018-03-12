public class dangling {
	public main(String[] args) : void  {
		int i = 0;
		int[] a = {1, 2, 3};
		if(i <= 3) {
			a:[i]++;
		}
		if(i >= 2) {
			a:[i]--;
		} else {
			a:[i] = 1;
		}
	}
}