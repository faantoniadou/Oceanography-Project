function [] = maxtempcop(~)
%latitude = ncread('temp.nc','lat');
%longitude = ncread('temp.nc','lon');
temperature = ncread('temp.nc','votemper');

max_temp = [];
date_actual = [];
%plot sea surface temperature for every calendar month 
for i = 1:size(temperature,1)
    for j = 1:size(temperature,2)
        for k = 1:size(temperature,3)
            for l = 1:size(temperature,4)
                temp = temperature(:,:,:,l);
                max_temp = [max_temp max(temp,[],'all')];
                
                %time iteration
                start_date = datetime('Dec-2005');
                end_date = datetime('Dec-2018');
                time_period = [start_date : calmonths(1) : end_date];
                date_actual = ([date_actual, (time_period(l))]);

            end
            continue
        end
        break
    end
    break
end
disp(max_temp)
scatter(date_actual,max_temp,'x')
hold on
line(date_actual,max_temp)
ylabel('Maximum Temperature / deg C');
xlabel('Date');
title('Monthly maximum temperature');



