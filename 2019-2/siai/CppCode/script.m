clear
clc
close all
posDesejada = 25;
kp = 3.75;
ki = 2.25229;
kd = 1.0929;
limInferior =22.5;
limSuperior =27.5;
pid = sim('PID.slx')
posfinal.getdatasamples(size(pid,1))
tempo = pid(size(pid,1))
