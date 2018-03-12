import Scanner;

public class Life {
    public show(boolean[][] grid) : void {
        String s = "";
        for(boolean[] row : grid){
            for(boolean val : row)
                if(val)
                    s += "*";
                else
                    s += ".";
            s += "\n";
        }
        System.out.println(s);
    }
    
    public gen() : boolean[][]{
        boolean[][] grid = new boolean[10][10];
        for(int r = 0; r < 10; r++)
            for(int c = 0; c < 10; c++)
                if( Math.random() > 0.7 )
                    grid[r][c] = true;
        return grid;
    }
    
    public main(String[] args) : void {
        boolean[][] world = gen();
        show(world);
        System.out.println();
        world = nextGen(world);
        show(world);
        Scanner s = new Scanner(System.in);
        while(s.nextLine().length() == 0){
            System.out.println();
            world = nextGen(world);
            show(world);
            
        }
    }
    
    public nextGen(boolean[][] world) : boolean[][]{
        boolean[][] newWorld 
            = new boolean[world.length][world[0].length];
        int num;
        for(int r = 0; r < world.length; r++){
            for(int c = 0; c < world[0].length; c++){
                num = numNeighbors(world, r, c);
                if( occupiedNext(num, world[r][c]) )
                    newWorld[r][c] = true;
            }
        }
        return newWorld;
    }
    
    public occupiedNext(int numNeighbors, boolean occupied) : boolean {
        if( occupied && (numNeighbors == 2 || numNeighbors == 3))
            return true;
        else if (!occupied && numNeighbors == 3)
            return true;
        else
            return false;
    }

    private numNeighbors(boolean[][] world, int row, int col) : int {
        int num = world[row][col] ? -1 : 0;
        for(int r = row - 1; r <= row + 1; r++)
            for(int c = col - 1; c <= col + 1; c++)
                if( inbounds(world, r, c) && world[r][c] )
                    num++;

        return num;
    }

    private inbounds(boolean[][] world, int r, int c) : boolean {
        return r >= 0 && r < world.length && c >= 0 &&
        c < world[0].length;
    }
    
    
    
}