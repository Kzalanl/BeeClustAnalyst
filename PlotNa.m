
data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T040948.txt');
SwarmTable={};
XnY ={{};{};{}};

indexTime=0;

line=fgetl(data);
line=fgetl(data);
% Size of swarm
ns = str2num(line);
line=fgetl(data);
line=fgetl(data);

while(ischar(line) )
    
    if line == "----"
        XnY = Sample(XnY, SwarmTable, ns);
        SwarmTable={};
        fclose(data);
        if ns == 60
            data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T043639.txt');
        end
        if ns == 80
            data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T045237.txt');
        end
        if ns == 100
            data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T054006.txt');
        end
        if ns == 120
            data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_24-11-20_T064038.txt');
        end
        if ns == 140
            break;
        end
        line=fgetl(data);
        line=fgetl(data);
        ns = str2num(line);
        line=fgetl(data);
        line=fgetl(data);
    end
    
    numIndex = regexp(line,',');
    
    Time =   1 + round(str2num(line(1              :numIndex(1))));
    X =                str2num(line(numIndex(2)    :numIndex(3)));
    Y =                str2num(line(numIndex(3)    :numIndex(4)));
        
    numIndex = regexp(line,'Bee');
    id = 1 + int16(str2num(line(numIndex+3   :numIndex+5)));
%     Table contains Time X BeeId cells
%     Each cell is a BeeMoment struct with aggr, mbounce and mtime values
    BeeMoment.aggr = isAggr(X,Y);
    
    SwarmTable{Time,id} = BeeMoment;
    
    timeNow = round(Time);
    if indexTime < timeNow
        indexTime=timeNow;
    end
    line=fgetl(data);
end

x = cell2mat(XnY{1,:});
y = cell2mat(XnY{2,:});
n = cell2mat(XnY{3,:});
isit60 = n == 60;
isit80 = n == 80;
isit100 = n == 100;
isit120 = n == 120;
isit140 = n == 140;
figure(1)
scatter(x(isit60), y(isit60), 'r', 'x');
hold on;
scatter(x(isit80), y(isit80), 'b', 'x');
hold on;
scatter(x(isit100), y(isit100), 'g', 'x');
hold on;
scatter(x(isit120), y(isit120), 'c', 'x');
hold on;
scatter(x(isit140), y(isit14), 'y', 'x');
hold off;
grid
% lsline


function XnY = Sample(XnY, SwarmTable, ns)
    for k=1:size(SwarmTable(:,1),1)-1
      na = Getna(SwarmTable(k,:));
      XnY{2} = [XnY{2}, na/ns];
      XnY{1} = [XnY{1}, k];
      XnY{3} = [XnY{3}, ns];
    end
    disp('Sample');
end

function na = Getna(SwarmMoment)
    na=0;
    for bee = SwarmMoment
        na = na + bee{1}.aggr;
    end
end
