% 收集到的数据
N = 11000000;
data_or = table([24;25;26],...
    [N;N;N],...
    [572;618;690],...
    [0;0;0],...
    [32;40;42],...
    [38;45;63],...
    'VariableNames',{'days','SIR_num','IR_num','I_uncertain','R_health','R_death'});
D = [];S = [];I = [];R = [];b = [0];g = [0];
for i = 1:3
    D = [D;data_or.days(i)];
    S = [S;data_or.SIR_num(i)-data_or.IR_num(i)-data_or.I_uncertain(i)*0.45];
    I = [I;data_or.IR_num(i)-data_or.R_health(i)-data_or.R_death(i)+data_or.I_uncertain(i)*0.45];
    R = [R;data_or.R_health(i)+data_or.R_death(i)];
    if i>1
        b = [b;(S(i-1)-S(i))/(I(i-1)*S(i-1))];
        g = [g;(R(i)-R(i-1))/I(i-1)];
    end
end
data = table(D,S,I,R,b,g,'VariableNames',{'Day','S','I','R','beta','gamma'});
clear data_or D S I R b g i
%% 模型拟合
global beta gamma 
beta = mean(data.beta(2:end));      % 感染率/天
gamma = mean(data.gamma(2:end));      % 抵抗率/天（治愈率/天+死亡率/天）
% 第一阶段
Y1 = [0 data.S(1) data.I(1) data.R(1)];y = [data.S(1) data.I(1) data.R(1)];
for i = 1:1:8
    dy=func_SIR(y);
    y = y+dy';
    Y1 = [Y1;[i,y]];
end
Y1(:,1) = Y1(:,1)+24;
% 第二阶段
beta = mean(data.beta(2:end))*0.8;      % 感染率/天
Y2 = [0 Y1(end,2) Y1(end,3) Y1(end,4)];y = [Y1(end,2) Y1(end,3) Y1(end,4)];
for i = 1:1:2
    dy=func_SIR(y);
    y = y+dy';
    Y2 = [Y2;[i,y]];
end
Y2(:,1) = Y2(:,1)+24+8;
% 第三阶段
beta = mean(data.beta(2:end))*0.5;      % 感染率/天
Y3 = [0 Y2(end,2) Y2(end,3) Y2(end,4)];y = [Y2(end,2) Y2(end,3) Y2(end,4)];
for i = 1:1:2
    dy=func_SIR(y);
    y = y+dy';
    Y3 = [Y3;[i,y]];
end
Y3(:,1) = Y3(:,1)+24+10;
% 第四阶段
beta = mean(data.beta(2:end))*0.05 ;     % 感染率/天
Y4 = [0 Y3(end,2) Y3(end,3) Y3(end,4)];y = [Y3(end,2) Y3(end,3) Y3(end,4)];
for i = 1:1:20
    dy=func_SIR(y);
    y = y+dy';
    Y4 = [Y4;[i,y]];
end
Y4(:,1) = Y4(:,1)+24+12;
Y= [Y1;Y2;Y3;Y4];

%% 绘图
% figure(1);
xlabel('t/ 天');
ylabel('I/ 人数');
hold on;grid minor;
% plot(Y(:,1),Y(:,2),'LineWidth',2);
plot(Y(:,1)+1,Y(:,3),'LineWidth',2);
% legend('60%被隔离','70%被隔离','80%被隔离','90%被隔离','95%被隔离');
plot(Y(:,1)+1,Y(:,4),'LineWidth',2);
legend('I-仍在患病人数','R-治愈人数+死亡人数');
figure(2);
beta = mean(data.beta(2:end));
xlabel('%/ 隔离率');
ylabel('R0');
hold on;grid minor;
x = [0:0.01:1];
y = beta*data.S(1)*(1-x)/gamma;
plot(x,y);