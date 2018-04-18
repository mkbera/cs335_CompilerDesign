main ()
{
	int g;
	scanf("%d", &g);
	myfunc (g);
}


myfunc (g)
{
int g_0;
int g_1;
const char * restrict D_2049;
int g_2;
int g_3;
// int g;
g_0 = g;
if (g_0 == 0) goto D_2046; else goto D_2047;
D_2046:
return;
D_2047:
g_1 = g;
// D_2049 = (const char * restrict) &"value of g is %d\n"[0];
printf ("%d ", g_1);
g_2 = g;
g_3 = g - 1;
g = g_3;
myfunc (g);
}


