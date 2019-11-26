clear
clc
close all
posDesejada = 25;
kp = 19.0251;
ki = 2.48394;
kd = 1.44081;
limInferior =22.5;
limSuperior =27.5;
pid = sim('PID.slx')
posfinal.getdatasamples(size(pid,1))
tempo = pid(size(pid,1))
