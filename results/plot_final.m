Gm_fy = load('FRFiy.mat');
Gm_fZ = load('FRFiz.mat');
Gm_fxy = load('FRFxy.mat');
Gm_fxz = load('FRFxz.mat');


figure (1), clf

hold on

plotdata(Gm_fxz.FRF_0,'--b');
plotdata(Gm_fxy.FRF_0,'--r');


hold on
title 'Prot�tipo I'
legend '1� Frequ�ncia' '--2� Frequ�ncia'

figure (2), clf
plotdata(Gm_fZ.FRF_0,'--k');

hold on

plotdata(Gm_fy.FRF_0,'--g');

hold on
title 'Prot�tipo II'
legend '1� Frequ�ncia' '2� Frequ�ncia'



