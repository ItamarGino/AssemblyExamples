// fib1.c

#include <stdio.h>

extern unsigned long int find_largest_fibo(unsigned long int n, 
unsigned int *index);

extern unsigned long int compute_fibo_code(unsigned int n);

int main()
{

  unsigned long int n;
  unsigned long int code;
  printf("Enter 32 bit unsigned integer:\n");
  scanf("%lu", &n);

  code = compute_fibo_code(n);
  printf("code = %lx\n", code);  

} // main   

