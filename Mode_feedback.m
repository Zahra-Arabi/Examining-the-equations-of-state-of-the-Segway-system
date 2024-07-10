
M = 1;  % جرم بدنه
m = 0.1;  % جرم چرخ
l = 0.5;  % فاصله مرکز جرم بدنه تا محور چرخ
I = 0.006;  % ممان اینرسی بدنه حول مرکز جرم
g = 9.81;  % شتاب گرانش

A = [0, 1, 0, 0;  0, 0, m*l/(M+m), 0;  0, 0, 0, 1; 0, 0, (M+m)*g/(I + m*l^2), 0];
B = [0; 1/(M+m); 0; -m*l/((M+m)*(I + m*l^2))];
C = [1, 0, 0, 0; 0, 0, 1, 0];
D = [0; 0];
p1 = -0.84 + 1.12i;
p2 = -0.84 - 1.12i;
p3 = -3;
p4 = -4;
K = place(A, B, [p1 p2 p3 p4]);
Acl = A - B * K;
Bcl = B;
Ccl = C;
Dcl = D;

sys_cl = ss(Acl, Bcl, Ccl, Dcl);
t = 0:0.01:10;
u = ones(size(t)); % ورودی پله واحد
[y, t, x] = lsim(sys_cl, u, t);

% رسم پاسخ زمانی
plot(t, y);
xlabel('Time (s)');
ylabel('Response');
title('Closed-Loop System Response');
grid on;

% محاسبه معیارهای عملکردی
info = stepinfo(y, t);
Ts = info.SettlingTime;
OS = info.Overshoot;
disp(OS);
disp(Ts);
