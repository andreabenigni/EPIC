clear all
clc

initPCT(1,3);


%Polinomyal Chaos
a = pct(3,0.5,1);

asample = resample(sin(a),10000);

hist(asample,100)


