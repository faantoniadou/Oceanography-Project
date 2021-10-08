function [] = allmonthlymaxtemp(~)
%latitude = ncread('alltemp.nc','lat');
%longitude = ncread('alltemp.nc','lon');
temperature = ncread('alltemp.nc','votemper');

monthlymax_temp = [];
date_actual = [];
%plot sea surface temperature for every calendar month 
for i = 1:size(temperature,1)
    for j = 1:size(temperature,2)
        for k = 1:size(temperature,3)
            for l = 1:size(temperature,4)
                temp = temperature(:,:,:,l);
                monthlymax_temp = [monthlymax_temp max(temp,[],'all')];
                
                %time iteration
                start_date = datetime('Jan-1987');
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

scatter(date_actual,monthlymax_temp,'x')
hold on
line(date_actual,monthlymax_temp)
ylabel('Temperature / deg C');
xlabel('Date');
title('Monthly maximum temperature');



