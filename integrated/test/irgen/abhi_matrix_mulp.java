import IO;
class matrix_multiplication{
 
    public void main(){
        IO io = new IO();
        int i, j, k;
        int[2][2] firstarray;
        int[2][2] secondarray;
        firstarray:[0][0] = 1;
        firstarray:[0][1] = 2;
        firstarray:[1][0] = 3;
        firstarray:[1][1] = 4;
        secondarray:[0][0] = 5;
        secondarray:[0][1] = 6;
        secondarray:[1][0] = 7;
        secondarray:[1][1] = 8;
        /* Create another 2d array to store the result using the original arrays' lengths on row and column respectively. */
        int[2][2] result;
        for (i = 0; i < 2; i++) {
            for (k = 0; k < 2; k++) {
                result:[i][k] = 0;
            }
        }
        /* Loop through each and get product, then sum up and store the value */
        for (i = 0; i < 2; i++) {
            for (j = 0; j < 2; j++) {
                for (k = 0; k < 2; k++) {
                    result:[i][j] =  result:[i][j] + firstarray:[i][k] * secondarray:[k][j];
                }
            }
        }

        /* Show the result */
        for (i = 0; i < 2; i++) {
            for (k = 0; k < 2; k++) {
                io.print_int(result:[i][k]); io.print_char(10);
            }
        }
    }
}