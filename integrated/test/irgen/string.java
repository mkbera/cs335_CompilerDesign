import IO;

class Char {
    char val;
    Char next;

    Char(char val) {
        this.val = val;
    }
}

class String {
    Char start;
    Char end;

    int length;

    IO io;

    String() {
        this.io = new IO();
    }

    void print() {
        Char curr = start;
        for (int i = 0; i < length; i++) {
            io.print_char(curr.val);
            curr = curr.next;
        }
        io.print_char('\n');
    }

    void scan() {
        char x = io.scan_char();

        if (x == '\n' || x == 0) {
            this.length = 0;
            return;
        }
        
        start = new Char(x);
        length = 1;

        Char end = start;
        while ((x = io.scan_char()) != '\n' && x != 0) {
            io.print_int(length);
            length += 1;
            end = new Char(x);
            end = end.next;
        }
        io.print_int(length);
    }

    boolean compare(String cmp) {
        if (cmp.length != length) {
            return false;
        }
        Char curr1 = start;
        Char curr2 = cmp.start;
        for (int i = 0; i < length; i++) {
            if (curr1.val != curr2.val) {
                return false;
            }
            curr1 = curr1.next;
            curr2 = curr2.next;
        }
        return true;
    }
}

class Test {
    void main() {
        String str1 = new String();
        str1.scan();
        str1.print();
        str1.io.print_char('\n');

        // String str2 = new String();
        // str2.scan();

        // if (str1.compare(str2)) {
        //     str1.io.print_char('T');
        // }
        // else {
        //     str1.io.print_char('F');
        // }
        // str1.io.print_char('\n');
    }
}