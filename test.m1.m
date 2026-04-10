clc; clear; close all;
Test du modèle;

t_exp = [0 10 20 30 60 120 240 480 960];
Mt_exp = [0 0.12 0.2 0.28 0.4 0.55 0.7 0.85 0.95];

a = 100e-6;
N_terms = 20;

model_fun = @(D, t) moisture_model(a, D, t, N_terms);

disp('Test du modèle :')
disp(model_fun(1e-10, t_exp(:)))

error_fun = @(D) sum((Mt_exp(:) - model_fun(D, t_exp(:))).^2);

options = optimset('Display','iter');

D_opt = fminsearch(error_fun, 1e-10, options);

fprintf('D = %.3e m^2/s\n', D_opt);

t_fit = linspace(0, max(t_exp), 200);
Mt_fit = model_fun(D_opt, t_fit(:));

figure;
plot(t_exp, Mt_exp, 'ro'); hold on;
plot(t_fit, Mt_fit, 'b-');
grid on;