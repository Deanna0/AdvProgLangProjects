#include <stdio.h>
#include <stdlib.h>

// Structure to hold grayscale pixel data
typedef struct {
    unsigned char value;
} PixelGray;

// Function to read a PGM image into a 2D array
PixelGray** readPGM(const char* filename, int* width, int* height); 
PixelGray** readPGM(const char* filename, int* width, int* height){
    FILE * read_in = NULL; // pointer holding input file
    read_in = fopen(filename, "r"); //opens file to be read

    // Error handling for input file 
    if (read_in == NULL){
        printf("Unable to open lenna.pgm");
        exit(1);
    }

    char data1[3];
    int max_value;
    fscanf(read_in,"%s", data1); //reads for magic number
    fscanf(read_in, "%d %d", height, width); //reads for height
    fscanf(read_in, "%d", &max_value); //reads for max bit
    fgetc(read_in);

    int rows = *height; //holds height dimension
    int cols = *width; //holds width dimension

    //allocate memory for array of row pointers
    // initialize new matrix 2d array
    PixelGray** matrix = (PixelGray**)malloc(rows * sizeof(PixelGray*));
    if (matrix == NULL){
        printf("Error: Unable to allocate memory for rows \n");
        exit(1);
    }

    //allocate memory for each column
    for (int i = 0; i < rows; i++){
        matrix[i] = (PixelGray*)malloc(cols * sizeof(PixelGray));
        if (matrix[i] == NULL){
            printf("Error: Unable to allocate memory for columns in row.\n");
            exit(1);
        }
    }

    //initialize and use the 2d array
    for (int i = 0; i < rows; i++){
        
        for (int j = 0; j < cols; j++){
            //takes in bit values and stores them into matrix
            unsigned char elements_read = fread(&matrix[i][j].value, sizeof(unsigned char), 1, read_in);
            //error handling
            if (elements_read != rows){
                if(feof(read_in)){
                    printf("End of file reached. \n");
            } else if (ferror(read_in)){
                perror("Error reading from lenna.pgm");
            }
            } else {
                //data was read successfully
                //add read data variable
            }
            
        }

    }

    fclose(read_in); //closes file

    return matrix;
}

// Function to write a 2D matrix as a PGM image
void writePGM(const char* filename, PixelGray** matrix, int* width, int* height);
void writePGM(const char* filename, PixelGray** matrix, int* width, int* height){
    FILE * file_copy = NULL;
    file_copy = fopen(filename, "w"); //create new file 

    // sees if the new file was actually created
    if (file_copy == NULL){
        printf("Unable to create file.");
    }

    // all important elements for a pgm file
    int rows = *height;
    int cols = *width;

   fprintf(file_copy, "%s\n", "P5"); // puts magic number
   fprintf(file_copy, "%d %d\n", rows, cols); // puts height & width into new file
   fprintf(file_copy,"%s\n", "255"); // puts max bit value into file

    for (int i = 0; i < rows; i++){
        
        for (int j = 0; j < cols; j++){
            // writes whatever is in matrix to the new file
            fwrite(&matrix[i][j].value, sizeof(unsigned char), 1, file_copy);
        }
    }

    fclose(file_copy); // close file

}
// Function to threshold the image matrix
PixelGray** threshold(PixelGray** matrix, int* width, int* height);
PixelGray** threshold(PixelGray** matrix, int* width, int* height){

    int rows = *height; //get rows from image later
    int cols = *width; //get cols from image later

    //allocate memory for array of row pointers
    //new thres_matrix
    PixelGray** thres_matrix = (PixelGray**)malloc(rows * sizeof(PixelGray*));

    //handle errors
    if (thres_matrix == NULL){
        printf("Error: Unable to allocate memory for thres rows \n");
        exit(1);
    }

    //allocate memory for each column
    for (int i = 0; i < rows; i++){
        thres_matrix[i] = (PixelGray*)malloc(cols * sizeof(PixelGray));
        //handle errors
        if (thres_matrix[i] == NULL){
            printf("Error: Unable to allocate memory for thres columns in row.\n");
            exit(1);
        }
    }

    //initialize and use the 2d array
    for (int i = 0; i < rows; i++){
        
        for (int j = 0; j < cols; j++){
           // checks each value in matrix & turns it either white or black 
           if (matrix[i][j].value > 80){
            thres_matrix[i][j].value = 255; //make pixel white
           } else {
            thres_matrix[i][j].value = 0; //makes pixel black
           }
        }

    }

    return thres_matrix;
}
// Function to rotate the image matrix
PixelGray** rotate(PixelGray** matrix, int* width, int* height);
PixelGray** rotate(PixelGray** matrix, int* width, int* height){
    int rows = *height; //holds height dimension
    int cols = *width; //holds width dimension

    //allocate memory for array of row pointers
    //new rotate_matrix
    PixelGray** rotate_matrix = (PixelGray**)malloc(rows * sizeof(PixelGray*));

    //handle errors
    if (rotate_matrix == NULL){
        printf("Error: Unable to allocate memory for rotate rows \n");
        exit(1);
    }

    //allocate memory for each column
    for (int i = 0; i < rows; i++){
        rotate_matrix[i] = (PixelGray*)malloc(cols * sizeof(PixelGray));
        //handle errors
        if (rotate_matrix[i] == NULL){
            printf("Error: Unable to allocate memory for rotate columns in row.\n");
            exit(1);
        }
    }

    // rotate image
    for (int i = 0; i < rows; i++){

        for (int j = 0; j < cols; j++){
            rotate_matrix[j][i].value = matrix[i][j].value; // put bits of matrix into rotate
        }
    }

    return rotate_matrix;
}


//main function - DO NOT MODIFY
int main() {
    int width, height;  // variable to hold width and height. Use reference in other functions

    PixelGray** image_original = readPGM("lenna.pgm", &width, &height);
    // Now you have the grayscale image data in the 'image_original' 2D array

    // Access pixel data using image[row][col].value
    // For example, to access the pixel at row=2, col=3:
    // unsigned char pixel_value = image[2][3].value;

    // Create a new 2D array 'image_thresh' to store the threshold image
    PixelGray** image_thresh = threshold(image_original, &width, &height);
    //write the image data as "threshold.pgm"
    writePGM("threshold.pgm", image_thresh, &width, &height);

     // Create a new 2D array 'image_rotate' to store the rotated image
     PixelGray** image_rotate = rotate(image_original, &width, &height);
     //write the image data as "rotate.pgm"
     writePGM("rotate.pgm", image_rotate, &width, &height);

     image_rotate = rotate(image_rotate, &width, &height);
     //write the image data as "rotate_again.pgm"
     writePGM("rotate_again.pgm", image_rotate, &width, &height);

    // Free the allocated memory when you're done
    for (int i = 0; i < height; ++i) {
        free(image_original[i]);
        free(image_thresh[i]);
        free(image_rotate[i]);
    }
    free(image_original);
    free(image_thresh);
    free(image_rotate);
    return 0;
}


