clear
clc
close all
posDesejada = 100;
kp = 0.2934;
ki = 0.909602;
kd = 0.213687;
pid = sim('PID.slx')
posfinal.getdatasamples(size(pid,1))
tempo = pid(size(pid,1))
