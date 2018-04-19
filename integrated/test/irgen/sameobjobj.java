import IO;

class rec1 {
    int a = 43;
    rec1 b;

    public void main() {
        IO io = new IO();

        rec1 obj1 = new rec1();
        obj1.b = new rec1();
		obj1.b.a = 6;
		io.print_int(obj1.b.a);
		// io.print_char(10);
        // int c = obj2.sum(a, 1);
        // io.print_int(c);
		// io.print_char(10);	

        // c = obj2.obj.three_times(b);
        // io.print_int(c);
		// io.print_char(10);	
    }
}