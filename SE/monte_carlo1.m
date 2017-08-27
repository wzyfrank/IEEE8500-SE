clear;
clc;

% load the voltage profile
V_PF = load('phasors.mat');
V_PF = V_PF.phasors;

Sub_measure = 1e-3 * [
4076.8 + 143.65i
3926.6 + 221.37i
3714.6 - 198.94i
];

Sub_measure = Sub_measure .* (1 + 1e-3 * randn(3, 1));
tic();
iter_num = 12;
error_vec = zeros(iter_num, 4);
parpool(4);

parfor k = 1:iter_num
    %disp(k);
    load_perturbed = load_process();
    phasors = ieee8500_SE(load_perturbed, Sub_measure);
    [MAPE_error, RMSE_error, angle_MAE, angle_RMSE] = calErrors(V_PF, phasors);
%     error_vec(k,1) = MAPE_error;
%     error_vec(k,2) = RMSE_error;
%     error_vec(k,3) = angle_MAE;
%     error_vec(k,4) = angle_RMSE;
    disp([MAPE_error, RMSE_error, angle_MAE, angle_RMSE]);
end
delete(gcp);
toc();