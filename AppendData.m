data = fopen('location.file.txt');
% Opens the file, reads all simulation data in empty array then attaches
% arrays to end of 'swarm' matrix
line=fgetl(data);...Empty line at start of file
line=fgetl(data);
ns = str2num(line);...Size of the swarm
line=fgetl(data);
CueR = str2num(line);...Diameter of the cue
line=fgetl(data);
% Arrays to store recorded variables
    rowIndex=1;
    ID=[];...Robot tags
    Time=[];...One set of data each second
    TPassed=[];...Free-roaming time
    NumCol=[];...Collision count
    PopN=[];...Population size
    Na=[];...Size of aggregate
    Agg=[];...Is the robot aggregated
    Run=[];...Iteration index of simulation
indexTime=0;
AgSum = 0;
run=1;...Each simulation has 10 runs

while(ischar(line) )
    if line == "----"
        Na(rowIndex-ns:rowIndex-1)=AgSum;...
        line=fgetl(data);
        run = run+1;
        indexTime=0;
        AgSum = 0;
    end
    numIndex = regexp(line,',');
    
    time =       round(str2num(line(1              :numIndex(1))));
    X =                str2num(line(numIndex(2)    :numIndex(3)));
    Y =                str2num(line(numIndex(3)    :numIndex(4)));
    mBounce =          str2num(line(numIndex(4)    :numIndex(5)));
    mTime =            str2num(line(numIndex(5)    :size(line,2)));
    timeNow = time;
%     Time incremented after all robots of the swarm are scanned
%     Aggregation size stored for the entire swarm
    if indexTime < timeNow
        Na(rowIndex-ns:rowIndex-1)=AgSum;
        AgSum = 0;
        indexTime=timeNow;
    end
    numIndex = regexp(line,'Bee');
    id = 1 + int16(str2num(line(numIndex+3   :numIndex+5)));
    Agg(rowIndex) = isAggr(X,Y); 
    ID(rowIndex) = id;
    Time(rowIndex) = time;
    TPassed(rowIndex) = mTime;
    NumCol(rowIndex) = mBounce;
    PopN(rowIndex) = ns;
    Run(rowIndex) = run;
%     If current robot is aggregated then aggregation size is incremented
    AgSum = AgSum + Agg(rowIndex);
    rowIndex = rowIndex+1;
        
    line=fgetl(data);
end
Na(rowIndex-ns:rowIndex-1)=AgSum;
fclose(data);
% New variable arrays are attached to the 'swarm' matrix that stores all
% simualtion data
if isempty(swarm)
    swarm=[ID', Time', TPassed', NumCol', PopN', Na', Agg', Run'];
else
    swarm=[[swarm(:,1); ID'], [swarm(:,2); Time'], [swarm(:,3); TPassed'], [swarm(:,4); NumCol'],...
    [swarm(:,5); PopN'], [swarm(:,6); Na'], [swarm(:,7); Agg'], [swarm(:,8); Run']];
end