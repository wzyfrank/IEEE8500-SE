function [MAPE_error, RMSE_error, angle_MAE, angle_RMSE] = calErrors(V_PF, phasors);
% the errors (MAPE and RMSE) of state estimation voltage resutls
N_bus = size(V_PF, 1);
MAPE_error = 0;
RMSE_error = 0;
voltage_count = 0;
angle_MAE = 0;
angle_RMSE = 0;

for k = 1:N_bus
    % Phase A
    if (V_PF(k, 1) > 0.5)
        RMSE_error = RMSE_error + (phasors(k, 1) - V_PF(k, 1)) ^2;
        MAPE_error = MAPE_error + abs(phasors(k, 1) - V_PF(k, 1));
        angle_MAE = angle_MAE + abs(phasors(k, 2) - V_PF(k, 2));
        angle_RMSE = angle_RMSE + (phasors(k, 2) - V_PF(k, 2)) ^2;
        voltage_count = voltage_count + 1;
    end
    % Phase B
    if (V_PF(k, 3) > 0.5)
        RMSE_error = RMSE_error + (phasors(k, 3) - V_PF(k, 3)) ^2;
        MAPE_error = MAPE_error + abs(phasors(k, 3) - V_PF(k, 3));
        angle_MAE = angle_MAE + abs(phasors(k, 4) - V_PF(k, 4));
        angle_RMSE = angle_RMSE + (phasors(k, 4) - V_PF(k, 4)) ^2;
        voltage_count = voltage_count + 1;
    end
    % Phase C
    if (V_PF(k, 5) > 0.5)
        RMSE_error = RMSE_error + (phasors(k, 5) - V_PF(k, 5)) ^2;
        MAPE_error = MAPE_error + abs(phasors(k, 5) - V_PF(k, 5));
        angle_MAE = angle_MAE + abs(phasors(k, 6) - V_PF(k, 6));
        angle_RMSE = angle_RMSE + (phasors(k, 6) - V_PF(k, 6)) ^2;
        voltage_count = voltage_count + 1;
    end
end

MAPE_error = MAPE_error / voltage_count;
RMSE_error = sqrt(RMSE_error / voltage_count);
angle_MAE = angle_MAE / voltage_count;
angle_RMSE = sqrt(angle_RMSE / voltage_count);