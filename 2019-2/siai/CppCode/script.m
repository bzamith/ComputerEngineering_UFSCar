clear
clc
close all
posDesejada = 100;
kp = 19.1119;
ki = 2.15527;
kd = 1.0573;
limInferior =90;
limSuperior =110;
pid = sim('PID.slx')
posfinal.getdatasamples(size(pid,1))
tempo = pid(size(pid,1))
