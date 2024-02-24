% Zane Grothe
% AERO 6530
% HW 3
% 2/21/22

clear all
close all
clc

% Problem 8 ~~~~~~~~~~~~~~~~~~~~

% Prop = Propane
% But = Butane
% Methy = Methyl Alcohol

% Molecular Weights (g/mol)
MW_RP1=175;
MW_Prop=44;
MW_But=58;
MW_Methy=32;

% Heats of Formation (kJ/mol)
Hf_CO2=-393.522;
Hf_H2O=-241.827;
Hf_RP1=-1.67*MW_RP1;
Hf_O2=0;
Hf_Prop=-103.6;
Hf_But=-126.148;
Hf_Methy=-201.07;

% Heats of Vaporization (kJ/mol)
Hv_Prop=335.4/1000*MW_Prop;
Hv_But=361.6/1000*MW_But;

% Heat of Reactions (kJ)
HR_RP1=(1*Hf_CO2+.95*Hf_H2O)-(1*Hf_RP1+1.475*Hf_O2);
HR_Prop=(3*Hf_CO2+4*Hf_H2O)-(1*(Hf_Prop+Hv_Prop)+5*Hf_O2);
HR_But=(8*Hf_CO2+10*Hf_H2O)-(2*(Hf_But+Hv_But)+13*Hf_O2);
HR_Methy=(2*Hf_CO2+4*Hf_H2O)-(2*(Hf_Methy)+3*Hf_O2);

% Enthalpies from STANJAN (J/kg)
h0_H=-3.48*10^5; % Hydrogen
he_H=-8.11*10^6;
h0_M=-1.0491*10^6; % Methane
he_M=-4.7442*10^6;

% Per unit mass (J/kg)
hR_RP1=abs(HR_RP1)/MW_RP1*10^6;
hR_Prop=abs(HR_Prop)/MW_Prop*10^6;
hR_But=abs(HR_But)/MW_But*10^6;
hR_Methy=abs(HR_Methy)/MW_Methy*10^6;

% Specific Impulses (s)
ue_RP1=sqrt(2*hR_RP1); % (m/s)
Isp_RP1=ue_RP1/9.81;

ue_Prop=sqrt(2*hR_Prop); % (m/s)
Isp_Prop=ue_Prop/9.81;

ue_But=sqrt(2*hR_But); % (m/s)
Isp_But=ue_But/9.81;

ue_Methy=sqrt(2*hR_Methy); % (m/s)
Isp_Methy=ue_Methy/9.81;

ue_H=sqrt(2*(h0_H-he_H)); % (m/s)
Isp_H=ue_H/9.81;

ue_M=sqrt(2*(h0_M-he_M)); % (m/s)
Isp_M=ue_M/9.81;

% Mixture Ratios (stoichiometric)
r_H=8;
r_M=4;
r_But=3.586;
r_Prop=3.636;
r_RP1=3.371;
r_Methy=1.5;

% Specific Gravities
Rho_O=1.104;
Rho_RP1=0.58;
Rho_Prop=0.583;
Rho_H=0.071;
Rho_M=0.554;
Rho_But=0.599;
Rho_Methy=0.79;

% Average Specific Gravity
Rho_av_RP1_O=(Rho_O*Rho_RP1*(1+r_RP1))/(r_RP1*Rho_RP1+Rho_O);
Rho_av_Prop_O=(Rho_O*Rho_Prop*(1+r_Prop))/(r_Prop*Rho_Prop+Rho_O);
Rho_av_H_O=(Rho_O*Rho_H*(1+r_H))/(r_H*Rho_H+Rho_O);
Rho_av_M_O=(Rho_O*Rho_M*(1+r_M))/(r_M*Rho_M+Rho_O);
Rho_av_But_O=(Rho_O*Rho_But*(1+r_But))/(r_But*Rho_But+Rho_O);
Rho_av_Methy_O=(Rho_O*Rho_Methy*(1+r_Methy))/(r_Methy*Rho_Methy+Rho_O);


% Density Specitic Impulses (s)
Id_RP1=Isp_RP1*Rho_av_RP1_O;
Id_Prop=Isp_Prop*Rho_av_Prop_O;
Id_H=Isp_H*Rho_av_H_O;
Id_M=Isp_M*Rho_av_M_O;
Id_But=Isp_But*Rho_av_But_O;
Id_Methy=Isp_Methy*Rho_av_Methy_O;

% Plot
X={'Hydrogen','Methane','Butane','Propane','RP-1','Methyl Alcohol'};
Y=[Id_H Id_M Id_But Id_Prop Id_RP1 Id_Methy];
bar(Y)
set(gca,'xticklabel',X)
xlabel('Fuel Type')
ylabel('Density Specific Impulse (s)')
title('Id Based on Fuel Type (at stoichiometric ratio)')

