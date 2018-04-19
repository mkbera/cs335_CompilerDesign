import IO;
class Qsort
{
        public int quicksort(int[5] x, int first, int last){
                int pivot,j,temp,i,f,e,a;

                if(first<last){
                        pivot=first;
                        i=first;
                        j=last;

                        while(i<j){

                                while((x:[i] <= x:[pivot]) && (i < last)){
                                        i= i + 1;
                                }
                                while(x:[j]>x:[pivot]){
                                        j= j - 1;
                                }
                                if(i<j){
                                        temp=x:[i];
                                        x:[i]=x:[j];
                                        x:[j]=temp;
                                }
                        }

                        temp=x:[pivot];
                        x:[pivot]=x:[j];
                        x:[j]=temp;
                        f = j - 1 ;
                        e = j + 1;

                        quicksort(x,first,f);
                        quicksort(x,e,last);

                }
                return 0;
        }

        public void main(){
				IO io = new IO();
                int[5] x;
                int size = 5;
                int first = 0;
                int l = size - 1;
                int i;

                x:[0] = 2;
                x:[1] = 1;
                x:[2] = 0;
                x:[3] = 5;
                x:[4] = 6;

				Qsort obj = new Qsort();

                // for(i=0;i<size;i++){
                        // System.out.println(l);
                // }
                int some = obj.quicksort(x,first,l);
				// some = x:[0];
				
				// io.print_int(some);

                for(i=0;i<5;i=i+1){
                        io.print_int(x:[i]);
                }
        }

}