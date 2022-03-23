


f2 = figure;
pmask=longSwarm(:,1)==1;
bee= longSwarm(pmask,:);
% Look at Na after 600s
Time= 600;
pmask = bee(:,2) >= Time;
bee=bee(pmask,:);
% Stored pops are [150 300 450]
pops=[150];
for p=pops
%     [Time Na iters] iterations then plots them
    pmask = bee(:,5) == p;
    bs = bee(pmask,[2 6 8] );
    for i=1:1
        plot(bs(bs(:,3)==i,1), bs(bs(:,3)==i,2))
        hold on;
    end
end