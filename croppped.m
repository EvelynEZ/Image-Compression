clear all; clc; close all
imagefile = dir('Cropped/*.pgm');
L = length(imagefile);
B = [];
cd('U:/AMATH 482/Cropped');
for i = 1:L
    image = imread(imagefile(i).name);
    image = im2double(image);
    [m, n] = size(image);
    col = reshape(image, [m*n 1]); %32256 pixels
    B(:,i) = col;    
end

[U, S, V] = svd(B, 'econ');
save B.dat B -ascii;
save U.dat U -ascii;
save S.dat S -ascii;
save V.dat V -ascii;

%%
%Plot S
S_diag = diag(S);
scatter(1:2414, S_diag);
title('Scatter Plot of Singular Values');
%%
%plot energy
figure(1);
S_diag = diag(S);
scatter(1:2414,100*S_diag(1:2414)/sum(S_diag));
title('Percentage of each Singular Value');
ylabel('Percentage');
xlabel('n')
figure(2);
scatter(1:2414,log(S_diag(1:2414)));
title('Log Plot of Singular Value');
ylabel('Log');
xlabel('n')
text(20,40,'(b)','Fontsize',[11]);
%%
%Calculating Energy
S_diag = diag(S);
k = 170;
energy = sum(S_diag(1:k))/sum(S_diag)
%%
j=2414;
S_rank = S;
S_rank(j+1:end,j+1:end) = 0;
A_new = U*S_rank*V';
imshow(reshape(A_new(:,60),[m,n]));
