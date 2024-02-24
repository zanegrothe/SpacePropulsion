% Zane Grothe
% AERO 6530
% HW 4
% 3/14/22

clear all
close all
clc

% Problem 4 ~~~~~~~~~~~~~~~~~~~~


% Extract data
% These coordinates were pulled by hand

% Pressure data (atm)
HMXp1=[1,1.8,2.2,2.7,3.6,3.9,4.3,5,5.7,7,7.8,7.8,10,11,15,16,18,21];
HMXp2=[27,33,40,48,53,67,68,82,100,150,210,280,350,415,565];
HMXp=[HMXp1,HMXp2];

RDXp=[1,6.5,13,20,21,22,30,31,72,74,107,120,130,160,200,250,251,360,460,700,760];
ADNp=[14,20,27,34,40,41,55,60,70,80,100,120,150,160];
APp=[27,28,35,40,41,58,59,70,82,85,101,102,110,120,130,140];
CL20p=[7,14,27,55,70,100];
GAPp=[10,20,30,40,50,60];
BAMOp=[16,21.5,28.5,31,38,40,41];
HNFp=[1.8,2,2.6,3.5,4.9,6.75,6.8,11,14,27,28,40,55,56,66];
ANp=[68,69,71,102,103,115,140,141,180,181,205,206,235,236,280,282,320,325];

% Burn rate data (cm/s)
HMXr1=[.035,.06,.085,.1,.11,.13,.16,.16,.19,.18,.21,.23,.25,.31,.3,.34,.46,.48];
HMXr2=[.69,.7,.73,.95,1,1.6,1,1.4,2,3,3.2,4.5,5,6.3,7.5];
HMXr=[HMXr1,HMXr2];

RDXr=[.039,.15,.32,.39,.40,.42,.64,.69,1.2,1.5,1.6,1.9,2.4,2.9,3.0,3.5,3.9,4.9,7.0,7.9,10.0];
ADNr=[2.6,2.5,3.4,2.4,3.0,2.8,3.3,3.1,3.5,3.2,3.6,4.0,4.5,4.8];
APr=[.39,.39,.5,.6,.58,.71,.69,.80,.98,.91,1.0,1.1,1.1,1.2,1.3,1.4];
CL20r=[.46,.63,1.1,2.0,2.4,3.0];
GAPr=[.51,.71,.85,.95,1.1,1.3];
BAMOr=[.17,.2,.24,.23,.26,.27,.26];
HNFr=[.15,.13,.17,.21,.32,.45,.52,.65,.89,1.5,1.7,2.1,2.5,2.7,3.1];
ANr=[.18,.21,.20,.25,.29,.32,.38,.40,.45,.52,.49,.54,.63,.68,.80,.90,.95,1.1];


% Find coefficients for a linear polynomial and convert to n&a

lc_HMX=polyfit(log(HMXp),log(HMXr),1); % lc = Linear Coef.s of polynomial
HMXn=lc_HMX(1,1);
HMXa=exp(lc_HMX(1,2));
HMX=[HMXn,HMXa];

lc_RDX=polyfit(log(RDXp),log(RDXr),1);
RDXn=lc_RDX(1,1);
RDXa=exp(lc_RDX(1,2));
RDX=[RDXn,RDXa];

lc_ADN=polyfit(log(ADNp),log(ADNr),1);
ADNn=lc_ADN(1,1);
ADNa=exp(lc_ADN(1,2));
ADN=[ADNn,ADNa];

lc_AP=polyfit(log(APp),log(APr),1);
APn=lc_AP(1,1);
APa=exp(lc_AP(1,2));
AP=[APn,APa];

lc_CL20=polyfit(log(CL20p),log(CL20r),1);
CL20n=lc_CL20(1,1);
CL20a=exp(lc_CL20(1,2));
CL20=[CL20n,CL20a];

lc_GAP=polyfit(log(GAPp),log(GAPr),1);
GAPn=lc_GAP(1,1);
GAPa=exp(lc_GAP(1,2));
GAP=[GAPn,GAPa];

lc_BAMO=polyfit(log(BAMOp),log(BAMOr),1);
BAMOn=lc_BAMO(1,1);
BAMOa=exp(lc_BAMO(1,2));
BAMO=[BAMOn,BAMOa];

lc_HNF=polyfit(log(HNFp),log(HNFr),1);
HNFn=lc_HNF(1,1);
HNFa=exp(lc_HNF(1,2));
HNF=[HNFn,HNFa];

lc_AN=polyfit(log(ANp),log(ANr),1);
ANn=lc_AN(1,1);
ANa=exp(lc_AN(1,2));
AN=[ANn,ANa];


% Collect and display coefficients

na_c=[HMX;RDX;ADN;AP;CL20;GAP;BAMO;HNF;AN]; % coefficients
na_l={'HMX ';'RDX ';'ADN ';'AP  ';'CL20';'GAP ';'BAMO';'HNF ';'AN  '}; % labels
na_m1=[na_l{1,1};na_l{2,1};na_l{3,1};na_l{4,1};na_l{5,1}];
na_m2=[na_l{6,1};na_l{7,1};na_l{8,1};na_l{9,1}];
na_m=[na_m1;na_m2];
disp('Propellants:')
disp(na_m)
disp('Coef:    n         a')
disp(na_c)

