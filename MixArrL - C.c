#include <stdio.h>
extern  int merge(long arr1[], int size1, long arr2[], int size2, long mergeArr[]);
int  main()
{
	long arr1[5] = { 1 , 3 , 6 , 170, 900000 };
	long *arr1Ptr[5];
	long arr2[7] = { 2 ,6 , 7 , 18 , 100 , 15000 , 200000 };
	long *arr2Ptr[7];
	long mergeArr[12];
	int i, mergeArrSize;
	
	for (i = 0; i < 5; i++)
		arr1Ptr[i] = &arr1[i];
	for (i = 0; i < 7; i++)
		arr2Ptr[i] = &arr2[i];

	mergeArrSize = merge(arr1Ptr, 5, arr2Ptr, 7, mergeArr);

	printf("mergeArr : \n");
	for (i = 0; i < mergeArrSize; i++)
		printf("%ld ", mergeArr[i]);

	return 0;
}
