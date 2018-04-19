import IO;

class rec {
    float a = 9;
    // float b = 10;
    // float[5] arr;

    // public float two_times(float a){    
    //     return 2*a;
    // }

    // public float sum(float a, float b) {
    //     float c =  two_times(a + b);
    //     return c;
    // }

    public void main() {
        
		rec obj = new rec();
		float d = obj.a;

        // obj.arr:[0] = 1;
        IO io = new IO();
        io.print_float(d);
        io.print_char(10);

        // obj.arr:[1] = obj.sum(obj.arr:[0], obj.arr:[0]);
        // io.print_float(obj.arr:[1]);
    }
}