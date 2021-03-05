% 한 환자의 전후 양상을 비교하는 예제로 registration된 영상으로 비교.

% 1명의 영상에 노이즈 추가하여 10명 환자 생성
PtNum=10 ;

% V1 만들기
folder = 'before_12';
[volume1, slice_data, image_meta_data] = dicom23D(folder, [], []);

% downsample
DownRate = 8;
volume1_down = zeros([size(volume1,1)/DownRate,size(volume1,2)/DownRate,size(volume1,3)]);
for i = 1:size(volume1,3)
    volume1_down(:,:,i) = transpose(downsample(transpose(downsample(volume1(:,:,i),DownRate)),DownRate));
end

for i = 1:PtNum
    V1(:,:,:,i) = volume1_down + normrnd(0,0.1,size(volume1_down));
end

% V2 만들기
folder = 'after_12_regi';
[volume2, slice_data, image_meta_data] = dicom23D(folder, [], []);

% downsample
DownRate = 8;
volume2_down = zeros([size(volume2,1)/DownRate,size(volume2,2)/DownRate,size(volume2,3)]);
for i = 1:size(volume2,3)
    volume2_down(:,:,i) = transpose(downsample(transpose(downsample(volume2(:,:,i),DownRate)),DownRate));
end
for i = 1:PtNum
    V2(:,:,:,i) = volume2_down + normrnd(0,0.1,size(volume2_down));
end

% TFCE로 비교하기
% [pcorr] = matlab_tfce(analysis,1,imgs,imgs2,covariate,nperm,H,E,C,dh,parworkers,nuisance)

%[pcorr_pos, pcorr_neg] = matlab_tfce('independent',2, V1,V2,[],1)
[pcorr_pos, pcorr_neg] = matlab_tfce('independent',2, V1,V2,[],1,[],[],[],1)

