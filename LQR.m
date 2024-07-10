% پارامترهای سیستم
M = 1;      % جرم بدنه
m = 0.1;    % جرم چرخ
l = 0.5;    % فاصله مرکز جرم بدنه تا محور چرخ
I = 0.006;  % ممان اینرسی بدنه حول مرکز جرم
g = 9.81;   % شتاب گرانش

% ماتریس‌های سیستم
A = [0, 1, 0, 0; 0, 0, m*l/(M+m), 0; 0, 0, 0, 1; 0, 0, (M+m)*g/(I + m*l^2), 0];
B = [0; 1/(M+m); 0; -m*l/((M+m)*(I + m*l^2))];
C = [1, 0, 0, 0; 0, 0, 1, 0];
D = [0; 0];

% تعریف ماتریس‌های وزنی برای LQR
q1 = 1;  % وزن برای خطای موقعیت
q2 = 1;  % وزن برای خطای سرعت
q3 = 10; % وزن برای خطای فراجهش
q4 = 10; % وزن برای خطای زاویه

r = 1;   % وزن برای ورودی کنترل

Q = diag([q1, q2, q3, q4]);
R = r;

% محاسبه کنترلر LQR
[K, ~, ~] = lqr(A, B, Q, R);

% ساخت سیستم حلقه بسته با کنترلر LQR
Acl = A - B * K;
Bcl = B;
Ccl = C;
Dcl = D;

sys_cl = ss(Acl, Bcl, Ccl, Dcl);

% شبیه‌سازی پاسخ زمانی سیستم
t = 0:0.01:10;
u = zeros(size(t)); % ورودی صفر (سیستم استوار)
[y, t, x] = lsim(sys_cl, u, t);

% رسم پاسخ زمانی
figure;
plot(t, y(:, 1), 'b', 'LineWidth', 2);
hold on;
plot(t, y(:, 2), 'r--', 'LineWidth', 2);
xlabel('زمان (ثانیه)');
ylabel('مقدار خروجی');
title('پاسخ زمانی سیستم با کنترل فیدبک حالت LQR');
legend('موقعیت', 'فراجهش', 'Location', 'Best');
grid on;

% محاسبه معیارهای عملکردی
info = stepinfo(sys_cl);
OS = info.Overshoot;
Ts = info.SettlingTime;
disp(['فراجهش: ', num2str(OS), '%']);
disp(['زمان نشست: ', num2str(Ts), ' ثانیه']);

% تحلیل تأثیر ضرایب ماتریس‌های وزنی بر عملکرد سیستم
q1_values = [1, 10, 100];
q2_values = [1, 10, 100];

figure;
for i = 1:length(q1_values)
    for j = 1:length(q2_values)
        Q = diag([q1_values(i), q2_values(j), q3, q4]);
        [K, ~, ~] = lqr(A, B, Q, R);
        
        Acl = A - B * K;
        sys_cl = ss(Acl, Bcl, Ccl, Dcl);
        
        info = stepinfo(sys_cl);
        OS = info.Overshoot;
        Ts = info.SettlingTime;
        
        subplot(length(q1_values), length(q2_values), (i-1)*length(q2_values) + j);
        plot(t, y(:, 1), 'b', 'LineWidth', 2);
        hold on;
        plot(t, y(:, 2), 'r--', 'LineWidth', 2);
        xlabel('زمان (ثانیه)');
        ylabel('مقدار خروجی');
        title(['Q = diag([', num2str(q1_values(i)), ', ', num2str(q2_values(j)), ', ', num2str(q3), ', ', num2str(q4), '])']);
        legend('موقعیت', 'فراجهش', 'Location', 'Best');
        grid on;
        
        disp(['Q = diag([', num2str(q1_values(i)), ', ', num2str(q2_values(j)), ', ', num2str(q3), ', ', num2str(q4), '])']);
        disp(['    فراجهش: ', num2str(OS), '%']);
        disp(['    زمان نشست: ', num2str(Ts), ' ثانیه']);
    end
end

