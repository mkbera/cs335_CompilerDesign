import IO;

class rec1 {
    int a = 43;
    int b;
    int c = 0;

    public int three_times(int c){
        return 3*c;
    }
}

class rec2 {
    int a = 9;
    int b = 10;
    rec1 obj;

    public int two_times(int a){    
        return 2*a;
    }

    public int sum(int a, int b) {
        int c =  two_times(a + b);
        return c;
    }

    public void main() {
        int a = 909;
        int b = 101;
        

        rec1 obj1 = new rec1();
        rec2 obj2 = new rec2();
        obj2.obj = new rec1();

        int c = obj2.sum(a, 1);
        IO io = new IO();
        io.print_int(c);

        c = obj2.obj.three_times(b);
        io.print_int(c);
    }
}