% load('CollisionVariables.mat')
 TimeMask = PopN == 160;
 figure(1)
 scatter(NumColl, TPassed.*TimeMask)
 title('Population: 160')
 xlabel('Collision counter')
 ylabel('Free roaming time')