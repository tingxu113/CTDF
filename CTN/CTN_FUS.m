function [HR_HSI]= CTN_FUS(HSI,MSI,T,sf,par,para)
[w,h,S]=size(HSI);
[W,H,s]=size(MSI);
r1=para.r1;r2=para.r2;
%% intialize
HR_load=imresize(HSI,sf,'bicubic');
[~,node] = DT_ALS(HR_load,[r1,r2],3);
A=node{1};
C=node{2};


%% 
A2=permute(A,[2,3,1,4]);
A2=reshape(A2,[H*W,r1*r2]);
Y3=reshape(double(HSI),[w*h,S]);
Z3=reshape(double(MSI),[W*H,s]);
C2=permute(C,[3,1,2]);
C2=reshape(C2,[r1*r2,S]);
Maxit=para.K;

for i=1:Maxit
%% A-sub
[A2] = CG( Y3, Z3,A2,C2, par, T,para.rho_1);

%% C-sub
C2=CG_2(Y3, Z3,A2,C2,para.rho_2, par, T);
C=reshape(C2,size(C));

end
HR_HSI=A2*C2;
HR_HSI=reshape( HR_HSI,[W,H,S]);
HR_HSI=double(HR_HSI);
end
