%% Plant Transfer Function
G = tf(2, [50 1]);     % 2/(50s + 1)

%% ----------------- P Controller -----------------
Kp = 1; Ki = 0; Kd = 0;
C_P = pid(Kp, Ki, Kd);

T_P = feedback(C_P * G, 1);    % closed-loop
[yP, tP] = step(T_P);

infoP = stepinfo(yP, tP);
disp('---- P Controller ----');
disp(infoP);


%% ----------------- PI Controller -----------------
Kp = 1; Ki = 0.5; Kd = 0;
C_PI = pid(Kp, Ki, Kd);

T_PI = feedback(C_PI * G, 1);
[yPI, tPI] = step(T_PI);

infoPI = stepinfo(yPI, tPI);
disp('---- PI Controller ----');
disp(infoPI);


%% ----------------- PID Controller -----------------
Kp = 1; Ki = 0.5; Kd = 1;
C_PID = pid(Kp, Ki, Kd);

T_PID = feedback(C_PID * G, 1);
[yPID, tPID] = step(T_PID);

infoPID = stepinfo(yPID, tPID);
disp('---- PID Controller ----');
disp(infoPID);


%% Plot all responses
figure;
step(T_P, T_PI, T_PID);
legend('P','PI','PID');
title('Step Responses of P, PI, PID Controllers');
grid on;
