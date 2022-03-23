pmask = (swarm(:,2) == 2400 | swarm(:,2) ==600);
% [Time Tpassed NumCol PopN]
stableswarm = pmask.*swarm(:,[2 3 4 5]);
stableswarm = unique(stableswarm, 'rows', 'stable');
stableswarm = stableswarm(2:end,:);

pmask = stableswarm(:,1) == 600;
start = pmask.*stableswarm(:,[2 3 4]);
start = unique(start, 'rows', 'stable');
start = start([1:60, 62:end],:);

pmask = stableswarm(:,1) == 2400;
finish = pmask.*stableswarm(:,[2 3]);
finish = unique(finish, 'rows', 'stable');
finish = finish(2:end,:);

start(:, 1) = finish(:,1) - start(:,1);
start(:, 2) = finish(:,2) - start(:,2);
b = 0.2 + zeros(length(start),1);
color = [start(:,3)/600 b b];

scatter(start(:, 1), start(:,2), 15,color);
title('Collisions while free roaming with varying swarm sizes indicated by color');
xlabel('Free roaming time'); 
ylabel('Collisions while roaming');