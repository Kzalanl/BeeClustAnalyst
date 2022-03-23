data = fopen('C:\Users\Zalán\Desktop\Honeybee\Results\BeeClust_Long_18-03-21_T022958.txt');

line=fgetl(data);
line=fgetl(data);
% Size of swarm
ns = str2num(line);
line=fgetl(data);
CueR = str2num(line);
line=fgetl(data);

    rowIndex=1;

    ID=[];
    Time=[];
    TPassed=[];
    NumCol=[];
    PopN=[];
    Na=[];
    Agg=[];
    Run=[];
indexTime=0;
AgSum = 0;
run=1;

while(ischar(line) )
    
    if line == "----"
        Na(rowIndex-ns:rowIndex-1)=AgSum;
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
    
    AgSum = AgSum + Agg(rowIndex);
    
    rowIndex = rowIndex+1;
    
    
    line=fgetl(data);
end
Na(rowIndex-ns:rowIndex-1)=AgSum;

fclose(data);

if isempty(longSwarm)
    longSwarm=[ID', Time', TPassed', NumCol', PopN', Na', Agg', Run'];
else
    longSwarm=[[longSwarm(:,1); ID'], [longSwarm(:,2); Time'], [longSwarm(:,3); TPassed'], [longSwarm(:,4); NumCol'],...
    [longSwarm(:,5); PopN'], [longSwarm(:,6); Na'], [longSwarm(:,7); Agg'], [longSwarm(:,8); Run']];
end