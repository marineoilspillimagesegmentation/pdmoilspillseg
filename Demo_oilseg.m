% This Matlab program demomstrates the proposed method for oil spill SAR image segmentation in our paper:
clc;clear all;close all;
c0 = 2;

imgID = 1 % 1,2,3  % choose the number of the test images.

Img = imread([num2str(imgID),'.bmp']);
imshow(Img);
Img = double(Img(:,:,1));

dim = 1; % the dimension of the image.
colormap(gray);
hold on;
axis off;


switch imgID
    case 1
        iterNum =60;
        gamma1 = 2.3;
        gamma2 = 2.303;
        nu = 0.0004*255*255;% coefficient of oil spill contour regularisation term
        initialLSF = ones(size(Img(:,:,1))).*c0;
        initialLSF(83:93,68:77) = -c0;
        
    case 2
        iterNum =88;
        gamma1 = 2.3;
        gamma2 = 2.303;
        nu = 0.00009*255*255;% coefficient of oil spill contour regularisation term
        initialLSF = ones(size(Img(:,:,1))).*c0;
        initialLSF(23:88,88:123) = -c0;
        
    case 3
        iterNum =60;
        gamma1 = 2.3;
        gamma2 = 2.306;
        nu = 0.00007*255*255;% coefficient of oil spill contour regularisation term
        initialLSF = ones(size(Img(:,:,1))).*c0;
        initialLSF(58:116,78:116) = -c0;
        
end

phi = initialLSF;
figure;imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
title('Initial contour');
[c,h] = contour(phi,[0 0],'r');
pause(0.1);

timestep = .1;% time step
Ks=1; %the system constant
mu = 1;% coefficient of the level set regularization term

epsilon = 1.0;% the papramater in the definition of smoothed Dirac function
tau=1.0;    
K=fspecial('gaussian',round(2*tau)*2+1,tau);     % the Gaussian kernel
I = Img;
KI=conv2(Img,K,'same');     
                                                 
KONE=conv2(ones(size(Img)),K,'same');  

% start level set evolution
for n=1:iterNum
    [sigma1, sigma2] = distributionBinaryFit(Img, phi, KI, KONE, K, Ks,epsilon);
    m=compute_m(Ks,Img,K,KONE,sigma1,sigma2,gamma1,gamma2,dim);
    phi=oilLSE(phi,nu,timestep,mu,m,epsilon,1);
    if mod(n,20)==0
        pause(0.1);
        imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
        [c,h] = contour(phi,[0 0],'r');
        iterNum=[num2str(n), ' iterations'];
        title(iterNum);
        hold off;
    end
end
imagesc(Img, [0, 255]);colormap(gray);hold on;axis off,axis equal
[c,h] = contour(phi,[0 0],'r');
totalIterNum=[num2str(n), ' iterations'];
title(['Final contour, ', totalIterNum]);

figure;
mesh(phi);
title('Final level set function');

