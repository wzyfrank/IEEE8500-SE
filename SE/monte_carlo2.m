clear;
clc;

% load the voltage profile
V_PF = load('phasors.mat');
V_PF = V_PF.phasors;

% load the Zbus .mat file
Zbus = load('Zbus.mat');
Zbus = Zbus.Zbus;
Cbus = load('Cbus.mat');
Cbus = Cbus.Cbus;

Sub_measure = 1e-3 * [
4076.8 + 1j * 143.65
3926.6 + 1j * 221.37
3714.6 - 1j * 198.94
];

SREGXFMR_190_8593190_8593_measure = 1e-3 * [
1895.1 + 1j * 488.68
1703.5 + 1j * 452.12
1424.1 + 1j * 361.08
];

SREGXFMR_190_8581190_8581_measure = 1e-3 * [
2169 + 1j * 230.67
2202.7 + 1j * 265.49
1527.1 + 1j * 8.47
];

SREGXFMR_190_7361190_7361_measure = 1e-3 * [
564.2 - 1j * 172.13
677.11 - 1j * 130.93
597.21 - 1j * 173.99
];

% perturb power measurements
Sub_measure = Sub_measure .* (1 + 1e-3 * randn(3, 1));
SREGXFMR_190_8593190_8593_measure = SREGXFMR_190_8593190_8593_measure .* (1 + 1e-3 * randn(3, 1));
SREGXFMR_190_8581190_8581_measure = SREGXFMR_190_8581190_8581_measure .* (1 + 1e-3 * randn(3, 1));
SREGXFMR_190_7361190_7361_measure = SREGXFMR_190_7361190_7361_measure .* (1 + 1e-3 * randn(3, 1));

tic();
iter_num = 200;
error_vec = zeros(iter_num, 4);
parpool(4);

parfor k = 1:iter_num
    load_perturbed = load_process();
    phasors = ieee8500_SE2(load_perturbed, Sub_measure, SREGXFMR_190_8593190_8593_measure, SREGXFMR_190_8581190_8581_measure, SREGXFMR_190_7361190_7361_measure, Zbus, Cbus);
    %phasors = ieee8500_SE(load_perturbed, Sub_measure, Zbus, Cbus);
    [MAPE_error, RMSE_error, angle_MAE, angle_RMSE] = calErrors(V_PF, phasors);
    disp([MAPE_error, RMSE_error, angle_MAE, angle_RMSE]);
%     error_vec(k,1) = MAPE_error;
%     error_vec(k,2) = RMSE_error;
%     error_vec(k,3) = angle_MAE;
%     error_vec(k,4) = angle_RMSE;
end
delete(gcp);
toc();