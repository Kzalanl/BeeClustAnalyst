function m = countAgg()

data = fopen('C:\Users\Kiszli\Desktop\Honeybee\Results\BeeClust_12-11-20_T101010.txt');

acc_min=0.25;
m={};
bb={};
indexTime=0;
sum = 0;
line=fgetl(data);
line=fgetl(data);

line=fgetl(data);

while(ischar(line) && indexTime < 1500)
    numIndex = regexp(line,'\t');
    
    Time =      str2num(line(2              :numIndex(2)));
    X =         str2num(line(numIndex(3)    :numIndex(4)));
    Y =         str2num(line(numIndex(4)    :numIndex(5)));
    mBounce =   str2num(line(numIndex(5)    :numIndex(6)));
    mAcc =      str2num(line(numIndex(6)    :size(line,2)));
    
    timeNow = round(Time);
    if indexTime < timeNow
        mMean = 0;
        if size(bb)
            mMean = mean(bb{1});
        end
        clear bb;
        bb={};
        
        m=[m; mMean];
        sum=0;
        indexTime=timeNow;
    end
    if isAggr(X,Y)
        sum = sum + 1;
    end
    if mAcc > acc_min
        bb = [bb; mBounce];
    end
    line=fgetl(data);
end

fclose(data);
