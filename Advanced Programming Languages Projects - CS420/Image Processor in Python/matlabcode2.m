
%reading the output text
output_variable_ccode = fileread('c_output.txt'); % for c code
output_variable_haskelcode = fileread('haskel_output.txt'); % for haskel code 
output_variable_prologcode = fileread('prolog_output.txt'); % for haskel code 


%turning the string array to array of nums
output_array_ccode = uint8(str2num(output_variable_ccode)); % for c code
output_array_haskelcode = uint8(str2num(output_variable_haskelcode)); % for haskel code
output_array_prologcode = uint8(str2num(output_variable_prologcode)); % for prolog code

%reshape new array 
resized_matrix = reshape(output_array_ccode, 256, 256);
resized_matrix2 = reshape(output_array_haskelcode, 256, 256);
resized_matrix3 = reshape(output_array_prologcode, 256, 256);

%create figure of pictures
figure()

%show original mickey photo
subplot(2,2,1);
A = imread('mickey-1.png');
imshow(A);
title('Original Mickey')

%show c code output
subplot(2,2,2)
imshow(resized_matrix); 
title('Black and White Image from C');

%show haskel code output
subplot(2,2,3);
imshow(resized_matrix2);
title('Demonic Mickey from Haskel');

%show prolog code output
subplot(2,2,4)
imshow(resized_matrix3);
title('Upside down Mickey from prolog');