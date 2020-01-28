function dy=func_SEIR(~,y)
global alpha beta gamma
S = y(1);
E = y(2);
I = y(3);
R = y(4);

dS = -beta*I*S;
dE =  beta*S*I - (gamma + alpha)*E;
dI =  alpha*E - gamma*I;
dR = gamma*(E+I);
dy = [dS;dE;dI;dR];
end