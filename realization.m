s = tf('s');
mysys = [(0.006* s^2-0.4905)/(0.006* s^4 +1.1* s^2+0.4905)  (0.05* s)/(0.006* s^4 +1.1 *s^2+0.4905)  ;
    (0.4905 *s^2)/(0.006* s^4+1.1 *s^2+0.4905) (0.05* s^2)/(0.006* s^4+1.1* s^2+0.4905)];
myss = minreal(ss(mysys));

% نمایش ماتریس تحقق
disp('Minimal realization of mysys:');
disp(myss);

% نمایش ویژگی‌های سیستم
disp('System properties:');
disp('InputName:');
disp(myss.InputName);
disp('OutputName:');
disp(myss.OutputName);
disp('A Matrix:');
disp(myss.A);
disp('B Matrix:');
disp(myss.B);
disp('C Matrix:');
disp(myss.C);
disp('D Matrix:');
disp(myss.D);

