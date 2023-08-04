Gm_fy = load('FRFiy.mat');
Gm_fZ = load('FRFiz.mat');
Gm_fxy = load('FRFxy.mat');
Gm_fxz = load('FRFxz.mat');


figure (2)
plotdata(Gm_fy.FRF_1,'--k');

hold on

plotdata(Gm_fZ.FRF_1,'--g');

hold on

plotdata(Gm_fxy.FRF_1,'--r');

hold on

plotdata(Gm_fxz.FRF_1,'--y');

hold on
legend 'y' 'z' 'xy' 'xz'

