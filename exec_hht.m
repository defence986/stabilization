function new_trace = exec_hht(x,Ts)

% Get HHT.
imf = emd(x);

M = length(imf);
for k = 1:M
   %fprintf('*********************\n');
   %imf{k}
   %fprintf('*********************\n');
   b(k) = sum(imf{k}.*imf{k});
   th   = angle(hilbert(imf{k})); % 相位
   d{k} = diff(th)/Ts/(2*pi); % 瞬时频率
   %b(k)
   %th
   %d{k}
end

% for k = 1:M
%     fre(k) = sum(d{k}.*d{k});
% end
for k = 1:M
    D(k) = std(d{k}, 0, 2);
end
[vars,indx] = sort(-D);

% [u,v] = sort(-fre);
round(M/2)
indx(1)
for k = indx(1:round(M/2))
    imf{k} = imf{k}/20;
end
new_trace = 0;
for k = 1:M
    new_trace = imf{k} + new_trace;
end
%new_trace
%plot(new_trace);

if 0
[u,v] = sort(-b);
b     = 1-b/max(b); % 后面绘图的亮度控制
%b
% Set time-frequency plots.
N = length(x);
c = linspace(0,(N-2)*Ts,N-1);

if 0
for k = v(1:length(imf))
%for k = v(1:2) % 显示能量最大的两个IMF的瞬时频率
   b([k k k])
   figure, plot(c,d{k},'k.','Color',b([k k k]),'MarkerSize',3);
   set(gca,'FontSize',8,'XLim',[0 c(end)],'YLim',[0 1/2/Ts]); xlabel('Time'), ylabel('Frequency');
   title(sprintf('IMF%d', k))
end
end

M = length(imf);
for k1 = 0:4:M-1
    figure
    for k2 = 1:min(4,M-k1)
    %for k = v(1:2) % 显示能量最大的两个IMF的瞬时频率
        k = v(k1+k2);
        %b([k k k])
        subplot(4,1,k2);
        %plot(c,d{k},'k.','Color',b([k k k]),'MarkerSize',3);
        plot(c,d{k},'k.','MarkerSize',3);
        set(gca,'FontSize',8,'XLim',[0 c(end)],'YLim',[0 1/3/Ts]);
        ylabel('Frequency');
        title(sprintf('IMF%d', k))
    end
    xlabel('Time');
end

% Set IMF plots.
M = length(imf);
N = length(x);
c = linspace(0,(N-1)*Ts,N);
for k1 = 0:4:M-1
   figure
   for k2 = 1:min(4,M-k1)
       subplot(4,1,k2);
       plot(c,imf{k1+k2});
       set(gca,'FontSize',8,'XLim',[0 c(end)]); 
       title(sprintf('第%d个IMF', k1+k2));
       ylabel(sprintf('IMF%d', k1+k2));
   end
   xlabel('Time');
   
end
end
