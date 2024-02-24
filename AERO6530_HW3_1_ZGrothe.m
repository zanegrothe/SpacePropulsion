% Zane Grothe
% AERO 6530
% HW 3
% 2/21/22

clear all
close all
clc

% Problem 1 ~~~~~~~~~~~~~~~~~~~~

% Molecular Weights (g/mol)
MW_RP1=175;
MW_Prop=44;

% Heats of Formations (kJ/mol)
Hf_CO2=-393.522;
Hf_H2O=-241.827;
Hf_RP1=-1.67*MW_RP1;
Hf_O2=0;
Hf_Prop=-103.6;

% Heat of Vaporization (kJ/mol)
Hv_Prop=335.4/1000*MW_Prop;

% Heat of Reactions (kJ)
HR_RP1=(1*Hf_CO2+.95*Hf_H2O)-(1*Hf_RP1+1.475*Hf_O2);
HR_Prop=(3*Hf_CO2+4*Hf_H2O)-(1*(Hf_Prop+Hv_Prop)+5*Hf_O2);

% Enthalpies from STANJAN (J/kg)
h0_H=-3.48*10^5;
he_H=-8.11*10^6;

% Per unit mass (J/kg)
hR_RP1=abs(HR_RP1)/MW_RP1*10^6;
hR_Prop=abs(HR_Prop)/MW_Prop*10^6;

% Specific Impulses (s)
ue_RP1=sqrt(2*hR_RP1); % (m/s)
Isp_RP1=ue_RP1/9.81;

ue_Prop=sqrt(2*hR_Prop); % (m/s)
Isp_Prop=ue_Prop/9.81;

ue_H=sqrt(2*(h0_H-he_H)); % (m/s)
Isp_H=ue_H/9.81;

% Mixture Ratio
r=linspace(0,10);

% Specific Gravities
Rho_O=1.14;
Rho_RP1=0.58;
Rho_Prop=0.583;
Rho_H=0.071;

% Average Specific Gravity
Rho_av_RP1_O=(Rho_O*Rho_RP1*(1+r))./(r.*Rho_RP1+Rho_O);
Rho_av_Prop_O=(Rho_O*Rho_Prop*(1+r))./(r.*Rho_Prop+Rho_O);
Rho_av_H_O=(Rho_O*Rho_H*(1+r))./(r.*Rho_H+Rho_O);

% Density Specitic Impulses (s)
Id_RP1=Isp_RP1*Rho_av_RP1_O;
Id_Prop=Isp_Prop*Rho_av_Prop_O;
Id_H=Isp_H*Rho_av_H_O;

% Plots
figure(1)
plot(r,Id_RP1)
xlabel('Mixture Ratio')
ylabel('Density Specific Impulse for RP1')
title('Id based on r (RP1)')

figure(2)
plot(r,Id_Prop)
xlabel('Mixture Ratio')
ylabel('Density Specific Impulse for Propane')
title('Id based on r (Propane)')

figure(3)
plot(r,Id_H)
xlabel('Mixture Ratio')
ylabel('Density Specific Impulse for Hydrogen')
title('Id based on r (Hydrogen)')


