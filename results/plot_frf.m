Gm_fy = load('FRFiy.mat');
Gm_fZ = load('FRFiz.mat');
Gm_fxy = load('FRFxy.mat');
Gm_fxz = load('FRFxz.mat');


figure (1)
plotdata(Gm_fy.FRF_0,'--k');

hold on

plotdata(Gm_fZ.FRF_0,'--g');

hold on

plotdata(Gm_fxy.FRF_0,'--r');

hold on

plotdata(Gm_fxz.FRF_0,'--y');

hold on
legend 'y' 'z' 'xy' 'xz'

