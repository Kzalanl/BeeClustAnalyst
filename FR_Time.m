pmask = (swarm(:,2) == 2400 | swarm(:,2) == 600);
% [time TPassed PopN iter]
stableSwarm = swarm(pmask,[2 3 5 8]);

% Subtract free roaming time at 600 from 2400
% [TPassed PopN iter]
fRoam = [stableSwarm(stableSwarm(:,1) == 2400,2) - stableSwarm(stableSwarm(:,1) == 600,2),...
    stableSwarm(stableSwarm(:,1) == 600,[3 4])];
% Each column is the sum of free-roaming time of the whole swarm
NOfSwarm = swarm(:, 5);
NOfSwarm = unique(NOfSwarm, 'rows');
s=zeros(10, length(NOfSwarm));
for i = 1:length(fRoam)
    popIndex = find(NOfSwarm==fRoam(i, 2));
    s(fRoam(i, 3), popIndex) = s(fRoam(i, 3), popIndex) + fRoam(i, 1);
end

y=reshape(s, 1, []);
pop = [];
for i = 1:length(NOfSwarm)
    for j=1:10
        pop( 10*(i-1)+j )=NOfSwarm(i);
    end
end

for i=1:length(NOfSwarm)
    NOfSwarm(i,2) = mean( s(:,i))./NOfSwarm(i,1)/1800;
    NOfSwarm(i,3) =  std( s(:,i))./NOfSwarm(i,1)/1800;
end

% f1=figure;
% scatter(pop, y./pop/1800, 'x');
% hold on;
% ax=gca;
% ax.Box='on';
% ax.FontSize=12;
% ax.XLimMode = 'manual';
% ax.ZLimMode = 'manual';
% ax.XLim = [0 700];
% ax.YLim = [0 1];
% ax.LineWidth = 1.2;
% f1.Color=[1 1 1];
% errorbar(NOfSwarm(:,1), NOfSwarm(:,2), NOfSwarm(:,3), 'o--');
% hold off;
% legend('Swarm in one simulation', 'Average of ten simulations')
% xlabel('Population size, n_s_w'); 
% ylabel('Free-roaming time of swarm') ;
% grid on;

% Plots the distribution of free-roaming time among robots
Start = 600;
End = 2400;
pmask = (swarm(:,2) == End | swarm(:,2) == Start);
% [time TPassed PopN iter]
stableSwarm = swarm(pmask,[2 3 5 8]);
% Subtract free roaming time at End from Start
% [TPassed PopN iter speed rSense]
fRoam = [stableSwarm(stableSwarm(:,1) == End,2) - stableSwarm(stableSwarm(:,1) == Start,2),...
    stableSwarm(stableSwarm(:,1) == Start,[3 4])];

f2=figure;
% Select populations here in 'pops'
pops=[600];
for p=1:length(pops)
%     ax = subplot(1,3,p);
    y = fRoam( fRoam(:,2) == pops(p), 1);
    histogram(y(:)./(End-Start),[0:0.02:1], 'Normalization','probability');
    x1 = xline(mean(y)/(End-Start),'-'..., num2str(mean(y)/(End-Start),'%.2f')
        , 'Color', 'g', 'LineWidth', 2);
    ax=gca;
    ax.LineWidth = 0.8;
    ax.FontSize=14;
    if p == 1
        ylabel('Probability density') ;
    end
    if p==2
        xlabel('Recorded free-roaming time'); 
    end
end
f2.Color=[1 1 1];
