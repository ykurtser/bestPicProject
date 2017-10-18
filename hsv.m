res=1024;
H=fliplr(repmat(linspace(1,924,res)/res,res,1));
%H=fliplr(meshgrid(1:res)/(res));
S=ones(res);
V=ones(res);
HSVIM=zeros(res,res,3);
HSVIM(:,:,1)=H;
HSVIM(:,:,2)=S;
HSVIM(:,:,3)=V;
RGBIM=hsv2rgb(HSVIM);
figure;
imagesc(H(1:res,1),H(1:res,1),RGBIM);







