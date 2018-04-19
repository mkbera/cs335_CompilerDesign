import IO;
class ifib{
	
    int ifibi (int n) {
        int f1 = 0;
        int f2 = 1;
        int fn;
        if (n==0) {
            fn = 0;
        }
        else if (n==1) {
            fn = 1;
        }
        for (int i=1;i<n;i++) {
            fn = f1 + f2;
            f1 = f2;
            f2 = fn;
        }
        return fn;
    }
    public void main() {
		IO io = new IO();
		ifib fib = new ifib();
        io.print_int(fib.ifibi(0));io.print_char(10);
        io.print_int(fib.ifibi(1));io.print_char(10);
        io.print_int(fib.ifibi(2));io.print_char(10);
        io.print_int(fib.ifibi(3));io.print_char(10);
        io.print_int(fib.ifibi(4));io.print_char(10);
        io.print_int(fib.ifibi(5));io.print_char(10);
        io.print_int(fib.ifibi(6));io.print_char(10);
        io.print_int(fib.ifibi(7));io.print_char(10);
    }
}
