% 내가 만든 엑셀파일 불러오기
proton = xlsread('proton.xlsx');
xray = xlsread('xray.xlsx');

% 같은 배열을 100층으로 쌓아서 3D 형태로 만들기
P = repmat(proton,[1 1 100]);
X = repmat(xray,[1 1 100]);

% noise 추가하여 subject 만들기 >>> result = V_P, V_X
SubNum = 5;
img1 = P;
img2 = X;
for i = 1:SubNum
    V_P(:,:,:,i) = P + normrnd(0,0.5,size(P));
    V_X(:,:,:,i) = X + normrnd(0,0.5,size(X));
end

% TFCE
[pcorr] = matlab_tfce('independent',1, V_X,V_P,[],100);

imshow(pcorr(:,:,50), []);