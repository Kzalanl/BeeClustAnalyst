function PlotHB()
    data = {{};{}};
    disp(data);
    x = {1 2 3 4};
    y = {1 2 3 4};
    data{1} = [data{1}, x];
    data{2} = [data{2}, y];
    x = {5 6};
    y = {5 6};
    data{1} = [data{1}, x];
    data{2} = [data{2}, y];
    
    xP =[];
    yP =[];
    xP = cell2mat(data{1,:});
    yP = cell2mat(data{2,:});
    scatter(xP, yP);
%     figure(1)
%     cellfun(@(x) scatter(x(1,:), x(2,:)), data);
%     grid
end

