import IO;
class uminus_bminus{
    public void main(){
		IO io = new IO();
		int i = 5;
        io.print_int(--i);
        i = 5;
        io.print_int(i--);
        i = 5;
        io.print_int(i-1);
        i = -5;
        io.print_int(i-10);
    }
}