% Zane Grothe
% AERO 6530
% HW 5
% 4/22/22

clear all
close all
clc

% Problem 5/6 ~~~~~~~~~~~~~~~~~~~~

mp=1.67262e-27;
mn=1.67493e-27;
me=9.10938e-31;
Z_U=92;
Z_Th=90;
A_U=235;
A_Th=232;
ma_U=235.04393*1.66054e-27;
ma_Th=232.0377*1.66054e-27;

Delta_U=(Z_U*(mp+me)+(A_U-Z_U)*mn)-ma_U;
Delta_Th=(Z_Th*(mp+me)+(A_Th-Z_Th)*mn)-ma_Th;

c=3e8;

E_U=Delta_U*c^2
E_Th=Delta_Th*c^2

