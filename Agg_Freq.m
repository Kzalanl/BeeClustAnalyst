function XnY = fileRead()

data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T045237.txt');

Times = [];
IDs = [];
Aggs = [];
rowIndex = 1;

% Number of aggregated bees 
indexTime=0;

line=fgetl(data);
line=fgetl(data);
% Size of swarm
ns = str2num(line);
line=fgetl(data);
CueR = str2num(line);
line=fgetl(data);
while(ischar(line) )
    
    if line == "----"
%         XnY = Sample(XnY, SwarmTable, 6, 50);
        break;
    end
    
    numIndex = regexp(line,',');
    
    Time =   1 + round(str2num(line(1              :numIndex(1))));
    X =                str2num(line(numIndex(2)    :numIndex(3)));
    Y =                str2num(line(numIndex(3)    :numIndex(4)));
    mBounce =          str2num(line(numIndex(4)    :numIndex(5)));
    mTime =            str2num(line(numIndex(5)    :size(line,2)));
        
    numIndex = regexp(line,'Bee');
    id = 1 + int16(str2num(line(numIndex+3   :numIndex+5)));
%     BeeMoment.aggr = isAggr(X,Y); 

%     SwarmTable{Time,id} = BeeMoment;
    Times(rowIndex) = Time;
    IDs(rowIndex) = id;
    Aggs(rowIndex) = isAggr(X,Y);
    rowIndex = rowIndex+1;
    
    disp('Line');
    line=fgetl(data);
end
fclose(data);

T = table(Times',IDs',Aggs');
filename = 'AggregationTable.xlsx';
writetable(T,filename)
