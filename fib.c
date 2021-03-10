 // fib.c

#include <stdio.h>

unsigned long int find_largest_fibo(unsigned long int n, 
unsigned int *index)
{
  unsigned int i;
  unsigned long int fib0=1, fib1 = 1, fib2=1;

  i = 0; 
  while(n >= fib2)
  {
   i++;
   fib2 = fib1+fib0;
   fib0 = fib1;
   fib1 = fib2;
   
  } // while

  printf("fib0 = %lu\n", fib0);
  printf("i = %u\n", i);


  *index =i;
  return fib0;


} // find_largest_fibo(int n) 

unsigned long int compute_fibo_code(unsigned int n)
{

  unsigned long int k;
  unsigned long int code, m;
  unsigned int  index;

  code =0;
  while(n > 0) 
  {
   k = find_largest_fibo(n, &index);
   m = 1<<index;
   code += m;
   printf("code = %x\n", code);

   n -= k;
   printf("n = %lu\n", n);

  } // while

  return code;
} //compute_fibo_code

int main()
{

  unsigned long int n;
  unsigned long int code;
  printf("Enter 32 bit unsigned integer:\n");
  scanf("%lu", &n);

  code = compute_fibo_code(n);
  printf("code = %lx\n", code);  

} // main   

