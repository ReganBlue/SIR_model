%% SIR模型
function dy=func_SIR(y)    %SIR模型定义 
global beta gamma
S = y(1);
I = y(2);
R = y(3);

dS = -beta*I*S;
dI =  beta*I*S - gamma*I;
dR =  gamma*I;
dy = [dS;dI;dR];
end
