% تعریف پارامترهای سیستم
M = 1;  % جرم بدنه
m = 0.1;  % جرم چرخ
l = 0.5;  % فاصله مرکز جرم بدنه تا محور چرخ
I = 0.006;  % ممان اینرسی بدنه حول مرکز جرم
g = 9.81;  % شتاب گرانش

% ماتریس‌های سیستم خطی شده
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

% بررسی پایداری لیاپانوف
eigenvalues = eig(A);
if all(real(eigenvalues) < 0)
    disp('سیستم پایدار است (بر اساس پایداری لیاپانوف).');
else
    disp('سیستم ناپایدار است (بر اساس پایداری لیاپانوف).');
end

% بررسی پایداری داخلی
if all(real(eigenvalues) < 0)
    disp('سیستم داخلاً پایدار است (بر اساس پایداری داخلی).');
else
    disp('سیستم داخلاً ناپایدار است (بر اساس پایداری داخلی).');
end

% بررسی پایداری BIBO
[num, den] = ss2tf(A, B, C, D);

% تبدیل سیستم به تابع تبدیل و بررسی پایداری BIBO
isBIBOStable = true;
for i = 1:size(num, 1)
    for j = 1:size(num, 2)
        sys_ij = tf(num(i, j, :), den);
        if ~isstable(sys_ij)
            isBIBOStable = false;
            break;
        end
    end
    if ~isBIBOStable
        break;
    end
end

if isBIBOStable
    disp('سیستم BIBO پایدار است.');
else
    disp('سیستم BIBO ناپایدار است.');
end
