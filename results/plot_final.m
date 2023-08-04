Gm_fy = load('FRFiy.mat');
Gm_fZ = load('FRFiz.mat');
Gm_fxy = load('FRFxy.mat');
Gm_fxz = load('FRFxz.mat');


figure (1), clf

hold on

plotdata(Gm_fxz.FRF_0,'--b');
plotdata(Gm_fxy.FRF_0,'--r');


hold on
title 'Protótipo I'
legend '1º Frequência' '--2º Frequência'

figure (2), clf
plotdata(Gm_fZ.FRF_0,'--k');

hold on

plotdata(Gm_fy.FRF_0,'--g');

hold on
title 'Protótipo II'
legend '1º Frequência' '2º Frequência'



