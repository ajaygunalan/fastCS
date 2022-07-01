% Get PSNR for BCS_FoE
addpath('./rwt-3.0/bin/');
if ~exist('convMatrix')
	load FoE_conv_matrix;
end

filenames=[];
filenames{end+1}='lena-gray-256.tif';
% filenames{end+1}='barbara-gray-256.tif';
% filenames{end+1}='peppers-gray-256.tif';
% filenames{end+1}='lena-color-256.tif';
% filenames{end+1}='barbara-color-256.tif';
% filenames{end+1}='peppers-color-256.tif';
% filenames{end+1}='Parthenon-color-256.tif';
% filenames{end+1}='girls-color-256.tif';  
% filenames{end+1}='Sydney-color-256.tif';
% filenames{end+1}='dinosaur-gray-256.tif';
% filenames{end+1}='dinosaur-color-256.tif';
% filenames{end+1}='brick-gray-256.tif';
% filenames{end+1}='stone-gray-256.tif';
% filenames{end+1}='fabric-gray-256.tif';
% filenames{end+1}='spot-5-ms-256.tif';
% filenames{end+1}='landsat-7-ms-256.tif';
% filenames{end+1}='iknos-ms-256.tif';

output=[];
nIters=3;
k=1;
for file_no=1:length(filenames)
	for sparsity=[0.1]
		filename=filenames{file_no};
		out.name=filename;
		out.sparsity=sparsity;
		out.psnr_FoE=0;		
		fprintf('--------------file: %s; sparsity: %f----------\n', filename, sparsity);
		for iter=1:nIters
			[msData,psnr]=BCS_Conv(filename,0.3, 0.1, sparsity, 0, convMatrix_FoE_3);
			if (out.psnr_FoE<psnr)
				out.psnr_FoE=psnr;
				out.data=msData;
			end
		end
		[msData,psnr]=BCS_Conv(filename,0.308, 0.018, sparsity, 0, convMatrix_Gradient, out.data);
		out.psnr_TV=psnr;
		output{k}=out;
		fprintf('----%d: %s: sparsity: %f, psnr: %.4f(FoE), %.4f(TV)----\n\n', k, filename, sparsity, out.psnr_FoE, out.psnr_TV);
		k=k+1;
	end
end
