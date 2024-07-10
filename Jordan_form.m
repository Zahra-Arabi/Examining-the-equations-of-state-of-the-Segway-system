% تعریف پارامترهای سیستم
M = 1;  % جرم بدنه
m = 0.1;  % جرم چرخ
l = 0.5;  % فاصله مرکز جرم بدنه تا محور چرخ
I = 0.006;  % ممان اینرسی بدنه حول مرکز جرم
g = 9.81;  % شتاب گرانش

% ماتریس‌های سیستم خطی شده
A = [0, 1, 0, 0;  0, 0, m*l/(M+m), 0;  0, 0, 0, 1; 0, 0, (M+m)*g/(I + m*l^2), 0];

B = [0; 1/(M+m); 0; -m*l/((M+m)*(I + m*l^2))];

C = [1, 0, 0, 0; 0, 0, 1, 0];

D = [0; 0];


% Convert to controllable canonical form (Jordan form)
[A_jordan, T] = jordan(A);

% Display the Jordan form and transformation matrix T
disp('Jordan form of A:');
disp(A_jordan);

disp('Transformation matrix T:');
disp(T);

