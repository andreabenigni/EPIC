%% 
clear all
clc

%%Test 1: single value
s = 5;
b_s = inv(s);

%% Test 2: double matrix
m_s = [3 10; 2 5];
Inv_m_s = inv(m_s); %Inv_c_s = [-1 2; 0.4 -0.6];

%% Test 3: PCT Test
initPCT(3,6)

a11 = pct(3,0.3,1);
a22 = pct(5,0.5,2);

a = [a11 10;2 a22];

b = inv(a);

%% Test 4: montecarlo
sample = 10000;
m_mc.a = uniform(2.7,3.3,sample);
m_mc.b = uniform(10,10,sample);
m_mc.c = uniform(2,2,sample);
m_mc.d = uniform(4.5,5.5,sample);

for i = 1:sample
    M_mc = [m_mc.a(i) m_mc.b(i);m_mc.c(i) m_mc.d(i)];
    Inv_M_mc = minverse(M_mc);
    Inv_m_mc.a(i)=Inv_M_mc(1,1);
    Inv_m_mc.b(i)=Inv_M_mc(1,2);
    Inv_m_mc.c(i)=Inv_M_mc(2,1);
    Inv_m_mc.d(i)=Inv_M_mc(2,2);
end
b_mc11 = Inv_m_mc.a;
b_mc12 = Inv_m_mc.b;
b_mc21 = Inv_m_mc.c;
b_mc22 = Inv_m_mc.d;

%% Resampling of PC variables and compare to MC
b11p = resample(b(1,1),sample);
b12p = resample(b(1,2),sample);
b21p = resample(b(2,1),sample);
b22p = resample(b(2,2),sample);

%% Plot
figure(1)
minlim = min(min(b_mc11),min(b11p));
maxlim = max(max(b_mc11),max(b11p));
[n1,p1]=hist(b_mc11,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(b11p,[minlim:abs(maxlim-minlim)/100:maxlim]);
title('b11')
bar(p1,n1);
hold on; 
bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(2)
minlim = min(min(b_mc12),min(b12p));
maxlim = max(max(b_mc12),max(b12p));
[n1,p1]=hist(b_mc12,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(b12p,[minlim:abs(maxlim-minlim)/100:maxlim]);
title('b12')
bar(p1,n1);
hold on; 
bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(3)
minlim = min(min(b_mc21),min(b21p));
maxlim = max(max(b_mc21),max(b21p));
[n1,p1]=hist(b_mc21,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(b21p,[minlim:abs(maxlim-minlim)/100:maxlim]);
title('b21')
bar(p1,n1);
hold on; 
bar(p2,n2,'facecolor','none', 'EdgeColor','r')

figure(4)
minlim = min(min(b_mc22),min(b22p));
maxlim = max(max(b_mc22),max(b22p));
[n1,p1]=hist(b_mc22,[minlim:abs(maxlim-minlim)/100:maxlim]);
[n2,p2]=hist(b22p,[minlim:abs(maxlim-minlim)/100:maxlim]);
title('b22')
bar(p1,n1);
hold on; 
bar(p2,n2,'facecolor','none', 'EdgeColor','r')


