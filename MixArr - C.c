#include <stdio.h>
extern  int merge(long arr1[], int size1, long arr2[], int size2, long mergeArr[]);
int  main()
{
	long arr1[5] = { 1 , 3 , 6 , 170, 900 };
	long arr2[7] = { 2 ,6 , 7 , 18 , 100 , 150 , 200 };
	long mergeArr[12];
	int i, mergeArrSize = merge(arr1, 5, arr2, 7, mergeArr);

	printf("mergeArr : \n");
	for (i = 0; i < mergeArrSize; i++)
		printf("%ld ", mergeArr[i]);

	return 0;
}
