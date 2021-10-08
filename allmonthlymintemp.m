function [] = allmonthlymintemp(~)
%latitude = ncread('alltemp.nc','lat');
%longitude = ncread('alltemp.nc','lon');
temperature = ncread('alltemp.nc','votemper');

monthlymin_temp = [];
date_actual = [];
%plot sea surface temperature for every calendar month 
for i = 1:size(temperature,1)
    for j = 1:size(temperature,2)
        for k = 1:size(temperature,3)
            for l = 1:size(temperature,4)
                temp = temperature(:,:,:,l);
                monthlymin_temp = [monthlymin_temp min(temp,[],'all')];
                
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
%disp(monthlymin_temp);
scatter(date_actual,monthlymin_temp,'x')
hold on
line(date_actual,monthlymin_temp)
ylabel('Temperature / deg C');
xlabel('Date');
title('Monthly minimum temperature');



