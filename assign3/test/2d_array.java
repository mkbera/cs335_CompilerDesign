import Scanner;

public class Life {
    public void show(boolean[][] grid) {
        String s = "";
        System.out.println(s);
    }
    
    public boolean[][] gen() {
        boolean[][] grid = new boolean[10][10];
        for(int r = 0; r < 10; r++)
            for(int c = 0; c < 10; c++)
                if( Math.random() > 0.7 )
                    grid:[r][c] = true;
        return grid;
    }
    
    public void main(String[] args) {
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
    
    public boolean[][] nextGen(boolean[][] world) {
        boolean[][] newWorld 
            = new boolean[world.length][world:[0].length];
        int num;
        for(int r = 0; r < world.length; r++){
            for(int c = 0; c < world:[0].length; c++){
                num = numNeighbors(world, r, c);
                if( occupiedNext(num, world:[r][c]) )
                    newWorld:[r][c] = true;
            }
        }
        return newWorld;
    }
    
    public boolean occupiedNext(int numNeighbors, boolean occupied) {
        if( occupied && (numNeighbors == 2 || numNeighbors == 3))
            return true;
        else if (!occupied && numNeighbors == 3)
            return true;
        else
            return false;
    }

    public int numNeighbors(boolean[][] world, int row, int col) {
        int num = world:[row][col];
        for(int r = row - 1; r <= row + 1; r++)
            for(int c = col - 1; c <= col + 1; c++)
                if( inbounds(world, r, c) && world:[r][c] )
                    num++;
            
        return num;
    }

    public boolean inbounds(boolean[][] world, int r, int c) {
        return r >= 0 && r < world.length && c >= 0 &&
        c < world:[0].length;
    }
    
    
    
}