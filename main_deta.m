%% ģ�����
N = 11000000;
global beta gamma 
Beta = 0.113/N;
Gamma = 0.0337;
Beta = 0.38/N;
Gamma = 0.07;
% Beta = 0.107/N;
% Gamma = 0.02778;

% ��һ�׶�
beta = Beta;gamma = Gamma;
Y1 = [0 N 572 70];y = [N 572 70];
for i = 1:1:8
    dy=func_SIR(y);
    y = y+dy';
    Y1 = [Y1;[i,y]];
end
Y1(:,1) = Y1(:,1)+24;
% �ڶ��׶�
beta = Beta*0.8;      % ��Ⱦ��/��
Y2 = [0 Y1(end,2) Y1(end,3) Y1(end,4)];y = [Y1(end,2) Y1(end,3) Y1(end,4)];
for i = 1:1:2
    dy=func_SIR(y);
    y = y+dy';
    Y2 = [Y2;[i,y]];
end
Y2(:,1) = Y2(:,1)+24+8;
% �����׶�
beta = Beta*0.5;      % ��Ⱦ��/��
Y3 = [0 Y2(end,2) Y2(end,3) Y2(end,4)];y = [Y2(end,2) Y2(end,3) Y2(end,4)];
for i = 1:1:2
    dy=func_SIR(y);
    y = y+dy';
    Y3 = [Y3;[i,y]];
end
Y3(:,1) = Y3(:,1)+24+10;
% ���Ľ׶�
beta = Beta*0.05 ;     % ��Ⱦ��/��
Y4 = [0 Y3(end,2) Y3(end,3) Y3(end,4)];y = [Y3(end,2) Y3(end,3) Y3(end,4)];
for i = 1:1:20
    dy=func_SIR(y);
    y = y+dy';
    Y4 = [Y4;[i,y]];
end
Y4(:,1) = Y4(:,1)+24+12;
Y= [Y1;Y2;Y3;Y4];

%% ��ͼ
figure(1);
xlabel('t/ ��');
ylabel('I/ ����');
hold on;grid minor;
% plot(Y(:,1),Y(:,2),'LineWidth',2);
plot(Y(:,1)+1,Y(:,3),'LineWidth',2);
% legend('60%������','70%������','80%������','90%������','95%������');
% plot(Y(:,1)+1,Y(:,4),'LineWidth',2);
% legend('I-���ڻ�������','R-��������+��������');
% figure(2);
% beta = mean(data.beta(2:end));
% xlabel('%/ ������');
% ylabel('R0');
% hold on;grid minor;
% x = [0:0.01:1];
% y = beta*data.S(1)*(1-x)/gamma;
% plot(x,y);