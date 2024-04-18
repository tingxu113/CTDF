%% ================================================================
% This is the demo code for 
% A Coupled Tensor Double-Factor Method for Hyperspectral and Multispectral Image Fusion
% Ting Xu, Ting-Zhu Huang*, Liang-Jian Deng*, Jin-Liang Xiao, Clifford Broni-Bediako, Junshi Xia, Naoto Yokoya
% IEEE Transactions on Geoscience and Remote Sensing, 2024.

% Contact email: tingxu113@163.com
% If you use this code, please cite the following paper:

% @ARTICLE{xu2024ctdf,
%  author={Xu, Ting and Huang, Ting-Zhu and Deng, Liang-Jian and Xiao, Jin-Liang and Broni-Bediako, Clifford and Xia, Junshi and Yokoya, Naoto},
%  journal={IEEE Transactions on Geoscience and Remote Sensing}, 
%  title={A Coupled Tensor Double-Factor Method for Hyperspectral and Multispectral Image Fusion}, 
%  year={2024},
%   volume={},
%   number={},
%   pages={1-1},
%   doi={10.1109/TGRS.2024.3389016}}

% =========================================================================
%% parameters
% Please adjust the following parameters for better results
% Please adjust K at [3,20]
% Please adjust r1 at [2,9]
% Please adjust r2 at [4,8]
% Please adjust rho at [1e-8,1e-4]
% =========================================================================

%%
clear;clc
close all;
addpath(genpath(pwd));
name='CAVE';
load 'resize_Paints.mat'

%% Simulate
Scale = 4;
F=create_F();%cave and harvard dataset use this command
[M,N,L] = size(S);
S_bar = hyperConvert2D(S);
sf = Scale;
s0 = 2;
% blur kernel
psf        =    ones(sf)/(sf^2);%uniform blur
sz=[M,N];
para.fft_B      =    psf2otf(psf,sz);
para.B     =    ifft2(para.fft_B) ;
para.fft_BT     =    conj(para.fft_B);
para.H          =    @(z)H_z(z, para.fft_B, sf, sz,s0 );
para.HT         =    @(y)HT_y(y, para.fft_BT, sf, sz);
para.HTH         =    @(y)HTHx(y, para.fft_B, para.fft_BT,sf,sz,s0);
hyper= para.H(S_bar);
HSI=hyperConvert3D(hyper,M/sf,N/sf);
%% generate MSI
Y=F*S_bar;
MSI = hyperConvert3D(Y, M, N);
%% Parameters
opts=[];
K=3; %% Please adjust this parameter at [3,20]
r1=3; %% Please adjust this parameter at [2,9]
r2=6; %% Please adjust this parameter at [4,8]
rho=1e-7; %% Please adjust this parameter at [1e-8,1e-4]
%%
opts.K=K;
opts.r1=r1;opts.r2=r2;
opts.rho_1=rho;opts.rho_2=rho;opts.rho_3=rho;
t0=clock;
[PRO] = CTN_FUS(HSI,MSI,F,sf,para,opts );
t_PRO=etime(clock,t0);

%% Show Metrics
[psnr_PRO,rmse_PRO, ergas_PRO, sam_PRO, uiqi_PRO,ssim_PRO,DD_PRO,CC3_PRO] = quality_assessment(S*255, PRO*255, 0, 1.0/sf);

fprintf('Data:   ')
disp(name)
fprintf('\n')
disp('             |====PSNR=====|===SSIM====|===ERGAS===|====SAM====|=====RMSE=====|====TIME=====|')
fprintf('       PRO ');fprintf('     %5.4f  ',[psnr_PRO,ssim_PRO,ergas_PRO, sam_PRO,rmse_PRO,t_PRO]);
fprintf('\n')
