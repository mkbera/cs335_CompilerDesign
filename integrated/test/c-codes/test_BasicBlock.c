#include <stdio.h>
int main ()
{
  int a;
  int b;
  int c;
  int d;
  int e;
  int f;
  int g;
  int h;
  int i;
  int j;
  int k;

a = 10;
b = a + 2;
c = a * 7;
d = a + -11;
if (a > 5) goto D_1738; else goto D_1739;
D_1738:
f = a + 40;
g = a + -40;
goto D_1740;
D_1739:
i = a + 20;
j = a + -20;
D_1740:
k = 0;
goto D_1735;
D_1734:
a = a + 1;
i = i + 1;
j = j + i;
k = k + 1;
D_1735:
if (k < b) goto D_1734; else goto D_1736;
D_1736:
printf("%d ",a);
printf("%d ",b);
printf("%d ",c);
printf("%d ",d);
// printf("%d",e);
printf("%d ",f);
printf("%d ",g);
// printf("%d",h);
printf("%d ",i);
printf("%d ",j);
printf("%d ",k);

return 0;
}


