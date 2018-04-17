import IO;

class Threed_array {
	public void main() {
		int[10][10][10] a;
		for (int i = 0; i<10; i = i + 1){
			for (int j=0; j<10; j = j + 1){
				for (int k=0; k<10; k++){
					a:[i][j][k] = (i - j)*-k;
					print(a:[i][j][k]);
				}
			}
		}
	}
}
