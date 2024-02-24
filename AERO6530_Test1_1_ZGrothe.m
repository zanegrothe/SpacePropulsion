% Zane Grothe
% AERO 6530
% Test 1
% 3/21/22

clear all
close all
clc

% Problem 1 ~~~~~~~~~~~~~~~~~~~~

% RP1    =  Rocket Propellant 1
% H2     =  Hydrogen gas
% F2     =  Fluorine gas
% A      =  Methyl Alcohol
% HF     =  Hydrogen Fluoride
% CO2    =  Carbon Dioxide
% H2O    =  Water
% O2     =  Oxygen gas


% ~~~~~~~~~~ Heat of Reaction Equations

% Molecular Weights (g/mol)
MW_RP1 = 175;
MW_A = 32;

% Heats of Formations (kJ/mol)
Hf_CO2 = -393.522;
Hf_H2O = -241.827;
Hf_RP1 = -1.67*MW_RP1;
Hf_A = -201.07;
Hf_O2 = 0;

% Heat of Reactions (kJ)
HR_RP1 = (1*Hf_CO2+.95*Hf_H2O)-(1*Hf_RP1+1.475*Hf_O2);
HR_A = (1*Hf_CO2+2*Hf_H2O)-(1*(Hf_A)+1.5*Hf_O2);

% Per unit mass (J/kg)
hR_RP1 = abs(HR_RP1)/MW_RP1*10^6;
hR_A = abs(HR_A)/MW_A*10^6;


% ~~~~~~~~~~ STANJAN

% Chamber Conditions (J/kg)
h0_H2 = -2.3329*10^5;
h0_F2 = -1.4398*10^5;

% Equilibrium Flow Enthalpies (J/kg)
he_H2_e = -1.0994*10^7;
he_F2_e = -1.2211*10^7;

% Frozen Flow Enthalpies (J/kg)
he_H2_f = -8.7602*10^6;
he_F2_f = -8.3546*10^6;

% Equilibrium Flow Specific Impulses (s)
ue_H2_e = sqrt(2*(h0_H2-he_H2_e)); % (m/s)
Isp_H2_e = ue_H2_e/9.81;

ue_F2_e = sqrt(2*(h0_F2-he_F2_e)); % (m/s)
Isp_F2_e = ue_F2_e/9.81;

% Frozen Flow Specific Impulses (s)
ue_RP1_f = sqrt(2*(hR_RP1)); % (m/s)
Isp_RP1_f = ue_RP1_f/9.81;

ue_H2_f = sqrt(2*(h0_H2-he_H2_f)); % (m/s)
Isp_H2_f = ue_H2_f/9.81;

ue_A_f = sqrt(2*(hR_A)); % (m/s)
Isp_A_f = ue_A_f/9.81;

ue_F2_f = sqrt(2*(h0_F2-he_F2_f)); % (m/s)
Isp_F2_f = ue_F2_f/9.81;


% ~~~~~~~~~~ Results

disp('~~~~~Results~~~~~')
disp(' ')
disp('Frozen Flow Isp:')
disp(sprintf('a) LOX-RP1             =  %.f  seconds',Isp_RP1_f))
disp(sprintf('b) LOX-Hydrogen        =  %.f  seconds',Isp_H2_f))
disp('c) LOX-Fluorine does not react. Fluorine-Hydrogen does though. See f)')
disp('d) Red Fuming Nitric Acid-RP1: I cant balance this equation.')
disp(sprintf('e) LOX-Alcohol         =  %.f  seconds',Isp_A_f))
disp(sprintf('f) Fluorine-Hydrogen   =  %.f  seconds',Isp_F2_f))
disp(' ')
disp('Equilibrium Flow Isp:')
disp(sprintf('b) LOX-Hydrogen        =  %.f  seconds',Isp_H2_e))
disp(sprintf('f) Fluorine-Hydrogen   =  %.f  seconds',Isp_F2_e))

