import IO;

class Main {
    int num = 0;
    float[1][2] a;

    Main() {
        num += 1;
    }

    void increase(int n) {
        for (int i = 0; i < n; i++) {
            num++;
        }
    }

    int test() {
        a:[0][0] = 5;
        return 10;
    }

    void main() {
        IO io = new IO();
        
        float[5][5] arr;
        float b = 10;

        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                arr:[i][j] = b + 5.0 * i + j;
            }
        }

        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 5; j++) {
                b = arr:[i][j];
                io.print_float(b);
            }
        }
    }
}