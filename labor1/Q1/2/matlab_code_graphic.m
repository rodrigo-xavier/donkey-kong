x=10:10:100;
y1=[0.00000728, 0.00001368, 0.00002008, 0.00002648, 0.00003288, 0.00003928, 0.00004568, 0.00005208, 0.00005848, 0.00006488];
y2=[0.00002258, 0.00008018, 0.00017378, 0.00030338, 0.00046898, 0.00067058, 0.00090818, 0.00118178, 0.00149138, 0.00183698];

%plot(y1,x,y2,x);
plot(x,y1,x,y2);

title('Gr�fico N x T');
xlabel('N Instru��es');
ylabel('Tempo');
grid on;