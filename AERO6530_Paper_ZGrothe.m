% Zane Grothe
% AERO 6530
% Test 2
% 5/2/22

clear all
close all
clc

% Givens

g=9.81;                         % Gravity (m/s^2)
mt=6161.4;                      % Total satellite mass (kg)
mf=167.5;                       % Fuel (hydrazine) mass (kg)
mo=132.5;                       % Oxidizer (nitrogen tetroxide) mass (kg)
rof=1.65;                       % Ratio of oxidizer to fuel for SCATs
mARC=mf-mo/rof;                 % Mass reserved for arcjets (kg)
Ft=linspace(0.222,0.258);       % Thrust (N)
abpy=1.5*52;                    % Avg burns per year (1.5 per week)
dVbudLT=25.5;                   % Delta V mission budget (m/s)
LTg=10.5;                       % Lifetime goal (years)
dVbud_py=dVbudLT/LTg;           % Delta V budget per year (m/s)
dVbud_pb=dVbud_py/abpy;         % Delta V budget per burn (m/s)
Isp=[585,615];                  % Max specific impulse (s)
dV=linspace(0,.12);             % Delta V required of MRE (arcjets) (m/s)
bpy=dVbud_py./dV;               % Burns per year


%% Calculations

tb=dVbud_pb*mt./Ft;             % Burn time (s)

k=1;
while k < 3
    
    mdot=Ft./Isp(1,k)./g;       % Mass flow rate (kg/s)
    
    mpbM=max(mdot)*max(tb);     % Theoretical Max propellant mass per burn (kg)
    mpbm=min(mdot)*min(tb);     % Theoretical min propellant mass per burn (kg)
    
    fuelav=mpbM*abpy*LTg;       % Fuel available for lifetime goal (kg)
    
    if k == 1
        mdotm=mdot;
        mpbMm=mpbM;
        mpbmm=mpbm;
        fm=fuelav;
    else
        mdotm=[mdotm;mdot]; %#ok<AGROW>
        mpbMm=[mpbMm;mpbM]; %#ok<AGROW>
        mpbmm=[mpbmm;mpbm]; %#ok<AGROW>
        fm=[fm;fuelav];     %#ok<AGROW>
    end
    k=k+1;
end

ArcjetMass=1.58;                    % kg
PCUMass=15.8;                       % kg
RelayMass=2.2;                      % kg
BatteryMass=22.8;                   % kg
MREMass=0.6;                        % kg
ExtraFuelMass=mARC-fm(1,1)*1.25;    % kg
MassChange=ArcjetMass*8+PCUMass+RelayMass*2+BatteryMass-MREMass*8-ExtraFuelMass; % kg

nLTg=fm(1,1)*1.5/(mpbM*abpy); % New lifetime goal (years) keeping 50% of unneeded fuel


%% Results

disp(sprintf('Delta V budget per year =                                   %.2f m/s',dVbud_py))
disp(sprintf('Delta V budget per burn at avg number of burns per year =   %.2f cm/s',dVbud_pb*100))
disp(sprintf('Maximum burns per year at maximum delta V per burn =        %.2f burns',min(bpy)))
disp(sprintf('Fuel available per burn at maximum thrust and burn time =   %.2f g',mpbMm(1,1)*10^3))
disp(sprintf('Total fuel available for arcjets =                          %.1f kg',mARC))
disp(sprintf('Total fuel needed for de-sat events (at max thrust) =       %.2f kg',fm(1,1)))
disp(sprintf('Unneccessary fuel (S.F. of 1.25) =                          %.2f kg',ExtraFuelMass))
disp(sprintf('Total mass change for MRE to Arcjet conversion =            %.2f kg',MassChange))
disp(sprintf('New lifetime goal keeping half of unecessary fuel mass =    %.2f years',nLTg))

%% Plots

figure(1)
plot(Ft*10^3,tb/60)
xlim([min(Ft)*10^3,max(Ft)*10^3])
xlabel('Thrust (mN)')
ylabel('Burn Time (min)')
title('Thrust vs Burn Time Based on Delta V Budget per Burn')

figure(2)
plot(Ft*10^3,mdotm(1,:)*6*10^4,Ft*10^3,mdotm(2,:)*6*10^4)
xlim([min(Ft)*10^3,max(Ft)*10^3])
xlabel('Thrust (mN)')
ylabel('Mass Flow Rate (grams/min)')
title('Thrust vs Mass Flow Rate for Various Levels of Isp')
legend({'min Isp','max Isp'},'Location','southeast')

figure(3)
plot(dV*100,bpy)
xlabel('Delta V per Burn (cm/s)')
ylabel('Burns per Year')
title('Delta V Needed vs Burns Available per Year')

figure(4)
plot(dV*100,bpy)
xlim([dVbud_pb*100,max(dV)*100])
ylim([0,100])
xlabel('Delta V per Burn (cm/s)')
ylabel('Burns per Year')
title('Delta V Needed vs Burns Available per Year')

