function [ Arr ] = SingleColorTests(  )  
res=256;
 %H=ones(res)*0.8;
 %mod((round(H(1,1)*256)+14),256)
 H = ones(res)*215;
 
 %H = mod((H-18),256); %when showing according to hue values the color starts from red and finishes in red, we want it to start in purple and finish in red.
 H = H/256; %normaliz 0-1
 S=ones(res)*0.5;
 V=ones(res)*0.5;
 HSVIM=zeros(res,res,3);
 HSVIM(:,:,1)=H;
 HSVIM(:,:,2)=S;
 HSVIM(:,:,3)=V;
 RGBIM=hsv2rgb(HSVIM);
 figure;
 imagesc(H(1:res,1),H(1:res,1),RGBIM);
 Arr = HSVIM;