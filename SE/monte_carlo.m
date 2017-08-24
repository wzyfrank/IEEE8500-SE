clear;
clc;

% load the voltage profile
V_PF = csvread('F:\Onedrive\code\SE\Sym. SDP\37node\voltage PF.csv', 0, 0);

% the standard deviation of sigma for load measurements
sigma_load = 0.2;

iter_num = 1000;
load_vec = zeros(iter_num, 1);
error_vec = zeros(iter_num, 4);

for k = 1:iter_num
    disp(k);
    [load_MAPE, MAPE_error, RMSE_error, angle_MAE, angle_RMSE, phasors] = SE_header(V_PF, sigma_load);
    load_vec(k) = load_MAPE;
    error_vec(k, :) = [MAPE_error, RMSE_error, angle_MAE, angle_RMSE];
end