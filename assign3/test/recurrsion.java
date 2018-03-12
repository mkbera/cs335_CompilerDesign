public class RecursionExampleDirectory
{	
	public getSize(Directory dir) : int
	{	int total = 0;
	
		//check files
		File[] files = dir.getFiles();
		for(int i = 0; i < files.length; i++) {
			total += files:[i].getSize();
        }
            
		//get sub directories and check them
		Directory[] subs = dir.getSubs();
		for(int i = 0; i < subs.length; i++){
            total += getSize(subs:[i]);
        }
			
		return total;
	}
	
	public main(String[] args) : void
	{	RecursionExampleDirectory r = new RecursionExampleDirectory();
		Directory d = new Directory();
		System.out.println( r.getSize(d) );
	}
	
	//pre: n >= 0
	public fact(int n) : int 
	{	int result = 0;
		if(n == 0){
            result = 1;
        }
		else{
			result = n * fact(n-1);
        }
        return result;
	}
	
	//pre: exp >= 0
	public pow(int base, int exp) : int
	{	int result = 0;
		if(exp == 0){
            result = 1;
        }
		else{
            result = base * pow(base, exp - 1);
        }
		return result;
	}
	
	//slow fib
	//pre: n >= 1
	public fib(int n) : int
	{	int result = 0;
		if(n == 1 || n == 2){
            result = 1;
        }
		else{
            result = fib(n-1) + fib(n-2);
        }
		return result;
	}
	
	public minWasted(int[] items, int itemNum, int capLeft) : int 
	{	int result = 0;
		if(itemNum >= items.length){
            result = capLeft;
        }
		else if( capLeft == 0){
            result = 0;
        }
		else
		{	int minWithout = minWasted(items, itemNum + 1, capLeft);
			if( capLeft <= items:[itemNum])		
			{	int minWith = minWasted(items, itemNum + 1, capLeft - items:[itemNum]);
				result = Math.min(minWith, minWithout);
			}
			else
				result = minWithout;
		}
		return result;	
	}
}

class Directory
{	Directory[] mySubs;
	File[] myFiles;
	
	public Directory()
	{	int numSubs = (int)(Math.random() * 3);
		mySubs = new Directory[numSubs];
		int numFiles = (int)(Math.random() * 10);
		myFiles = new File[numFiles];
		
		for(int i = 0; i < myFiles.length; i++)
		{	myFiles:[i] = new File( (int)(Math.random() * 1000 ) );}
		for(int i = 0; i < mySubs.length; i++)
		{	mySubs:[i] = new Directory();}
	}
	
	public getSubs() : Directory[] 
	{	return mySubs;
	}
	
	public getFiles() : File[] 
	{	return myFiles;
	}
}

class File
{	int iMySize;

	public File(int size)
	{	iMySize = size;
	}
	
	public getSize() : int 
	{	return iMySize;
	}
}