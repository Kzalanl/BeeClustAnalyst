function XnY = fileRead()

data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T045237.txt');

mBounce=0;
mTime=0;
SwarmTable={};
% % XnY ={{};{}};

% Number of aggregated bees 
indexTime=0;

line=fgetl(data);
line=fgetl(data);
% Size of swarm
ns = str2num(line);
line=fgetl(data);

while(ischar(line) )
    
    if line == "----"
        XnY = Sample(XnY, SwarmTable, 6, 50);
        SwarmTable={};
        disp(SwarmTable);
        line=fgetl(data);
    end
    
    numIndex = regexp(line,',');
    
    Time =   1 + round(str2num(line(1              :numIndex(1))));
    X =                str2num(line(numIndex(2)    :numIndex(3)));
    Y =                str2num(line(numIndex(3)    :numIndex(4)));
    mBounce =          str2num(line(numIndex(4)    :numIndex(5)));
    mTime =            str2num(line(numIndex(5)    :size(line,2)));
        
    numIndex = regexp(line,'Bee');
    id = 1 + int16(str2num(line(numIndex+3   :numIndex+5)));
%     Table contains Time X BeeId cells
%     Each cell is a BeeMoment struct with aggr, mbounce and mtime values
    BeeMoment.aggr = isAggr(X,Y); 
    BeeMoment.mbounce = mBounce;
    BeeMoment.mtime = mTime;
    
    SwarmTable{Time,id} = BeeMoment;
    
    timeNow = round(Time);
    if indexTime < timeNow
        indexTime=timeNow;
    end
    line=fgetl(data);
end
fclose(data);

XnY = Sample(XnY, SwarmTable, 6, 50);
% x = cell2mat(XnY{1,:});
% y = cell2mat(XnY{2,:});
% figure(1)
% scatter(x, y)
% grid
% lsline
% grid
