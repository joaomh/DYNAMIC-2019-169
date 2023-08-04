model = createpde('structural','modal-solid');
importGeometry(model,'TuningFork.stl');
figure
pdegplot(model)

E = 210E9;
nu = 0.3;
rho = 8000;
structuralProperties(model,'YoungsModulus',E, ...
                           'PoissonsRatio',nu, ...
                           'MassDensity',rho);

generateMesh(model,'Hmax',1);
RF = solve(model,'FrequencyRange',[-1,4000]*2*pi);
modeID = 1:numel(RF.NaturalFrequencies);
tmodalResults = table(modeID.',RF.NaturalFrequencies/2/pi);
tmodalResults.Properties.VariableNames = {'Mode','Frequency'};
disp(tmodalResults);
frames  = animateSixTuningForkModes(RF);


