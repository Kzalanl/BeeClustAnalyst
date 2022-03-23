Hitcount = zeros(10, 9);
NOfSwarm = swarm(:, 5);
NOfSwarm = unique(NOfSwarm, 'rows');
StartT = 1;
EndT = 150;
pmask = (swarm(:, 2) == StartT) | (swarm(:, 2) == EndT);
% [time, hits, pop, iter]
pswarm = swarm(pmask, [2 4 5 8]);


for i = 1:length(pswarm)
    popIndex = find(NOfSwarm==pswarm(i, 3));
    if pswarm(i, 1) == StartT
        Hitcount(pswarm(i, 4), popIndex) = Hitcount(pswarm(i, 4), popIndex)...
            - pswarm(i, 2);
    else
        Hitcount(pswarm(i, 4), popIndex) = Hitcount(pswarm(i, 4), popIndex)...
            + pswarm(i, 2);
    end
end


HC=reshape(Hitcount, [], 1);
pop = [];
for i = 1:length(NOfSwarm)
    for j=1:10
        pop( 10*(i-1)+j )=NOfSwarm(i);
    end
end

pmask = (swarm(:,2) == 2400 & swarm(:,1) ==1);
% [PopN Na iter]
Na = swarm(pmask,[5 6 8]);
Na = sortrows(Na, [1 3]);
% mean and std for errorbars
for i=1:length(NOfSwarm)
    nf=Na(:,1)==NOfSwarm(i);
    nf=NOfSwarm(i)-mean(Na(nf, 2));
%     NOfSwarm(i,2) = mean( Hitcount(:,i)./nf );
%     NOfSwarm(i,3) = std( Hitcount(:,i)./nf );
    NOfSwarm(i,2) = mean( Hitcount(:,i)./NOfSwarm(i) );
    NOfSwarm(i,3) = std( Hitcount(:,i)./NOfSwarm(i) );
end
% exclude 800 pops if exists
HC=HC(1:80);
pop=pop(1:80);

f=figure;
% scatter(pop, HC./(Na(:,1)-Na(:,2)), 50,'x')
scatter(pop, HC./Na(:,1), 50,'x')
hold on
errorbar(NOfSwarm(:,1), NOfSwarm(:,2), NOfSwarm(:,3), 'o--');
xlabel('Population size, n_s_w');
ylabel('Number of collisions for one robot');
grid on
legend('Number of collisions in swarm', 'Mean and standard deviation of ten simulation')
ax=gca;
ax.FontSize=12;
ax.XLimMode = 'manual';
ax.XLim = [0 700];
ax.LineWidth = 1.2;
ax.Box='on';
f.Color=[1 1 1];
