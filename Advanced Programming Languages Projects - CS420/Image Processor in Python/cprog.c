#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    // Dynamically allocate memory for an array of integers
    const int arraySize = argc - 1;
    int * intarrayPtr = NULL;
    intarrayPtr = (int* )malloc(arraySize * sizeof(int));

    if (intarrayPtr == NULL) {
        printf("Halting: Unable to allocate array. \n");
        return 1;
    }

    // Read elements from command line and convert to integers
    int arg;
    float sum = 0;

    if (argc < 2) {
        printf("\n Numbers not specified on the command line! \n\n");
        return 1;
    }

    for (arg = 1; arg < argc; arg++) {
       intarrayPtr[arg - 1] = atoi(argv[arg]);
    }

    
    const int threshold = 170;  // Hardcoded threshold

    // Changes each pixel to either 0 (if pixel/num < 170) or 255 (if pixel/num > 170) 
    // Generates black & white image
    for (arg = 0; arg < arraySize; arg++) {
         if (intarrayPtr[arg] > threshold) {
             printf("255 ");
         } else {
           printf("0 ");
       }
    }


    // Free dynamically allocated memory
    free(intarrayPtr);
    intarrayPtr = NULL;

    return 0;
}