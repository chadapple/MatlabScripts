t_signal=0:0.0001:1;
y_signal=sin(t_signal*2*pi*50);

t_800 = t_signal(1:12:length(t_signal));
y_800 = y_signal(1:12:length(y_signal));

sys = tf(2*pi*2, [1 2*pi*2]);
dig_800 = c2d(sys, 0.00125);
dig_20 = c2d(sys, 0.05);
dig_10 = c2d(sys, 0.1);

bode(sys, dig_800, dig_20, dig_10, (0.1*2*pi):0.01:(10*2*pi));
title('Transfer function comparison of single pole unity gain 5 Hz system');
legend('Continuous time domain',...
       'Discrete time at 800 Hz sampling rate',...
       'Discrete time at 20 Hz sampling rate',...
       'Discrete time at 10 Hz sampling rate');

%plot(t_signal, y_signal, t_800, y_800)
