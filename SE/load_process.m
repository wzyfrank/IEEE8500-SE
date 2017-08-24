function load_perturbed = load_process()

loads = load('loads.mat');
loads = 1e-6 * loads.loads;
loads = transpose(loads);

len = length(loads);
load_perturbed = zeros(len, 1);
for i = 1:len
    if(real(loads(i)) > 500)
        sigma_load = 0.05;
    elseif(real(loads(i)) > 200 && real(loads(i)) <= 500)
        sigma_load = 0.1;        
    elseif(real(loads(i)) > 50 && real(loads(i)) <= 200)
        sigma_load = 0.2;        
    elseif(real(loads(i)) > 10 && real(loads(i)) <= 50)
        sigma_load = 0.3;        
    else
        sigma_load = 0.4;        
    end
    load_perturbed(i) = loads(i) * (1 + sigma_load * randn(1, 1));
end
