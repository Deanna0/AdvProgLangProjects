A = imread('mickey-1.png');
B = reshape(A, 1, []);
dlmwrite('input.txt', B, 'delimiter', ' ');
imshow(A);