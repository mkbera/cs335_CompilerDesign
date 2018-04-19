import IO;
class operators_type_check{

    public void main(){
		  IO io = new IO();
			int i = 3;
          float j = 2.34;
          char c = 'a';
          i = i + j;
          j = i + j;
		  i = i + c;
		  io.print_int(i); 
		  io.print_float(j);
		  io.print_char(c);
    }
}
