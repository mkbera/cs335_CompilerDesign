import IO;

class Main {
    int num = 0;

    Main() {
        num += 1;
    }

    void increase(int n) {
        for (int i = 0; i < n; i++) {
            num++;
        }
    }

    int test() {
        return 10;
    }

    void main() {
        IO io = new IO();
        
        Main cc = new Main();
        int b = 10;
        int a = (float) ((int) (b * 5 + cc.test()));
        io.print_int(a);

        for (int i = 0; i < 10; i++) {
            a++;
        }

        
        io.print_int(a);
    }
}