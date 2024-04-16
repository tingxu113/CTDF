function [z] = HTHx(y, fft_B,fft_BT, sf, sz,s0)
[ch,n]                   =    size(y);

if  ch  == 1
    z                        =    zeros(sz);    
    z(s0:sf:end, s0:sf:end)  =    reshape(y, floor(sz/sf));
    z                        =    real( ifft2(fft2( z ).*fft_BT) );
    z                        =    z(:)';
else    
    z                        =    zeros(ch, n);
    t                        =    zeros(sz);
    for  i  = 1 : ch
        a0=reshape(y(i,:),sz);
        a=real( ifft2(fft2(a0).*fft_B) );
        t(s0:sf:end,s0:sf:end)        =    a(s0:sf:end,s0:sf:end);
        Htz                           =    real( ifft2(fft2( t ).*fft_BT) );
        z(i,:)                        =    Htz(:)';
    end
end

