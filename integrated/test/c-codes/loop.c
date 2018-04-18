int main ()
{
  const char * restrict D_2055;
  int i;
  int j;
  int k;
  int res;

  res = 0;
  i = 0;
  goto D_2052;
  D_2051:
  j = 0;
  goto D_2049;
  D_2048:
  k = 0;
  goto D_2046;
  D_2045:
  res = res + 1;
  k = k + 1;
  D_2046:
  if (k <= 9) goto D_2045; else goto D_2047;
  D_2047:
  j = j + 1;
  D_2049:
  if (j <= 9) goto D_2048; else goto D_2050;
  D_2050:
  i = i + 1;
  D_2052:
  if (i <= 9) goto D_2051; else goto D_2053;
  D_2053:
  D_2055 = (const char * restrict) &"res = %d\n"[0];
  printf (D_2055, res);
	return 0;
}


