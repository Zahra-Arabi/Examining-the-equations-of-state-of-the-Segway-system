M = 1;  % جرم بدنه
m = 0.1;  % جرم چرخ
l = 0.5;  % فاصله مرکز جرم بدنه تا محور چرخ
I = 0.006;  % ممان اینرسی بدنه حول مرکز جرم
g = 9.81;  % شتاب گرانش

A = [0, 1, 0, 0;  
     0, 0, m*l/(M+m), 0;  
     0, 0, 0, 1; 
     0, 0, (M+m)*g/(I + m*l^2), 0];

B = [0; 
     1/(M+m); 
     0; 
     -m*l/((M+m)*(I + m*l^2))];

C = [1, 0, 0, 0; 
     0, 0, 1, 0];

D = [0; 0];
% بررسی قابل مشاهده بودن سیستم
observable = rank(obsv(A, C));

if observable == size(A, 1)
    disp('سیستم قابل مشاهده است');
else
    disp('سیستم قابل مشاهده نیست');
end

% جایابی قطب‌های رویتگر
poles = [-10, -11, -12, -13];
L = place(A', C', poles)';

% معادلات رویتگر
A_observer = A - L * C;
B_observer = [B, L];
C_observer = eye(size(A));
D_observer = zeros(size(A, 1), size(B, 2) + size(C, 1));

disp("ماتریس L:");
disp(L);

% نمایش ماتریس‌های رویتگر
disp('ماتریس A_observer:');
disp(A_observer);

disp('ماتریس B_observer:');
disp(B_observer);

disp('ماتریس C_observer:');
disp(C_observer);

disp('ماتریس D_observer:');
disp(D_observer);

% تقسیم سیستم به زیرسیستم‌های قابل مشاهده و غیر قابل مشاهده
A11 = A([1, 3], [1, 3]);
A12 = A([1, 3], [2, 4]);
A21 = A([2, 4], [1, 3]);
A22 = A([2, 4], [2, 4]);
B1 = B([1, 3]);
B2 = B([2, 4]);

% تعیین مکان‌های قطب‌های رویتگر کاهش یافته
reduced_poles = [-20, -21];

% محاسبه ماتریس L برای رویتگر کاهش یافته
L_reduced = place(A22', A12', reduced_poles)';

disp('ماتریس L برای رویتگر کاهش یافته:');
disp(L_reduced);

