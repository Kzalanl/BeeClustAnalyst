StartT=600;
EndT=2400;
% [Time Tpassed NumCol PopN]
stableswarm = swarm((swarm(:,2) == EndT | swarm(:,2) ==StartT),[2 3 4 5]);
% Selects data at time EndT
% [Tpassed NumCol PopN]
nOverTpassed = stableswarm(stableswarm(:,1) == EndT,[2 3 4]);
% Selects data at time StartT
% [Tpassed NumCol]
startState = stableswarm(stableswarm(:,1) == 600,[2 3]);
% Compares counter values between EndT - StartT
nOverTpassed(:, 1) = nOverTpassed(:,1) - startState(:,1);
nOverTpassed(:, 2) = nOverTpassed(:,2) - startState(:,2);

% Plots collisions against free-roaming time for the whole swarm
% Fits curve on data and shows the slope
for p=[60 350]
    xy = nOverTpassed(nOverTpassed(:,3) == p,[1 2]); 
    x=xy(:,1)/(EndT-StartT);
    y=xy(:,2);
    f = figure;
    [curvefit, gof, output] = fit(x,y,'poly1');
    plt = plot(curvefit, x, y);
%     xlabel('Free-roaming time (sec)');
%     ylabel('Number of collisions');
%     legend(join([num2str(p), "Robots"]), join(["Fitted slope: ", num2str(curvefit.p1)]))
    grid on
    ax=gca;
    set(ax,'YTickLabel',[]);
    set(ax,'YLabel',[]);
    set(ax,'XLabel',[]);
    set(ax,'XTickLabel',[]);
    ax.YLim=[0 200];
    ax.XLim=[0 1];
    ax.FontSize=12;
    ax.LineWidth = 1.2;
    ax.Legend.Visible='off';
%     ax.Legend.Location = 'northwest';
    f.Color=[1 1 1];
end

% % Error histogram
% f2 = figure;
% h = histogram(output.residuals,40);
% xlabel('Magnitude of error');
% ylabel('Occurance of error');
% ax=gca;
% ax.FontSize=12;
% ax.LineWidth = 1.2;
% f2.Color=[1 1 1];
